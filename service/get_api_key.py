from google.cloud import kms
import base64


def decrypt_symmetric(project_id: str, location_id: str, key_ring_id: str, crypto_key_id: str, ciphertext_file: str) -> str:
    """
    Decrypt the provided ciphertext using the specified symmetric CryptoKey.
    """

    # KMS クライアントを作成
    client = kms.KeyManagementServiceClient()

    # KMS のキーの名前を指定
    key_name = client.crypto_key_path(project_id, location_id, key_ring_id, crypto_key_id)
    with open(ciphertext_file, 'rb') as f:
        ciphertext = f.read()
    # 復号リクエストを作成
    response = client.decrypt(request={'name': key_name, 'ciphertext': ciphertext})

    decoded_plaintext = base64.b64decode(response.plaintext)
    return decoded_plaintext.decode('utf-8')


if __name__ == '__main__':
    PROJECT_ID = 'your-project-id'
    LOCATION_ID = 'us-central1'
    KEY_RING_ID = 'my-keyring'
    CRYPTO_KEY_ID = 'openai-api-key'
    CIPHERTEXT_FILE = '.secret/openai_api_key.txt.enc'
    
    print(decrypt_symmetric(PROJECT_ID, LOCATION_ID, KEY_RING_ID, CRYPTO_KEY_ID, CIPHERTEXT_FILE))