#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { FREEBAYES } from '../../../../software/freebayes/multi/main.nf' addParams( options: [:] )

workflow test_freebayes {

    bam = [ [ id:'test', single_end:false ], // meta map
              file(params.test_data['homo_sapiens']['illumina']['test_paired_end_markduplicates_sorted_bam'], checkIfExists: true),
              [ id:'test2', single_end:false ], // meta map
              file(params.test_data['homo_sapiens']['illumina']['test2_paired_end_markduplicates_sorted_bam'], checkIfExists: true)]
    genome_fasta = file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)

    FREEBAYES ( bam, genome_fasta )
}
