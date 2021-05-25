## 只抓上皮細胞的Migration

## Clean variables
rm(list = ls())

######## Path setting ########
setwd(getwd()) ## Set current working directory
PathName = setwd(getwd())

RVersion = "20210525V1"
dir.create(paste0(PathName,"/",RVersion))


FileName <- c("M14851") # M14851 # M12808
Data_Ori <- read.delim(paste0(PathName,"/",FileName,"_TableV2.txt"),  # 資料檔名
                          header=F,          # 資料中的第一列，作為欄位名稱
                          sep="\t")

Data <- Data_Ori[,c(30,33)]
Data_Epith <- Data[grepl("epith", Data$V33),]
Data_carcinoma <- Data[grepl("carci", Data$V33),]
# Data_EpithTTT <- Data[grepl("epith", Data$V33, ignore.case=TRUE),]
# Data_EpithTTT2 <- Data[Data$V30 %in% "dll4",]

Data_Epith_Uniq <- Data_Epith[!duplicated(Data_Epith$V30),] 
Data_Epith_Uniq_Genes <- Data_Epith_Uniq[,1]

library(Hmisc)
Data_Epith_Uniq_Genes_C <- toupper(as.character(Data_Epith_Uniq_Genes))
Data_Epith_Uniq_Genes_C <- as.data.frame(Data_Epith_Uniq_Genes_C)

Export_Line1 <- paste0(FileName,"_Epith")
Export_Line2 <- paste0("> Grepl epith from ",FileName)
library(dplyr)
library(plyr)
Export <- rbind.fill(as.data.frame(Export_Line1),as.data.frame(Export_Line2),Data_Epith_Uniq_Genes_C)
write.table(Export,file=paste0(PathName,"/",RVersion,"/",FileName,"_Epith.gmx"),quote = FALSE,row.names = FALSE, na = "",col.names = FALSE)
