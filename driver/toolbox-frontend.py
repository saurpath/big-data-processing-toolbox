from flask import Flask

app = Flask(__name__)


@app.route("/")
def banner():
    return "Welcome to Big Data Processing Application"


# TODO: This is used later to host the GUI for the terminal
if __name__ == "__main__":
    app.run(host="0.0.0.0")
