# Set up some toy data
gen_one = function(i, fname)
{
    d = data.frame(y = i, z = i * 1:10)
    saveRDS(d, file = fname)
}
nchunks = 4L
fnames = paste0("x", seq(nchunks), ".rds")
Map(gen_one, seq(nchunks), fnames)
