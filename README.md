# :bento: Restaurant Landing Page :bento:

> This website is built with [Hugo ♥](https://gohugo.io/) -- [Live demo link](https://lowess.github.io/restaurant-landingpage/)

## 🚀 Déploiement Automatique

Ce projet est configuré pour un déploiement automatique sur AWS S3 via Drone CI.

### Configuration requise
- Bucket S3 configuré pour l'hébergement de sites web statiques
- Credentials AWS configurés dans les secrets Drone
- Instance Drone CI configurée

### Secrets Drone à configurer
- `aws_access_key_id` - Votre clé d'accès AWS
- `aws_secret_access_key` - Votre clé secrète AWS

### Configuration du bucket S3
```bash
# Créer le bucket
aws s3 mb s3://resto-files-ccm2

# Configurer pour l'hébergement web
aws s3 website s3://resto-files-ccm2 --index-document index.html --error-document 404.html
```

## Production release process

|                 |                    |
| --------------- | ------------------ |
| Distributor ID: | Ubuntu             |
| Description     | Ubuntu 24.04.1 LTS |
| Release         | 24.04              |
| Codename        | noble              |

---

* Install [Nginx webserver](https://www.nginx.com/)

```bash
apt-get update
apt-get install nginx
```

* Configure your webserver to run on port `8080`

```
# Edit the following file and set server port to 8080
nano /etc/nginx/sites-enabled/default
```

* Restart the `nginx` webserver 

```
systemctl status nginx
systemctl restart nginx
```

* Download the Website release from Github / Extract the archive and place it under Nginx `/var/www/html`

```bash
# Devenir root
sudo su -

# Installer la version du site
curl -L  https://github.com/Lowess/restaurant-landingpage/archive/v1.0.0.tar.gz --output web.tar.gz

tar xzf web.tar.gz --strip 1 -C /var/www/html

rm -f web.tar.gz
```
