from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import psycopg2

def calculate_stats():
    conn = psycopg2.connect(
        host="postgres",
        dbname="pokemon",
        user="admin",
        password="admin"
    )
    cursor = conn.cursor()

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS pokemon_app.stats AS
        SELECT type1, AVG(base_attack) as avg_attack
        FROM pokemon_app.pokemon_species
        GROUP BY type1;
    """)

    conn.commit()
    cursor.close()
    conn.close()


with DAG(
    dag_id="pokemon_stats",
    start_date=datetime(2024,1,1),
    schedule_interval="@daily",
    catchup=False
):
    
    task = PythonOperator(
        task_id="calc_stats",
        python_callable=calculate_stats
    )
