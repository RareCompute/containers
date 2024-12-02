# Boltz

By default the image will attempt a prediction based on the provided flags and input. If you want to create a shell pod, i.e. research environment, you can pass `SHELL: true`

Attach a volume for data and models by referencing `/cache` and for generated predictions by referencing `/predictions`

## Upstream repository

From the [author repository](https://github.com/jwohlwend/boltz/tree/main):

> Boltz-1 is the state-of-the-art open-source model that predicts the 3D structure of proteins, RNA, DNA, and small molecules; it handles modified residues, covalent ligands and glycans, as well as condition the generation on pocket residues.

## Environment variables

You can configure the docker image using the below environment variables

| Environment Variable   | CLI Flag                 | Type                 | Default Value               | Description                                                         |
| ---------------------- | ------------------------ | -------------------- | --------------------------- | ------------------------------------------------------------------- |
| `OUTPUT_DIR`           | `--out_dir`              | `PATH`               | `./`                        | The path where predictions will be saved.                           |
| `DOWNLOAD_DIR`         | `--cache`                | `PATH`               | `/cache`                    | The directory for downloading data and models.                      |
| `DEVICE_TYPE`          | `--accelerator`          | `[gpu, cpu, tpu]`    | `gpu`                       | The type of accelerator to use for predictions.                     |
| `DEVICES_COUNT`        | `--devices`              | `INTEGER`            | `1`                         | The number of devices to use for predictions.                       |
| `RECYCLING_STEPS`      | `--recycling_steps`      | `INTEGER`            | `3`                         | The number of recycling steps to use for predictions.               |
| `SAMPLING_STEPS`       | `--sampling_steps`       | `INTEGER`            | `200`                       | The number of sampling steps to use for predictions.                |
| `DIFFUSION_SAMPLES`    | `--diffusion_samples`    | `INTEGER`            | `1`                         | The number of diffusion samples to use for predictions.             |
| `OUTPUT_FORMAT`        | `--output_format`        | `[pdb, mmcif]`       | `mmcif`                     | The output format for predictions.                                  |
| `WORKERS`              | `--num_workers`          | `INTEGER`            | `2`                         | The number of workers for data loading.                             |
| `OVERRIDE`             | `--override`             | `FLAG`               | `False`                     | Whether to override existing predictions.                           |
| `USE_MSA_SERVER`       | `--use_msa_server`       | `FLAG`               | `False`                     | Whether to use the MSA server to generate MSAs.                     |
| `MSA_SERVER_URL`       | `--msa_server_url`       | `STR`                | `https://api.colabfold.com` | The URL of the MSA server (used only if `--use_msa_server` is set). |
| `MSA_PAIRING_STRATEGY` | `--msa_pairing_strategy` | `[greedy, complete]` | `greedy`                    | The MSA pairing strategy to use (requires `--use_msa_server`).      |
| `WRITE_FULL_PAE`       | `--write_full_pae`       | `FLAG`               | `False`                     | Whether to save the full PAE matrix as a file.                      |
| `WRITE_FULL_PDE`       | `--write_full_pde`       | `FLAG`               | `False`                     | Whether to save the full PDE matrix as a file.                      |
| `SHELL`                | N/A                      | N.A                  | N/A                         | Start the docker container as a shell                               |
