from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector

app = Flask(__name__)
CORS(app) 

def connect_db():
    return mysql.connector.connect(
        host="db",   
        port=3306,       
        user="root",
        password="Educem00.",
        database="Projecte"
    )


@app.route('/ping', methods=['GET'])
def ping():
    return jsonify({'message': 'pong'})

@app.route('/api/check_cliente/<dni>', methods=['GET'])
def check_cliente(dni):
    db = connect_db()
    cursor = db.cursor()
    cursor.execute("SELECT 1 FROM clients WHERE DNI = %s", (dni,))
    exists = cursor.fetchone() is not None
    db.close()
    return jsonify({'exists': exists})

@app.route('/api/register', methods=['POST'])
def register_cliente():
    data = request.get_json()
    dni = data['DNI']
    nom = data['nom']
    telefon = data['telefon']
    correu = data['correu']
    db = connect_db()
    cursor = db.cursor()
    try:
        cursor.execute("INSERT INTO clients (DNI, nom, telefon, correu) VALUES (%s, %s, %s, %s)", 
                       (dni, nom, telefon, correu))
        db.commit()
        return jsonify({'success': True})
    except mysql.connector.Error as err:
        return jsonify({'success': False, 'error': str(err)})
    finally:
        db.close()



def insertar_cita(consoles_id, data_cita, servei_solicitat, client_DNI, id_accessoris=None):
    db = connect_db()
    cursor = db.cursor()

    if id_accessoris and consoles_id:
        query = """INSERT INTO incidencies 
                   (consola_id, id_accessoris, data_incidencia, servei_solicitat, client_DNI) 
                   VALUES (%s ,%s, %s, %s, %s)"""
        params = (consoles_id, id_accessoris, data_cita, servei_solicitat, client_DNI)

    elif consoles_id:
        query = """INSERT INTO incidencies 
                   (consola_id, data_incidencia, servei_solicitat, client_DNI) 
                   VALUES (%s, %s, %s, %s)"""
        params = (consoles_id, data_cita, servei_solicitat, client_DNI)

    elif id_accessoris:
        query = """INSERT INTO incidencies 
                   (id_accessoris, data_incidencia, servei_solicitat, client_DNI) 
                   VALUES (%s, %s, %s, %s)"""
        params = (id_accessoris, data_cita, servei_solicitat, client_DNI)
    
    else:
        raise ValueError("Debe proporcionarse consola_id o id_accessoris")

    cursor.execute(query, params)
    db.commit()
    db.close()



@app.route('/accessoris', methods=['GET'])
def get_accessoris():
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM accessoris")
    accessories = cursor.fetchall()
    db.close()
    return jsonify(accessories)


def existe_cliente(client_DNI):
    db = connect_db()
    cursor = db.cursor()
    cursor.execute("SELECT 1 FROM clients WHERE DNI = %s", (client_DNI,))
    existe = cursor.fetchone() is not None
    db.close()
    return existe

@app.route('/api/cita', methods=['POST'])
def recibir_cita():
    try:
        data = request.get_json()
        consoles_id = data.get('consoles_id')
        id_accessoris = data.get('id_accessoris')
        data_cita = data.get('data_cita')
        servei_solicitat = data.get('servei_solicitat')
        client_DNI = data.get('client_DNI')
        consoles_id = data.get('consoles_id')

        if consoles_id == "" or consoles_id is None:
            consoles_id = None
        if id_accessoris == "" or id_accessoris is None:
            id_accessoris = None
        print(id_accessoris,consoles_id)
        if not consoles_id and not id_accessoris:
            return jsonify({"error": "Has d'enviar 'consoles_id' o 'id_accessoris'"}), 400
        if not client_DNI:
            return jsonify({"error": "Has d'enviar 'client_DNI'"}), 400

        if not existe_cliente(client_DNI):
            return jsonify({"error": "El DNI proporcionaat no existeix a la base de dades de clients."}), 400

        insertar_cita(consoles_id, data_cita, servei_solicitat, client_DNI, id_accessoris)
        return jsonify({"message": "Cita registrada Correctament"})
    except Exception as e:
        print("Error a rebre_cita:", e)
        return jsonify({"error": str(e)}), 500

@app.route('/consoles', methods=['GET'])
def get_consoles():
    db = connect_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM consoles")
    consoles = cursor.fetchall()
    db.close()
    return jsonify(consoles)

@app.route('/incidencies', methods=['POST'])
def crear_incidencia():
    data = request.get_json()
    insertar_cita(data['consola_id'], data['data_incidencia'], data['servei_solicitat'])
    return jsonify({'message': 'Incidencia creada'}), 201

@app.route('/cincidencies', methods=['GET'])
def get_incidencies():
    db = connect_db()
    client_DNI = request.args.get('client_DNI')
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM incidencies WHERE client_DNI = %s", (client_DNI,))
    incidencies = cursor.fetchall()
    db.close()
    return jsonify(incidencies)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
