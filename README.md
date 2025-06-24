# Projeto de Engenharia de Dados com Snowflake, dbt e Airflow

## 1. Visão Geral do Projeto

Este projeto tem como objetivo construir um pipeline de dados ponta-a-ponta (*end-to-end*), desde a ingestão de dados brutos até a criação de um dashboard analítico. O fluxo simula um ambiente corporativo moderno, utilizando o dataset público de E-commerce da Olist como fonte de dados inicial.

O propósito é aplicar e documentar as melhores práticas de engenharia de dados, incluindo a modelagem de dados com a **Arquitetura Medallion** e a criação de um **Data Warehouse** com tabelas fato e dimensão, prontas para o consumo por ferramentas de Business Intelligence.

---

## 2. Arquitetura e Tecnologias

A escolha das ferramentas foi baseada em uma stack de dados moderna, escalável e amplamente utilizada no mercado.

| Tecnologia | Função | Justificativa da Escolha |
| :--- | :--- | :--- |
| **Snowflake** | Data Cloud Platform (DWH) | Plataforma de dados em nuvem poderosa, com separação real entre armazenamento e processamento, performance excelente e um generoso *free trial* que permite o desenvolvimento completo do projeto. |
| **dbt (Data Build Tool)** | Transformação de Dados (o "T" do ELT) | Ferramenta que permite construir pipelines de transformação de dados confiáveis usando apenas SQL. Facilita testes, documentação e versionamento do código de transformação, sendo o padrão de mercado hoje. |
| **Arquitetura Medallion** | Metodologia de Modelagem | Abordagem que organiza os dados em camadas (Bronze, Silver e Gold), garantindo a rastreabilidade, qualidade e governança dos dados à medida que são refinados. |
| **Airflow** | Orquestração de Pipeline | Padrão open-source para orquestração de workflows. Permite definir pipelines como código (Python), agendar execuções e gerenciar dependências complexas entre tarefas. |
| **Azure Blob Storage**| Camada de Staging (Landing Zone) | Serviço de armazenamento de objetos de baixo custo, ideal para ser a "zona de pouso" dos dados brutos (camada Bronze) extraídos de APIs na Fase 2 do projeto. |
| **Power BI / Streamlit** | Visualização de Dados | Ferramentas para a criação de dashboards. O Power BI Desktop é gratuito e robusto. O Streamlit permite criar dashboards web com Python de forma rápida e elegante. |

---

## 3. Estrutura do Projeto

O repositório está organizado da seguinte forma:

- `data/`: Contém os datasets brutos (arquivos `.csv`) utilizados na fase inicial do projeto.
- `dbt_project/`: Contém todo o código do projeto dbt, incluindo modelos, testes e documentação.
- `notebooks/`: Espaço para Jupyter Notebooks utilizados para análise exploratória e experimentação.
- `.gitignore`: Especifica os arquivos e pastas que devem ser ignorados pelo Git.
- `README.md`: A documentação principal do projeto (este arquivo).