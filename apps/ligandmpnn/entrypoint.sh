#!/usr/bin/env bash

MODEL_PARAMS_DIR="/model"
if [[ -z $(find $MODEL_PARAMS_DIR -maxdepth 1 -type f -printf '.') ]]; then
  echo "Downloading model parameters..."
  bash get_model_params.sh $MODEL_PARAMS_DIR
fi

EXTRA_FLAGS=""
declare -A FLAG_MAP=(
  [PDB_PATH]="--pdb_path"
  [OUT_FOLDER]="--out_folder"
  [TEMPERATURE]="--temperature"
  [SEED]="--seed"
  [VERBOSE]="--verbose"
  [SAVE_STATS]="--save_stats"
  [FIXED_RESIDUES]="--fixed_residues"
  [REDESIGNED_RESIDUES]="--redesigned_residues"
  [NUMBER_OF_BATCHES]="--number_of_batches"
  [BIAS_AA]="--bias_AA"
  [BIAS_AA_PER_RESIDUE]="--bias_AA_per_residue"
  [OMIT_AA]="--omit_AA"
  [OMIT_AA_PER_RESIDUE]="--omit_AA_per_residue"
  [SYMMETRY_RESIDUES]="--symmetry_residues"
  [SYMMETRY_WEIGHTS]="--symmetry_weights"
  [HOMO_OLIGOMER]="--homo_oligomer"
  [FILE_ENDING]="--file_ending"
  [ZERO_INDEXED]="--zero_indexed"
  [CHAINS_TO_DESIGN]="--chains_to_design"
  [PARSE_THESE_CHAINS_ONLU]="--parse_these_chains_only"
  [CHECKPOINT_LIGAND_MPNN]="--checkpoint_ligand_mpnn"
  [LIGAND_MPNN_USE_ATOM_CONTEXT]="--ligand_mpnn_use_atom_context"
  [LIGAND_MPNN_USE_SIDE_CHAIN_CONTEXT]="--ligand_mpnn_use_side_chain_context"
  [MODEL_TYPE]="--model_type"
  [FASTA_SEQ_SEPARATION]="--fasta_seq_separation"
  [PDB_PATH_MULTI]="--pdb_path_multi"
  [FIXED_RESIDUES_MULTI]="--fixed_residues_multi"
  [REDESIGNED_RESIDUES_MULTI]="--redesigned_residues_multi"
  [OMIT_AA_PER_RESIDUE_MULTI]="--omit_AA_per_residue_multi"
  [BIAS_AA_PER_RESIDUE_MULTI]="--bias_AA_per_residue_multi"
  [LIGAND_MPNN_CUTOFF_FOR_SCORE]="--ligand_mpnn_cutoff_for_score"
  [PARSE_ATOMS_WITH_ZERO_OCCUPANCY]="--parse_atoms_with_zero_occupancy"
)

for VAR in "${!FLAG_MAP[@]}"; do
  if [ -n "${!VAR}" ]; then
    VALUE_LOWER=$(echo "${!VAR}" | tr '[:upper:]' '[:lower:]')
    if [[ "$VALUE_LOWER" == "true" ]]; then
      EXTRA_FLAGS+=" ${FLAG_MAP[$VAR]}"
    elif [[ "$VALUE_LOWER" != "false" ]]; then
      EXTRA_FLAGS+=" ${FLAG_MAP[$VAR]} ${!VAR}"
    fi
  fi
done

exec \
  python /app/run.py \
  "$@" \
  $EXTRA_FLAGS
