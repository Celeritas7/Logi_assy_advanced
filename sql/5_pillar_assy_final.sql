-- ============================================================
-- LOGI ASSEMBLY - PILLAR ASSY TREE
-- Assembly ID: b7e4f701-e071-4b58-8302-0476fc39dab9
-- ============================================================

-- ============================================================
-- STEP 1: DELETE EXISTING DATA
-- ============================================================
DELETE FROM logi_links WHERE assembly_id = 'b7e4f701-e071-4b58-8302-0476fc39dab9';
DELETE FROM logi_nodes WHERE assembly_id = 'b7e4f701-e071-4b58-8302-0476fc39dab9';
DELETE FROM logi_links WHERE deleted = true;
DELETE FROM logi_nodes WHERE deleted = true;

-- ============================================================
-- STEP 2: INSERT NODES
-- ============================================================

-- Root node (P0)
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000001', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Pillar assy', 'GPEA-0300001-0-0', 600, 50, 'NOT_STARTED', false);

-- P1
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000002', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Actuated slider', 'GPCP-0300052-0-0', 200, 200, 'NOT_STARTED', false);

-- P2.2
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000003', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Pulley Case', NULL, 400, 200, 'NOT_STARTED', false);

-- P3
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000004', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'THK Slider', NULL, 600, 200, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000005', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3 Extruded Pillar Cover', NULL, 800, 200, 'NOT_STARTED', false);

-- P4
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000006', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3 ExtrudedPillarTopCover', 'GPMP-0300006-0-0', 1000, 200, 'NOT_STARTED', false);

-- Extra 1
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000007', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Nut Spacer', NULL, 200, 350, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000008', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '3.4 mm Nut spacer', NULL, 400, 350, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000009', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Mechanical stopper', NULL, 600, 350, 'NOT_STARTED', false);

-- Extra 2
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000010', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'THK', NULL, 800, 350, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000011', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3 Motor Unit', NULL, 1000, 350, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000012', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Motor Spacer', 'GPMP-0300002-0-0', 200, 500, 'NOT_STARTED', false);

-- P8
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000013', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Tensioner Block', NULL, 400, 500, 'NOT_STARTED', false);

-- P9
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000014', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Timing Belt', NULL, 600, 500, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000015', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'KSF8T-(Slider)(MP1)', NULL, 800, 500, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000016', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'KSF8RT-1500-T-(body)(MP1)_V3', NULL, 1000, 500, 'NOT_STARTED', false);

-- P10-P11
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000017', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Body side', NULL, 200, 650, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000018', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3 side', NULL, 400, 650, 'NOT_STARTED', false);

-- P12-P14
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000019', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Cable carrier heads', 'GPCP-0300051-0-0', 600, 650, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000020', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Mobile base side', NULL, 800, 650, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000021', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Cover Cable Bear', NULL, 1000, 650, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000022', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Cable Tie Holder (HC-100)', 'GPCP-0000253-0-0', 200, 800, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000023', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'COVER_CABLE_BEAR(DVT-1)', NULL, 400, 800, 'NOT_STARTED', false);

-- P15
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000024', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Cable carrier Bracket', 'GPMP-0400003-0-3', 600, 800, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000025', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Cable Carrier Bracket', 'GPMP-0400014-0-0', 800, 800, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000026', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Cable Carrier Bracket Add On', NULL, 1000, 800, 'NOT_STARTED', false);

-- P16-P17
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000027', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'COVER_CABLE_BEAR', 'GPMP-0300004-0-0', 200, 950, 'NOT_STARTED', false);

-- P18
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000028', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Brake_PCB Case (Lower)', NULL, 400, 950, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000029', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Blake_SW Bracket', NULL, 600, 950, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000030', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'TX_BRK_V12', 'GPEP-0000009-1-1', 800, 950, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000031', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Brake SW Assy', 'GPEA-0000016-0-0', 1000, 950, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000032', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Brake SW', 'GPEA-0000016-0-0', 200, 1100, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000033', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'BRK CAN', 'GPHP-0000005-0-0', 400, 1100, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000034', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3_ExtrudedPillarCover', NULL, 600, 1100, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000035', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'BRK Power', NULL, 800, 1100, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000036', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'BRK', NULL, 1000, 1100, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000037', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Brake_PCB Case(Lower)', NULL, 200, 1250, 'NOT_STARTED', false);

