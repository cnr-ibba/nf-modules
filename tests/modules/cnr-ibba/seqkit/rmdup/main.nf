#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { SEQKIT_RMDUP } from '../../../../../modules/cnr-ibba/seqkit/rmdup/main.nf'

workflow test_seqkit_rmdup {

    sequence = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['homo_sapiens']['genome']['genome_21_fasta'], checkIfExists: true)
    ]

    SEQKIT_RMDUP ( sequence )
}
