from flask import Blueprint, render_template

errors = Blueprint('errors', __name__)

# In flask we can return the status code as well from a route or error. Default status code is "200".
# But in case of errors, we need to pass the exact status code.

@errors.app_errorhandler(404)
def error_404(error):                                
    return render_template('errors/404.html'), 404  

@errors.app_errorhandler(403)
def error_403(error):                                
    return render_template('errors/403.html'), 403  

@errors.app_errorhandler(500)
def error_500(error):                                
    return render_template('errors/500.html'), 500  

    