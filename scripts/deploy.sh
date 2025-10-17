#!/bin/bash

# Script de déploiement pour le site Hugo sur S3
# Usage: ./scripts/deploy.sh [bucket-name] [cloudfront-distribution-id]

set -e

# Variables par défaut
BUCKET_NAME=${1:-"your-bucket-name"}
CLOUDFRONT_DISTRIBUTION_ID=${2:-""}
AWS_REGION="us-east-1"

echo "🚀 Déploiement du site Hugo sur S3..."

# Vérifier que AWS CLI est installé
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI n'est pas installé. Veuillez l'installer d'abord."
    exit 1
fi

# Vérifier que Hugo est installé
if ! command -v hugo &> /dev/null; then
    echo "❌ Hugo n'est pas installé. Veuillez l'installer d'abord."
    exit 1
fi

# Construire le site Hugo
echo "📦 Construction du site Hugo..."
hugo --minify

# Vérifier que le dossier public existe
if [ ! -d "public" ]; then
    echo "❌ Le dossier public n'existe pas. La construction a échoué."
    exit 1
fi

# Synchroniser avec S3
echo "☁️ Synchronisation avec S3..."
aws s3 sync public/ s3://$BUCKET_NAME --delete

# Définir les en-têtes de cache appropriés
echo "📄 Configuration des en-têtes de cache..."
aws s3 cp s3://$BUCKET_NAME/index.html s3://$BUCKET_NAME/index.html --cache-control "no-cache"

# Invalider CloudFront si un ID de distribution est fourni
if [ ! -z "$CLOUDFRONT_DISTRIBUTION_ID" ]; then
    echo "🔄 Invalidation du cache CloudFront..."
    aws cloudfront create-invalidation --distribution-id $CLOUDFRONT_DISTRIBUTION_ID --paths "/*"
fi

echo "✅ Déploiement terminé avec succès!"
echo "🌐 Votre site est disponible sur: https://$BUCKET_NAME.s3-website-$AWS_REGION.amazonaws.com"
