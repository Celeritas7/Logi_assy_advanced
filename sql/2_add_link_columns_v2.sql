-- ============================================================
-- Logi Assembly v28 - Add ALL missing columns to logi_links
-- Run this SQL in Supabase SQL Editor
-- ============================================================

-- Add qty column (if missing)
ALTER TABLE logi_links 
ADD COLUMN IF NOT EXISTS qty INTEGER DEFAULT 1;

-- Add loctite column
ALTER TABLE logi_links 
ADD COLUMN IF NOT EXISTS loctite TEXT;

-- Add torque value column
ALTER TABLE logi_links 
ADD COLUMN IF NOT EXISTS torque_value NUMERIC;

-- Add torque unit column
ALTER TABLE logi_links 
ADD COLUMN IF NOT EXISTS torque_unit TEXT DEFAULT 'Nm';

-- Verify columns were added
SELECT column_name, data_type, column_default 
FROM information_schema.columns 
WHERE table_name = 'logi_links' 
ORDER BY ordinal_position;
