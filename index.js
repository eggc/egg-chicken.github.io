const Lib = {marked, tocbot}

class App {
  static start() {
    var app = (new App)
    app.markdown()
    app.toc()
  }

  toc() {
    Lib.tocbot.init({headingSelector: 'h1'})
  }

  markdown() {
    var pre = document.querySelector('#source-code')
    var main = document.querySelector('#tech')
    var text = pre.innerText
    main.innerHTML = Lib.marked(text)
  }
}

window.onload = App.start
