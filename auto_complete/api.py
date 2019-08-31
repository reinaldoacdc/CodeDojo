import os
from flask import Flask, request, jsonify, render_template, make_response, current_app
from flask_restful import Resource, Api
from flask_cors import CORS
from json import dumps

from elasticsearch import Elasticsearch
from datetime import datetime
import uuid

from functools import update_wrapper
from datetime import timedelta 

def crossdomain(origin=None, methods=None, headers=None, max_age=21600, attach_to_all=True, automatic_options=True):  
    if methods is not None:
        methods = ', '.join(sorted(x.upper() for x in methods))
    if headers is not None and not isinstance(headers, str):
        headers = ', '.join(x.upper() for x in headers)
    if not isinstance(origin, str):
        origin = ', '.join(origin)
    if isinstance(max_age, timedelta):
        max_age = max_age.total_seconds()

    def get_methods():
        if methods is not None:
            return methods

        options_resp = current_app.make_default_options_response()
        return options_resp.headers['allow']

    def decorator(f):
        def wrapped_function(*args, **kwargs):
            if automatic_options and request.method == 'OPTIONS':
                resp = current_app.make_default_options_response()
            else:
                resp = make_response(f(*args, **kwargs))
            if not attach_to_all and request.method != 'OPTIONS':
                return resp

            h = resp.headers

            h['Access-Control-Allow-Origin'] = origin
            h['Access-Control-Allow-Methods'] = get_methods()
            h['Access-Control-Max-Age'] = str(max_age)
            if headers is not None:
                h['Access-Control-Allow-Headers'] = headers
            return resp

        f.provide_automatic_options = False
        return update_wrapper(wrapped_function, f)
    return decorator


es = Elasticsearch(os.getenv('URL_ELASTICSEARCH'))

app = Flask(__name__)
app.config['CORS_HEADERS'] = 'Content-Type'
cors = CORS(app)

api = Api(app)

@app.route('/')
@crossdomain(origin='*')
def index():
	return render_template('index.html')

class Suggestion(Resource):
    def to_query(self, text):
        return  {
            "query": {"wildcard": {"text": {"value": "{text}".format(text=text)}}}
        }
    

    def to_json(self, text):
        return {
            'text': text, 
            'timestamp': datetime.now()
    }

    @crossdomain(origin='*')
    def post(self):              
        text = request.get_json()['name']
        #es.index(index='history', doc_type='text', id=uuid.uuid4(), body=self.to_json(text))
        
        #
        result = es.search(index="history", body=self.to_query(text.lower())) 
        print(result['hits']['total'])
        if result['hits']['total'] == 0:
            es.index(index='history', doc_type='text', id=uuid.uuid4(), body=self.to_json(text))
        response = app.response_class(status=200, mimetype='application/json')    
        data = {'status': 200}
        return jsonify(data)

    @crossdomain(origin='*')
    def get(self):   
        text = request.args.get("text")
        result = es.search(index="history", body=self.to_query('{text}*'.format(text=text.lower())))
        
        suggestions = []
        for hit in result['hits']['hits']:
            suggestions.append(hit["_source"]["text"]) 
            print(hit["_source"]["text"])
        suggestions = list(dict.fromkeys(suggestions))
        #suggestions = list(set(suggestions))
        return jsonify(suggestions)

api.add_resource(Suggestion, '/sugestions') # Route_1

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port)
    