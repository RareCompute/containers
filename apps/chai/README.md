# Chai

From the [upstream repository](https://github.com/chaidiscovery/chai-lab)

> Chai-1 is a multi-modal foundation model for molecular structure prediction that performs at the state-of-the-art across a variety of benchmarks. Chai-1 enables unified prediction of proteins, small molecules, DNA, RNA, glycosylations, and more.

## Environment variables

You can configure the docker image using the below environment variables

| Environment Variable | CLI Flag           | Type      | Default Value    | Description                                     |
| -------------------- | ------------------ | --------- | ---------------- | ----------------------------------------------- |
| `USERNAME`           | N/A                | `STR`     | `rare`           | Username for the container                      |
| `UID`                | N/A                | `INTEGER` | `900`            | UID for the container                           |
| `GID`                | N/A                | `INTEGER` | `900`            | GID for the container                           |
| `CHAI_DOWNLOADS_DIR` | N/A                | `PATH`    | `/tmp/downloads` | The path where downloads will be cached.        |
| `USE_MSA_SERVER`     | `--use-msa-server` | `BOOLEAN` | `False`          | Whether to use the MSA server to generate MSAs. |
| `MSA_SERVER_URL`     | `--msa-server-url` | `STR`     | N/A              | Use a custom MSA server                         |
