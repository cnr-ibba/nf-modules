#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { FREEBAYES_PARALLEL } from '../../../../modules/freebayes/parallel/main.nf'

workflow test_freebayes_parallel {

    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['homo_sapiens']['illumina']['test_paired_end_markduplicates_sorted_bam'], checkIfExists: true)
    ]

    genome_fasta = file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)
    genome_fasta_fai = file(params.test_data['homo_sapiens']['genome']['genome_fasta_fai'], checkIfExists: true)

    FREEBAYES_PARALLEL ( input, genome_fasta, genome_fasta_fai )
}
