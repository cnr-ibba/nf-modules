#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { SAMTOOLS_CRAM } from '../../../../modules/samtools/cram/main.nf' addParams( options: [:] )

workflow test_samtools_cram {
    input = [ [ id:'test', single_end:false ], // meta map
                file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
            ]
    fasta = file(params.test_data['sarscov2']['genome']['genome_fasta'], checkIfExists: true)

    SAMTOOLS_CRAM ( input, fasta )
}
