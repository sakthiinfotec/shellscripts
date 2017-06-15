#!/bin/sh
# Commands(zip/unzip, tar, gzip/gunzip, bzip2/bunzip2, 7za, jar) used to compress and uncompress files and directories
# Usage: sh compress-usage.sh

# 1. ZIP Command
# --------------
# Compress one or more files
zip result.zip file1 file2 file3

# Omit directory path(-j junk path)
zip -j compressed.zip /path/to/file

# To zip a directory(-r -> recursive)
zip -r result.zip ./output

# To uncompress: (this unzips it in our current working directory)
unzip result.zip

# unzips files under specified path
unzip result.zip -d /home/sakthi/downloads

# Omit -j -> ignore creation of(junk) directory path -o -> overwrite
unzip -jo compressed.zip

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

# 3. Java's JAR command
# ---------------------
# Sometimes java's jar(java archive) command also handy to archive files/directories
# Archive using jar(-M to ignore adding manifest info, otherwise by default it adds manifest info inside the archive)
jar -cvfM result.zip ./output

# Extract the archive
jar -xvf result.zip
