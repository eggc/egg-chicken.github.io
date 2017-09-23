# Docker

[Docker](https://www.docker.com/what-docker) はサービスのコンテナ化を実現するプラットフォーム。
コンテナとは、簡単に言えば取り回しの良い仮想環境のこと。
コンテナはカーネルを共有するため、完全な仮想環境を提供するソフトウェアと比べるとディスク使用量やメモリなどのリソース消費量が少ない。
Docker はホストのカーネルをそのまま利用するので、Linux の上で windows を動かしたりすることはできない。

mac に Docker をインストールして簡単に操作してみる。 [Explore the application and run examples](https://docs.docker.com/docker-for-mac/#explore-the-application-and-run-examples) の前半をなぞった。

1. [Docker Community Edition for Mac](https://store.docker.com/editions/community/docker-ce-desktop-mac) をダウンロードしてインストール。
2. インストール後 `docker run hello-world` でそれらしいメッセージが出ることを確かめる。
3. docker で nginx を動かしてみる `docker run -d -p 80:80 --name webserver nginx`
4. http://localhost にアクセスしてウェルカムメッセージが出ることを確かめる。
5. `docker ps` で nginx コンテナが動いていることを確かめる。
6. `docker stop webserver` と `docker start webserver` でコンテナの停止・起動ができることを確かめる。
7. `docker rm webserver` でコンテナを削除できることを確かめる。
8. `docker images` で消したコンテナのイメージが残っていることを確かめる。
9. `docker rmi nginx` でさっきpullしたイメージを削除できることを確かめる。

## Docker Container

[Get started](https://docs.docker.com/get-started/part2) をなぞる。
定義されているコンテナ hello-world や nginx だけでは物足りないので
[Dockerfile](https://docs.docker.com/get-started/part2/#define-a-container-with-a-dockerfile)
を使ってそれらをカスタマイズして自分のものにする。
Dockerfile の内容は元になるイメージ、パッケージの追加方法、
ネットワーク・インターフェースやディスクドライブへのアクセス方法など。
Dockerfile からイメージを作ると、そこからいつでも同じ環境を持つコンテナを作ることができる。

1. [Dockerfile](https://docs.docker.com/get-started/part2/#dockerfile) に書いてある内容をコピーペーストする。
2. 同様に requirements.txt と app.py をつくる。
3. `docker build -t friendlyhello .` でさっき作った Dockerfile からイメージを作る。
4. `docker images` で friendlyhelll が作られていることを確かめる。
5. `docker run -p 4000:80 friendlyhello` でコンテナを起動する。
6. http://localhost:4000 へアクセスして Hello World が出ることを確かめる。カウンタはあとで動かす。
7. `docker run -p 4000:80 friendlyhello` でバックグラウンドでコンテナを起動する。
8. `docker container ls` でコンテナが見えることを確認する。container id をメモする。
9. `docker stop <CONTAINER_ID>` でさっきメモしたIDを指定すると、コンテナを停止できることを確かめる。

次は、[DockerHub](https://hub.docker.com/) にビルドしたイメージを公開する。
誰でも、どこからでも同じ環境を作れるようになる。

1. [Docker cloud](https://cloud.docker.com/) にアクセスして Docker アカウントを作る。
2. clould.docker.com 上でブラウザを操作して get-started リポジトリを作る（この操作いらないかも）
3. アカウントが作れたら `docker login` を実行してターミナル上でログインする。
4. `docker tag friendlyhello eggc/get-started:part1` を使って以前でビルドしたイメージにタグを付ける。
5. `docker images` でタグ付けできたことを確かめる。
6. `docker push eggc/get-started:part1` で自分のレジストリに push する。
8. 同じ環境を作れることを試すため `docker image rm -f <IMAGE_ID>` でローカルのイメージを削除する。
9. `docker run -p 4000:80 eggc/get-started:part1` で前準備なしにさっきの環境が作れることを確かめる。

## Docker Service

次は元記事の [part3](https://docs.docker.com/get-started/part3) をなぞる。
コンテナのおかげで、いつでもどのマシンでも同じ環境を作れるようになった。
けれども、サービスの本番環境ではコンテナを複数個組み合わせて動かしたり、負荷分散のため並列起動するかもしれない。
そのような本番環境の振る舞いは [docker-compose.yml](https://docs.docker.com/get-started/part3/#your-first-docker-composeyml-file)
に書き込む。

1. [docker-compose.yml](https://docs.docker.com/get-started/part3/#your-first-docker-composeyml-file) に書いてある内容をコピーペーストする。
2. `docker swarm init` を実行（解説はあとで）
3. `docker stack deploy -c docker-compose.yml getstartedlab` で docker-compose をもとにデプロイする。
4. `docker service ls` で web コンテナのレプリカが5個あることを確かめる。
5. `docker service ps getstartedlab_web` で各レプリカのプロセスを確かめる。 `docker container ls` でも見える。
6. `curl http://localhost` を連打して container id が変化してラウンドロビンすることを確かめる。
7. docker-compose.yml を編集して replicas を3個に減らす。
8. `docker stack deploy -c docker-compose.yml getstartedlab` で再度デプロイする。
8. 30秒くらい待ってから `docker container ls` とか `docker ps` でレプリカが減ってるのを確かめる。
9. `docker stack rm getstartedlab` でサービスを停止する。`docker ps` で確かめる。
10. `docker node ls` で `docker swarm` のプロセスが生きているのを確かめる。
11. `docker swarm leave --force` で docker swarm を停止させる。 `docker node ls` で確かめる。

## Docker Swarm

次は元記事の [part4](https://docs.docker.com/get-started/part4) をなぞる。
VirtualBox を使って二台のマシンの仮想マシンでクラスタを作る。
今回は仮想マシンを使うが、物理的に二台のマシンを用意してクラスタを作る事もできる。
part3 で出てきた [swarm](https://docs.docker.com/get-started/part4/#understanding-swarm-clusters) は
docker が動いているマシンのグループのこと。swarm に参加したマシンは node と呼ぶ。
node の中で swarm manager は swarm の中の１個だけで、他は worker となる。

1. [VirtualBox](https://www.virtualbox.org/) をダウンロードしてインストールする。
2. `docker-machine create --driver virtualbox myvm1` で virtual box 用の仮想マシンイメージをダウンロードして、バックグラウンド起動する。
3. `docker-machine create --driver virtualbox myvm2` でもう１個起動させる。
4. `docker-machine ls` で仮想マシンが２個起動していることを確認する。
5. `docker-machine ssh myvm1` で仮想マシン1に ssh ログインして下の操作を行う。
  1. `docker swarm init --advertise-addr 192.168.99.100:2377` でクラスタを作る。join する方法が出力されるのでメモを取る。
6. `docker-machine ssh myvm2` で仮想マシン2に ssh ログインして下の操作を行う。token はメモした物を使う。
  1. `docker swarm join --token SWMTKN-1-32gb4b6p0tj68qdhevgdidkewgixrqi6ramipeedislk71j23a-23hngch1tmomo8qbj8rvy80fm 192.168.99.100:2377`
5. `docker-machine ssh myvm1` で仮想マシン1に ssh ログインして下の操作を行う。
  1. `docker node ls` で swarm に参加しているマシンが2台あることを確かめる。
9. `docker-machine scp docker-compose.yml myvm1:~` で docker-compose.yml を転送する。
10. `docker-machine ssh myvm1` で仮想マシン1に ssh ログインして下の操作を行う。
  1. `docker stack deploy -c docker-compose.yml getstartedlab` でデプロイする。
  2. `docker stack ps getstartedlab` でクラスタで動いているプロセスを確認する。
12. `curl http://192.168.99.100` と `curl http://192.168.99.101` を何回か叩いてみて、どちらもすべてのプロセスを巡回することを確認する。
13. `docker-machine ssh myvm1 "docker stack rm getstartedlab"` でサービスを停止する。
14. `docker-machine ssh myvm2 "docker swarm leave" で worker` を停止する。
15. `docker-machine ssh myvm1 "docker swarm leave --force"` で swarm を停止する。
15. `docker-machine stop myvm2 && docker-machine stop myvm1` で VM を停止する。

part5 と part6 は…。疲れたのでこれくらいで。
