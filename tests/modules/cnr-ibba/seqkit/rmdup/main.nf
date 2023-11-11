#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { SEQKIT_RMDUP } from '../../../../../modules/cnr-ibba/seqkit/rmdup/main.nf'

workflow test_seqkit_rmdup {
    
    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
    ]

    SEQKIT_RMDUP ( input )
}
