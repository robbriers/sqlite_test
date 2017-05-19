# testing read of rds (uncompressed and compressed)

# try rivers as a max test

rds_file <- "rivers.rds"
saveRDS(rivers, rds_file, compress=FALSE)

# and compressed version

rds_file <- "rivers_c.rds"
saveRDS(rivers, rds_file, compress=TRUE)

# read back in

rivers2<-readRDS(url("https://raw.githubusercontent.com/robbriers/sqlite_test/master/rivers.rds"))
rivers3<-readRDS(gzcon(url("https://raw.githubusercontent.com/robbriers/sqlite_test/master/rivers_c.rds")))

# compressed RDS is massively faster to read back in!
# this is now the compressed RDS version - default to be used
sepa<-readRDS(gzcon(url("https://raw.githubusercontent.com/robbriers/sqlite_test/master/sepa.rds")))

# comparing subsetting times
library(dplyr)

# compare these

# convert category to character rather than factor
sepa2<-sepa
sepa2$Water.body.category<-as.character(sepa2$Water.body.category)

# compare different versions
# base
system.time(rivers<-sepa[sepa$Water.body.category=="River", ])
# dplyr
system.time(rivers2<-filter(sepa, Water.body.category=="River"))
# character base
system.time(rivers3<-sepa2[sepa2$Water.body.category=="River", ])
# character dplyr
system.time(rivers4<-filter(sepa2, Water.body.category=="River"))

# character dplyr best
