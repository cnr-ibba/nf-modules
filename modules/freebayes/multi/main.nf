// Import generic module functions
include { initOptions; saveFiles; getSoftwareName } from './functions'

params.options = [:]
options        = initOptions(params.options)

process FREEBAYES_MULTI {
    tag "freebayes.multi"
    label 'process_high'
    publishDir "${params.outdir}",
        mode: params.publish_dir_mode,
        saveAs: { filename -> saveFiles(filename:filename, options:params.options, publish_dir:getSoftwareName(task.process), meta:meta, publish_by_meta:['id']) }

    conda (params.enable_conda ? "bioconda::freebayes=1.3.5" : null)
    if (workflow.containerEngine == 'singularity' && !params.singularity_pull_docker_container) {
        container "https://depot.galaxyproject.org/singularity/freebayes:1.3.5--py38ha193a2f_3"
    } else {
        container "quay.io/biocontainers/freebayes:1.3.5--py38ha193a2f_3"
    }

    input:
    path(bam)
    path(genome_fasta)

    output:
    path "all.fb.vcf.gz"          , emit: vcf
    path "all.fb.vcf.gz.tbi"      , emit: index
    path "*.version.txt"          , emit: version

    script:
    def software = getSoftwareName(task.process)
    """
    ls $bam | xargs -n1 > bam_list.txt
    freebayes $options.args --bam-list bam_list.txt --standard-filters -f $genome_fasta | bgzip --threads $task.cpus --stdout > all.fb.vcf.gz
    tabix all.fb.vcf.gz
    echo \$(freebayes --version 2>&1) | sed 's/^version: * v//' > ${software}.version.txt
    """
}
