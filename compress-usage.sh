#!/bin/sh
# Commands(zip/unzip, tar, gzip/gunzip, bzip2/bunzip2, 7zip) used to compress and uncompress files and directories
# Usage: sh compress-usage.sh

# 1. ZIP Command
# --------------
# Compress one or more files
zip result.zip file1 file2 file3

# To zip a directory(-r -> recursive)
zip -r squash.zip ./output

# To uncompress: (this unzips it in our current working directory)
unzip squash.zip

# 2. TAR / GZIP / BZIP2 Commands
# ------------------------------
# Typically one uses 'tar', a GNU program, to create an uncompressed archive and either 'gzip' or 'bzip2' to compress that archive. 
# The corresponding 'gunzip' and 'bunzip2' commands can be used to uncompress said archive, or can just use flags along with
# the 'tar' command to perform the uncompression.

# To compress and archive ./output directory
tar -zcvf result.tgz ./output

# To un compress the compressed file
tar -xvzf result.tgz

# To perform archive(without -z) and compress in a separate steps tar cvf result.tar ./output. The following will create result.tar.gz
gzip result.tar

# To un compress(-x)
tar -xvzf result.tar.gz