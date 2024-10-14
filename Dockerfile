# Pythonイメージをベースにする
FROM python:3.12

WORKDIR /usr/src/app

COPY . /usr/src/app
RUN pip install poetry
RUN poetry config virtualenvs.create false \
    && poetry install --no-root

# expose port
EXPOSE 8501

CMD ["streamlit", "run", "main.py"]
