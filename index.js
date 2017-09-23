const Lib = {marked, tocbot};
class Section {
  constructor(selector) {
    this.element = document.createElement('section');
    document.querySelector(selector).appendChild(this.element);
  }

  fetch(url) {
    return fetch(url)
      .then(response => response.text())
      .then(text => this.element.innerHTML = Lib.marked(text));
  }
}

class App {
  static start() {
    (new App).start();
  }

  toc() {
    Lib.tocbot.init({headingSelector: 'h1'});
  }

  start() {
    const section = new Section('#tech');
    section.fetch('https://egg-chicken.github.io/tech/github_pages.md').then(this.toc);
  }
}

App.start();
