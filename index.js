const container = document.querySelector('#tech');
const url = 'https://egg-chicken.github.io/tech/github_pages.md';
fetch(url)
  .then(response => response.text())
  .then(text => container.innerHTML = marked(text));
