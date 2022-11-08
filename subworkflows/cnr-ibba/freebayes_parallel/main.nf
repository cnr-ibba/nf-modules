//
// Prepare and run freebayes paralle
//

include { FREEBAYES_SPLITBAM } from '../../../modules/cnr-ibba/freebayes/splitbam/main'

workflow FREEBAYES_PARALLEL {
    take:
    bam     // channel: [ val(meta), [ bam/cram ]]
    bai     // channel: [ val(meta), [ bai/crai ]]
    fasta   // channel: [ fasta ]
    fai     // channel: [ fai ]

    main:
    ch_versions = Channel.empty()

    FREEBAYES_SPLITBAM ( bam, bai, fasta, fai )
    ch_versions = ch_versions.mix(FREEBAYES_SPLITBAM.out.versions)

    emit:

    versions = ch_versions // channel: [ versions.yml ]
}
