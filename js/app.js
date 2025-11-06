// Simple blog system using JSON for posts data

// Load posts data
async function loadPosts() {
    try {
        const response = await fetch('posts/posts.json');
        const posts = await response.json();
        return posts;
    } catch (error) {
        console.error('Error loading posts:', error);
        return [];
    }
}

// Format date to French format
function formatDate(dateString) {
    const date = new Date(dateString);
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return date.toLocaleDateString('fr-FR', options);
}

// Display all posts on home page
async function displayPosts(postsContainer) {
    const posts = await loadPosts();
    posts.sort((a, b) => new Date(b.date) - new Date(a.date));

    postsContainer.innerHTML = posts.map(post => `
        <article class="post-card">
            <a href="post.html?id=${post.id}">
                <img src="${post.image}" alt="${post.title}">
            </a>
            <div class="post-content-wrapper">
                <div class="post-category">${post.category}</div>
                <h2><a href="post.html?id=${post.id}">${post.title}</a></h2>
                <div class="post-date">${formatDate(post.date)}</div>
                <p class="post-excerpt">${post.excerpt}</p>
                <a href="post.html?id=${post.id}" class="read-more">LIRE L'ARTICLE</a>
            </div>
        </article>
    `).join('');
}

// Display single post
async function displaySinglePost(postContainer) {
    const urlParams = new URLSearchParams(window.location.search);
    const postId = urlParams.get('id');

    if (!postId) {
        postContainer.innerHTML = '<p>Article non trouvé.</p>';
        return;
    }

    const posts = await loadPosts();
    const post = posts.find(p => p.id === postId);

    if (!post) {
        postContainer.innerHTML = '<p>Article non trouvé.</p>';
        return;
    }

    // Load post content
    try {
        const response = await fetch(`posts/${post.id}.html`);
        const content = await response.text();

        postContainer.innerHTML = `
            <article class="post">
                <header class="post-header">
                    <div class="post-category">${post.category}</div>
                    <h1 class="post-title">${post.title}</h1>
                    <div class="post-meta">${formatDate(post.date)}</div>
                </header>
                <div class="post-content">
                    ${content}
                </div>
                <a href="index.html" class="back-link">← Retour aux articles</a>
            </article>
        `;
    } catch (error) {
        console.error('Error loading post content:', error);
        postContainer.innerHTML = '<p>Erreur lors du chargement de l\'article.</p>';
    }
}

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', function() {
    const postsContainer = document.getElementById('posts-container');
    const postContainer = document.getElementById('post-container');

    if (postsContainer) {
        displayPosts(postsContainer);
    }
    if (postContainer) {
        displaySinglePost(postContainer);
    }
});
