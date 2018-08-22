# GitHub Pages

[GitHub Pages](https://pages.github.com/) はウェブサイトのホスティングサービス。
GitHub Pages を使うと手作りのウェブサイトを簡単に公開できる。
ソースコードを GitHub のリポジトリに登録して、少しの設定をするだけで利用できる。
お金はかからない。ホストが勝手に広告を出すこともない。
利用の前には、念のため [規約](https://help.github.com/articles/what-is-github-pages/) を読んだほうが良いかもしれない。
スパム、暴力、エロ等はダメ、転送量は 100GB/月 までと言った制限が書いてある。

[Tutorial](https://pages.github.com/#tutorial) に書いてあることをなぞる。
以下は https://egg-chicken.github.io/ にサイトを公開する場合の操作手順。

1. GitHub にリポジトリを作る。リポジトリ名は egg-chicken.github.io の形式とする。
2. git clone https://github.com/egg-chicken/egg-chicken.github.io.git
3. cd egg-chicken.github.io/
4. echo "Hello World" > index.html
5. git add --all
6. git commit -m "Initial commit"
7. git push -u origin master
8. curl https://egg-chicken.github.io/

あとは普通のサイトづくりと同じように index.html を書き換え、画像や css を追加したりして内容を増やしていく。
[Next Step](https://pages.github.com/#next-step) に jekyll を使ったブログの作り方や、URL のカスタマイズ等が書いてあるので、読んでみると良いかもしれない。

# Jekyll

[Jekyll](https://jekyllrb.com/) は、ブログや技術的なドキュメントを作ることを目的とした静的サイトジェネレータ。
markdown で書いたファイルから HTML を生成できる。
Jekyll はテンプレートの機能を持つ。
たとえば、共通ヘッダーやフッターを、全部のページに対してコピーすることなく作ることができる。
他にもテーマとかいろいろ機能がある。
GitHub Pages は Jekyll と協調して働けるようにデザインされているため、他のジェネレータよりもずっと簡単にできる。

[Setting up your GitHub Pages site locally with Jekyll](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/) の手順を軽くなぞる。
Jekyll & GitHub Pages をインストールし、開発を始めるまでの大まかな流れは下記の通り。

1. 適当な Git プロジェクトを作成する
2. Gemfile を作成し bundle install を実行する
4. Jekyll の基本ファイルを生成 `bundle exec jekyll new . --force`
5. Gemfile が自動変更されるのでコメントに書いてある通り修正
7. Jekyll でサイトを開発環境で実行 `bundle exec jekyll serve`
8. 適当なブラウザで http://localhost:4000 を開く

https://egg-chicken.github.io/jekyll-test/ にアクセスすると見えるようになっていた。正直な所、面倒で使い方を忘れてしまった。
