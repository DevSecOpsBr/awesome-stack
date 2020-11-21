from flask import Flask, jsonify, request, url_for
from markupsafe import escape
from multiprocessing import Value
import logging
import time
from jaeger_client import Config

counter = Value('i', 0)
app = Flask(__name__)
app.config["DEBUG"] = True

dc = [ {
    "name": "datacenter-1",
    "metadata": {
      "monitoring": {
        "enabled": "true"
      },
      "limits": {
        "cpu": {
          "enabled": "false",
          "value": "100m"
        }
      }
    }
  },
  {
    "name": "datacenter-2",
    "metadata": {
      "monitoring": {
        "enabled": "true"
      },
      "limits": {
        "cpu": {
          "enabled": "true",
          "value": "150m"
        }
      }
    }
  },
  {
    "name": "datacenter-3",
    "metadata": {
      "monitoring": {
        "enabled": "true"
      },
      "limits": {
        "cpu": {
          "enabled": "true",
          "value": "750m"
        }
      }
    }
  }
]

help_message = """
API Usage:

- List    /configs
- Get     /configs/{name}
- Create  /configs 
- Update  /configs/{name} 
- Delete  /configs/{name}
- Query   /search?metadata.key=value

"""

def generatorId():
    with counter.get_lock():
        counter.value += 1
        return counter.value

@app.route('/', methods=['GET'])
def helpApi():
    return (help_message)

@app.route('/configs', methods=['GET'])
def listConfigs():
    return jsonify(dc)

@app.route('/configs', methods=['POST'])
def addConfig():
    payload = request.json
    dc.append(payload)
    return "Created object: {} \n".format(payload)

@app.route('/configs/<search>', methods=['GET'])
def getConfig():
    return 'ID Required: /configs/get/{name} \n'

@app.route('/configs/<search>', methods=['GET'])
def getConfigId(search):
    for configs in dc:
        print(configs)
        if search == configs['name']:
            return jsonify(configs)
    return '''<h1>Not found</h1>'''

@app.route('/api/configs/update', methods=['PUT'])
def update_none():
    return 'ID and Desired K/V in Payload required: /api/update/<id> -d \'{"name": "john"}\' \n'

@app.route('/configs/update/<name>', methods=['PUT','PATCH'])
def update(name):
    update_req = request.json
    key_to_update = update_req.keys()[0]
    update_val = (item for item in dc if item['name'] == name).next()[key_to_update] = update_req.values()[0]
    update_resp = (item for item in dc if item['name'] == name).next()
    return "Updated: {} \n".format(update_resp)

@app.route('/configs/<string:item>', methods=['DELETE'])
def delete(item):
    deleted_user = (item for item in a if item['name'] == item).next()
    a.remove(deleted_user)
    return "Deleted: {} \n".format(deleted_user)

if __name__ == '__main__':
    log_level = logging.DEBUG
    logging.getLogger('').handlers = []
    logging.basicConfig(format='%(asctime)s %(message)s', level=log_level)

    config = Config(
        config={ # usually read from some yaml config
            'sampler': {
                'type': 'const',
                'param': 1,
            },
            'logging': True,
        },
        service_name='hellofresh',
        validate=True,
    )
    # this call also sets opentracing.tracer
    tracer = config.initialize_tracer()

    with tracer.start_span('TestSpan') as span:
        span.log_kv({'event': 'test message', 'life': 42})

        with tracer.start_span('ChildSpan', child_of=span) as child_span:
            child_span.log_kv({'event': 'down below'})

    time.sleep(2)   # yield to IOLoop to flush the spans - https://github.com/jaegertracing/jaeger-client-python/issues/50
    tracer.close()  # flush any buffered spans
    app.run()
