import flask
from flask import request, jsonify

app = flask.Flask(__name__)
app.config["DEBUG"] = True

# Create some test data for our catalog in the form of a list of dictionaries.
allergerns = [
    {
        "name": "burger-nutrition",
        "metadata": {
            "calories": 230,
            "fats": {
            "saturated-fat": "0g",
            "trans-fat": "1g"
            },
            "carbohydrates": {
                "dietary-fiber": "4g",
                "sugars": "1g"
            },
            "allergens": {
            "nuts": "false",
            "seafood": "false",
            "eggs": "true"
            }
        }
    }
]

@app.route('/', methods=['GET'])
def home():
    return '''<h1>HelloFresh - API</h1>'''

@app.route('/api/v1/allergerns/all', methods=['GET'])
def api_all():
    return jsonify(allergerns)

@app.route('/api/v1/allergerns', methods=['GET'])
def api_id():
    if 'id' in request.args:
        id = int(request.args['id'])
    else:
        return "Error: No id field provided. Please specify an id."

    # Create an empty list for our results
    results = []

    # Loop through the data and match results that fit the requested ID.
    # IDs are unique, but other fields might return many results
    for book in books:
        if book['id'] == id:
            results.append(book)

    # Use the jsonify function from Flask to convert our list of
    # Python dictionaries to the JSON format.
    return jsonify(results)

app.run()