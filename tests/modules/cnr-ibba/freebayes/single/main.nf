#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { BAMTOOLS_COVERAGE } from '../../../../../modules/cnr-ibba/bamtools/coverage/main.nf'
include { FREEBAYES_SINGLE } from '../../../../../modules/cnr-ibba/freebayes/single/main.nf'

workflow test_freebayes_single {
    // this is a requisite before running freebayes/single
    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam'], checkIfExists: true),
    ]

    BAMTOOLS_COVERAGE ( input )

    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam'], checkIfExists: true),
        file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam_bai'], checkIfExists: true),
    ]

    genome_fasta = [
        [ id:'genome' ],
        file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)
    ]

    genome_fasta_fai = [
        [ id:'genome' ],
        file(params.test_data['homo_sapiens']['genome']['genome_fasta_fai'], checkIfExists: true)
    ]

    FREEBAYES_SINGLE ( input, BAMTOOLS_COVERAGE.out.data, genome_fasta, genome_fasta_fai, [] )
}
