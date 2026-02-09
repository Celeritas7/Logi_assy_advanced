-- ============================================================
-- Logi Assembly v28 - Add Loctite and Torque columns to links
-- Run this SQL in Supabase SQL Editor
-- ============================================================

-- Add loctite column
ALTER TABLE logi_links 
ADD COLUMN IF NOT EXISTS loctite TEXT;

-- Add torque value column
ALTER TABLE logi_links 
ADD COLUMN IF NOT EXISTS torque_value NUMERIC;

-- Add torque unit column
ALTER TABLE logi_links 
ADD COLUMN IF NOT EXISTS torque_unit TEXT DEFAULT 'Nm';

-- Add comment for documentation
COMMENT ON COLUMN logi_links.loctite IS 'Loctite type: 222 (Purple-Low), 243 (Blue-Med), 262 (Red-High), 271 (Red-High Strength), etc.';
COMMENT ON COLUMN logi_links.torque_value IS 'Torque value (numeric)';
COMMENT ON COLUMN logi_links.torque_unit IS 'Torque unit: Nm, ft-lb, in-lb, kgf-cm';

-- Verify columns were added
SELECT column_name, data_type, column_default 
FROM information_schema.columns 
WHERE table_name = 'logi_links' 
ORDER BY ordinal_position;
