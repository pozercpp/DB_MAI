-- 1. CHECK: отрицательная вместимость
INSERT INTO warehouses (warehouse_code, name, address, capacity_m3)
VALUES ('WH-ERR-01', 'Ошибочный склад', 'Москва', -100);

-- 2. UNIQUE: дублирование кода склада
INSERT INTO warehouses (warehouse_code, name, address, capacity_m3)
VALUES ('WH-MSK-01', 'Дубликат склада', 'Москва', 1000);

-- 3. FOREIGN KEY: несуществующий склад
INSERT INTO employees (warehouse_id, full_name, position)
VALUES (999999, 'Тестовый сотрудник', 'Кладовщик');

-- 4. NOT NULL: отсутствует название товара
INSERT INTO products (sku, product_name, unit, min_stock)
VALUES ('SKU-ERR-01', NULL, 'шт.', 10);

-- 5. CHECK: отрицательный остаток
UPDATE inventory
SET quantity = -10
WHERE warehouse_id = 1 AND product_id = 1;

-- 6. CHECK: отрицательное количество в поступлении
INSERT INTO receipt_items (receipt_id, product_id, quantity, unit_price)
VALUES (1, 1, -5, 100);

-- 7. CHECK: отрицательная цена
INSERT INTO receipt_items (receipt_id, product_id, quantity, unit_price)
VALUES (1, 2, 5, -100);

-- 8. CHECK: недопустимый статус поступления
INSERT INTO receipts (warehouse_id, supplier_id, document_no, status)
VALUES (1, 1, 'REC-ERROR-001', 'UNKNOWN');