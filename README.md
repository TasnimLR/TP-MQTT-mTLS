# TP : Configuration mTLS MQTT avec OpenSSL

Ce dépôt contient les fichiers nécessaires à la réalisation du TP sur la configuration mTLS (mutual Transport Layer Security) pour MQTT.

## Contenu du dépôt

*   `scripts/generate_certs.sh` : Un script Bash qui automatise toutes les étapes de génération des clés et certificats (CA, broker, client) nécessaires au TP.
*   `mosquitto.conf` : Un exemple de fichier de configuration pour le broker Mosquitto, adapté pour utiliser le mTLS.
*   `.gitignore` : Fichier pour exclure les clés privées et certificats du suivi Git, conformément aux bonnes pratiques de sécurité.

## Comment utiliser ce TP

1.  **Cloner le dépôt** :
    ```bash
    git clone https://github.com/TasnimLR/TP-MQTT-mTLS.git
    cd TP-MQTT-mTLS
    ```
2.  **Générer les certificats** :
    Exécutez le script `generate_certs.sh` pour créer tous les fichiers de clés et certificats localement. Ce script affichera également les vérifications des certificats.
    ```bash
    chmod +x scripts/generate_certs.sh
    ./scripts/generate_certs.sh
    ```
3.  **Configurer Mosquitto** :
    Utilisez le fichier `mosquitto.conf` fourni comme base pour configurer votre broker Mosquitto. N'oubliez pas de copier les fichiers `ca.crt`, `broker.crt` et `broker.key` dans le répertoire `/etc/mosquitto/certs/` (ou l'emplacement spécifié dans votre configuration Mosquitto).
4.  **Tester la configuration** :
    Une fois Mosquitto configuré et démarré, vous pouvez utiliser les commandes `mosquitto_pub` et `mosquitto_sub` (avec les options `--cafile`, `--cert`, `--key`) pour tester la connexion mTLS.

## Note importante sur la sécurité

Conformément aux bonnes pratiques de cybersécurité, les clés privées et les certificats générés par le script `generate_certs.sh` ne sont **pas** inclus dans ce dépôt Git. Ils doivent être générés localement et manipulés avec la plus grande prudence. Ce dépôt fournit uniquement les outils et la configuration pour les créer et les utiliser. 
