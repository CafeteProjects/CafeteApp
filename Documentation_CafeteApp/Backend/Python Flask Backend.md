
Was tut es? Verbindet sich mit der Datenbank und gibt json Rows der ausgelesenen Tabelle wieder (bisher menu)


Code : 

from flask import Flask, jsonify
import mysql.connector
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # erlaubt Flutter Zugriff von anderen Domains

# MySQL-Verbindungsdaten, standen gott sei dank auf der Seite
db_config = {
    'host': 'ea5oe8.h.filess.io',       # dein Host
    'user': 'cafete_topicglad',         # DB-Benutzer
    'password': '15e8f9e8222cc351aa28ad15e3e46f8b98853c36',        # dein DB-Passwort
    'database': 'cafete_topicglad',     # Name der DB
    'port': 61001                       # Port von Filess
}
# API-Endpunkt für Menü
@app.route('/menu', methods=['GET'])
def get_menu():
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT itemname, price FROM menu")
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(rows)  # liefert JSON zurück

if __name__ == '__main__':
    # host=0.0.0.0 damit von außen erreichbar
    app.run(debug=True, host='0.0.0.0', port=5000)

~                                                            