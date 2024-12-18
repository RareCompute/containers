# Protenix

From the [upstream repository](https://github.com/bytedance/Protenix):

> A trainable PyTorch reproduction of AlphaFold 3

## Environment variables

You can configure the docker image using the below environment variables

| Environment Variable | CLI Flag | Type      | Default Value | Description                |
| -------------------- | -------- | --------- | ------------- | -------------------------- |
| `USERNAME`           | N/A      | `STR`     | `rare`        | Username for the container |
| `UID`                | N/A      | `INTEGER` | `900`         | UID for the container      |
| `GID`                | N/A      | `INTEGER` | `900`         | GID for the container      |

# TODO: Update above table

```sh
declare -A FLAG_MAP=(
  [INPUT]="--input"
  [INPUT_JSON_PATH]="--input_json_path"
  [DUMP_DIR]="--dump_dir"
  [DATA_TYPE]="--dtype"a # "bf16" or "fp32"
  [OUT_DIR]="--out_dir"
  [USE_MSA]="--use_msa" # Default true
  [USE_MSA_SERVER]="--use_msa_server"
)
```
