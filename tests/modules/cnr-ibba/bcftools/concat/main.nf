#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { BCFTOOLS_CONCAT } from '../../../../../modules/cnr-ibba/bcftools/concat/main.nf'

workflow test_bcftools_concat_tbi {

    input = [ [ id:'test3' ], // meta map
              [ file(params.test_data['homo_sapiens']['illumina']['test_haplotc_cnn_vcf_gz'], checkIfExists: true),
                file(params.test_data['homo_sapiens']['illumina']['test_genome_vcf_gz'], checkIfExists: true) ],
              [ file(params.test_data['homo_sapiens']['illumina']['test_genome_vcf_gz_tbi'], checkIfExists: true),
                file(params.test_data['homo_sapiens']['illumina']['test_haplotc_cnn_vcf_gz_tbi'], checkIfExists: true) ]
            ]

    BCFTOOLS_CONCAT ( input )
}

workflow test_bcftools_concat_no_tbi {

    input = [ [ id:'test3' ], // meta map
              [ file(params.test_data['homo_sapiens']['illumina']['test_haplotc_cnn_vcf_gz'], checkIfExists: true),
                file(params.test_data['homo_sapiens']['illumina']['test_genome_vcf_gz'], checkIfExists: true) ],
              []
            ]

    BCFTOOLS_CONCAT ( input )
}
