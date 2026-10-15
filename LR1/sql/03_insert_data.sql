-- Тестовые данные

INSERT INTO warehouses (warehouse_code, name, address, capacity_m3) VALUES
('WH-MSK-01', 'Центральный склад', 'Москва, ул. Складская, 10', 5000.00),
('WH-SPB-01', 'Северный склад', 'Санкт-Петербург, пр. Индустриальный, 5', 3200.00);

INSERT INTO suppliers (supplier_name, tax_id, phone, email) VALUES
('ООО «ПромСнаб»', '7701234567', '+7-495-100-10-10', 'info@promsnab.ru'),
('ООО «ТехИмпорт»', '7807654321', '+7-812-200-20-20', 'sales@techimport.ru'),
('АО «Комплект»', '7722334455', '+7-495-300-30-30', 'order@komplekt.ru');

INSERT INTO products (sku, product_name, unit, min_stock) VALUES
('SKU-1001', 'Ноутбук офисный', 'шт.', 10),
('SKU-1002', 'Монитор 24"', 'шт.', 15),
('SKU-1003', 'Клавиатура USB', 'шт.', 30),
('SKU-1004', 'Мышь беспроводная', 'шт.', 40),
('SKU-1005', 'Кабель HDMI 2 м', 'шт.', 50),
('SKU-1006', 'Бумага А4', 'пачка', 100);

INSERT INTO employees (warehouse_id, full_name, position, phone) VALUES
(1, 'Иванов Сергей Петрович', 'Заведующий складом', '+7-900-111-11-11'),
(1, 'Петров Алексей Игоревич', 'Кладовщик', '+7-900-222-22-22'),
(2, 'Сидорова Анна Олеговна', 'Заведующий складом', '+7-900-333-33-33'),
(2, 'Кузнецов Дмитрий Андреевич', 'Кладовщик', '+7-900-444-44-44');

INSERT INTO inventory (warehouse_id, product_id, quantity) VALUES
(1, 1, 25), (1, 2, 40), (1, 3, 100), (1, 4, 120),
(1, 5, 200), (1, 6, 300),
(2, 1, 12), (2, 2, 20), (2, 3, 60), (2, 4, 80),
(2, 5, 100), (2, 6, 150);

INSERT INTO receipts (warehouse_id, supplier_id, receipt_date, document_no, status) VALUES
(1, 1, '2026-10-01', 'REC-2026-0001', 'POSTED'),
(2, 2, '2026-10-02', 'REC-2026-0002', 'POSTED'),
(1, 3, '2026-10-04', 'REC-2026-0003', 'POSTED');

INSERT INTO receipt_items (receipt_id, product_id, quantity, unit_price) VALUES
(1, 1, 10, 65000.00),
(1, 2, 20, 18000.00),
(1, 5, 50, 450.00),
(2, 3, 30, 2200.00),
(2, 4, 40, 1800.00),
(2, 6, 100, 550.00),
(3, 1, 5, 64000.00),
(3, 2, 10, 17500.00);

INSERT INTO shipments (warehouse_id, shipment_date, document_no, destination, status) VALUES
(1, '2026-10-05', 'SHP-2026-0001', 'Москва, магазин №1', 'POSTED'),
(2, '2026-10-06', 'SHP-2026-0002', 'Санкт-Петербург, магазин №7', 'POSTED'),
(1, '2026-10-07', 'SHP-2026-0003', 'Москва, офис клиента', 'DRAFT');

INSERT INTO shipment_items (shipment_id, product_id, quantity) VALUES
(1, 1, 3),
(1, 2, 5),
(1, 4, 10),
(2, 3, 15),
(2, 5, 20),
(3, 6, 25);