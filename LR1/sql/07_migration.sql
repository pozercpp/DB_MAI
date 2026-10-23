BEGIN;
CREATE TABLE inventory_history (
    history_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    warehouse_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    old_quantity DECIMAL(12,3),
    new_quantity DECIMAL(12,3) NOT NULL,
    changed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE inventory
ADD COLUMN dummy BOOLEAN DEFAULT FALSE;
CREATE OR REPLACE FUNCTION log_inventory_quantity_change()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'UPDATE' AND
       OLD.quantity IS DISTINCT FROM NEW.quantity THEN
        INSERT INTO inventory_history (
            warehouse_id,
            product_id,
            old_quantity,
            new_quantity
        )
        VALUES (
            OLD.warehouse_id,
            OLD.product_id,
            OLD.quantity,
            NEW.quantity
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trg_inventory_quantity_history
AFTER UPDATE OF quantity ON inventory
FOR EACH ROW
EXECUTE FUNCTION log_inventory_quantity_change();
ALTER TABLE inventory
DROP COLUMN dummy;
COMMIT;