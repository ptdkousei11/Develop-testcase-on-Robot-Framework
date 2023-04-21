from flask import Flask, json, request
import uuid
from RPA.Windows import Windows
from RPA.JavaAccessBridge import JavaAccessBridge

api = Flask(__name__)
sessions = {}
commands = [
    'StartApp',
    'Quit'
]
windows_library = Windows()
java_library = JavaAccessBridge()


def start_app(app):
    windows_library.windows_run(app)


@api.route('/sessions', methods=['POST'])
def create_session():
    session_id = uuid.uuid4()
    sessions[session_id] = {}
    return json.dumps({"success": True,
                       "session_id": session_id}), 200


@api.route('/session/<uuid:session_id>/<string:command>', methods=['POST'])
def session_action(session_id, command):
    if session_id not in sessions or command not in commands:
        return
    data = request.get_json()
    if command == 'StartApp':
        if 'app_path' in data:
            start_app(data['app_path'])
            return json.dumps({"success": True,
                               "session_id": session_id}), 200
    elif command == 'Quit':
        del sessions[session_id]
        return json.dumps({"success": True}), 200


if __name__ == '__main__':
    api.run()
