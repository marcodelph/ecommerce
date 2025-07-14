# Projeto de Engenharia de Dados: Pipeline de Vendas Olist

![Status: Concluído](https://img.shields.io/badge/status-concluído-brightgreen)

## 🎯 Visão Geral do Projeto
Este projeto implementa um pipeline de dados completo (end-to-end), desde a ingestão de dados brutos em arquivos CSV até a criação de um dashboard analítico interativo no Power BI. O objetivo foi aplicar as melhores práticas de engenharia de dados utilizando uma stack moderna com Snowflake, dbt e Power BI, simulando um ambiente corporativo real com o dataset de e-commerce da Olist.

Este repositório serve como um portfólio prático, demonstrando competências em modelagem de dados (Arquitetura Medallion, Esquema Estrela), transformação, testes de qualidade de dados e visualização de insights de negócio.

## 🛠️ Ferramentas e Tecnologias
| Ferramenta | Propósito |
| :--- | :--- |
| **Snowflake** | Cloud Data Warehouse para armazenamento e processamento dos dados. |
| **dbt (Data Build Tool)** | Ferramenta de transformação (o 'T' do ELT), usada para modelar, testar e documentar os dados. |
| **Power BI** | Ferramenta de Business Intelligence para visualização de dados e criação do dashboard. |
| **Git & GitHub** | Sistema de versionamento de código e hospedagem do projeto. |

## 🏗️ Arquitetura da Solução
A solução foi construída seguindo a arquitetura **Medallion**, garantindo governança e qualidade dos dados em cada etapa do pipeline.

```mermaid
graph LR
    A["Fonte: CSVs"] --> B("Load: Snowflake Bronze");
    B -- dbt build --> C("Transform: Silver");
    C -- dbt build --> D("Model: Gold");
    D --> E["Visualize: Power BI"];

    style A fill:#f9f,stroke:#333,stroke-width:2px,color:#000
    style B fill:#add8e6,stroke:#333,stroke-width:2px,color:#000
    style C fill:#ff7f50,stroke:#333,stroke-width:2px,color:#000
    style D fill:#ff7f50,stroke:#333,stroke-width:2px,color:#000
    style E fill:#ffffb3,stroke:#333,stroke-width:2px,color:#000
```
* **Bronze (RAW):** Cópia fiel dos dados brutos, garantindo um backup imutável da fonte.
* **Silver (Staging):** Os dados são limpos, padronizados, com tipos de dados corrigidos e renomeação de colunas.
* **Gold (Marts):** A camada final, onde os dados são agregados e modelados em um Esquema Estrela, com tabelas Fato e Dimensão otimizadas para análise.

## 📊 Dashboard de Resultados
O resultado de todo o pipeline é um dashboard com duas páginas que fornecem uma visão completa do negócio.

*(Pode levar alguns segundos para o dashboard carregar completamente)*

<a href="https://app.powerbi.com/view?r=eyJrIjoiNGRjY2ZjMmMtYWVkNS00NTllLTkzMjYtMGFhYjU1NTAxZDg3IiwidCI6ImRhMDk2NjZlLTMxM2QtNDM0NS04ZTQ0LTk5MzI0MjI0ZWZhNCJ9" target="_blank">
  <img src="https://img.shields.io/badge/Acessar_Dashboard_Interativo-593196?style=for-the-badge&logo=powerbi&logoColor=white" alt="Dashboard Interativo"/>
</a>

### Página 1: Análise Geral de Vendas
![Dashboard de Vendas](images/p1_vendas.png)

### Página 2: Análise de Produtos e Vendedores
![Dashboard de Produtos](images/p2_vendedores.png)

## 📈 Linhagem de Dados (dbt)
A documentação gerada pelo dbt (`dbt docs`) fornece um gráfico de linhagem de dados (DAG) que mostra visualmente como os modelos se conectam, desde as fontes brutas até as tabelas finais, garantindo total rastreabilidade e governança.

<h4>Linhagem de Dados (DAG)</h4>
<p>O gráfico de linhagem gerado pelo <code>dbt docs</code> mostra visualmente como os modelos se conectam, desde as fontes brutas até as tabelas finais, garantindo total rastreabilidade.</p>
<table align="center">
  <tr>
    <td align="center"><b>Linhagem da Tabela Fato Principal</b></td>
    <td align="center"><b>Linhagem da Dimensão de Clientes</b></td>
  </tr>
  <tr>
    <td><img src="images/dag_fct.png" alt="DAG da fct_order_items" width="100%"></td>
    <td><img src="images/dag_customers.png" alt="DAG da dim_customers" width="100%"></td>
  </tr>
</table>

#### Testes de Qualidade
O projeto inclui um conjunto de testes de dados para garantir a integridade, unicidade e lógica de negócio dos modelos finais, validando a confiabilidade do pipeline.

![dbt Test Results](images/dbt_tests.png)

## 🚀 Próximos Passos (Fase 2)
Como uma evolução deste projeto, os seguintes passos estão planejados:
* **Automação e Orquestração:** Integrar o pipeline com o **Apache Airflow** para automatizar as execuções diárias.
* **Ingestão de Dados via API:** Desenvolver um processo para complementar os dados existentes com informações de uma API externa.
* **Análise de Cohort:** Implementar um visual de Análise de Cohort no Power BI para medir a retenção de clientes mês a mês.
* **Materialização Incremental:** Alterar a materialização dos modelos da camada Gold para `incremental` para otimizar os custos e o tempo de execução em um ambiente de produção.
