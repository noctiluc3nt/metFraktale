

#berlin-dahlem
file1='~/Downloads/stundenwerte_RR_00403_20020128_20211231_hist/produkt_rr_stunde_20020128_20211231_00403.txt'

#hohenpeissenberg
file2='~/Downloads/stundenwerte_RR_02290_19950901_20211231_hist/produkt_rr_stunde_19950901_20211231_02290.txt'



einlesen = function(file,jahr=2020) {
	dat=read.table(file,sep=';',header=T)
	datum=format(strptime(dat$MESS_DATUM,format='%Y%m%d%H'),format='%Y-%m-%d %H:%M')
	dat_neu=data.frame(datum,dat$R1)
	colnames(dat_neu)=c('datum','rr')
	dat_sub=subset(dat_neu,format.Date(dat_neu$datum,'%Y')==as.numeric(jahr))
	return(dat_sub)
}



dat1 = einlesen(file1)
dat2 = einlesen(file2)

dat = data.frame(dat1,dat2$rr)
colnames(dat)=c('datum','rr_dahlem','rr_hohenpeissenberg')
write.table(dat,'rr_1h_2020_dahlem-hohenpeissenberg.txt',sep='\t',quote=F)


#wiedereinlesen
dat=read.table('rr_1h_2020_dahlem-hohenpeissenberg.txt',header=T,sep='\t')
