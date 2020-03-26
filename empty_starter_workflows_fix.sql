--
-- Data for Name: workflow_scheme; Type: TABLE DATA; Schema: public; Owner: dotcms_dev
--

COPY public.workflow_scheme (id, name, description, archived, mandatory, default_scheme, entry_action_id, mod_date) FROM stdin;
d61a59e1-a49c-46f2-a929-db2b4bfa88b2	System Workflow		f	f	f	\N	2020-03-26 00:35:21.869
2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd	Blogs		f	f	f	\N	2020-03-26 00:35:21.945
\.


COPY public.workflow_action (id, step_id, name, condition_to_progress, next_step_id, next_assign, my_order, assignable, commentable, requires_checkout, icon, show_on, use_role_hierarchy_assign, scheme_id) FROM stdin;
45f2136e-a567-49e0-8e22-155019ccfc1c	\N	Approve		f43c5d5a-fc51-4c67-a750-cc8f8e4a87f7	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	t	f	workflowIcon	EDITING,UNPUBLISHED,PUBLISHED,LISTING,LOCKED,UNLOCKED,NEW	f	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd
1b84f952-e6c7-40a9-9b8a-06d764d4c8fd	\N	Archive		37cebe78-cf46-4153-be4c-9c2efd8ec04a	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon	EDITING,UNPUBLISHED,PUBLISHED,LISTING,LOCKED,UNLOCKED	f	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd
f1e3e786-9095-4157-b756-ffc767e2cc12	\N	Copy Blog		currentstep	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon	PUBLISHED,LISTING,UNLOCKED	f	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd
bf83c370-14cc-45f2-8cf7-e963da74eb29	\N	Destroy		currentstep	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon	EDITING,UNPUBLISHED,PUBLISHED,LISTING,LOCKED,UNLOCKED,NEW,ARCHIVED	f	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd
2d1dc771-8fda-4b43-9e81-71d43a8c73e4	\N	Reset Workflow		5865d447-5df7-4fa8-81c8-f8f183f3d1a2	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon	EDITING,UNPUBLISHED,PUBLISHED,LISTING,LOCKED,UNLOCKED,NEW,ARCHIVED	f	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd
8beed083-8999-4bb4-914b-ea0457cf9fd4	\N	Save		f43c5d5a-fc51-4c67-a750-cc8f8e4a87f7	e7d4e34e-5127-45fc-8123-d48b62d510e3	0	f	f	f	workflowIcon	EDITING,UNPUBLISHED,PUBLISHED,LOCKED,NEW	f	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd
89685558-1449-4928-9cff-adda8648d54d	\N	Save and Publish		f43c5d5a-fc51-4c67-a750-cc8f8e4a87f7	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon	EDITING,UNPUBLISHED,PUBLISHED,LISTING,LOCKED,NEW	f	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd
175009d6-9e4b-4ed2-ae31-7d019d3dc278	\N	Save and Publish		f43c5d5a-fc51-4c67-a750-cc8f8e4a87f7	e7d4e34e-5127-45fc-8123-d48b62d510e3	0	f	f	f	workflowIcon	EDITING,UNPUBLISHED,PUBLISHED,LISTING,LOCKED,UNLOCKED,NEW,ARCHIVED	f	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd
d4b61549-84e3-4e8e-8182-8e34f12f9063	\N	Save as Draft		5865d447-5df7-4fa8-81c8-f8f183f3d1a2	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon	EDITING,UNPUBLISHED,PUBLISHED,LOCKED,NEW,ARCHIVED	f	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd
ae569f3a-c96f-4c44-926c-4741b2ad344f	\N	Send Email		currentstep	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon		f	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd
88794a29-d861-4aa5-b137-9a6af72c6fc0	\N	Send for Review		d95caaa6-1ece-42b2-8663-fb01e804a149	e7d4e34e-5127-45fc-8123-d48b62d510e3	0	f	f	f	workflowIcon	EDITING,UNPUBLISHED,LISTING,UNLOCKED	f	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd
8d567403-a201-42de-9a48-10cea8a7bdb2	\N	Translate		f43c5d5a-fc51-4c67-a750-cc8f8e4a87f7	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon	EDITING,UNPUBLISHED,PUBLISHED,LISTING,LOCKED	f	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd
4da13a42-5d59-480c-ad8f-94a3adf809fe	\N	Archive		d6b095b6-b65f-4bdb-bbfd-701d663dfee2	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon	UNPUBLISHED,LISTING,UNLOCKED,ARCHIVED	f	d61a59e1-a49c-46f2-a929-db2b4bfa88b2
963f6a04-5320-42e7-ab74-6d876d199946	\N	Copy		currentstep	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon	PUBLISHED,LISTING,LOCKED,UNLOCKED	f	d61a59e1-a49c-46f2-a929-db2b4bfa88b2
777f1c6b-c877-4a37-ba4b-10627316c2cc	\N	Delete		d6b095b6-b65f-4bdb-bbfd-701d663dfee2	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon	EDITING,LISTING,LOCKED,UNLOCKED,ARCHIVED	f	d61a59e1-a49c-46f2-a929-db2b4bfa88b2
1e0f1c6b-b67f-4c99-983d-db2b4bfa88b2	\N	Destroy		d6b095b6-b65f-4bdb-bbfd-701d663dfee2	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon	EDITING,LISTING,LOCKED,UNLOCKED,ARCHIVED	f	d61a59e1-a49c-46f2-a929-db2b4bfa88b2
b9d89c80-3d88-4311-8365-187323c96436	\N	Publish		dc3c9cd0-8467-404b-bf95-cb7df3fbc293	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon	EDITING,UNPUBLISHED,PUBLISHED,LISTING,LOCKED,UNLOCKED,NEW	f	d61a59e1-a49c-46f2-a929-db2b4bfa88b2
ceca71a0-deee-4999-bd47-b01baa1bcfc8	\N	Save		ee24a4cb-2d15-4c98-b1bd-6327126451f3	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon	EDITING,UNPUBLISHED,PUBLISHED,LOCKED,NEW	f	d61a59e1-a49c-46f2-a929-db2b4bfa88b2
c92f9aa1-9503-4567-ac30-d3242b54d02d	\N	Unarchive		ee24a4cb-2d15-4c98-b1bd-6327126451f3	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon	LISTING,LOCKED,UNLOCKED,ARCHIVED	f	d61a59e1-a49c-46f2-a929-db2b4bfa88b2
38efc763-d78f-4e4b-b092-59cd8c579b93	\N	Unpublish		ee24a4cb-2d15-4c98-b1bd-6327126451f3	654b0931-1027-41f7-ad4d-173115ed8ec1	0	f	f	f	workflowIcon	PUBLISHED,LISTING,LOCKED,UNLOCKED	f	d61a59e1-a49c-46f2-a929-db2b4bfa88b2
\.


