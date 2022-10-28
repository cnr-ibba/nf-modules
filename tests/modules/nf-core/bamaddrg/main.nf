#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { BAMADDRG } from '../../../modules/bamaddrg/main.nf'

workflow test_bamaddrg {
    
    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
    ]

    BAMADDRG ( input )
}
