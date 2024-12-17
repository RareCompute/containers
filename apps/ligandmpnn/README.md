# Chai

From the [upstream repository](https://github.com/dauparas/LigandMPNN):

> This package provides inference code for LigandMPNN & ProteinMPNN models. The code and model parameters are available under the MIT license.

## Environment variables

You can configure the docker image using the below environment variables. Not all of them are listed in the table.

| Environment Variable | CLI Flag             | Type      | Default Value      | Description                                                                                                                                                                    |
| -------------------- | -------------------- | --------- | ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `USERNAME`           | N/A                  | `STR`     | `rare`             | Username for the container                                                                                                                                                     |
| `UID`                | N/A                  | `INTEGER` | `900`              | UID for the container                                                                                                                                                          |
| `GID`                | N/A                  | `INTEGER` | `900`              | GID for the container                                                                                                                                                          |
| `PDB_PATH`           | `--pdb_path`         | `PATH`    | Required           | Path to PDB file                                                                                                                                                               |
| `OUT_FOLDER`         | `--out_folder`       | `PATH`    | Required           | Path to output folder                                                                                                                                                          |
| `SEED`               | `--seed`             | `INTEGER` | Randomly generated | The random seed to use                                                                                                                                                         |
| `MODEL_TYPE`         | `--model_type`       | `STR`     | `ligand_mpnn`      | Model type to use                                                                                                                                                              |
| `CHAINS_TO_DESIGN`   | `--chains_to_design` | `STR`     | N/A                | Specify which chains (e.g. "A,B,C") need to be redesigned, other chains will be kept fixed. Outputs in seqs/backbones will still have atoms/sequences for the whole input PDB. |

# TODO: Update above table with below args

```sh
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
```

<!--
    [SEED]="--seed"
    [PDB_PATH]="--pdb_path"
    [OUT_FOLDER]="--out_folder"
    [MODEL_TYPE]="--model_type"
    [CHAINS_TO_DESIGN]="--chains_to_design"
    [LIGAND_MPNN_USE_ATOM_CONTEXT]="--ligand_mpnn_use_atom_context"
    [FILE_ENDING]="--file_ending"
    [NUMBER_OF_BATCHES]="--number_of_batches"
    [ZERO_INDEXED]="--zero_indexed"
    [HOMO_OLIGOMER]="--homo_oligomer"
    [FIXED_RESIDUES]="--fixed_residues"
    [SYMMETRY_RESIDUES]="--symmetry_residues"
    [SYMMETRY_WEIGHTS]="--symmetry_weights"
    [VERBOSE]="--verbose"
-->
