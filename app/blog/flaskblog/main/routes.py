from flask import render_template, request, Blueprint
from flaskblog.models import Post
from flaskblog.users.utils import get_picture
from prometheus_client import Counter, generate_latest

main = Blueprint('main', __name__)
view_metric = Counter('http_request', 'Total http request counter')

@main.route('/')
@main.route('/home')
def home():
    view_metric.inc()
    presigned_urls = {}
    page = request.args.get('page', 1, type=int)
    posts = Post.query.order_by(Post.date_posted.desc())
    
    for post in posts:
        if(post.userid not in presigned_urls.keys()):
            presigned_url = get_picture(post.author.image_file)
            presigned_urls[post.userid] = presigned_url

    post_paginate = posts.paginate(page=page, per_page=4)

    return render_template('home.html', posts=post_paginate, presigned_urls=presigned_urls)

@main.route('/about')
def about():
    return render_template('about.html', title='About')

@main.route('/metrics')
def metrics():
    return generate_latest()