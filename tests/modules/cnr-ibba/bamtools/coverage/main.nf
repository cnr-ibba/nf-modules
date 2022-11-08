#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { BAMTOOLS_COVERAGE } from '../../../../../modules/cnr-ibba/bamtools/coverage/main.nf'

workflow test_bamtools_coverage {

    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
    ]

    BAMTOOLS_COVERAGE ( input )
}