--
-- Data for Name: workflow_action_class; Type: TABLE DATA; Schema: public; Owner: dotcms_dev
--

COPY public.workflow_action_class (id, action_id, name, my_order, clazz) FROM stdin;
f1cead4a-c92e-4c20-ae30-93c3b754a833	45f2136e-a567-49e0-8e22-155019ccfc1c	Notify Assignee	0	com.dotmarketing.portlets.workflows.actionlet.NotifyAssigneeActionlet
abba75a1-2bdf-48d6-a138-6e0cefb0f129	45f2136e-a567-49e0-8e22-155019ccfc1c	Unlock content	1	com.dotmarketing.portlets.workflows.actionlet.CheckinContentActionlet
631cdc09-7336-4499-bd16-f8fe58d10026	45f2136e-a567-49e0-8e22-155019ccfc1c	Publish content	2	com.dotmarketing.portlets.workflows.actionlet.PublishContentActionlet
cb260982-2c3f-45e7-b7ea-ab03e1a355f3	1b84f952-e6c7-40a9-9b8a-06d764d4c8fd	Lock content	0	com.dotmarketing.portlets.workflows.actionlet.CheckoutContentActionlet
b4a28af6-487c-4e56-bca1-29f8c96ff5d7	1b84f952-e6c7-40a9-9b8a-06d764d4c8fd	Set Value	1	com.dotmarketing.portlets.workflows.actionlet.SetValueActionlet
b75e11c2-216d-4502-bcaa-cdcbe253cd61	1b84f952-e6c7-40a9-9b8a-06d764d4c8fd	Save content	2	com.dotmarketing.portlets.workflows.actionlet.SaveContentActionlet
f595591f-a2f1-4624-af40-bdb0fe788e7d	1b84f952-e6c7-40a9-9b8a-06d764d4c8fd	Unpublish content	3	com.dotmarketing.portlets.workflows.actionlet.UnpublishContentActionlet
45587874-fc45-4aad-9082-745a9645e244	1b84f952-e6c7-40a9-9b8a-06d764d4c8fd	Archive content	4	com.dotmarketing.portlets.workflows.actionlet.ArchiveContentActionlet
76aa50d0-7d41-49af-a80c-af1d7e24d04a	f1e3e786-9095-4157-b756-ffc767e2cc12	Copy Contentlet	0	com.dotmarketing.portlets.workflows.actionlet.CopyActionlet
eaab7268-fa86-4340-b360-a724f759136f	bf83c370-14cc-45f2-8cf7-e963da74eb29	Unpublish content	0	com.dotmarketing.portlets.workflows.actionlet.UnpublishContentActionlet
10b415ad-d95a-4ad5-847a-33571938b4ea	bf83c370-14cc-45f2-8cf7-e963da74eb29	Archive content	1	com.dotmarketing.portlets.workflows.actionlet.ArchiveContentActionlet
df8f68b6-d546-4c99-bc92-60fb19663965	bf83c370-14cc-45f2-8cf7-e963da74eb29	Delete content	2	com.dotmarketing.portlets.workflows.actionlet.DeleteContentActionlet
214253d0-2f94-41ad-b8c8-9406fe245a77	2d1dc771-8fda-4b43-9e81-71d43a8c73e4	Unarchive content	0	com.dotmarketing.portlets.workflows.actionlet.UnarchiveContentActionlet
99205d78-5e4b-4bd1-866d-aa3cf5b5b759	2d1dc771-8fda-4b43-9e81-71d43a8c73e4	Unlock content	1	com.dotmarketing.portlets.workflows.actionlet.CheckinContentActionlet
965af324-75e9-4ae3-9d56-e9b4128efa19	8beed083-8999-4bb4-914b-ea0457cf9fd4	Save content	0	com.dotmarketing.portlets.workflows.actionlet.SaveContentActionlet
f64a9d26-ee20-4c88-905b-dd708ea4025c	8beed083-8999-4bb4-914b-ea0457cf9fd4	Unlock content	1	com.dotmarketing.portlets.workflows.actionlet.CheckinContentActionlet
6f3a78c3-eb93-47c2-8018-5ba33c7b08a0	89685558-1449-4928-9cff-adda8648d54d	Save content	0	com.dotmarketing.portlets.workflows.actionlet.SaveContentActionlet
8e17634f-99d7-443c-bdba-a21d131f7a4d	89685558-1449-4928-9cff-adda8648d54d	Publish content	1	com.dotmarketing.portlets.workflows.actionlet.PublishContentActionlet
f83b949d-37d8-4178-bca9-add88309b11d	89685558-1449-4928-9cff-adda8648d54d	Unlock content	2	com.dotmarketing.portlets.workflows.actionlet.CheckinContentActionlet
4d519a71-0832-46d6-a2a6-017ca8643ada	175009d6-9e4b-4ed2-ae31-7d019d3dc278	Save content	0	com.dotmarketing.portlets.workflows.actionlet.SaveContentActionlet
d156ba99-ab12-4548-9beb-c3ccba013bc2	175009d6-9e4b-4ed2-ae31-7d019d3dc278	Publish content	1	com.dotmarketing.portlets.workflows.actionlet.PublishContentActionlet
ca6c04f1-86da-4efa-92ea-b35c97b3f7ab	175009d6-9e4b-4ed2-ae31-7d019d3dc278	Notify Assignee	2	com.dotmarketing.portlets.workflows.actionlet.NotifyAssigneeActionlet
02b17eca-bc64-4864-9981-7b3fe8ad8c01	175009d6-9e4b-4ed2-ae31-7d019d3dc278	Unlock content	3	com.dotmarketing.portlets.workflows.actionlet.CheckinContentActionlet
5309a94b-866c-467c-a131-fbaea3a84869	d4b61549-84e3-4e8e-8182-8e34f12f9063	Set Value	0	com.dotmarketing.portlets.workflows.actionlet.SetValueActionlet
3376733a-b192-4aa3-9bf8-7e485d1bc6c8	d4b61549-84e3-4e8e-8182-8e34f12f9063	Save content	1	com.dotmarketing.portlets.workflows.actionlet.SaveContentActionlet
e9734cf0-c177-440c-90af-4db34deba502	ae569f3a-c96f-4c44-926c-4741b2ad344f	Notify Assignee	0	com.dotmarketing.portlets.workflows.actionlet.NotifyAssigneeActionlet
4335e9f9-8d02-48b0-986b-ba44619e6db5	88794a29-d861-4aa5-b137-9a6af72c6fc0	Unlock content	0	com.dotmarketing.portlets.workflows.actionlet.CheckinContentActionlet
3e2a14f5-c26d-4e10-82c8-8565bd711c3c	88794a29-d861-4aa5-b137-9a6af72c6fc0	Notify Assignee	1	com.dotmarketing.portlets.workflows.actionlet.NotifyAssigneeActionlet
95c06ac3-9430-41c0-825a-9c7bc3179886	8d567403-a201-42de-9a48-10cea8a7bdb2	Translate Content	0	com.dotmarketing.portlets.workflows.actionlet.TranslationActionlet
74c560b7-f71d-44cd-bb33-8016abb3f0f2	4da13a42-5d59-480c-ad8f-94a3adf809fe	Archive content	0	com.dotmarketing.portlets.workflows.actionlet.ArchiveContentActionlet
6bc6def5-0565-483d-a5bf-e42d4e424bf0	4da13a42-5d59-480c-ad8f-94a3adf809fe	Unlock content	1	com.dotmarketing.portlets.workflows.actionlet.CheckinContentActionlet
a0346612-62fe-4a8f-bdbc-528d25c71a13	963f6a04-5320-42e7-ab74-6d876d199946	Copy Contentlet	0	com.dotmarketing.portlets.workflows.actionlet.CopyActionlet
93f32847-87b7-4770-bd00-987446fd69b8	777f1c6b-c877-4a37-ba4b-10627316c2cc	Delete content	0	com.dotmarketing.portlets.workflows.actionlet.DeleteContentActionlet
74f42846-86b6-4660-bd00-789446fd67c8	1e0f1c6b-b67f-4c99-983d-db2b4bfa88b2	Destroy content	0	com.dotmarketing.portlets.workflows.actionlet.DestroyContentActionlet
b84879e9-545f-4436-b4c5-e76c1743d168	b9d89c80-3d88-4311-8365-187323c96436	Save content	0	com.dotmarketing.portlets.workflows.actionlet.SaveContentActionlet
9aacba54-b6f4-424c-97f2-56019cbdbbc7	b9d89c80-3d88-4311-8365-187323c96436	Publish content	1	com.dotmarketing.portlets.workflows.actionlet.PublishContentActionlet
6abcf2ab-16ae-4d84-9977-b6124d4d1f73	b9d89c80-3d88-4311-8365-187323c96436	Unlock content	2	com.dotmarketing.portlets.workflows.actionlet.CheckinContentActionlet
52c05cfd-5544-4fe1-9fa4-4e9d95059909	ceca71a0-deee-4999-bd47-b01baa1bcfc8	Save Draft content	0	com.dotmarketing.portlets.workflows.actionlet.SaveContentAsDraftActionlet
7e25aaa2-8371-479a-a978-01374c70decd	ceca71a0-deee-4999-bd47-b01baa1bcfc8	Unlock content	1	com.dotmarketing.portlets.workflows.actionlet.CheckinContentActionlet
a766e1a8-dd14-4b6a-b39e-98db6a258623	c92f9aa1-9503-4567-ac30-d3242b54d02d	Unarchive content	0	com.dotmarketing.portlets.workflows.actionlet.UnarchiveContentActionlet
4132cee3-393d-42ee-84f7-1084a015c4b3	38efc763-d78f-4e4b-b092-59cd8c579b93	Unpublish content	0	com.dotmarketing.portlets.workflows.actionlet.UnpublishContentActionlet
\.


