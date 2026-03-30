#!/bin/bash

# Ce script automatise la génération des certificats et clés pour le TP MQTT mTLS.

# 1. Préparation Environnement
mkdir -p certs csr
chmod 700 certs csr

# 2. Création CA Root
openssl genrsa -out ca.key 2048
openssl req -new -x509 -key ca.key -out ca.crt -days 3650 \
-subj "/C=fr/ST=ile-de-france/L=paris/O=IB/OU=IB-Data/CN=MQTT-CA"

# 3. Génération Clés & CSR
openssl genrsa -out broker.key 2048
openssl genrsa -out client.key 2048
openssl req -new -key broker.key -out broker.csr \
-subj "/C=FR/ST=Ile-de-France/L=Paris/O=IB/OU=IB-Data/CN=MQTT-test"
openssl req -new -key client.key -out client.csr \
-subj "/C=FR/ST=Ile-de-France/L=Paris/O=IB/OU=IB-Data/CN=iot-client-iba"

# 4. Signature avec CA
openssl x509 -req -in broker.csr -CA ca.crt -CAkey ca.key \
-CAcreateserial -out broker.crt -days 365
openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key \
-CAcreateserial -out client.crt -days 365

# 5. Vérification Certificats (pour affichage)
echo "\n--- Vérification Certificat Broker ---"
openssl x509 -in broker.crt -text -noout | grep "MQTT-test"
echo "\n--- Vérification Certificat Client ---"
openssl x509 -in client.crt -text -noout | grep "iba"
echo "\n--- Vérification Certificat CA ---"
openssl x509 -in ca.crt -text -noout | grep "MQTT-CA"

# 6. Sécurisation Fichiers
chmod 600 *.key
chmod 644 *.crt *.csr

echo "\nCertificats et clés générés avec succès dans le répertoire courant."
echo "N\'oubliez pas de déplacer les fichiers .key, .crt et .csr dans les dossiers certs/ et csr/ si nécessaire."
