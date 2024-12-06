# Chai

From the [upstream repository](https://github.com/RosettaCommons/RFdiffusion)

> RFdiffusion is an open source method for structure generation, with or without conditional information (a motif, target etc). It can perform a whole range of protein design challenges as we have outlined in the RFdiffusion paper.
>
> Things Diffusion can do
>
> Motif Scaffolding
> Unconditional protein generation
> Symmetric unconditional generation (cyclic, dihedral and tetrahedral symmetries currently implemented, more coming!)
> Symmetric motif scaffolding
> Binder design
> Design diversification ("partial diffusion", sampling around a design)

## Environment variables

You can configure the docker image using the below environment variables

| Environment Variable | CLI Flag | Type      | Default Value | Description                |
| -------------------- | -------- | --------- | ------------- | -------------------------- |
| `USERNAME`           | N/A      | `STR`     | `rare`        | Username for the container |
| `UID`                | N/A      | `INTEGER` | `900`         | UID for the container      |
| `GID`                | N/A      | `INTEGER` | `900`         | GID for the container      |
