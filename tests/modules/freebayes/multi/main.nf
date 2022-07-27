#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { FREEBAYES_MULTI } from '../../../../modules/freebayes/multi/main.nf' addParams( options: [:] )

workflow test_freebayes_multi {

    bam = [
        file(params.test_data['homo_sapiens']['illumina']['test_paired_end_markduplicates_sorted_bam'], checkIfExists: true),
        file(params.test_data['homo_sapiens']['illumina']['test2_paired_end_markduplicates_sorted_bam'], checkIfExists: true)
    ]

    genome_fasta = file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)

    genome_fasta_fai = file(params.test_data['homo_sapiens']['genome']['genome_fasta_fai'], checkIfExists: true)

    FREEBAYES_MULTI ( bam, genome_fasta, genome_fasta_fai )
}