--
-- Data for Name: workflow_action_class_pars; Type: TABLE DATA; Schema: public; Owner: dotcms_dev
--

COPY public.workflow_action_class_pars (id, workflow_action_class_id, key, value) FROM stdin;
6c44b7c9-26bf-4c92-989b-e1f15ccea898	f1cead4a-c92e-4c20-ae30-93c3b754a833	emailSubject	\N
07bbcaae-051d-4e73-bcdd-b0f973f112af	f1cead4a-c92e-4c20-ae30-93c3b754a833	emailBody	\N
1afa09d2-a834-4567-9465-3ae63b599e85	f1cead4a-c92e-4c20-ae30-93c3b754a833	isHtml	true
86a1b3ad-91b9-4c46-9415-aa828a95fdfc	b4a28af6-487c-4e56-bca1-29f8c96ff5d7	field	postingDate
dd525a7b-254b-45b0-b7ec-da43a9575c66	b4a28af6-487c-4e56-bca1-29f8c96ff5d7	value	#set($value='')
83a1cfc7-4f14-43ca-b77e-f7d1cc3758ea	ca6c04f1-86da-4efa-92ea-b35c97b3f7ab	emailSubject	There is a new Blog: $content.title
fdc358be-acba-49f5-bafc-f3535443399f	ca6c04f1-86da-4efa-92ea-b35c97b3f7ab	emailBody	There is a new Blog: $content.title
5b2f01c0-3ddd-4d85-be48-df83d01e70c7	ca6c04f1-86da-4efa-92ea-b35c97b3f7ab	isHtml	true
c4f4d55d-4cb7-4427-be8b-e79ee5b3ca2e	5309a94b-866c-467c-a131-fbaea3a84869	field	postingDate
0961a74f-30de-4e6a-88e2-55ee342977b6	5309a94b-866c-467c-a131-fbaea3a84869	value	#set($value="")
c4d63be6-586a-4edf-a2ad-621287aa5560	e9734cf0-c177-440c-90af-4db34deba502	emailSubject	\N
33b20055-98d5-4b72-9c72-160bc4205ec9	e9734cf0-c177-440c-90af-4db34deba502	emailBody	\N
c63f1807-cecd-4850-9709-4721bba27887	e9734cf0-c177-440c-90af-4db34deba502	isHtml	true
409885f9-ffe6-44d3-a574-824bb907bfb8	3e2a14f5-c26d-4e10-82c8-8565bd711c3c	emailSubject	\N
d7d143f6-2f7a-4235-8742-538178b3b62f	3e2a14f5-c26d-4e10-82c8-8565bd711c3c	emailBody	\N
3affc9e8-1416-4f07-a6c6-fa4bc665cdb4	3e2a14f5-c26d-4e10-82c8-8565bd711c3c	isHtml	true
923f2ed0-42c0-4c4f-8350-7c986ddd33f9	95c06ac3-9430-41c0-825a-9c7bc3179886	translateTo	all
ccf7ceb5-aaf9-4322-94fb-93a8478edd04	95c06ac3-9430-41c0-825a-9c7bc3179886	fieldTypes	text,wysiwyg,textarea
86ea3f85-8dc6-4d91-9806-8d88477217f1	95c06ac3-9430-41c0-825a-9c7bc3179886	ignoreFields	\N
c02b80c2-8028-453e-8066-5d6394bdf9c2	95c06ac3-9430-41c0-825a-9c7bc3179886	apiKey	AIzaSyCzeaNIUO33tW7wjyY5dXhtbayIJpKoUi4
\.


