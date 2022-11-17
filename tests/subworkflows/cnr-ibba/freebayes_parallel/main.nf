#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { FREEBAYES_PARALLEL } from '../../../../subworkflows/cnr-ibba/freebayes_parallel/main'

workflow test_freebayes_parallel {
    bam = [
        file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam'], checkIfExists: true),
        file(params.test_data['homo_sapiens']['illumina']['test2_paired_end_sorted_bam'], checkIfExists: true)
    ]

    bai = [
        file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam_bai'], checkIfExists: true),
        file(params.test_data['homo_sapiens']['illumina']['test2_paired_end_sorted_bam_bai'], checkIfExists: true)
    ]

    // trasform input in channels and add a meta key (single emission)
    bam_ch = Channel.of(bam).map{ it -> [[id: "all.fb"], it]}
    bai_ch = Channel.of(bai).map{ it -> [[id: "all.fb"], it]}

    genome_fasta = file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)

    genome_fasta_fai = file(params.test_data['homo_sapiens']['genome']['genome_fasta_fai'], checkIfExists: true)

    FREEBAYES_PARALLEL ( bam_ch, bai_ch, genome_fasta, genome_fasta_fai )
}
