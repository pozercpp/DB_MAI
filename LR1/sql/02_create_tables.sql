-- Основные сущности: warehouses, employees, suppliers, products,
-- inventory, receipts, receipt_items, shipments, shipment_items.

CREATE TABLE warehouses (
    warehouse_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    warehouse_code VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(250) NOT NULL,
    capacity_m3 DECIMAL(12,2) NOT NULL CHECK (capacity_m3 > 0)
);

CREATE TABLE suppliers (
    supplier_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL,
    tax_id VARCHAR(20) NOT NULL UNIQUE,
    phone VARCHAR(30),
    email VARCHAR(254)
);

CREATE TABLE products (
    product_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sku VARCHAR(40) NOT NULL UNIQUE,
    product_name VARCHAR(150) NOT NULL,
    unit VARCHAR(20) NOT NULL,
    min_stock DECIMAL(12,3) NOT NULL DEFAULT 0
        CHECK (min_stock >= 0)
);

CREATE TABLE employees (
    employee_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    warehouse_id BIGINT NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    position VARCHAR(80) NOT NULL,
    phone VARCHAR(30),
    CONSTRAINT fk_employee_warehouse
        FOREIGN KEY (warehouse_id)
        REFERENCES warehouses(warehouse_id)
        ON DELETE RESTRICT
);

-- Остатки: одна строка на пару склад + товар.
CREATE TABLE inventory (
    warehouse_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity DECIMAL(12,3) NOT NULL DEFAULT 0
        CHECK (quantity >= 0),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (warehouse_id, product_id),
    CONSTRAINT fk_inventory_warehouse
        FOREIGN KEY (warehouse_id)
        REFERENCES warehouses(warehouse_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE RESTRICT
);

CREATE TABLE receipts (
    receipt_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    warehouse_id BIGINT NOT NULL,
    supplier_id BIGINT NOT NULL,
    receipt_date DATE NOT NULL DEFAULT CURRENT_DATE,
    document_no VARCHAR(40) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'POSTED',
    CONSTRAINT chk_receipt_status
        CHECK (status IN ('DRAFT', 'POSTED', 'CANCELLED')),
    CONSTRAINT fk_receipt_warehouse
        FOREIGN KEY (warehouse_id)
        REFERENCES warehouses(warehouse_id)
        ON DELETE RESTRICT,
    CONSTRAINT fk_receipt_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers(supplier_id)
        ON DELETE RESTRICT
);

CREATE TABLE receipt_items (
    receipt_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity DECIMAL(12,3) NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(12,2) NOT NULL CHECK (unit_price >= 0),
    PRIMARY KEY (receipt_id, product_id),
    CONSTRAINT fk_receipt_item_receipt
        FOREIGN KEY (receipt_id)
        REFERENCES receipts(receipt_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_receipt_item_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE RESTRICT
);

CREATE TABLE shipments (
    shipment_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    warehouse_id BIGINT NOT NULL,
    shipment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    document_no VARCHAR(40) NOT NULL UNIQUE,
    destination VARCHAR(250) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'POSTED',
    CONSTRAINT chk_shipment_status
        CHECK (status IN ('DRAFT', 'POSTED', 'CANCELLED')),
    CONSTRAINT fk_shipment_warehouse
        FOREIGN KEY (warehouse_id)
        REFERENCES warehouses(warehouse_id)
        ON DELETE RESTRICT
);

CREATE TABLE shipment_items (
    shipment_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity DECIMAL(12,3) NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (shipment_id, product_id),
    CONSTRAINT fk_shipment_item_shipment
        FOREIGN KEY (shipment_id)
        REFERENCES shipments(shipment_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_shipment_item_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE RESTRICT
);