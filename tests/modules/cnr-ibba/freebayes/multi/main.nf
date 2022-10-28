#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { FREEBAYES_MULTI } from '../../../../../modules/cnr-ibba/freebayes/multi/main.nf'

workflow test_freebayes_multi {

    bam = [
        file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam'], checkIfExists: true),
        file(params.test_data['homo_sapiens']['illumina']['test2_paired_end_sorted_bam'], checkIfExists: true)
    ]

    bai = [
        file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam_bai'], checkIfExists: true),
        file(params.test_data['homo_sapiens']['illumina']['test2_paired_end_sorted_bam_bai'], checkIfExists: true)
    ]

    genome_fasta = file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)

    genome_fasta_fai = file(params.test_data['homo_sapiens']['genome']['genome_fasta_fai'], checkIfExists: true)

    FREEBAYES_MULTI ( bam, bai, genome_fasta, genome_fasta_fai )
}
