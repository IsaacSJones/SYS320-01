
log="$1"
ioc="$2"

cat "$log" | grep -i -f "$ioc" | cut -d ' ' -f1,4,7 > report.txt
