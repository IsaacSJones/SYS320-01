
touch /var/www/html/report.html
report="report.txt"
page="/var/www/html/report.html"

echo "<html>" > "$page"
echo "<body>" >> "$page"
echo "Access logs with IOC indicators:" >> "$page"
echo "<table border=\"1\">" >> "$page"

while IFS= read -r line; do
    ip_address=$(echo "$line" | awk '{print $1}')
    datetime=$(echo "$line" | awk '{print $2}')
    pattern=$(echo "$line" | awk '{print $3}')

    
    echo "<tr><td>$ip_address</td><td>$datetime</td><td>$pattern</td></tr>" >> "$page"
done < "$report"

echo "</table>" >> "$page"
echo "</body>" >> "$page"
echo "</html>" >> "$page"