--
-- Data for Name: workflow_step; Type: TABLE DATA; Schema: public; Owner: dotcms_dev
--

COPY public.workflow_step (id, name, scheme_id, my_order, resolved, escalation_enable, escalation_action, escalation_time) FROM stdin;
5865d447-5df7-4fa8-81c8-f8f183f3d1a2	Editing	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd	0	f	f	\N	0
d95caaa6-1ece-42b2-8663-fb01e804a149	QA	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd	1	f	f	\N	0
37cebe78-cf46-4153-be4c-9c2efd8ec04a	Archive	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd	3	t	f	\N	0
6cb7e3bd-1710-4eed-8838-d3db60f78f19	New	d61a59e1-a49c-46f2-a929-db2b4bfa88b2	0	f	f	\N	0
ee24a4cb-2d15-4c98-b1bd-6327126451f3	Draft	d61a59e1-a49c-46f2-a929-db2b4bfa88b2	1	f	f	\N	0
dc3c9cd0-8467-404b-bf95-cb7df3fbc293	Published	d61a59e1-a49c-46f2-a929-db2b4bfa88b2	2	t	f	\N	0
d6b095b6-b65f-4bdb-bbfd-701d663dfee2	Archived	d61a59e1-a49c-46f2-a929-db2b4bfa88b2	3	t	f	\N	0
f43c5d5a-fc51-4c67-a750-cc8f8e4a87f7	Published	2a4e1d2e-5342-4b46-be3d-80d3a2d9c0dd	2	f	t	1b84f952-e6c7-40a9-9b8a-06d764d4c8fd	15552000
\.


