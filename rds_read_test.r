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

sepa<-readRDS(gzcon(url("https://raw.githubusercontent.com/robbriers/sqlite_test/master/sepa.rds")))

str(sepa)

rivers<-sepa[sepa$Water.body.category=="River", ]

canal<-sepa[sepa$Water.body.ID=="1", ]

# subsetting is still quite slow - try feather format and remote subsetting instead

#library(feather)

#write_feather(sepa, "sepa.feather")

# huge file (174mb - not going to be feasible!)

# try dplyr subsetting instead

library(dplyr)

canal2<-filter(sepa, Water.body.ID=="1")

# compare these

system.time(canal2<-filter(sepa, Water.body.ID=="1"))
system.time(canal<-sepa[sepa$Water.body.ID=="1", ])

# not much in it!

# Could host feather file elsewhere and load/query it from there
# need to check remote subsetting

test<-read_feather("url")
canal3<-filter(test, Water.body.ID=="1")

# check relative time for filter by character or factor