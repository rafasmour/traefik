#source https://arminreiter.com/2022/01/create-your-own-certificate-authority-ca-using-openssl/
#customised it a little to my needs
export $(grep -v '^#' ./.env | xargs)
mkdir certs
cd certs
# generate aes encrypted private key
openssl genrsa -aes256 -out $CANAME.key 4096
# create certificate, 1826 days = 5 years
openssl req -x509 -new -nodes -key $CANAME.key -sha256 -days 365 -out $CANAME.crt -subj "/CN=$CN/C=$C/ST=$ST/L=$L/O=$O"
# create certificate for service
openssl req -new -nodes -out $MYCERT.csr -newkey rsa:4096 -keyout $MYCERT.key -subj "/CN=$CN/C=$C/ST=$ST/L=$L/O=$O"
# create a v3 ext file for SAN properties
cat > $MYCERT.v3.ext << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = *.$DOMAIN
IP.1 = $IP
EOF
openssl x509 -req -in $MYCERT.csr -CA $CANAME.crt -CAkey $CANAME.key -CAcreateserial -out $MYCERT.crt -days 365 -sha256 -extfile $MYCERT.v3.ext
