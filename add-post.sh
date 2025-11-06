#!/bin/bash

# Script simple pour ajouter un nouveau post au blog
# Usage: ./add-post.sh

echo "=== Ajout d'un nouveau post ==="
echo ""

# Demander les informations du post
read -p "Titre du post: " title
read -p "Catégorie (Art visuel/Jeu collectif/Lecture offerte/Vie de classe): " category
read -p "Date (format YYYY-MM-DD, ex: 2024-04-15): " date
read -p "Extrait court (1-2 phrases): " excerpt

# Créer l'ID du post (slug)
id=$(echo "$title" | iconv -t ascii//TRANSLIT | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$//')

echo ""
echo "ID du post: $id"
echo ""

# Créer le fichier HTML du post
post_file="posts/${id}.html"

echo "Création du fichier $post_file..."
echo "Ouvrez ce fichier avec notepad et écrivez le contenu de votre post."
echo ""
echo "Format HTML simple:"
echo "<p>Votre premier paragraphe...</p>"
echo ""
echo "<h3>Un sous-titre</h3>"
echo "<p>Un autre paragraphe...</p>"
echo ""
echo "<ul>"
echo "  <li>Premier point</li>"
echo "  <li>Deuxième point</li>"
echo "</ul>"
echo ""

# Créer un template vide
cat > "$post_file" << 'EOF'
<p>Écrivez votre contenu ici...</p>

<h3>Un sous-titre</h3>

<p>Un autre paragraphe...</p>

<ul>
    <li>Premier point</li>
    <li>Deuxième point</li>
</ul>
EOF

echo "Fichier créé: $post_file"
echo "Éditez ce fichier avec notepad pour ajouter votre contenu."
echo ""
read -p "Appuyez sur Entrée quand vous avez fini d'éditer le fichier..."

# Ajouter l'entrée dans posts.json
echo ""
echo "Ajout de l'entrée dans posts.json..."

# Lire le fichier JSON actuel
json_content=$(cat posts/posts.json)

# Créer la nouvelle entrée
new_entry=$(cat << EOF
  {
    "id": "$id",
    "title": "$title",
    "category": "$category",
    "date": "$date",
    "excerpt": "$excerpt"
  }
EOF
)

# Insérer la nouvelle entrée au début du tableau JSON
# On enlève le dernier ] et on ajoute la nouvelle entrée
temp_json=$(echo "$json_content" | sed '$ d')  # Enlever le dernier ]
temp_json="${temp_json},"$'\n'"${new_entry}"$'\n'"]"

echo "$temp_json" > posts/posts.json

echo ""
echo "✓ Post ajouté avec succès!"
echo ""
echo "Pour voir votre blog:"
echo "1. Ouvrez le fichier index.html dans un navigateur"
echo "2. Ou utilisez: python3 -m http.server 8000"
echo "   Puis ouvrez: http://localhost:8000"
echo ""
