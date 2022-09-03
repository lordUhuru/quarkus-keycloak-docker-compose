#script generates a keystore and uses this to generate a self-signed certificate to use in keycloak
keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore server.keystore

keytool -export -alias server -keystore server.keystore -file public.der

openssl x509 -inform der -in public.cert -out certificate.pem

keytool -importkeystore -srckeystore server.keystore -destkeystore keystore.p12 -deststoretype PKCS12

openssl pkcs12 -in keystore.p12  -nodes -nocerts -out server.key