-- P19
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000038', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Brake_PCBCase(upper)', 'GPMP-0300032-0-2', 400, 1250, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000039', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Magic Tape', NULL, 600, 1250, 'NOT_STARTED', false);

-- P21
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000040', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Double-sided tape', 'GPCP-0000254-0-0', 800, 1250, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000041', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '20 mm', NULL, 1000, 1250, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000042', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '30 mm', NULL, 200, 1400, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000043', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '40 mm', NULL, 400, 1400, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000044', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'ECB_Cable_200', NULL, 600, 1400, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000045', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'TX_ECB_V2', NULL, 800, 1400, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000046', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'TX_ECB_V10', 'GPEP-0000023-0-0', 1000, 1400, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000047', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Cable Bush', 'GPCP-0000282-0-0', 200, 1550, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000048', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'MDB_PWR_Cable_500', NULL, 400, 1550, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000049', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3_MDB', NULL, 600, 1550, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000050', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3_PWR_Cable', NULL, 800, 1550, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000051', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3_PWR Cable', NULL, 1000, 1550, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000052', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'ECB_Base', NULL, 200, 1700, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000053', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'ECB_Lid', 'GPMP-0200042-0-0', 400, 1700, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000054', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'TX_ECB_V1', 'GPEP-0000023-0-0', 600, 1700, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000055', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'MDB Cover', NULL, 800, 1700, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000056', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '48V', NULL, 1000, 1700, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000057', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3 Actuator', NULL, 200, 1850, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000058', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '100mm', NULL, 400, 1850, 'NOT_STARTED', false);

-- P22-P24
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000059', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'FG', NULL, 600, 1850, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000060', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Tape', 'GPCP-0000249-0-0', 800, 1850, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000061', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'CBE M3x8', NULL, 1000, 1850, 'NOT_STARTED', false);

-- Additional nodes
INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000062', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'A', 'GPMP-0300005-0-0', 200, 2000, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000063', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'B', NULL, 400, 2000, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a0000001-0000-0000-0000-000000000064', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '20cm', NULL, 600, 2000, 'NOT_STARTED', false);

-- ============================================================
-- STEP 3: INSERT LINKS
-- ============================================================

-- Top level to root
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000001', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000005', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000002', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000010', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000003', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000016', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000004', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000034', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000005', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000052', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000006', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000057', NULL, 1, NULL, NULL, NULL, false);

-- THK Slider -> L3 Extruded Pillar Cover
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000010', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000005', 'a0000001-0000-0000-0000-000000000004', NULL, 1, NULL, NULL, NULL, false);

-- Nut Spacer -> 3.4 mm Nut spacer
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000011', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000008', 'a0000001-0000-0000-0000-000000000007', NULL, 1, NULL, NULL, NULL, false);

-- L3 Motor Unit -> THK
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000012', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000010', 'a0000001-0000-0000-0000-000000000011', NULL, 1, NULL, NULL, NULL, false);

-- Motor Spacer -> L3 Motor Unit
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000013', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000011', 'a0000001-0000-0000-0000-000000000012', NULL, 1, NULL, NULL, NULL, false);

-- Timing Belt -> KSF8T-(Slider)(MP1)
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000014', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000015', 'a0000001-0000-0000-0000-000000000014', NULL, 1, NULL, NULL, NULL, false);

-- Pulley Case -> KSF8RT-1500 (with fastener)
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000015', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000016', 'a0000001-0000-0000-0000-000000000003', 'M4x8 screws', 4, '222', 1.14, 'Nm', false);

-- Body side -> L3 side
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000016', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000018', 'a0000001-0000-0000-0000-000000000017', NULL, 1, NULL, NULL, NULL, false);

-- Mobile base side -> Cover Cable Bear (with fastener)
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000017', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000021', 'a0000001-0000-0000-0000-000000000020', 'SFB M3x5 Flat Head', 2, '425', 0.63, 'Nm', false);

-- Cable Tie Holder -> COVER_CABLE_BEAR(DVT-1)
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000018', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000023', 'a0000001-0000-0000-0000-000000000022', NULL, 1, NULL, NULL, NULL, false);

