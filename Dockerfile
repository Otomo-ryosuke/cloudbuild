# Pythonイメージをベースにする
FROM python:3.9-slim

# 作業ディレクトリを設定
WORKDIR /usr/src/app

# index.htmlを作業ディレクトリにコピー
COPY index.html .

# ポート8080を開放
EXPOSE 8080

# http.serverモジュールを使ってHTTPサーバを起動
CMD ["python", "-m", "http.server", "8080"]
