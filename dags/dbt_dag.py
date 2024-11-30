from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2024, 1, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}


with DAG(
    'dbt_pipeline',
    default_args=default_args,
    schedule_interval=None,
    catchup=False,
) as dag:

    # task to install dbt dependencies
    dbt_deps = BashOperator(
        task_id='dbt_deps',
        bash_command='dbt deps'
    )

    # task to seed data
    dbt_seed = BashOperator(
        task_id='dbt_seed',
        bash_command='dbt seed'
    )

    # task to run models
    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command='dbt run'
    )

    # task to test models
    dbt_test = BashOperator(
        task_id='dbt_test',
        bash_command='dbt test'
    )

    dbt_deps >> dbt_seed >> dbt_run >> dbt_test
