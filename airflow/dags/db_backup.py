from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

with DAG(
    dag_id='backup_db',
    start_date=datetime(2024,1,1),
    schedule_interval='@daily',
    catchup=False
):
    backup = BashOperator(
        task_id='dump',
        bash_command='pg_dump postgresql://admin:admin@postgres/pokemon > /opt/airflow/backups/pokemon.sql'
    )
