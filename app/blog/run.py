from flaskblog import create_app

app = create_app()

if __name__ == '__main__':
    app.run(debug=True)

# Execute "pip freeze" command to get the required modules for the application developed inside
# a virtual environment. Add the output of "pip freeze" command to "requirements.txt" file.
