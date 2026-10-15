SELECT
    w.warehouse_code,
    w.name AS warehouse,
    p.sku,
    p.product_name,
    i.quantity,
    p.min_stock,
    CASE WHEN i.quantity < p.min_stock THEN 'LOW' ELSE 'OK' END AS stock_status
FROM inventory i
JOIN warehouses w ON w.warehouse_id = i.warehouse_id
JOIN products p ON p.product_id = i.product_id
ORDER BY w.warehouse_code, p.sku;