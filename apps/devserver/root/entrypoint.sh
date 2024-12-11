#!/usr/bin/env bash
set -euo pipefail

USER_HOME="/config"
SSH_DIR="$USER_HOME/ssh"
AUTH_KEYS="$USER_HOME/.ssh/authorized_keys"

echo '
Rare Compute Devserver
───────────────────────────────────────'
echo "
Username:    ${USER_NAME}
User UID:    ${UID}
User GID:    ${GID}
Listen Port: ${LISTEN_PORT}
───────────────────────────────────────"

if ! getent group "${GID}" >/dev/null; then
  groupadd -g "${GID}" ssh
fi

if ! id "$USER_NAME" &> /dev/null; then
  useradd -u "${UID}" -g "${GID}" -d /config -s /bin/bash -m "$USER_NAME"
fi

if [ "${SUDO_ACCESS}" = "true" ]; then
  usermod -aG sudo "$USER_NAME"
  echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER_NAME
  chmod 440 /etc/sudoers.d/$USER_NAME
fi

if [ ! -d "$SSH_DIR" ]; then
  mkdir -p "$SSH_DIR"
  chown -R root:root "$SSH_DIR"
fi

if [ "$(stat -c '%U' "$SSH_DIR")" != "root" ]; then
  chown -R root:root "$SSH_DIR"
fi

if [ "$(stat -c '%a' "$SSH_DIR")" != "700" ]; then
  chmod 700 "$SSH_DIR"
fi

if [ ! -f /config/ssh/sshd_config ]; then
    cp /sshd_config.template /config/ssh/sshd_config
    chown root:root /config/ssh/sshd_config
    chmod 600 /config/ssh/sshd_config
fi

if [ ! -f /config/ssh/ssh_host_rsa_key ]; then
    echo "Host keys not found, generating..."
    ssh-keygen -f /config/ssh/ssh_host_rsa_key -N '' -t rsa
    ssh-keygen -f /config/ssh/ssh_host_ed25519_key -N '' -t ed25519
    chmod 600 /config/ssh/ssh_host_*_key
fi

if [ ! -d "$USER_HOME/.ssh" ]; then
  mkdir -p "$USER_HOME/.ssh"
  chown -R "$UID":"$GID" "$USER_HOME/.ssh"
  chmod 755 "$USER_HOME"
  chmod 700 "$USER_HOME/.ssh"
fi

if [ ! -f "$AUTH_KEYS" ]; then
  touch "$AUTH_KEYS"
  chmod 600 "$AUTH_KEYS"
  chown "$UID":"$GID" "$AUTH_KEYS"
  
  if [ -n "$PUBLIC_KEY" ]; then
    echo "$PUBLIC_KEY" >> "$AUTH_KEYS"
  fi
fi

sed -i '/pam_motd.so/d' /etc/pam.d/sshd

if [ -d /custom-cont-init.d ]; then
    for f in /custom-cont-init.d/*; do
        if [ -f "$f" ]; then
            echo "Running custom init script: $f"
            if [ -x "$f" ]; then
                "$f"
            else
                bash "$f"
            fi
        fi
    done
fi

exec \
  /usr/sbin/sshd \
  -p "$LISTEN_PORT" \
  -f /config/ssh/sshd_config \
  -D
