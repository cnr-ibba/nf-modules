# cnr-ibba/nf-modules

[![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-%E2%89%A521.10.3-23aa62.svg?labelColor=000000)](https://www.nextflow.io/)
[![run with conda](http://img.shields.io/badge/run%20with-conda-3EB049?labelColor=000000&logo=anaconda)](https://docs.conda.io/en/latest/)
[![run with docker](https://img.shields.io/badge/run%20with-docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)
[![run with singularity](https://img.shields.io/badge/run%20with-singularity-1d355c.svg?labelColor=000000)](https://sylabs.io/docs/)
![GitHub Actions Coda Linting](https://github.com/cnr-ibba/nf-modules/workflows/Code%20Linting/badge.svg)

A repository for hosting custom [Nextflow DSL2](https://www.nextflow.io/docs/latest/dsl2.html)
modules not hosted in [nf-core/modules](https://github.com/nf-core/modules)
with process definitions and their associated documentation.

## Table of contents

- [cnr-ibba/nf-modules](#cnr-ibbanf-modules)
  - [Table of contents](#table-of-contents)
  - [Using existing modules](#using-existing-modules)
  - [Adding new modules](#adding-new-modules)
  - [Acknowledgment](#acknowledgment)

## Using existing modules

The module files hosted in this repository define a set of processes for software tools such as `fastqc`, `bwa`, `samtools` etc. This allows you to share and add common functionality across multiple pipelines in a modular fashion.

We have written a helper command in the `nf-core/tools` package that uses the GitHub API to obtain the relevant information for the module files present in the [`modules/`](modules/) directory of this repository. This includes using `git` commit hashes to track changes for reproducibility purposes, and to download and install all of the relevant module files.

1. Install the latest version of [`nf-core/tools`](https://github.com/nf-core/tools#installation) (`>=2.10`)
2. List the available modules:

   ```console
   $ nf-core modules --git-remote https://github.com/cnr-ibba/nf-modules.git list remote

                                              ,--./,-.
              ___     __   __   __   ___     /,-._.--~\
        |\ | |__  __ /  ` /  \ |__) |__         }  {
        | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                              `._,._,'

        nf-core/tools version 2.11.dev0 - https://nf-co.re



    INFO     Modules available from https://github.com/cnr-ibba/nf-modules.git (master):

    ┏━━━━━━━━━━━━━━━━━━━━┓
    ┃ Module Name        ┃
    ┡━━━━━━━━━━━━━━━━━━━━┩
    │ bamaddrg           │
    │ bamtools/coverage  │
    │ freebayes/chunk    │
    │ freebayes/multi    │
    │ freebayes/single   │
    │ freebayes/splitbam │
    │ seqkit/rmdup       │
    └────────────────────┘

   ```

3. Install the module in your pipeline directory:

   ```console
   $ nf-core modules --git-remote https://github.com/cnr-ibba/nf-modules.git install freebayes/splitbam

                                             ,--./,-.
             ___     __   __   __   ___     /,-._.--~\
       |\ | |__  __ /  ` /  \ |__) |__         }  {
       | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                             `._,._,'

       nf-core/tools version 2.11.dev0 - https://nf-co.re


   INFO     Installing 'freebayes/splitbam'
   INFO     Use the following statement to include this module:

     include { FREEBAYES_SPLITBAM } from '../modules/cnr-ibba/freebayes/splitbam/main'

   ```

4. Import the module in your Nextflow script (fix the path accordingly your
   project):

   ```nextflow
   #!/usr/bin/env nextflow

   nextflow.enable.dsl = 2

   include { FREEBAYES_SPLITBAM } from './modules/cnr-ibba/freebayes/splitbam/main'
   ```

5. Remove the module from the pipeline repository if required:

   ```console
   $ nf-core modules --git-remote https://github.com/cnr-ibba/nf-modules.git remove freebayes/splitbam

                                             ,--./,-.
             ___     __   __   __   ___     /,-._.--~\
       |\ | |__  __ /  ` /  \ |__) |__         }  {
       | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                             `._,._,'

       nf-core/tools version 2.11.dev0 - https://nf-co.re


   INFO     Removed files for 'freebayes/splitbam' and its dependencies 'freebayes/splitbam'.
   ```

6. Check that a locally installed nf-core module is up-to-date compared to the one hosted in this repo:

   ```console
   $ nf-core modules --git-remote https://github.com/cnr-ibba/nf-modules.git lint freebayes/splitbam

                                              ,--./,-.
              ___     __   __   __   ___     /,-._.--~\
        |\ | |__  __ /  ` /  \ |__) |__         }  {
        | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                              `._,._,'

        nf-core/tools version 2.11.dev0 - https://nf-co.re



    INFO     Linting pipeline: '.'
    INFO     Linting module: 'freebayes/splitbam'
    INFO     Found 6 inputs in modules/cnr-ibba/freebayes/splitbam/main.nf
    INFO     Found 3 outputs in modules/cnr-ibba/freebayes/splitbam/main.nf


    ╭─ [!] 4 Module Test Warnings ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
    │                     ╷                                              ╷                                                                                      │
    │ Module name         │ File path                                    │ Test message                                                                         │
    │╶────────────────────┼──────────────────────────────────────────────┼─────────────────────────────────────────────────────────────────────────────────────╴│
    │ freebayes/splitbam  │ modules/cnr-ibba/freebayes/splitbam/main.nf  │ Conda update: bioconda::freebayes 1.3.6 -> 1.3.7                                     │
    │ freebayes/splitbam  │ modules/cnr-ibba/freebayes/splitbam/main.nf  │ Unable to connect to container registry, code:  403, url:                            │
    │                     │                                              │ https://www.docker.com/bunop/freebayes:v0.1                                          │
    │ freebayes/splitbam  │ modules/cnr-ibba/freebayes/splitbam/main.nf  │ Container versions do not match                                                      │
    │ freebayes/splitbam  │ modules/cnr-ibba/freebayes/splitbam/meta.yml │ meta is present as an output in meta.yml but not in main.nf                          │
    │                     ╵                                              ╵                                                                                      │
    ╰───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
    ╭───────────────────────╮
    │ LINT RESULTS SUMMARY  │
    ├───────────────────────┤
    │ [✔]  44 Tests Passed  │
    │ [!]   4 Test Warnings │
    │ [✗]   0 Tests Failed  │
    ╰───────────────────────╯
   ```

## Adding new modules

If you wish to contribute a new module, cosider to contribute to the original
[nf-core/modules](https://github.com/nf-core/modules) instead. Please see the
documentation on the
[nf-core website](https://nf-co.re/developers/modules#writing-a-new-module-reference).

## Acknowledgment

This pipeline uses code and infrastructure developed and maintained by the
[nf-core](https://nf-co.re) community, reused here under the
[MIT license](https://github.com/nf-core/tools/blob/master/LICENSE).

> The nf-core framework for community-curated bioinformatics pipelines.
>
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
>
> Nat Biotechnol. 2020 Feb 13. doi: 10.1038/s41587-020-0439-x.
> In addition, references of tools and data used in this pipeline are as follows:
