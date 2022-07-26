from datetime import datetime
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from flask import current_app
from flask_login import UserMixin
from flaskblog import db, login_manager



@login_manager.user_loader                    # This is required for the LoginManager to load the user. Check LoginManager Extension Documentation.
def load_user(user_id):                       # The class that you use to represent users (User) needs to implement 3 properties (is_authenticated, is_active,
    return User.query.get(int(user_id))       # is_anonymous) and 1 method (get_id()) for LoginManager to work.
                                              # We can do that by inheriting "UserMixin" class (In User class) from flask_login
class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)   # id is auto generated by SQLAlchemy
    username = db.Column(db.String(20), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    image_file = db.Column(db.String(40), nullable=False, default='default.jpeg')
    password = db.Column(db.String(60), nullable=False)
    posts = db.relationship('Post', backref='author', lazy=True)

    # 'posts' is not a column in user. This only refers the 'Post' class with backref as 'author'.
    # This create an attribute 'posts' for a User object, which will fetch all the posts related to that user as "user.posts".
    # Also it creates an attribute called 'author' (referred as 'backref') for 'Post' class object, which can be used
    # to find out the user who created the post as "post.author".

    def get_reset_token(self, expires_sec=1800):
        serializer = Serializer(current_app.config['SECRET_KEY'], expires_sec)
        return serializer.dumps({'user_id' : self.id}).decode('utf-8')

    @staticmethod
    def verify_reset_token(token):
        serializer = Serializer(current_app.config['SECRET_KEY'])
        try:
            user_id = serializer.loads(token)['user_id']
        except Exception as _:
            return None
        return User.query.get(user_id)

    def __repr__(self):
        return f"User('{self.username}', '{self.email}', '{self.image_file}')"


class Post(db.Model):
    id = db.Column(db.Integer, primary_key=True)  # id is auto generated by SQLAlchemy
    title = db.Column(db.String(100), nullable=False)
    date_posted = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    content = db.Column(db.Text, nullable=False)
    userid = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)

    def __repr__(self):
        return f"Post('{self.title}', '{self.date_posted}')"

# The __init__() method:
# Our User class, as defined using the Declarative system, has been provided with a constructor (e.g. __init__() method)
# which automatically accepts keyword names that match the columns we’ve mapped. We are free to define any explicit __init__() method
# we prefer on our class, which will override the default method provided by Declarative.
