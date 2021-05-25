## 只抓上皮細胞的Migration

## Clean variables
rm(list = ls())

######## Path setting ########
setwd(getwd()) ## Set current working directory
PathName = setwd(getwd())

RVersion = "20210525V1"
dir.create(paste0(PathName,"/",RVersion))


FileName <- c("M12808") # M14851 # M12808
Data_Ori <- read.delim(paste0(PathName,"/",FileName,"_Table.txt"),  # 資料檔名
                          header=F,          # 資料中的第一列，作為欄位名稱
                          sep="\t")

Data <- Data_Ori[,19:20]
Data_Epith <- Data[grepl("epith", Data$V19),]
Data_carcinoma <- Data[grepl("carci", Data$V19),]
# Data_EpithTTT <- Data[grepl("epith", Data$V19, ignore.case=TRUE),]
# Data_EpithTTT2 <- Data[Data$V20 %in% "dll4",]

Data_Epith_Uniq <- Data_Epith[!duplicated(Data_Epith$V20),] 
Data_Epith_Uniq_Genes <- Data_Epith_Uniq[,2]

library(Hmisc)
Data_Epith_Uniq_Genes_C <- toupper(as.character(Data_Epith_Uniq_Genes))
Data_Epith_Uniq_Genes_C <- as.data.frame(Data_Epith_Uniq_Genes_C)

Export_Line1 <- paste0(FileName,"_Epith")
Export_Line2 <- paste0("> Grepl epith from ",FileName)
library(dplyr)
library(plyr)
Export <- rbind.fill(as.data.frame(Export_Line1),as.data.frame(Export_Line2),Data_Epith_Uniq_Genes_C)
write.table(Export,file=paste0(PathName,"/",RVersion,"/",FileName,"_Epith.gmx"),quote = FALSE,row.names = FALSE, na = "",col.names = FALSE)
