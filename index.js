const Lib = {tocbot}

class App {
  static start() {
    Lib.tocbot.init();
  }
}

window.onload = App.start
