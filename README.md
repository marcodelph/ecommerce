# Projeto: Pipelines para Análise de Dados de Vendas de E-commerce

## Problema de Negócio

Pequenos e médios e-commerces frequentemente operam com dados de vendas fragmentados, o que dificulta a obtenção de insights sobre performance de produtos, comportamento do cliente e tendências do mercado. Isso gera um impacto diretamente na tomada de decisões estratégias em marketing, estoque e promoções.

## Solução Proposta

Esse projeto visa implementar um pipeline de dados, utilizando:

* **Docker:** Para conteinerizar e isolar o ambiente de desenvolvimento e produção.
* **Apache Airflow:** Para orquestrar a extração, carregamento e transformação dos dados.
* **PostgreSQL:** Como banco de dados relacional para armazenar os dados brutos e transformados.
* **dbt:** Para transformar e modelar os dados em um esquema dimensional (Fato e Dimensão), aplicando boas práticas de Engenharia de Dados (testes, documentação, reusabilidade).

A arquitetura seguirá os princípios da Medallion Architecture (Bronze, Silver, Gold), garantindo qualidade e organização dos dados em cada estágio.

## Tecnologias

* **Orquestração:** Apache Airflow
* **Transformação de Dados:** dbt (data build tool)
* **Banco de Dados:** PostgreSQL
* **Conteinerização:** Docker / Docker Compose
* **Linguagem de Programação:** Python
* **Controle de Versão:** Git / GitHub

## Instalação

## Insights e Análises Geradas

## Testes de Qualidade de Dados

## Próximos passos
1.  Definir o dataset de entrada (CSV - Kaggle ?)
2.  Configurar o ambiente Docker com PostgreSQL, Airflow e dbt.
3.  Implementar a ingestão inicial de dados (Bronze Layer).
4.  Desenvolver os modelos dbt (Silver e Gold Layers).
5.  Configurar as DAGs do Airflow para orquestrar o pipeline.
6.  Implementar testes e validações.
7.  Aprimorar a documentação e o README.
