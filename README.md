# new_adenomera_AF
Scripts, alignments, and software information about the paper: ["Unexplored Urban Diversity: A New Species of Adenomera (Anura, Leptodactylidae) Related to A. ajurauna from the Atlantic Forest of Southeastern and Southern Brazil"](https://doi.org/10.1655/Herpetologica-D-22-00022), by Cassini et al. (2024).

In the script 'genetic_distances.R' you will find the script used to build the genetic distances table (Table 3), and files 'distance_coi.fas' and 'distance_16S.fas' are the input matrices.

The file 'sppDistMatrix2.R' contains a function to compute minimum and maximum genetic distances with R package 'spider'. It was written by Dr. Rupert Collins in 2016.

In the file 'partition_finder.cfg' you will find arguments for the PartitionFinder2 analysis, and the file 'best_scheme.txt' is its output.

In the file 'ML_tree.tre' you will find the resulting tree from the maximum likelihood analysis.

In the files 'BI_matrix.nex',  'BI_tree.tre', and 'mrbayes_stdout.txt' you will find the matrix with the arguments used in the Bayesian inference analysis, the resulting tree and the analysis output, respectively.

In the files 'POMC_phased_out.fasta' and 'RAG_phased_out.fasta' you will find the output matriced from phasing algorithm used in haplotype natworks building.

## Command line arguments for each software
### MAFFT
#### Coding gene fragments
`
mafft --maxiterate 1000 --globalpair --reorder --preservecase --thread 8 gene_fragment.fas > gene_fragment_mafft.fasta
`
#### 16S
`
mafft --maxiterate 1000 --genafpair --reorder --preservecase --thread 8 16S.fas > 16S_mafft.fasta
`
### PartitionFinder2

PartitionFinder2 arguments are in the file 'partition_finder.cfg'.

### PHASE
`
PHASE -d1 seqphase.inp seqphase.out 10000 100 10000 -x10 
`

### RAxML-NG
#### Phylogenetic analysis
`
raxml-ng --all --msa matrix.phy --model partitions.txt --prefix cantitata --threads 8 --seed 12345 --bs-metric fbp --tree rand{50},pars{50} --bs-trees 1000
`
#### Haplotype networks
`
raxml-ng-mpi --msa matrix.fasta --model GTR+G --prefix pomc --threads 10 --seed 12345 --tree rand{50},pars{50}
`
### MrBayes

MrBayes arguments are in the file 'BI_matrix.nex'

### Paper citation

Carla S. Cassini, Thiago R. Carvalho, Pedro P. G. Taucce, Célio F. B. Haddad, Mirco Solé; Unexplored Urban Diversity: A New Species of _Adenomera_ (Anura, Leptodactylidae) Related to _Adenomera ajurauna_ from the Atlantic Forest of Southeastern and Southern Brazil. Herpetologica 80. doi: https://doi.org/10.1655/Herpetologica-D-22-00022
