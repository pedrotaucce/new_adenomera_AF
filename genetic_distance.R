#Set working directory
setwd("~/Dropbox/adenomera/sp_s/distancias/")
library("spider")
library("ape")

#it is necessary to download this file and place it inside your working directory
source("sppDistMatrix2.R")

#Names of the terminals must be separated by underline(_), with first part usually the genus, second
#part the species and third part anything you want, usually the voucher or GB accession number. the 
#script will use second part to group sequences.

#First with the COI gene fragment
#Reading the matrix
dat <- read.dna("distance_coi.fas", format="fasta")
#Split terminal names by "_"
splited <- strsplit(dimnames(dat)[[1]], split="_")
#Naming groups according to part 2 of the terminal names
species <- sapply(splited, function(x) paste (x[2]))
#Compute raw p-distances among all terminals
gen_dist <- dist.dna(dat, model="raw",pairwise.deletion = T)

#Searches max distances among all groups and writes a table. Numbers are given as percentage with
#two decimal numbers 
max_dist <- sppDistMatrix2(distobj=gen_dist, sppVector=species, dist=max)
max_dist <- round(max_dist*100,digits=1)
write.table(max_dist, file="max_dist_coi.txt", sep=";")

#same for min distances
min_dist <- sppDistMatrix2(gen_dist, species, min)
min_dist <- round(min_dist*100,digits=1)
write.table(min_dist, file="min_dist_coi.txt", sep=";")

#Takes unique species names
unique_species<-unique(species)

#Adds min and max values to each species through a loop separated by an EN-Dash
x = 0
for(i in unique_species){
  x = x+1
  assign(i,paste(min_dist[,x], max_dist[,x], sep="\u2013"))
}


#Building the table
matriz <- cbind(noquote(unique_species))
#write species names in the order they appear in the fasta file
matriz <- cbind(ajurauna,araucaria, bokermanni,cantitata, engelsi,kweti,marmorata, nana)
#nomeia colunas e linhas
rownames(matriz)<-paste("A.",unique_species)
colnames(matriz)<-paste("A.",unique_species)
#Wrinting the table tab-separated. Values in diagonal will be intraspecific distances
write.table(matriz, file="distance_matrix_coi.txt", sep="\t")


#Counts number of specimens by species
library("plyr")
count(species)

#Same process with 16S

dat <- read.dna("distance_16S.fas", format="fasta")
splited <- strsplit(dimnames(dat)[[1]], split="_")
species <- sapply(splited, function(x) paste (x[2]))
gen_dist <- dist.dna(dat, model="raw",pairwise.deletion = T)
max_dist <- sppDistMatrix2(distobj=gen_dist, sppVector=species, dist=max)
max_dist <- round(max_dist*100,digits=1)
write.table(max_dist, file="max_dist_16S.txt", sep=";")
min_dist <- sppDistMatrix2(gen_dist, species, min)
min_dist <- round(min_dist*100,digits=1)
write.table(min_dist, file="min_dist_16S.txt", sep=";")
unique_species<-unique(species)
x = 0
for(i in unique_species){
  x = x+1
  assign(i,paste(min_dist[,x], max_dist[,x], sep="\u2013"))
}
matriz <- cbind(noquote(unique_species))
matriz <- cbind(ajurauna,araucaria, bokermanni,cantitata, engelsi,kweti,marmorata, nana)
rownames(matriz)<-paste("A.",unique_species)
colnames(matriz)<-paste("A.",unique_species)
write.table(matriz, file="distance_matrix_16S.txt", sep="\t")
count(species)

       