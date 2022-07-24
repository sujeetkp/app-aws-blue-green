import os
import secrets
from PIL import Image
from flask import url_for, current_app
from flask_mail import Message
from flaskblog import mail
import boto3
from botocore.exceptions import ClientError
import io

def save_picture(form_picture):
    random_hex = secrets.token_hex(8)
    _, f_ext = os.path.splitext(form_picture.filename)
    picture_fn = random_hex + f_ext
    object_name = "images/" + picture_fn
    output_size = (125, 125)
    i = Image.open(form_picture)
    i.thumbnail(output_size)
    buffer = io.BytesIO()
    i.save(buffer, "JPEG")
    buffer.seek(0)
    try:
        s3_client = boto3.client('s3')
        s3_client.put_object(
            Bucket=current_app.config['BUCKET'],
            Key=object_name,
            Body=buffer,
            ContentType='image/jpeg',
        )
    except ClientError:
        pass
    
    return picture_fn

def get_picture(file_name):
    s3_client = boto3.client('s3')
    object_name = "images/" + file_name
    try:
        response = s3_client.generate_presigned_url('get_object',
                                                    Params = {'Bucket': current_app.config['BUCKET'],
                                                              'Key': object_name
                                                             },
                                                    ExpiresIn = 3600)
    except ClientError:
        return None

    # The response contains the presigned URL
    return response

def send_reset_email(user):
    token = user.get_reset_token()
    msg = Message('Password Reset Request', sender='noreply@demo.com', recipients=[user.email])
    msg.body = f''' To reset your password visit the following link:
{url_for('users.reset_token', token=token, _external=True)}

If you didn't make this request, the simply ignore this email and no changes will be made.
'''
    print(msg)
    mail.send(msg)
