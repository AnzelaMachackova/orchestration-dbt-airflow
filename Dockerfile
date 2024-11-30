FROM apache/airflow:latest
RUN pip3 install dbt-core dbt-bigquery
WORKDIR /opt/airflow