# Quick port discovery for productcatalogservice
cd src/productcatalogservice/

echo "🔍 CHECKING ACTUAL PORT USAGE:"
echo "=============================="

echo "1. Looking in server.go for port:"
grep -n "port\|Port\|Listen\|:.*[0-9]" server.go

echo
echo "2. Looking for default port values:"
grep -n "3550\|8080\|8000\|9090" *.go

echo
echo "3. Environment variable PORT usage:"
grep -n "PORT" *.go

echo
echo "4. Listen patterns:"
grep -n "Listen\|listen" *.go