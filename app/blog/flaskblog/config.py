import os

DB_SERVER = os.environ.get('DB_SERVER')
DB_PORT = int(os.environ.get('DB_PORT'))
DATABASE_NAME = os.environ.get('DATABASE_NAME')
DB_USERNAME = os.environ.get('DB_USERNAME')
DB_PASSWORD = os.environ.get('DB_PASSWORD')

os.environ['SQLALCHEMY_DATABASE_URI'] = f"postgresql://{DB_USERNAME}:{DB_PASSWORD}@{DB_SERVER}:{DB_PORT}/{DATABASE_NAME}"

class Config:
    MAIL_USERNAME = os.environ.get('EMAIL_USER')
    MAIL_PASSWORD = os.environ.get('EMAIL_PASS')
    SECRET_KEY = os.environ.get('SECRET_KEY')   # Required for the Registration and Login form. will be used for securely signing the session cookie - secrets.token_hex(16)
    SQLALCHEMY_TRACK_MODIFICATIONS = os.environ.get('SQLALCHEMY_TRACK_MODIFICATIONS')
    MAIL_SERVER = os.environ.get('MAIL_SERVER')
    MAIL_PORT = int(os.environ.get('MAIL_PORT'))
    MAIL_USE_TLS = bool(os.environ.get('MAIL_USE_TLS'))
    SQLALCHEMY_DATABASE_URI = os.environ.get('SQLALCHEMY_DATABASE_URI')
    BUCKET = os.environ.get('BUCKET')
