#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { FREEBAYES_CHUNK } from '../../../../../modules/cnr-ibba/freebayes/chunk/main.nf'
include { FREEBAYES_SPLITBAM } from '../../../../../modules/cnr-ibba/freebayes/splitbam/main.nf'

workflow test_freebayes_chunk {
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

    genome_fasta = [
        [ id:'genome' ],
        file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)
    ]

    genome_fasta_fai = [
        [ id:'genome' ],
        file(params.test_data['homo_sapiens']['genome']['genome_fasta_fai'], checkIfExists: true)
    ]

    FREEBAYES_SPLITBAM ( bam_ch, bai_ch, genome_fasta, genome_fasta_fai )

    regions_ch = FREEBAYES_SPLITBAM.out.regions
        .map{ it -> it[1]}
        .splitText()
        .map{ it -> [[id: it.trim()], it.trim()]}

    FREEBAYES_CHUNK ( regions_ch, bam_ch, bai_ch, FREEBAYES_SPLITBAM.out.bam_list, genome_fasta, genome_fasta_fai )
}
