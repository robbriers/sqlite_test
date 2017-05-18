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
