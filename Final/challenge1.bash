link="127.0.0.1/IOC.html"
page=$(curl -sL "$link")

ioc=$(echo "$page" | grep "<td>" | awk -F'<td>|</td>' '{print $2}' | awk 'NR%2==1')

echo "$ioc" > "IOC.txt"