--
-- Data for Name: workflow_action_step; Type: TABLE DATA; Schema: public; Owner: dotcms_dev
--

COPY public.workflow_action_step (action_id, step_id, action_order) FROM stdin;
8d567403-a201-42de-9a48-10cea8a7bdb2	5865d447-5df7-4fa8-81c8-f8f183f3d1a2	0
ae569f3a-c96f-4c44-926c-4741b2ad344f	5865d447-5df7-4fa8-81c8-f8f183f3d1a2	1
d4b61549-84e3-4e8e-8182-8e34f12f9063	5865d447-5df7-4fa8-81c8-f8f183f3d1a2	2
88794a29-d861-4aa5-b137-9a6af72c6fc0	5865d447-5df7-4fa8-81c8-f8f183f3d1a2	3
8beed083-8999-4bb4-914b-ea0457cf9fd4	5865d447-5df7-4fa8-81c8-f8f183f3d1a2	4
175009d6-9e4b-4ed2-ae31-7d019d3dc278	5865d447-5df7-4fa8-81c8-f8f183f3d1a2	5
45f2136e-a567-49e0-8e22-155019ccfc1c	d95caaa6-1ece-42b2-8663-fb01e804a149	0
1b84f952-e6c7-40a9-9b8a-06d764d4c8fd	d95caaa6-1ece-42b2-8663-fb01e804a149	1
8beed083-8999-4bb4-914b-ea0457cf9fd4	d95caaa6-1ece-42b2-8663-fb01e804a149	2
8d567403-a201-42de-9a48-10cea8a7bdb2	d95caaa6-1ece-42b2-8663-fb01e804a149	3
8beed083-8999-4bb4-914b-ea0457cf9fd4	f43c5d5a-fc51-4c67-a750-cc8f8e4a87f7	0
f1e3e786-9095-4157-b756-ffc767e2cc12	f43c5d5a-fc51-4c67-a750-cc8f8e4a87f7	1
89685558-1449-4928-9cff-adda8648d54d	f43c5d5a-fc51-4c67-a750-cc8f8e4a87f7	2
8d567403-a201-42de-9a48-10cea8a7bdb2	f43c5d5a-fc51-4c67-a750-cc8f8e4a87f7	3
2d1dc771-8fda-4b43-9e81-71d43a8c73e4	f43c5d5a-fc51-4c67-a750-cc8f8e4a87f7	4
1b84f952-e6c7-40a9-9b8a-06d764d4c8fd	f43c5d5a-fc51-4c67-a750-cc8f8e4a87f7	5
2d1dc771-8fda-4b43-9e81-71d43a8c73e4	37cebe78-cf46-4153-be4c-9c2efd8ec04a	0
89685558-1449-4928-9cff-adda8648d54d	37cebe78-cf46-4153-be4c-9c2efd8ec04a	1
bf83c370-14cc-45f2-8cf7-e963da74eb29	37cebe78-cf46-4153-be4c-9c2efd8ec04a	2
ceca71a0-deee-4999-bd47-b01baa1bcfc8	6cb7e3bd-1710-4eed-8838-d3db60f78f19	0
b9d89c80-3d88-4311-8365-187323c96436	6cb7e3bd-1710-4eed-8838-d3db60f78f19	1
777f1c6b-c877-4a37-ba4b-10627316c2cc	6cb7e3bd-1710-4eed-8838-d3db60f78f19	2
ceca71a0-deee-4999-bd47-b01baa1bcfc8	ee24a4cb-2d15-4c98-b1bd-6327126451f3	0
38efc763-d78f-4e4b-b092-59cd8c579b93	ee24a4cb-2d15-4c98-b1bd-6327126451f3	1
963f6a04-5320-42e7-ab74-6d876d199946	ee24a4cb-2d15-4c98-b1bd-6327126451f3	2
b9d89c80-3d88-4311-8365-187323c96436	ee24a4cb-2d15-4c98-b1bd-6327126451f3	3
4da13a42-5d59-480c-ad8f-94a3adf809fe	ee24a4cb-2d15-4c98-b1bd-6327126451f3	4
963f6a04-5320-42e7-ab74-6d876d199946	dc3c9cd0-8467-404b-bf95-cb7df3fbc293	0
38efc763-d78f-4e4b-b092-59cd8c579b93	dc3c9cd0-8467-404b-bf95-cb7df3fbc293	1
ceca71a0-deee-4999-bd47-b01baa1bcfc8	dc3c9cd0-8467-404b-bf95-cb7df3fbc293	2
4da13a42-5d59-480c-ad8f-94a3adf809fe	dc3c9cd0-8467-404b-bf95-cb7df3fbc293	3
b9d89c80-3d88-4311-8365-187323c96436	dc3c9cd0-8467-404b-bf95-cb7df3fbc293	4
c92f9aa1-9503-4567-ac30-d3242b54d02d	d6b095b6-b65f-4bdb-bbfd-701d663dfee2	0
777f1c6b-c877-4a37-ba4b-10627316c2cc	d6b095b6-b65f-4bdb-bbfd-701d663dfee2	1
1e0f1c6b-b67f-4c99-983d-db2b4bfa88b2	d6b095b6-b65f-4bdb-bbfd-701d663dfee2	2
\.


