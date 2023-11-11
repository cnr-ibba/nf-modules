#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { SEQKIT_RMDUP } from '../../../../../modules/cnr-ibba/seqkit/rmdup/main.nf'

workflow test_seqkit_rmdup {
    input = [
        [ id:'test' ],   // meta map
        [ file(params.test_data['sarscov2']['genome']['genome_fasta'], checkIfExists: true) ]
    ]
    SEQKIT_RMDUP ( input )
}

workflow test_seqkit_rmdup_fq {
    input = [
        [ id:'test' ], // meta map
        [ file(params.test_data['sarscov2']['illumina']['test_1_fastq_gz'], checkIfExists: true) ]
    ]
    SEQKIT_RMDUP ( input )
}