-- Cable Carrier Bracket -> Cable Carrier Bracket Add On
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000019', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000026', 'a0000001-0000-0000-0000-000000000025', NULL, 1, NULL, NULL, NULL, false);

-- Brake_PCB Case (Lower) -> Blake_SW Bracket (with fastener)
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000020', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000029', 'a0000001-0000-0000-0000-000000000028', 'M4x6 Trassneji', 4, '425', 0.65, 'Nm', false);

-- TX_BRK_V12 -> Blake_SW Bracket (with fastener)
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000021', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000029', 'a0000001-0000-0000-0000-000000000030', 'M2x6 PanHead', 4, NULL, 0.176, 'Nm', false);

-- Brake SW -> TX_BRK_V12
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000022', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000030', 'a0000001-0000-0000-0000-000000000032', NULL, 1, NULL, NULL, NULL, false);

-- BRK CAN -> TX_BRK_V12
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000023', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000030', 'a0000001-0000-0000-0000-000000000033', NULL, 1, NULL, NULL, NULL, false);

-- BRK CAN -> Brake_PCB Case(Lower)
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000024', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000037', 'a0000001-0000-0000-0000-000000000033', NULL, 1, NULL, NULL, NULL, false);

-- Blake_SW Bracket -> L3_ExtrudedPillarCover (with fastener)
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000025', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000034', 'a0000001-0000-0000-0000-000000000029', 'M4x6 Trassneji', 2, '222', 0.65, 'Nm', false);

-- Brake_PCBCase(upper) -> Brake_PCB Case(Lower)
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000026', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000037', 'a0000001-0000-0000-0000-000000000038', NULL, 1, NULL, NULL, NULL, false);

-- 20cm -> Magic Tape
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000027', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000039', 'a0000001-0000-0000-0000-000000000064', NULL, 1, NULL, NULL, NULL, false);

-- Double-sided tape links
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000028', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000041', 'a0000001-0000-0000-0000-000000000040', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000029', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000042', 'a0000001-0000-0000-0000-000000000040', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000030', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000043', 'a0000001-0000-0000-0000-000000000040', NULL, 1, NULL, NULL, NULL, false);

-- ECB links
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000031', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000045', 'a0000001-0000-0000-0000-000000000044', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000032', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000047', 'a0000001-0000-0000-0000-000000000046', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000033', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000047', 'a0000001-0000-0000-0000-000000000048', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000034', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000050', 'a0000001-0000-0000-0000-000000000049', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000035', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000046', 'a0000001-0000-0000-0000-000000000050', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000036', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000052', 'a0000001-0000-0000-0000-000000000046', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000037', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000052', 'a0000001-0000-0000-0000-000000000045', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000038', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000052', 'a0000001-0000-0000-0000-000000000047', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000039', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000052', 'a0000001-0000-0000-0000-000000000053', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000040', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000055', 'a0000001-0000-0000-0000-000000000054', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000041', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000055', 'a0000001-0000-0000-0000-000000000046', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000042', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000056', 'a0000001-0000-0000-0000-000000000046', NULL, 1, NULL, NULL, NULL, false);

-- MDB Cover -> L3 Actuator (with fastener)
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000043', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000057', 'a0000001-0000-0000-0000-000000000055', 'M3x10 Hex Cap', 4, '425', 0.63, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000044', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000058', 'a0000001-0000-0000-0000-000000000046', NULL, 1, NULL, NULL, NULL, false);

-- FG -> L3_ExtrudedPillarCover (with fastener)
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000045', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000034', 'a0000001-0000-0000-0000-000000000059', 'CBE M3x8', 1, NULL, 1.14, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000046', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000034', 'a0000001-0000-0000-0000-000000000061', 'CBE M3x8', 1, NULL, NULL, NULL, false);

-- A -> B
INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0000001-0000-0000-0000-000000000047', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'a0000001-0000-0000-0000-000000000063', 'a0000001-0000-0000-0000-000000000062', NULL, 1, NULL, NULL, NULL, false);

-- ============================================================
-- DONE! 64 nodes, 47 links
-- ============================================================
