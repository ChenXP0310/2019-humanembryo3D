TADsingal_Filt<-function(A){
keep<- c();
for(i in 1:nrow(A)){
  if(is.na(A$V4[i])){next;}
  j=i-50;if(j<=0){j=1}
  m=i+50;if(m>=nrow(A)){m=nrow(A)}	
  if(any(is.na(A$V4[j:m]))){next;}else{keep<- c(keep,i)}
}
return(A[keep,])
}

TADsingal_depth<-function(A){
keep<- c();
for(i in 1:nrow(A)){
  if(is.na(A$V4[i])){next;}
  j=i-50;if(j<=0){j=1}
  m=i+50;if(m>=nrow(A)){m=nrow(A)}	
  if(sum(A$V4[j:m])<10){next;}else{keep<- c(keep,i)}
}
return(A[keep,])
}

header<- function(B){
  B$name <- paste(B$V1,B$V2,B$V3,sep="_")
  return(B)
}

a<- read.table(paste("Human.blastocyst.TADsignal.txt",sep=""),header=F,na.strings = "NA")  ## hardcoding for inputfile
TAD<- list(HBlt<-a)
names(TAD)<-c("HBlt")
TAD_Filt<-lapply(TAD,TADsingal_Filt)
TAD_Filt2<- lapply(TAD_Filt, header)
TAD_depth<- lapply(TAD_Filt2,TADsingal_depth)
print(var(TAD_Filt2$HBlt$V4))


