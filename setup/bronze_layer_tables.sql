-- Usar o banco de dados e schema corretos
USE DATABASE RAW;
USE SCHEMA OLIST_ECOMMERCE;

-- Tabela de Clientes
CREATE OR REPLACE TABLE olist_customers_dataset (
    customer_id VARCHAR,
    customer_unique_id VARCHAR,
    customer_zip_code_prefix NUMBER,
    customer_city VARCHAR,
    customer_state VARCHAR
);

-- Tabela de Geolocalização
CREATE OR REPLACE TABLE olist_geolocation_dataset (
    geolocation_zip_code_prefix NUMBER,
    geolocation_lat DECIMAL(10, 8),
    geolocation_lng DECIMAL(11, 8),
    geolocation_city VARCHAR,
    geolocation_state VARCHAR
);

-- Tabela de Itens de Pedidos
CREATE OR REPLACE TABLE olist_order_items_dataset (
    order_id VARCHAR,
    order_item_id NUMBER,
    product_id VARCHAR,
    seller_id VARCHAR,
    shipping_limit_date TIMESTAMP_NTZ,
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2)
);

-- Tabela de Pagamentos de Pedidos
CREATE OR REPLACE TABLE olist_order_payments_dataset (
    order_id VARCHAR,
    payment_sequential NUMBER,
    payment_type VARCHAR,
    payment_installments NUMBER,
    payment_value DECIMAL(10, 2)
);

-- Tabela de Avaliações de Pedidos
CREATE OR REPLACE TABLE olist_order_reviews_dataset (
    review_id VARCHAR,
    order_id VARCHAR,
    review_score NUMBER,
    review_comment_title VARCHAR,
    review_comment_message VARCHAR,
    review_creation_date TIMESTAMP_NTZ,
    review_answer_timestamp TIMESTAMP_NTZ
);

-- Tabela de Pedidos
CREATE OR REPLACE TABLE olist_orders_dataset (
    order_id VARCHAR,
    customer_id VARCHAR,
    order_status VARCHAR,
    order_purchase_timestamp TIMESTAMP_NTZ,
    order_approved_at TIMESTAMP_NTZ,
    order_delivered_carrier_date TIMESTAMP_NTZ,
    order_delivered_customer_date TIMESTAMP_NTZ,
    order_estimated_delivery_date TIMESTAMP_NTZ
);

-- Tabela de Produtos
CREATE OR REPLACE TABLE olist_products_dataset (
    product_id VARCHAR,
    product_category_name VARCHAR,
    product_name_lenght NUMBER,
    product_description_lenght NUMBER,
    product_photos_qty NUMBER,
    product_weight_g NUMBER,
    product_length_cm NUMBER,
    product_height_cm NUMBER,
    product_width_cm NUMBER
);

-- Tabela de Vendedores
CREATE OR REPLACE TABLE olist_sellers_dataset (
    seller_id VARCHAR,
    seller_zip_code_prefix NUMBER,
    seller_city VARCHAR,
    seller_state VARCHAR
);

-- Tabela de Tradução de Nomes de Categoria
CREATE OR REPLACE TABLE product_category_name_translation (
    product_category_name VARCHAR,
    product_category_name_english VARCHAR
);

CREATE OR REPLACE FILE FORMAT my_csv_format
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    NULL_IF = ('')
    FIELD_OPTIONALLY_ENCLOSED_BY = '"';

CREATE OR REPLACE STAGE olist_stage
FILE_FORMAT = my_csv_format;

LIST @olist_stage;

-- Comando para cada tabela, copiando do arquivo correspondente no stage


COPY INTO olist_customers_dataset
FROM @olist_stage/olist_customers_dataset.csv
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format');

COPY INTO olist_geolocation_dataset
FROM @olist_stage/olist_geolocation_dataset.csv
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format');

COPY INTO olist_order_items_dataset
FROM @olist_stage/olist_order_items_dataset.csv
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format');

COPY INTO olist_order_payments_dataset
FROM @olist_stage/olist_order_payments_dataset.csv
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format');

COPY INTO olist_order_reviews_dataset
FROM @olist_stage/olist_order_reviews_dataset.csv
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format');

COPY INTO olist_orders_dataset
FROM @olist_stage/olist_orders_dataset.csv
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format');

COPY INTO olist_products_dataset
FROM @olist_stage/olist_products_dataset.csv
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format');

COPY INTO olist_sellers_dataset
FROM @olist_stage/olist_sellers_dataset.csv
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format');

COPY INTO product_category_name_translation
FROM @olist_stage/product_category_name_translation.csv
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format');  