Projeto de Engenharia de Dados: Pipeline de Vendas Olist Automatizado
🎯 Visão Geral do Projeto
Este projeto implementa um pipeline de dados ELT (Extract, Load, Transform) completo e automatizado, desde a ingestão de dados brutos em arquivos CSV até a criação de um dashboard analítico interativo. O objetivo foi aplicar as melhores práticas de engenharia de dados utilizando uma stack moderna, com Apache Airflow para orquestração, Snowflake como Data Warehouse, dbt para transformação e Power BI para visualização.

Este repositório serve como um portfólio prático, demonstrando competências em orquestração de pipelines, modelagem de dados (Arquitetura Medallion, Esquema Estrela), testes de qualidade e entrega de valor para o negócio.

🛠️ Ferramentas e Tecnologias
Ferramenta

Propósito

Apache Airflow

Orquestração do pipeline, agendando e automatizando a execução diária das tarefas.

Docker

Containerização do ambiente de desenvolvimento do Airflow, garantindo reprodutibilidade.

Snowflake

Cloud Data Warehouse para armazenamento e processamento dos dados.

dbt (Data Build Tool)

Ferramenta para Transformação (T do ELT), Modelagem, Testes e Documentação de Dados.

Power BI

Ferramenta de Business Intelligence para criação do dashboard analítico interativo.

Git & GitHub

Sistema para versionamento de código e hospedagem do projeto.

🏗️ Arquitetura da Solução
A solução é orquestrada pelo Airflow e segue a arquitetura Medallion, garantindo governança e qualidade dos dados em cada etapa do pipeline.

graph LR
    subgraph Airflow [Orquestração Diária com Airflow]
        direction TB
        T1(Task 1: Clean & Upload) --> T2(Task 2: Load to Bronze);
        T2 --> T3(Task 3: dbt Build);
    end

    subgraph Snowflake [Cloud Data Platform]
        direction LR
        B("Bronze Layer");
        C("Silver Layer");
        D("Gold Layer");
    end

    A[Fonte: CSVs] --> T1;
    T2 --> B;
    T3 -- dbt Core --> C;
    C -- dbt Core --> D;
    D --> E[Visualize: Power BI];

    style A fill:#f9f,stroke:#333,stroke-width:2px,color:#000
    style B fill:#add8e6,stroke:#333,stroke-width:2px,color:#000
    style C fill:#ff7f50,stroke:#333,stroke-width:2px,color:#000
    style D fill:#ff7f50,stroke:#333,stroke-width:2px,color:#000
    style E fill:#ffffb3,stroke:#333,stroke-width:2px,color:#000

Orquestração (Airflow): Uma DAG diária executa as tarefas de limpeza do Stage, upload dos dados, carga para a camada Bronze e disparo das transformações do dbt.

Bronze (RAW): Cópia fiel dos dados brutos, garantindo um backup imutável da fonte.

Silver (Staging): Camada onde os dados são limpos, padronizados, deduplicados com ROW_NUMBER() e preparados para a modelagem.

Gold (Marts): Camada analítica final, com os dados modelados em um Esquema Estrela (Star Schema), com tabelas Fato e Dimensão enriquecidas e prontas para o consumo.

📊 Dashboard Interativo e Resultados
🔗 Clique aqui para acessar o Dashboard Interativo
(Pode levar alguns segundos para o dashboard carregar completamente)

<a href="https://app.powerbi.com/view?r=eyJrIjoiNGRjY2ZjMmMtYWVkNS00NTllLTkzMjYtMGFhYjU1NTAxZDg3IiwidCI6ImRhMDk2NjZlLTMxM2QtNDM0NS04ZTQ0LTk5MzI0MjI0ZWZhNCJ9" target="_blank">
  <img src="https://img.shields.io/badge/Acessar_Dashboard_Interativo-593196?style=for-the-badge&logo=powerbi&logoColor=white" alt="Dashboard Interativo"/>
</a>

O resultado final é um dashboard de duas páginas que permite a exploração dinâmica dos dados.

Página 1: Visão Geral Executiva
Página 2: Análise de Produtos e Vendedores
✨ Qualidade e Governança de Dados com dbt
A confiabilidade do pipeline foi garantida através dos recursos nativos do dbt para testes e documentação, expondo e corrigindo problemas de qualidade nos dados de origem.

Testes de Qualidade
O projeto inclui um conjunto robusto de testes de dados para garantir a integridade, unicidade e lógica de negócio dos modelos finais, prevenindo que dados de baixa qualidade cheguem ao dashboard.

Linhagem de Dados (DAG)
O gráfico de linhagem gerado pelo dbt docs mostra visualmente como os modelos se conectam, desde as fontes brutas até as tabelas finais, garantindo total rastreabilidade sobre o fluxo de dados.

<table align="center">
<tr>
<td align="center"><b>Linhagem da Tabela Fato Principal</b></td>
<td align="center"><b>Linhagem da Dimensão de Clientes</b></td>
</tr>
<tr>
<td><img src="images/dbt_lineage_fct.png" alt="DAG da fct_order_items" width="100%"></td>
<td><img src="images/dbt_lineage_dim.png" alt="DAG da dim_customers" width="100%"></td>
</tr>
</table>

🚀 Próximos Passos
Com a base de orquestração e transformação estabelecida, os próximos passos para evoluir o projeto são:

Materialização Incremental: Alterar a materialização das tabelas Fato para incremental no dbt, otimizando os custos e o tempo de execução do pipeline diário.

Ingestão de Dados via API: Substituir a ingestão de arquivos CSV por uma extração diária de dados de uma API externa, tornando o pipeline mais dinâmico.

Infraestrutura como Código (IaC): Utilizar Terraform para provisionar e gerenciar a infraestrutura do Snowflake (bancos de dados, roles, etc.) de forma automatizada.
