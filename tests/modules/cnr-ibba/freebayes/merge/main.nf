#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { FREEBAYES_MERGE } from '../../../../../modules/cnr-ibba/freebayes/merge/main.nf'

workflow test_freebayes_merge {

    vcf = [
        [[ id:'test' ], // meta map
        file(params.test_data['sarscov2']['illumina']['test_vcf_gz'], checkIfExists: true)],
        [[ id:'test2' ], // meta map
        file(params.test_data['sarscov2']['illumina']['test2_vcf_gz'], checkIfExists: true)],
    ]

    vcf_ch = Channel.from(vcf)
        .collect{ it -> it[1]}
        .map{ it -> [[id: 'all-samples'], it]}

    FREEBAYES_MERGE ( vcf_ch )
}
