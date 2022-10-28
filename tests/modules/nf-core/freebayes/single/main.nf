#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { FREEBAYES_SINGLE } from '../../../../../modules/nf-core/freebayes/single/main.nf'

workflow test_freebayes_single {

    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam'], checkIfExists: true)
    ]

    genome_fasta = file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)

    FREEBAYES_SINGLE ( input, genome_fasta )
}
