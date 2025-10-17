# :bento: Restaurant Landing Page :bento:

> This website is built with [Hugo ♥](https://gohugo.io/) -- [Live demo link](https://lowess.github.io/restaurant-landingpage/)

## 🚀 Déploiement Automatique

Ce projet est configuré pour un déploiement automatique sur AWS S3 via GitHub Actions.

### Configuration requise
- Bucket S3 configuré pour l'hébergement de sites web statiques
- Credentials AWS configurés dans les secrets GitHub
- CloudFront (optionnel) pour de meilleures performances

### Secrets GitHub à configurer
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY` 
- `S3_BUCKET_NAME`
- `CLOUDFRONT_DISTRIBUTION_ID` (optionnel)

📖 **Voir [DEPLOYMENT.md](DEPLOYMENT.md) pour le guide complet de déploiement**

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
