# Define variables
LOCATION=us-central1
KEYRING_NAME=my-keyring
KEY_NAME=openai-api-key
ENCRYPTED_KEY_FILE=.secret/openai_api_key.txt.enc
PROJECT_ID=udf-practice
IMAGE_NAME=asia-northeast1-docker.pkg.dev/${PROJECT_ID}/my-docker-repo/streamlit-image
SERVICE_NAME=website-summarizer
REGION=asia-northeast1

# Target to decrypt the API key
decrypt:
	$(eval API_KEY=$(shell gcloud kms decrypt \
		--location $(LOCATION) \
		--keyring $(KEYRING_NAME) \
		--key $(KEY_NAME) \
		--ciphertext-file $(ENCRYPTED_KEY_FILE) \
		--plaintext-file - | base64 -d))
# Target to deploy to Cloud Run
deploy: decrypt
	gcloud run deploy $(SERVICE_NAME) \
		--image $(IMAGE_NAME) \
		--platform managed \
		--region $(REGION) \
		--allow-unauthenticated \
		--ingress all \
		--project $(PROJECT_ID) \
		--set-env-vars OPENAI_API_KEY=$(API_KEY) \
		--quiet
