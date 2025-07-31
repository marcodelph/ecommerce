from __future__ import annotations
import pendulum
from airflow.models.dag import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from airflow.providers.snowflake.hooks.snowflake import SnowflakeHook
import os

# Constantes do Projeto 
DBT_PROJECT_DIR = "/usr/local/airflow/dbt_project"
DBT_PROFILES_DIR = "/usr/local/airflow/include/dbt"
LOCAL_CSV_DIR = "/usr/local/airflow/include/data"
SNOWFLAKE_STAGE_NAME = "olist_stage"
SNOWFLAKE_CONN_ID = "snowflake_conn"

# Comandos SQL 
COPY_INTO_SQL_COMMANDS = """
    COPY INTO olist_customers_dataset FROM @{stage}/olist_customers_dataset.csv FILE_FORMAT = (FORMAT_NAME = 'my_csv_format') ON_ERROR = 'SKIP_FILE';
    COPY INTO olist_geolocation_dataset FROM @{stage}/olist_geolocation_dataset.csv FILE_FORMAT = (FORMAT_NAME = 'my_csv_format') ON_ERROR = 'SKIP_FILE';
    COPY INTO olist_order_items_dataset FROM @{stage}/olist_order_items_dataset.csv FILE_FORMAT = (FORMAT_NAME = 'my_csv_format') ON_ERROR = 'SKIP_FILE';
    COPY INTO olist_order_payments_dataset FROM @{stage}/olist_order_payments_dataset.csv FILE_FORMAT = (FORMAT_NAME = 'my_csv_format') ON_ERROR = 'SKIP_FILE';
    COPY INTO olist_order_reviews_dataset FROM @{stage}/olist_order_reviews_dataset.csv FILE_FORMAT = (FORMAT_NAME = 'my_csv_format') ON_ERROR = 'SKIP_FILE';
    COPY INTO olist_orders_dataset FROM @{stage}/olist_orders_dataset.csv FILE_FORMAT = (FORMAT_NAME = 'my_csv_format') ON_ERROR = 'SKIP_FILE';
    COPY INTO olist_products_dataset FROM @{stage}/olist_products_dataset.csv FILE_FORMAT = (FORMAT_NAME = 'my_csv_format') ON_ERROR = 'SKIP_FILE';
    COPY INTO olist_sellers_dataset FROM @{stage}/olist_sellers_dataset.csv FILE_FORMAT = (FORMAT_NAME = 'my_csv_format') ON_ERROR = 'SKIP_FILE';
    COPY INTO product_category_name_translation FROM @{stage}/product_category_name_translation.csv FILE_FORMAT = (FORMAT_NAME = 'my_csv_format') ON_ERROR = 'SKIP_FILE';
""".format(stage=SNOWFLAKE_STAGE_NAME)

# Função Python para o Upload 
def upload_files_to_snowflake_stage():
    hook = SnowflakeHook(snowflake_conn_id=SNOWFLAKE_CONN_ID)
    csv_files = [f for f in os.listdir(LOCAL_CSV_DIR) if f.endswith('.csv')]
    for file_name in csv_files:
        local_file_path = os.path.join(LOCAL_CSV_DIR, file_name)
        put_command = f"PUT file://{local_file_path} @{SNOWFLAKE_STAGE_NAME} OVERWRITE=TRUE;"
        print(f"Executando: {put_command}")
        hook.run(put_command)

# Definição da DAG 
with DAG(
    dag_id="olist_production_pipeline",
    start_date=pendulum.datetime(2024, 7, 30, tz="UTC"),
    schedule="@daily",
    catchup=False,
    tags=["ecommerce", "dbt", "production"],
) as dag:

    upload_csv_to_stage = PythonOperator(
        task_id="upload_csv_to_stage",
        python_callable=upload_files_to_snowflake_stage,
    )

    copy_from_stage_to_bronze = SQLExecuteQueryOperator(
        task_id="copy_from_stage_to_bronze",
        conn_id=SNOWFLAKE_CONN_ID,
        sql=COPY_INTO_SQL_COMMANDS,
        split_statements=True,
    )

    # Task 3: Instalar as dependências do dbt
    install_dbt_dependencies = BashOperator(
        task_id="install_dbt_dependencies",
        bash_command=f"dbt deps --project-dir {DBT_PROJECT_DIR} --profiles-dir {DBT_PROFILES_DIR}",
    )

    # Task 4: Rodar as transformações
    run_dbt_transformations = BashOperator(
        task_id="run_dbt_transformations",
        bash_command=f"dbt build --project-dir {DBT_PROJECT_DIR} --profiles-dir {DBT_PROFILES_DIR}",
    )

    #  Definindo a Nova Ordem das Tarefas 
    upload_csv_to_stage >> copy_from_stage_to_bronze >> install_dbt_dependencies >> run_dbt_transformations
