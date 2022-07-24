from datetime import datetime
import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager
from flask_mail import Mail
from flask_migrate import Migrate
from flaskblog.config import Config

# Initialize Extensions
db = SQLAlchemy()
bcrypt = Bcrypt()
login_manager = LoginManager()
migrate = Migrate()
login_manager.login_view = 'users.login'  # Route to which Login Manager will direct if login is required.
login_manager.login_message_category = 'info'
mail = Mail()

def create_app(config_class=Config):
    # Define Flask App and Config
    app = Flask(__name__)
    app.config.from_object(config_class)
    
    # Import Blueprints
    from flaskblog.users.routes import users
    from flaskblog.posts.routes import posts
    from flaskblog.main.routes import main
    from flaskblog.errors.handlers import errors
    
    # Register Blueprints
    app.register_blueprint(users)
    app.register_blueprint(posts)
    app.register_blueprint(main)
    app.register_blueprint(errors)

    # Initialize Extentions with App
    bcrypt.init_app(app)
    login_manager.init_app(app)
    mail.init_app(app)
    migrate.init_app(app, db)

    with app.app_context():
        db.init_app(app)
        #db.drop_all()
        #db.create_all()
    
    return app


# We will use "flask-migrate" to create the database instead of db.create_all() command.
# This gives us the flexibility to migrate and upgrade/update the database easily in multi-developer environmanet.
# Commit your "migrations" folder along with the code. Any other developer can just run "flask db upgrade" to get
# the databse set up. "flask db upgrade" gets the script to upgrade the database from the "migrations" folder committed by
# previous developer. You can upgrade as well as downgrade.

# Commands to be used for flask-migrate : 
    # export FLASK_APP=run.py
    # flask db init
    # flask db migrate
    # flask db upgrade

# "flask db init" needs to be run only ONCE. This sets up your "migrations" folder.
# Everytime you make any change to the Database schema execute "flask db migrate".
# This generates the scripts for database upgrade with the new changes.
# You can verify the generated scripts and if everything is fine, execute "flask db upgrade"
# "flask db upgrade" changes/updates your database schema.
# At the beginning of your project, you need to run all the 3 commands to set up your database.
# After that if you do any changes to the schema, just execute "flask db migrate" and "flask db upgrade".
