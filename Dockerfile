# Pythonイメージをベースにする
FROM python:3.12

WORKDIR /usr/src/app

COPY . /usr/src/app
RUN pip install poetry
RUN poetry config virtualenvs.create false \
    && poetry install --no-root

# expose port
EXPOSE 8080

CMD ["streamlit", "run", "main.py", "--server.port", "$PORT", "--server.address", "0.0.0.0"]
