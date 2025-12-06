from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import requests
import psycopg2

def load_pokemon():
    conn = psycopg2.connect(
        host="postgres",
        dbname="pokemon",
        user="admin",
        password="admin"
    )
    cursor = conn.cursor()
    
    for id in range(1, 152):  # Gen1
        api = f"https://pokeapi.co/api/v2/pokemon/{id}"
        res = requests.get(api).json()
        name = res['name']
        base_attack = res['stats'][1]['base_stat']
        
        cursor.execute("""
            INSERT INTO pokemon_app.pokemon_species (name, base_attack)
            VALUES (%s, %s)
            ON CONFLICT (name) DO NOTHING;
        """, (name, base_attack))
    
    conn.commit()
    cursor.close()
    conn.close()


with DAG(
    dag_id="pokemon_refresh",
    start_date=datetime(2024,1,1),
    schedule_interval="@daily",
    catchup=False
):
    
    task = PythonOperator(
        task_id="seed_pokemon",
        python_callable=load_pokemon
    )
