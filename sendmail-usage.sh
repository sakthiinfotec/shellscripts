#!/bin/bash

from="sakthi@mail.com"
mailto="dev-team@mail.com"
subject="Job - Success!"
boundary="ZZ_/afg6432dfgkl.94531q"

alert_date_time=$(date "+%Y-%m-%d %T %Z")
last_run_on=$(date "+%Y-%m-%d %T %Z")
report_path=/usr/report-job/output/report

body="$(cat <<-EOF
  <html><body>Hi,
  <br/>
  <br/>
  <p>
  <b>Alert date: </b>${alert_date_time}<br/>
  <b>Last successful run on: </b>${last_run_on}<br/>
  <b>Report path: </b>${report_path}<br/>
  <p/>
  <br/>
  Thanks!
  </html>
EOF
)"

# body="This is the body of our email"
declare -a attachments
attachments=( "job_20171015.log.zip" )

get_mimetype(){
  # warning: assumes that the passed file exists
  file --mime-type "$1" | sed 's/.*: //'
}

# Build headers
{

printf '%s\n' "From: $from
To: $mailto
Subject: $subject
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=\"$boundary\"

--${boundary}
Content-Type: text/html; charset=\"US-ASCII\"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

$body
"

# now loop over the attachments, guess the type
# and produce the corresponding part, encoded base64
for file in "${attachments[@]}"; do

  [ ! -f "$file" ] && echo "Warning: attachment $file not found, skipping" >&2 && continue

  mimetype=$(get_mimetype "$file")

  printf '%s\n' "--${boundary}
Content-Type: $mimetype
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=\"$file\"
"

  base64 "$file"
  echo
done

# print last boundary with closing --
printf '%s\n' "--${boundary}--"

} | sendmail -t -oi   # one may also use -f here to set the envelope-from


# Send a single file as attachment
# --------------------------------
from="sakthi@mail.com"
mailto="dev-team@mail.com"
subject="Report - Success!"
boundary="ZZ_/afg6432dfgkl.94531q"

alert_date_time=$(date "+%Y-%m-%d %T %Z")
last_run_on=$(date "+%Y-%m-%d %T %Z")
report_path=/usr/report-job/output/report
log_file="job_20171015.log.zip"

body="$(cat <<-EOF
  <html><body>Hi Team,
  <br/>
  <br/>
  <p>
  <b>Alert date: </b>${alert_date_time}<br/>
  <b>Last successful run on: </b>${last_run_on}<br/>
  <b>Report path(at Helios Env.): </b>${report_path}<br/>
  <p/>
  <br/>
  Thanks!
  </html>
EOF
)"

# Build headers
{

printf '%s\n' "From: $from
To: $mailto
Subject: $subject
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=\"$boundary\"

--${boundary}
Content-Type: text/html; charset=\"US-ASCII\"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

$body
"

printf '%s\n' "--${boundary}
Content-Type: application/zip
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=\"$log_file\"
"
base64 "$log_file"
echo

printf '%s\n' "--${boundary}--"

} | sendmail -t -oi
