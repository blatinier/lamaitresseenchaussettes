# La maîtresse en chaussettes - Blog

Réplique simple du blog "La maîtresse en chaussettes" avec HTML, CSS et JavaScript vanilla.

## Structure du projet

```
lamaitresseenchaussettes/
├── index.html          # Page d'accueil avec liste des posts
├── post.html           # Template pour afficher un post
├── about.html          # Page "À propos"
├── css/
│   └── style.css       # Styles du site
├── js/
│   └── app.js          # JavaScript pour charger les posts
├── posts/
│   ├── posts.json      # Base de données des posts (titres, dates, etc.)
│   └── *.html          # Contenu de chaque post
├── images/             # Dossier pour les images
└── add-post.sh         # Script pour ajouter facilement un nouveau post
```

## Comment voir le site localement

### Option 1: Ouvrir directement dans le navigateur
Double-cliquez sur `index.html`

**Note**: Certains navigateurs peuvent bloquer le chargement des fichiers JSON pour des raisons de sécurité. Si ça ne marche pas, utilisez l'option 2.

### Option 2: Utiliser un serveur local
```bash
cd ~/git/lamaitresseenchaussettes
python3 -m http.server 8000
```

Puis ouvrez dans votre navigateur: `http://localhost:8000`

## Comment ajouter un nouveau post

### Méthode simple (recommandée)

1. Ouvrez un terminal dans le dossier du blog
2. Exécutez le script:
   ```bash
   ./add-post.sh
   ```
3. Répondez aux questions (titre, catégorie, date, extrait)
4. Le script crée un fichier dans `posts/` que vous pouvez éditer
5. Ouvrez le fichier avec notepad et écrivez votre contenu
6. Sauvegardez et c'est fini !

### Méthode manuelle

#### Étape 1: Créer le fichier du post

Créez un nouveau fichier dans le dossier `posts/` avec un nom en minuscules et tirets.
Exemple: `posts/mon-nouveau-post.html`

Écrivez votre contenu en HTML simple:

```html
<p>Votre premier paragraphe...</p>

<h3>Un sous-titre</h3>

<p>Un autre paragraphe...</p>

<ul>
    <li>Premier point</li>
    <li>Deuxième point</li>
</ul>
```

#### Étape 2: Ajouter l'entrée dans posts.json

Ouvrez le fichier `posts/posts.json` avec notepad.

Ajoutez une nouvelle entrée **au début** du tableau (après le premier `[`):

```json
[
  {
    "id": "mon-nouveau-post",
    "title": "Mon nouveau post",
    "category": "Vie de classe",
    "date": "2024-04-15",
    "excerpt": "Une courte description du post en 1-2 phrases."
  },
  ... autres posts ...
]
```

**Important**:
- L'`id` doit correspondre au nom du fichier (sans `.html`)
- N'oubliez pas la virgule `,` après votre nouveau post
- La date doit être au format `YYYY-MM-DD`
- Les catégories existantes: "Art visuel", "Jeu collectif", "Lecture offerte", "Vie de classe"

#### Étape 3: Vérifier

Ouvrez `index.html` dans votre navigateur pour voir votre nouveau post !

## Catégories disponibles

- **Art visuel** : Activités artistiques et créatives
- **Jeu collectif** : Jeux pour la classe
- **Lecture offerte** : Lectures partagées avec les élèves
- **Vie de classe** : Organisation et vie quotidienne de la classe

## Déploiement automatique

Le site est configuré pour se déployer automatiquement sur Cloudflare Pages à chaque push vers GitHub.

**Voir le guide complet**: [DEPLOYMENT.md](DEPLOYMENT.md)

### Quick Start

1. Créez un dépôt GitHub et poussez le code
2. Connectez le dépôt à Cloudflare Pages
3. À chaque `git push`, le site se déploie automatiquement !

### Workflow pour publier un nouveau post

```bash
# 1. Ajouter le post
./add-post.sh

# 2. Commit et push
git add .
git commit -m "Nouveau post: Titre"
git push

# 3. Le site est automatiquement mis à jour !
```

## Format HTML simple pour les posts

Voici les balises HTML les plus utiles:

```html
<!-- Paragraphe -->
<p>Votre texte...</p>

<!-- Sous-titres -->
<h3>Titre de niveau 3</h3>

<!-- Gras et italique -->
<strong>Texte en gras</strong>
<em>Texte en italique</em>

<!-- Liste à puces -->
<ul>
    <li>Premier point</li>
    <li>Deuxième point</li>
</ul>

<!-- Liste numérotée -->
<ol>
    <li>Première étape</li>
    <li>Deuxième étape</li>
</ol>

<!-- Lien -->
<a href="https://exemple.com">Texte du lien</a>

<!-- Image -->
<img src="images/mon-image.jpg" alt="Description de l'image">
```

## Besoin d'aide ?

Le site utilise:
- HTML pour la structure
- CSS pour le design (fichier `css/style.css`)
- JavaScript pour charger dynamiquement les posts (fichier `js/app.js`)
- Un fichier JSON comme "base de données" simple (`posts/posts.json`)

Aucun framework compliqué, tout est simple et modifiable avec un éditeur de texte basique !
