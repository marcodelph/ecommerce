from __future__ import annotations
import pendulum
from airflow.models.dag import DAG
from airflow.operators.bash import BashOperator
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator

# Diretórios para o dbt
DBT_PROJECT_DIR = "/usr/local/airflow/dbt_project"
DBT_PROFILES_DIR = "/usr/local/airflow/include/dbt"

with DAG(
    dag_id="olist_dbt_pipeline",
    start_date=pendulum.datetime(2024, 7, 26, tz="UTC"),
    schedule=None,
    catchup=False,
    tags=["ecommerce", "dbt"],
) as dag:
    
    # Task 1: Testa a conexão com o Snowflake
    test_snowflake_connection = SQLExecuteQueryOperator(
        task_id="test_snowflake_connection",
        sql="SELECT 1;",
        conn_id="snowflake_conn", # O ID da conexão que criamos na UI
    )

    # Task 2: Testa a instalação e configuração do dbt
    test_dbt_setup = BashOperator(
        task_id="test_dbt_setup",
        bash_command=f"dbt debug --project-dir {DBT_PROJECT_DIR} --profiles-dir {DBT_PROFILES_DIR}",
    )