--
-- Data for Name: workflow_scheme_x_structure; Type: TABLE DATA; Schema: public; Owner: dotcms_dev
--

COPY public.workflow_scheme_x_structure (id, scheme_id, structure_id) FROM stdin;
ffc83470-9541-4454-ad0f-10bea90be61b	d61a59e1-a49c-46f2-a929-db2b4bfa88b2	c6e3a3c6-a0c6-494b-9ae8-bde7322bc68e
ce124c80-16d6-47c9-9e26-3326bbfa998b	d61a59e1-a49c-46f2-a929-db2b4bfa88b2	33888b6f-7a8e-4069-b1b6-5c1aa9d0a48d
0c0106df-6563-4e08-ae67-1e8cdecb5c05	d61a59e1-a49c-46f2-a929-db2b4bfa88b2	f4d7c1b8-2c88-4071-abf1-a5328977b07d
203086df-f400-42f4-b05d-1b62e52be883	d61a59e1-a49c-46f2-a929-db2b4bfa88b2	855a2d72-f2f3-4169-8b04-ac5157c4380c
f54498d0-4fe3-443b-a507-78d7ff794039	d61a59e1-a49c-46f2-a929-db2b4bfa88b2	4d21b6d8-1711-4ae6-9419-89e2b1ae5a06
85d5b026-00cc-4422-9465-4087faed2ff3	d61a59e1-a49c-46f2-a929-db2b4bfa88b2	8e850645-bb92-4fda-a765-e67063a59be0
04ed7311-1fad-4e83-835a-dcf625b33ec3	d61a59e1-a49c-46f2-a929-db2b4bfa88b2	c541abb1-69b3-4bc5-8430-5e09e5239cc8
fadef487-4618-4583-b2dc-df6f17777c68	d61a59e1-a49c-46f2-a929-db2b4bfa88b2	f6259cc9-5d78-453e-8167-efd7b72b2e96
ad9b798e-59d7-4a22-a051-b0ea1dd86a70	d61a59e1-a49c-46f2-a929-db2b4bfa88b2	2a3e91e4-fbbf-4876-8c5b-2233c1739b05
\.



