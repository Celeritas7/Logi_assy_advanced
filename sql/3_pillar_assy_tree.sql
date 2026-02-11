-- ============================================================
-- LOGI ASSEMBLY - PILLAR ASSY TREE GENERATION
-- Generated from Excel: TX SOP of Pillar v7 00
-- ============================================================

-- ============================================================
-- STEP 1: HARD DELETE ALL SOFT-DELETED ENTRIES (One-time cleanup)
-- ============================================================
-- WARNING: This permanently removes all deleted entries!

-- Hard delete soft-deleted links
DELETE FROM logi_links WHERE deleted = true;

-- Hard delete soft-deleted nodes  
DELETE FROM logi_nodes WHERE deleted = true;

-- Hard delete soft-deleted assemblies (if any)
DELETE FROM logi_assemblies WHERE deleted = true;

-- Hard delete soft-deleted projects (if any)
DELETE FROM logi_projects WHERE deleted = true;

-- ============================================================
-- STEP 2: INSERT ASSEMBLY ID
-- ============================================================
-- IMPORTANT: Replace these placeholder IDs with your actual IDs!
-- You can find your project_id and assembly_id in your Supabase dashboard
-- or from the URL when viewing an assembly in your app.

-- Option A: Use existing assembly (recommended)
-- Find your assembly_id from: SELECT id, name FROM logi_assemblies;

-- Option B: Create new assembly (uncomment if needed)
-- INSERT INTO logi_assemblies (id, project_id, name, description)
-- VALUES ('YOUR-ASSEMBLY-UUID', 'YOUR-PROJECT-UUID', 'Pillar Assy v7', 'Generated from SOP Excel');

-- ============================================================
-- STEP 3: SET YOUR ASSEMBLY ID HERE
-- ============================================================
-- Replace 'b7e4f701-e071-4b58-8302-0476fc39dab9' in ALL statements below with your actual assembly_id


-- ============================================================
-- STEP 4: INSERT NODES
-- ============================================================
-- Copy and run these INSERT statements after setting your assembly_id


INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('cab8b180-429f-402e-88dc-081d37423701', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Actuated slider', 'GPCP-0300052-0-0', 200, 100, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('b25b7b96-4190-4c27-bbe1-6abb34d78176', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Pulley Case', NULL, 400, 100, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('186352e9-39c7-4b98-a688-cec594d33e08', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'THK Slider', NULL, 600, 100, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('0decf386-08af-43ae-9af7-472797462ca2', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3 Extruded Pillar Cover', NULL, 800, 100, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a16dc7fe-292d-4ab5-9fe4-99db685ba3ad', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'A', 'GPMP-0300005-0-0', 1000, 100, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('041e7b1f-a741-4046-91a7-e55c346a3634', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'B', NULL, 1200, 100, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('361143cd-8e28-498b-a7cc-54dfa14169d1', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3 ExtrudedPillarTopCover', 'GPMP-0300006-0-0', 200, 250, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('ef492aaf-9f76-444c-91fb-e778efc70cc1', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Nut Spacer', NULL, 400, 250, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('19dc66c9-10b9-4ba0-aa2c-9a828eced9b1', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '3.4 mm Nut spacer', NULL, 600, 250, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('373c4d20-3d68-44f7-86c3-af6e293161fa', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Mechanical stopper', NULL, 800, 250, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('2039a9fe-0d10-4493-ac46-7122c276afb6', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Loctite 243', NULL, 1000, 250, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('9bdfa310-7116-4a3e-9caa-f79bad5f8150', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3 Motor Unit', NULL, 1200, 250, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('4117503e-3fe8-45c1-bb8f-154a4db68631', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'THK', NULL, 200, 400, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('ad02f391-8fd8-4f3d-84b1-b7c1199284ca', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Motor Spacer', 'GPMP-0300002-0-0', 400, 400, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('00aa5ee9-eefd-472b-8cb7-1650b27213ca', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Tensioner Block', NULL, 600, 400, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('9048038f-0c51-4697-b164-25bf0f4fa660', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Timing Belt', NULL, 800, 400, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('9b2220d4-2ea7-4479-8fcd-92e3d69c3389', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'KSF8T-(Slider)(MP1)', NULL, 1000, 400, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('e0e48fcd-561d-405d-8deb-bb38676ac2bc', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '50.2N ~ 67.9N', NULL, 1200, 400, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('84b41fc4-4921-42ea-a9c1-e43557dfbec2', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'KSF8RT-1500-T-(body)(MP1) V3', NULL, 200, 550, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('508c6f97-6948-467e-bf83-7a99b362f782', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Body side', NULL, 400, 550, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('3a1c1481-1cbe-4890-aed6-f04cd69689a1', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3 side', NULL, 600, 550, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('2a9a202a-82a2-4b65-b9ea-ab7fe4f879c2', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Cable carrier heads', 'GPCP-0300051-0-0', 800, 550, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('a28d4742-52df-4aa0-b60f-14edbff9d684', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Mobile base side', NULL, 1000, 550, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('f127f94f-9346-4ca7-a008-8cbc945694ec', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Cover Cable Bear', NULL, 1200, 550, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('c99976af-e3c3-407c-ad35-819771b0173d', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Cable Tie Holder (HC-100)', 'GPCP-0000253-0-0', 200, 700, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('4aa9d7f9-4ebf-4dbc-aee7-40e4dd01a3f1', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'COVER CABLE BEAR(DVT-1)', NULL, 400, 700, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('d71b38fc-e87c-40b5-a187-98118e4f5dff', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Cable carrier Bracket', 'GPMP-0400003-0-3', 600, 700, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('0ca70f3c-4b06-4add-8bdd-7fdbdbdbccfe', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Cable Carrier Bracket', 'GPMP-0400014-0-0', 800, 700, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('512c2c0a-84c0-4c0c-8746-78ef8aa6459d', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Cable Carrier Bracket Add On', NULL, 1000, 700, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('4f27a125-c9f7-490f-b7db-4d1a7449c5a8', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'COVER CABLE BEAR', 'GPMP-0300004-0-0', 1200, 700, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('61b46e7c-44ef-4799-bc24-a1d46a6b15b8', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Brake PCB Case (lower)', NULL, 200, 850, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('987e5625-3cc5-443b-af5d-3ceb97e0b43c', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Blake SW Bracket', NULL, 400, 850, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('bcc0ed25-17ca-4054-a231-4219f7ce1415', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'TX BRK V12', 'GPEP-0000009-0-1', 600, 850, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('b628e851-ff29-4480-bb8a-1258d0835601', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Brake SW Assy', 'GPEA-0000016-0-0', 800, 850, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('b7a1c801-4251-4664-9b6a-93eab1bf4a74', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Brake PCB Case(lower)', NULL, 1000, 850, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('4b14ad07-0997-441b-a0d8-59fdfa87df96', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Brake SW', 'GPEA-0000016-0-0', 1200, 850, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('afc330db-7cdb-4bf1-9489-13d93f2f8054', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'BRK CAN', 'GPHP-0000005-0-0', 200, 1000, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('7a31040c-8a07-4ce0-8613-bd0a0351137b', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3 ExtrudedPillarCover', NULL, 400, 1000, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('d4ab2e3b-403b-4131-814e-e60798650529', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'BRK Power', NULL, 600, 1000, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('7629381d-4a91-4ed0-9730-2b254f077cf2', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'BRK', NULL, 800, 1000, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('75528e52-8cb3-4d9d-9e11-d536fd8ba172', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Brake PCBCase(upper)', 'GPMP-0300032-0-2', 1000, 1000, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('dda935d7-f06a-4c23-8cfb-6710b8293432', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '20cm', NULL, 1200, 1000, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('6173e156-2cf1-46e7-86d6-3fd7cc90fa1b', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Magic Tape', NULL, 200, 1150, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('b050514e-d4a7-40d5-8fbf-04ea07ec4dff', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Double-sided tape', 'GPCP-0000254-0-0', 400, 1150, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('f01c2128-1566-458e-9251-cf0ffed23c8b', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '20 mm', NULL, 600, 1150, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('ce7cac11-c6d8-4189-be55-99a7bc3bf49d', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'ECB Cable 200', NULL, 800, 1150, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('36c91a84-f5ff-4014-9ba2-898c9801e771', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'TX ECB V2', NULL, 1000, 1150, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('0d121d6e-fd21-4bd0-b66f-5261fe6f4d5c', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'TX ECB V10', 'GPEP-0000023-0-0', 1200, 1150, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('8fb6cf97-77b8-40e9-ac30-26f99d2fb14f', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Cable Bush', 'GPCP-0000282-0-0', 200, 1300, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('1064a876-3d7a-4882-9024-14b078a88323', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '30 mm', NULL, 400, 1300, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('c97a0ee8-2ab6-46f1-a313-fbbb44748fc3', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'MDB PWR Cable 500', NULL, 600, 1300, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('8452299a-1cab-4275-a1ff-1bfec80d3be0', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3 MDB', NULL, 800, 1300, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('8eabdac9-ce3a-408c-b4e3-28501a63415d', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3 PWR Cable', NULL, 1000, 1300, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('2ef1295f-73fe-4e34-86fe-63396fdb6912', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'ECB Base', NULL, 1200, 1300, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('8b78dd27-31a6-4d3b-9e8b-963caab08ec7', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'ECB Lid', 'GPMP-0200042-0-0', 200, 1450, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('14099770-90fb-4784-a56b-45a846576829', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '40 mm', NULL, 400, 1450, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('94cbe79f-7c76-4562-900a-46a47c3b9339', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'MDB Cover', NULL, 600, 1450, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('2510f5db-1569-4fb5-8038-bc5de88663e8', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'TX ECB V1', 'GPEP-0000023-0-0', 800, 1450, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('413ed2e9-f4f6-4325-b29e-7a007e5a44a9', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '48V', NULL, 1000, 1450, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('40dadce9-921f-4117-9695-dc8ea37eabf0', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'L3 Actuator', NULL, 1200, 1450, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('24dcce5e-cc41-4b61-9c5e-ba4468e2dbbd', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '100mm', NULL, 200, 1600, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('c3166451-9e1b-4c98-ae7d-2da369c3b85e', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'FG', NULL, 400, 1600, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('90041363-7202-494b-ac35-52b44925a1e4', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Tape', 'GPCP-0000249-0-0', 600, 1600, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('de3720a1-8f96-407d-a278-fca6ee605715', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'CBE M3x8', NULL, 800, 1600, 'NOT_STARTED', false);

INSERT INTO logi_nodes (id, assembly_id, name, part_number, x, y, status, deleted)
VALUES ('8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'Pillar assy', 'GPEA-0300001-0-0', 1000, 1600, 'NOT_STARTED', false);


-- ============================================================
-- STEP 5: INSERT LINKS
-- ============================================================

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('5a4b8b7c-4770-43d4-ae88-e09466d734dd', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '4aa9d7f9-4ebf-4dbc-aee7-40e4dd01a3f1', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b0e0aa06-1c54-4afd-9d1a-2a236f57bbb3', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '9b2220d4-2ea7-4479-8fcd-92e3d69c3389', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('4e47bbec-ba59-43a9-9ed7-1d5ab1cd06e3', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '4117503e-3fe8-45c1-bb8f-154a4db68631', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('a008c8cd-24bf-426d-a656-53f07a6442f8', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '512c2c0a-84c0-4c0c-8746-78ef8aa6459d', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('0fb9986d-a3de-48f8-b0e3-bb443261dd09', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', 'b7a1c801-4251-4664-9b6a-93eab1bf4a74', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('64569f91-7606-429b-a62f-2dcf8d48e0c5', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '84b41fc4-4921-42ea-a9c1-e43557dfbec2', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('e534cfd8-9a4f-45f7-b348-0cfb6545aba3', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '7a31040c-8a07-4ce0-8613-bd0a0351137b', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('eb3c8563-be32-4af2-9536-29d50345ff73', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', 'f01c2128-1566-458e-9251-cf0ffed23c8b', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('a72a1869-e638-41a5-a1af-730a36f69602', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '1064a876-3d7a-4882-9024-14b078a88323', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('eeb52a2e-aabd-4b33-b7ab-f626f97ccb71', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '2ef1295f-73fe-4e34-86fe-63396fdb6912', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('bdfc3778-df37-4686-8171-d1aa653b673d', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '24dcce5e-cc41-4b61-9c5e-ba4468e2dbbd', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('a3f39203-5290-41bc-aa7e-4ce7ae64c9c5', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '413ed2e9-f4f6-4325-b29e-7a007e5a44a9', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('3d42a286-c188-436e-81f1-a217d27b8277', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '3a1c1481-1cbe-4890-aed6-f04cd69689a1', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('4d728efe-a298-4afe-b899-aa1abe820d97', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '041e7b1f-a741-4046-91a7-e55c346a3634', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('0efe83fd-5838-4592-93f9-1ea3be567fe7', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '40dadce9-921f-4117-9695-dc8ea37eabf0', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('72de48bc-2113-4c05-bdee-7a1f9e961227', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '14099770-90fb-4784-a56b-45a846576829', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('f9007a2e-cb14-486d-98c9-661633d4f9bb', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', 'f127f94f-9346-4ca7-a008-8cbc945694ec', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('41688410-220b-4cfe-9e41-4e77dca7a120', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '6173e156-2cf1-46e7-86d6-3fd7cc90fa1b', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('8e8d600a-1f5f-472a-a7bc-4ed03f52758c', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '0decf386-08af-43ae-9af7-472797462ca2', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('3776b001-fbd6-4cab-8c92-532ec40b931c', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8ec14c31-5049-4cb4-8473-bb13d8f5b8cf', '19dc66c9-10b9-4ba0-aa2c-9a828eced9b1', NULL, 1, NULL, NULL, NULL, false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('07abaf78-2010-4855-af34-b12e3ddca478', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '0decf386-08af-43ae-9af7-472797462ca2', '186352e9-39c7-4b98-a688-cec594d33e08', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('95e7b6d5-a824-4190-b818-4af00c3b9897', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '041e7b1f-a741-4046-91a7-e55c346a3634', 'a16dc7fe-292d-4ab5-9fe4-99db685ba3ad', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('0e277df6-1a5f-4882-9fe7-fc00d9f6a50c', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '19dc66c9-10b9-4ba0-aa2c-9a828eced9b1', 'ef492aaf-9f76-444c-91fb-e778efc70cc1', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('f92e968d-173c-439e-81fb-a3188ec1b14c', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '4117503e-3fe8-45c1-bb8f-154a4db68631', '9bdfa310-7116-4a3e-9caa-f79bad5f8150', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('0beee411-5517-4d5e-bf9f-ec0cb2fee50d', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '9bdfa310-7116-4a3e-9caa-f79bad5f8150', 'ad02f391-8fd8-4f3d-84b1-b7c1199284ca', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('534ae96f-deae-4311-820a-8b985c0e1bf5', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '9b2220d4-2ea7-4479-8fcd-92e3d69c3389', '9048038f-0c51-4697-b164-25bf0f4fa660', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('9d190ca5-7600-4cd0-8c54-604ec5a0d9d2', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '84b41fc4-4921-42ea-a9c1-e43557dfbec2', 'b25b7b96-4190-4c27-bbe1-6abb34d78176', 'M4x8 screws (Re-use Pre installed screws)', 4, '222', 1.14, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('3cfdbe26-c0ed-4216-97a6-b8b7ae7642f8', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '3a1c1481-1cbe-4890-aed6-f04cd69689a1', '508c6f97-6948-467e-bf83-7a99b362f782', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('cbae3d7c-5d7c-4912-bab1-7054ef629c27', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'f127f94f-9346-4ca7-a008-8cbc945694ec', 'a28d4742-52df-4aa0-b60f-14edbff9d684', 'SFB M3x5 Flat Head Screws', 2, '425', 0.63, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('4b1ac3f1-3601-435a-bfce-2456c4b35d9d', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '4aa9d7f9-4ebf-4dbc-aee7-40e4dd01a3f1', 'c99976af-e3c3-407c-ad35-819771b0173d', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('c6c53058-569a-4b0f-a2c3-affa9e8eacd0', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '512c2c0a-84c0-4c0c-8746-78ef8aa6459d', '0ca70f3c-4b06-4add-8bdd-7fdbdbdbccfe', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('40e51d5b-9b9e-43fc-b106-ebe7e165ce42', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '987e5625-3cc5-443b-af5d-3ceb97e0b43c', '61b46e7c-44ef-4799-bc24-a1d46a6b15b8', 'CSPTRT-STU M4x6 Trassneji Screws', 4, '425', 0.65, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('c35d9024-9405-43d0-9440-479bd91f193f', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '987e5625-3cc5-443b-af5d-3ceb97e0b43c', 'bcc0ed25-17ca-4054-a231-4219f7ce1415', 'CSPPNHP-STU-TPT M2x6 PanHead Screws', 4, NULL, 0.176, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('1648bd96-bf11-486c-a696-a73e5429d972', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'b7a1c801-4251-4664-9b6a-93eab1bf4a74', 'b628e851-ff29-4480-bb8a-1258d0835601', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('aa591d8f-9bcd-4545-90d0-533151adc269', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'bcc0ed25-17ca-4054-a231-4219f7ce1415', '4b14ad07-0997-441b-a0d8-59fdfa87df96', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('8d1d5be9-5386-4e17-96af-5d1dec0828e3', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'bcc0ed25-17ca-4054-a231-4219f7ce1415', 'afc330db-7cdb-4bf1-9489-13d93f2f8054', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('50a9ef07-029e-4e1f-a123-f48b84438e28', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'b7a1c801-4251-4664-9b6a-93eab1bf4a74', 'afc330db-7cdb-4bf1-9489-13d93f2f8054', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('fd763f28-5939-41f8-9140-80aa661f6292', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '7a31040c-8a07-4ce0-8613-bd0a0351137b', '987e5625-3cc5-443b-af5d-3ceb97e0b43c', 'CSPTRT-STU M4x6 Trassneji Screws', 2, '222', 0.65, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('fec8885b-65fd-481e-bc14-e164b56e5854', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'b7a1c801-4251-4664-9b6a-93eab1bf4a74', 'd4ab2e3b-403b-4131-814e-e60798650529', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('8d3a44eb-f56f-41ce-b419-712d8f23634e', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'b7a1c801-4251-4664-9b6a-93eab1bf4a74', '7629381d-4a91-4ed0-9730-2b254f077cf2', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('f155d89c-4593-4c0b-aa35-8944e512a7f5', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'b7a1c801-4251-4664-9b6a-93eab1bf4a74', '75528e52-8cb3-4d9d-9e11-d536fd8ba172', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('f73f5d16-3c96-4a8e-a872-d904ebace9d3', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '6173e156-2cf1-46e7-86d6-3fd7cc90fa1b', 'dda935d7-f06a-4c23-8cfb-6710b8293432', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('cb87444c-b8a9-406e-93ce-752873955881', 'b7e4f701-e071-4b58-8302-0476fc39dab9', 'f01c2128-1566-458e-9251-cf0ffed23c8b', 'b050514e-d4a7-40d5-8fbf-04ea07ec4dff', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('d431e5d5-d97e-45a7-9081-fab7105d0409', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '36c91a84-f5ff-4014-9ba2-898c9801e771', 'ce7cac11-c6d8-4189-be55-99a7bc3bf49d', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('9ad72256-802a-4303-a530-da0e84275857', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8fb6cf97-77b8-40e9-ac30-26f99d2fb14f', '0d121d6e-fd21-4bd0-b66f-5261fe6f4d5c', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('b278c6d5-ee74-4113-b463-473d589ee045', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '1064a876-3d7a-4882-9024-14b078a88323', 'b050514e-d4a7-40d5-8fbf-04ea07ec4dff', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('1dcfc87f-60ec-4e5a-b5db-dbe6d564a1bd', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8fb6cf97-77b8-40e9-ac30-26f99d2fb14f', 'c97a0ee8-2ab6-46f1-a313-fbbb44748fc3', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('3c8ee273-370f-406e-85fd-ec65c8d4938b', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '8eabdac9-ce3a-408c-b4e3-28501a63415d', '8452299a-1cab-4275-a1ff-1bfec80d3be0', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('0affff76-5417-4711-8897-9682dc5122b7', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '2ef1295f-73fe-4e34-86fe-63396fdb6912', '0d121d6e-fd21-4bd0-b66f-5261fe6f4d5c', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('41c93538-287a-40d6-b78e-44f330a07fbd', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '2ef1295f-73fe-4e34-86fe-63396fdb6912', '36c91a84-f5ff-4014-9ba2-898c9801e771', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('4f1e458d-4951-4b89-bc13-c2200c226080', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '2ef1295f-73fe-4e34-86fe-63396fdb6912', '8fb6cf97-77b8-40e9-ac30-26f99d2fb14f', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('864e694b-40ed-4ef4-94c8-54b880f9658e', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '2ef1295f-73fe-4e34-86fe-63396fdb6912', '8b78dd27-31a6-4d3b-9e8b-963caab08ec7', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('770573e2-3100-4fca-9c9e-3dfef0f1554e', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '14099770-90fb-4784-a56b-45a846576829', 'b050514e-d4a7-40d5-8fbf-04ea07ec4dff', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('eade1252-b243-435d-8109-9ed9ab5b94ef', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '94cbe79f-7c76-4562-900a-46a47c3b9339', '0d121d6e-fd21-4bd0-b66f-5261fe6f4d5c', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('cf197d14-60f0-4032-b453-d4b8e52a905c', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '94cbe79f-7c76-4562-900a-46a47c3b9339', '2510f5db-1569-4fb5-8038-bc5de88663e8', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('7e96fd0b-95e3-46b7-be07-18be55ff9897', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '413ed2e9-f4f6-4325-b29e-7a007e5a44a9', '0d121d6e-fd21-4bd0-b66f-5261fe6f4d5c', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('ccef052e-a369-4f98-921f-c03f32ab9bb1', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '40dadce9-921f-4117-9695-dc8ea37eabf0', '94cbe79f-7c76-4562-900a-46a47c3b9339', 'M3x10 Hex Cap Screw', 4, '425', 0.63, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('2b5bdcab-710e-45d4-ba3e-b5a069d54549', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '24dcce5e-cc41-4b61-9c5e-ba4468e2dbbd', '0d121d6e-fd21-4bd0-b66f-5261fe6f4d5c', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('e137a11d-e792-4a8f-994d-52ea97ac3632', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '0d121d6e-fd21-4bd0-b66f-5261fe6f4d5c', '8eabdac9-ce3a-408c-b4e3-28501a63415d', NULL, 1, NULL, NULL, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('fa078b59-36e9-4dbe-ad3e-2d86fdec5203', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '7a31040c-8a07-4ce0-8613-bd0a0351137b', 'c3166451-9e1b-4c98-ae7d-2da369c3b85e', 'CBE M3x8 Hex Cap Screw', 1, NULL, 1.14, 'Nm', false);

INSERT INTO logi_links (id, assembly_id, parent_id, child_id, fastener, qty, loctite, torque_value, torque_unit, deleted)
VALUES ('1ac45ec3-7373-4bf0-add9-70cffa6d3e19', 'b7e4f701-e071-4b58-8302-0476fc39dab9', '7a31040c-8a07-4ce0-8613-bd0a0351137b', 'de3720a1-8f96-407d-a278-fca6ee605715', 'CBE M3x8 Hex Cap Screw', 1, NULL, NULL, 'Nm', false);


-- ============================================================
-- STEP 6: VERIFY
-- ============================================================
-- Run these queries to verify the import:

-- SELECT COUNT(*) as node_count FROM logi_nodes WHERE assembly_id = 'b7e4f701-e071-4b58-8302-0476fc39dab9';
-- SELECT COUNT(*) as link_count FROM logi_links WHERE assembly_id = 'b7e4f701-e071-4b58-8302-0476fc39dab9';

-- ============================================================
-- DONE! Refresh your app to see the tree.
-- ============================================================
