# Script Bash pour la mise à jour d'Uptime Kuma

Ce script Bash est utilisé pour mettre à jour une installation existante d'Uptime Kuma en récupérant la dernière version disponible depuis GitHub. Le script effectue les étapes suivantes :

1. Accéder au dossier d'installation d'Uptime Kuma :
```bash
cd /opt/uptime-kuma/
```

2. Récupérer la dernière version disponible en utilisant l'API GitHub :
```bash
tag=$(curl --silent "https://api.github.com/repos/louislam/uptime-kuma/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
```

3. Mettre à jour depuis le référentiel Git en utilisant la balise (tag) récupérée :
```bash
git fetch --all
git checkout $tag --force
```

4. Installer les dépendances et les précompilations :
```bash
npm install --production
npm run download-dist
```

5. Activer l'option d'affichage en iframe :
```bash
sed -i 's/\(.*disableFrameSameOrigin.*=.*\)false;/\1true;/' server/server.js
```

6. Redémarrer le service Uptime Kuma (adapté selon votre configuration) :
```bash
service uptimeKuma restart
```

Assurez-vous de modifier le chemin du dossier d'installation (`/opt/uptime-kuma/`) selon votre configuration.

## Prérequis
- Node.js et npm doivent être installés.
- L'utilisateur exécutant le script doit avoir les permissions nécessaires pour accéder au dossier d'installation et redémarrer le service.

## Utilisation
1. Copiez le contenu du script dans un fichier avec l'extension `.sh`, par exemple `update-uptime-kuma.sh`.

2. Ouvrez un terminal et exécutez la commande suivante pour rendre le script exécutable :
```bash
chmod +x update-uptime-kuma.sh
```

3. Exécutez le script en utilisant la commande suivante :
```bash
./update-uptime-kuma.sh
```

Le script effectuera les étapes nécessaires pour mettre à jour votre installation d'Uptime Kuma en utilisant la dernière version disponible depuis le référentiel GitHub.

**Note :** Assurez-vous d'avoir une sauvegarde de votre installation existante avant d'exécuter ce script, au cas où quelque chose ne se passerait pas comme prévu.
