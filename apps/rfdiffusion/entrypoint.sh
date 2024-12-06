#!/usr/bin/env bash

DOWNLOAD_COMPLEX_BETA=$(echo "${!ENV_VAR_NAME}" | tr '[:upper:]' '[:lower:]')
DOWNLOAD_STRUCTURE_PREDICTION_WEIGHTS=$(echo "${!ENV_VAR_NAME}" | tr '[:upper:]' '[:lower:]')
BASE_URL="http://files.ipd.uw.edu/pub/RFdiffusion"

declare -A downloads=(
  ["Base_ckpt.pt"]="$BASE_URL/6f5902ac237024bdd0c176cb93063dc4/Base_ckpt.pt"
  ["Complex_base_ckpt.pt"]="$BASE_URL/e29311f6f1bf1af907f9ef9f44b8328b/Complex_base_ckpt.pt"
  ["Complex_Fold_base_ckpt.pt"]="$BASE_URL/60f09a193fb5e5ccdc4980417708dbab/Complex_Fold_base_ckpt.pt"
  ["InpaintSeq_ckpt.pt"]="$BASE_URL/74f51cfb8b440f50d70878e05361d8f0/InpaintSeq_ckpt.pt"
  ["InpaintSeq_Fold_ckpt.pt"]="$BASE_URL/76d00716416567174cdb7ca96e208296/InpaintSeq_Fold_ckpt.pt"
  ["ActiveSite_ckpt.pt"]="$BASE_URL/5532d2e1f3a4738decd58b19d633b3c3/ActiveSite_ckpt.pt"
  ["Base_epoch8_ckpt.pt"]="$BASE_URL/12fc204edeae5b57713c5ad7dcb97d39/Base_epoch8_ckpt.pt"
)

if [ "$DOWNLOAD_COMPLEX_BETA" == "true" ]; then
  files["Complex_beta_ckpt.pt"]="$BASE_URL/f572d396fae9206628714fb2ce00f72e/Complex_beta_ckpt.pt"
fi

if [ "$DOWNLOAD_STRUCTURE_PREDICTION_WEIGHTS" == "true" ]; then
  files["RF_structure_prediction_weights.pt"]="$BASE_URL/1befcb9b28e2f778f53d47f18b7597fa/RF_structure_prediction_weights.pt"
fi

for filename in "${!files[@]}"; do
  filepath="/models/$filename"
  if [ ! -f "$filepath" ]; then
    echo "Downloading $filename..."
    wget -q -P /models --timestamping "${files[$filename]}"
  else
    echo "File $filename already exists, skipping download."
  fi
done

exec /app/scripts/run_inference.py "$@"
