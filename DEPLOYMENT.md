# Guide de déploiement sur Cloudflare Pages

Ce guide explique comment déployer automatiquement le blog sur Cloudflare Pages.

## Option 1: Déploiement automatique via GitHub (Recommandé)

Cette option déploie automatiquement le site à chaque push sur GitHub.

### Étape 1: Créer un dépôt GitHub

1. Allez sur [GitHub](https://github.com) et créez un nouveau dépôt
2. Nommez-le `lamaitresseenchaussettes` (ou autre nom)
3. Ne cochez aucune option (pas de README, .gitignore, etc.)
4. Cliquez sur "Create repository"

### Étape 2: Pousser le code vers GitHub

```bash
cd ~/git/lamaitresseenchaussettes
git remote add origin https://github.com/VOTRE-USERNAME/lamaitresseenchaussettes.git
git push -u origin main
```

Remplacez `VOTRE-USERNAME` par votre nom d'utilisateur GitHub.

### Étape 3: Connecter Cloudflare Pages

1. Allez sur [Cloudflare Dashboard](https://dash.cloudflare.com/)
2. Sélectionnez "Workers & Pages" dans le menu
3. Cliquez sur "Create application" > "Pages" > "Connect to Git"
4. Connectez votre compte GitHub
5. Sélectionnez le dépôt `lamaitresseenchaussettes`
6. Configuration:
   - **Production branch**: `main`
   - **Build command**: (laisser vide)
   - **Build output directory**: `/`
7. Cliquez sur "Save and Deploy"

### Étape 4: Configuration des secrets GitHub (optionnel - pour GitHub Actions)

Si vous voulez utiliser GitHub Actions au lieu du déploiement direct de Cloudflare:

1. Sur GitHub, allez dans votre dépôt
2. Settings > Secrets and variables > Actions
3. Ajoutez ces secrets:
   - `CLOUDFLARE_API_TOKEN`:
     - Sur Cloudflare: My Profile > API Tokens > Create Token
     - Utilisez le template "Edit Cloudflare Workers"
   - `CLOUDFLARE_ACCOUNT_ID`:
     - Sur Cloudflare: Workers & Pages > Overview
     - Copiez l'Account ID à droite

### Résultat

Maintenant, à chaque fois que vous faites un `git push`, le site sera automatiquement déployé !

## Option 2: Déploiement direct (sans GitHub)

### Via Wrangler CLI

1. Installez Wrangler:
   ```bash
   npm install -g wrangler
   ```

2. Connectez-vous à Cloudflare:
   ```bash
   wrangler login
   ```

3. Déployez:
   ```bash
   cd ~/git/lamaitresseenchaussettes
   wrangler pages deploy . --project-name=lamaitresseenchaussettes
   ```

### Via l'interface web (Drag & Drop)

1. Allez sur [Cloudflare Pages](https://dash.cloudflare.com/)
2. Cliquez sur "Create a project" > "Upload assets"
3. Glissez-déposez le dossier `lamaitresseenchaussettes`
4. Donnez un nom au projet
5. Cliquez sur "Deploy"

## Workflow pour ajouter un nouveau post

Une fois le déploiement automatique configuré:

1. **Ajoutez votre post**:
   ```bash
   cd ~/git/lamaitresseenchaussettes
   ./add-post.sh
   ```

2. **Commitez et poussez**:
   ```bash
   git add .
   git commit -m "Ajout d'un nouveau post: Titre du post"
   git push
   ```

3. **C'est automatique** ! Le site sera déployé en 1-2 minutes.

## Vérifier le déploiement

Sur Cloudflare Pages, vous verrez:
- L'historique des déploiements
- Le statut (en cours / réussi / échoué)
- L'URL de votre site: `https://lamaitresseenchaussettes.pages.dev`

## Domaine personnalisé (optionnel)

Pour utiliser votre propre domaine (ex: `lamaitresseenchaussettes.fr`):

1. Sur Cloudflare Pages, cliquez sur votre projet
2. Allez dans "Custom domains"
3. Cliquez sur "Set up a custom domain"
4. Suivez les instructions pour configurer vos DNS

Si votre domaine est déjà sur Cloudflare, c'est automatique. Sinon, vous devrez changer les nameservers de votre domaine.

## Besoin d'aide ?

- Documentation Cloudflare Pages: https://developers.cloudflare.com/pages/
- Support Cloudflare: https://community.cloudflare.com/
