
-- tags
-- 111401:和铁拳弟子说完话
-- 111402:上官剧情结束，在走到格子20。
-- 111403:和重伤之人说完话（不会在说话）
-- 111404:拯救完上官齐
-- 111405:获得伏音木

-- 111406:击败格子8的三个小
-- 111407:击败格子10的两小一大
-- 111408:击败格子11的两大一小
-- 111409:击败格子15的三个大狼
-- 111410:击败格子18的狼王

-- 111400:章节结束

-- 111411:击败格子66疙瘩大蛤蟆1411208，获得装备地灵鞋454511
-- 111412:击败格子65青蛤蟆1411209，获得太虚拳宝典397513
-- 111413:击败格子65青蛤蟆1411210，获得太虚拳宝典397513
-- 111414:击败格子65青蛤蟆1411211，获得太虚拳宝典397513
-- 111415:击败格子72三个毒血宗弟子1411212
-- 111416:击败格子74毒血宗长老+两个弟子1411213
-- 111417:击败格子75毒血老怪1411214，获得碧血晶190010，获得太虚拳传承397519
-- 111418:击败格子89长剑怪1411216，获得原水神剑之柄190012
-- 111419:击败格子88匕首怪1411215，获得灰梦双匕之鞘190011
-- 111420:解开91阵法
-- 111421:和格子92对话，获得七弦无形剑传承397329


local scene_011401 = {
	name = "伏心谷",
	id = 11401,
	enter = {11401,1001},

	points = {
		[1001] = {
			name = "官道",
			pos = {100,26},
			id = 1001,
			grids = {[1]=1002,},
			desc = "前往岳城的官道上，不时有马匹飞驰扬起尘土，更多的是三三两两风尘仆仆的行人。",
		},

		[1002] = {
			name = "官道",
			pos = {100,130},
			id = 1002,
			grids = {[2]=1001,[1]=1005,},
			desc = "前往岳城的官道上，不时有马匹飞驰扬起尘土，更多的是三三两两风尘仆仆的行人。",
			triggerDesc = "和邵灵儿一人一骑，说说笑笑，悠悠然的往岳城而行，行至半道，被铁臂红拳门弟子的交谈吸引了。",

			npcs = {
				{
					npcName = "铁臂红拳弟子",
					desc = "个个虎头虎脑，面貌质朴忠厚。",
					visibleConditions = {noTags = {111401}},
					[1] = {
						talks = {
							{npc = "二师兄，你说咱们的贺礼，会合田老爷子的心意么？。",npcName="铁臂红拳弟子"},
							{npc = "是啊，二师兄，各门各派都备下贺礼的吧？咱的可要给师门长脸。",npcName="铁臂红拳弟子"},
							{npc = "不必多虑，尽了心意便可。",player = "啊？还要备礼啊！……灵儿，你的鞭子不错。",npcName="铁臂红拳弟子"},
							{npc = "信不信给你一鞭？",player = "额……",npcName="邵灵儿"},
							{npc = "我有个主意，听我爹说，田老爷子精通音律，尤擅吹笛，传闻伏音谷有伏音木，此木可存声音。",player = "还有这等宝贝？就它了！灵儿，你可真灵。",npcName="邵灵儿"},
							{npc = "少贫嘴，还不快马加鞭的，伏音谷可不近呢。",npcName="邵灵儿"},
						},
						next = 4,
					},
					[4] = {
						res = {
							tags = {111401}
						}
					},
				},
			},
		},

		[1003] = {
			name = "外缘",
			pos = {-366,234},
			id = 1003,
			grids = {[4]=1004,[1]=1007,},
			desc = "伏音谷的雾，时而薄如纱，时而浓如幕，整个山谷都迷茫在雾中，如虚如幻。",
		},

		[1004] = {
			name = "外缘",
			pos = {-133,234},
			id = 1004,
			grids = {[4]=1005,[3]=1003,[1]=1008,},
			desc = "伏音谷的雾，时而薄如纱，时而浓如幕，整个山谷都迷茫在雾中，如虚如幻。",
		},

		[1005] = {
			name = "外缘",
			pos = {100,234},
			id = 1005,
			grids = {[2]=1002,[3]=1004,[4]=1006,[1]=1009,},
			desc = "伏音谷的雾，时而薄如纱，时而浓如幕，整个山谷都迷茫在雾中，如虚如幻。",
		},

		[1006] = {
			name = "外缘",
			pos = {333,234},
			id = 1006,
			grids = {[3]=1005,[1]=1010,},
			desc = "伏音谷的雾，时而薄如纱，时而浓如幕，整个山谷都迷茫在雾中，如虚如幻。",
		},

		[1007] = {
			name = "谷中",
			pos = {-366,338},
			id = 1007,
			grids = {[2]=1003,[4]=1008,[1]=1011,},
			desc = "临近谷底，雾越发的浓成了化不开似的乳白色，四顾迷茫，只闻得雾狼一声声的“嗷呜----”在山谷中回荡。",
		},

		[1008] = {
			name = "谷中",
			pos = {-133,338},
			id = 1008,
			grids = {[3]=1007,[2]=1004,[4]=1009,[1]=1012,},
			desc = "临近谷底，雾越发的浓成了化不开似的乳白色，四顾迷茫，只闻得雾狼一声声的“嗷呜----”在山谷中回荡。",
			triggerDesc = "雾狼正悄无声息地缓缓逼近。",

			npcs = {
				{
					npcName = "雾狼",
					desc = "体型巨大，像白雾中一块块黝黑的山石，只是那碧绿的眼睛，穿透浓雾，闪着嗜血的光。",
					visibleConditions = {noTags = {111406}},
					[0] = {
						player = {
							{content = "驱赶", next = 2},
						}
					},
					[2] = {
						player = "有狼，小心。",
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1411401, level = 30 },
								{ index = 4, id = 1411401, level = 30 },
								{ index = 7, id = 1411401, level = 30 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									tags = 111406,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
				
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = 111406},
					failMsg = "有三只小狼挡住了去路。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1009] = {
			name = "谷中",
			pos = {100,338},
			id = 1009,
			grids = {[3]=1008,[2]=1005,[4]=1010,},
			desc = "临近谷底，雾越发的浓成了化不开似的乳白色，四顾迷茫，只闻得雾狼一声声的“嗷呜----”在山谷中回荡。",
		},

		[1010] = {
			name = "谷中",
			pos = {333,338},
			id = 1010,
			grids = {[3]=1009,[2]=1006,},
			desc = "临近谷底，雾越发的浓成了化不开似的乳白色，四顾迷茫，只闻得雾狼一声声的“嗷呜----”在山谷中回荡。",
			triggerDesc = "雾狼正悄无声息地缓缓逼近。",

			npcs = {
				{
					npcName = "雾狼",
					desc = "体型巨大，像白雾中一块块黝黑的山石，只是那碧绿的眼睛，穿透浓雾，闪着嗜血的光。",
					visibleConditions = {noTags = {111407}},
					[0] = {
						player = {
							{content = "驱赶", next = 2},
						}
					},
					[2] = {
						player = "有狼，小心。",
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 2, id = 1411401, level = 30 },
								{ index = 4, id = 1411402, level = 30 },
								{ index = 8, id = 1411401, level = 30 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									tags = 111407,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = 111407},
					failMsg = "有一只大狼和两只小狼挡住了去路。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1011] = {
			name = "谷中",
			pos = {-366,442},
			id = 1011,
			grids = {[2]=1007,[4]=1012,[1]=1015,},
			desc = "临近谷底，雾越发的浓成了化不开似的乳白色，四顾迷茫，只闻得雾狼一声声的“嗷呜----”在山谷中回荡。",
			triggerDesc = "雾狼正悄无声息地缓缓逼近。",

			npcs = {
				{
					npcName = "雾狼",
					desc = "体型巨大，像白雾中一块块黝黑的山石，只是那碧绿的眼睛，穿透浓雾，闪着嗜血的光。",
					visibleConditions = {noTags = {111408}},
					[0] = {
						player = {
							{content = "驱赶", next = 2},
						}
					},
					[2] = {
						player = "有狼，小心。",
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 2, id = 1411402, level = 30 },
								{ index = 6, id = 1411401, level = 30 },
								{ index = 8, id = 1411402, level = 30 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
					},
					[6] = {
						talks = {
							{player = "地上还有一根长鞭，看来是有使鞭的侠客在这里遇害了。"},
							{npc = "还是一根良锻的长鞭，观其色泽当是鳄皮所制。",npcName="邵灵儿"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = {111408},
							items = {{421761,1}},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = 111408},
					failMsg = "有两只大狼和一只小狼挡住了去路。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1012] = {
			name = "谷中",
			pos = {-133,442},
			id = 1012,
			grids = {[3]=1011,[2]=1008,[1]=1016,},
			desc = "临近谷底，雾越发的浓成了化不开似的乳白色，四顾迷茫，只闻得雾狼一声声的“嗷呜----”在山谷中回荡。",
		},

		[1013] = {
			name = "谷崖",
			pos = {100,442},
			id = 1013,
			grids = {[1]=1017,},
			desc = "伏音谷崖石嶙峋，人迹罕，鸟飞绝。",
		},

		[1014] = {
			name = "玉泉",
			pos = {333,442},
			id = 1014,
			grids = {[1]=1018,},
			desc = "山涧潺潺汩汩，自峭壁而下，喷珠吐玉，流经一片青翠翠的矮树丛，泛起团团水雾。",
			triggerDesc = "伏音木，音韵袅袅，似伏音谷的雾，如虚如幻。",

			npcs = {
				{
					npcName = "伏音木",
					desc = "似竹非竹，似木非木，青翠翠，碧盈盈。",
					[0] = {
						player = {
							{content = "探查", next = 3},
						}
					},
					[3] = {
						talks = {
							{player = "这便是伏音木了？真是宝物啊！都带走吧。"},
							{npc = "别贪心，伏音木成长不易，只取所需吧。",player = "好嘞，听灵儿的。",npcName="邵灵儿"},
						},
						next = 4,
					},
					[4] = {
						[1] = {
							conditions = {
								noTags = {111405},
							},
							res = {
								tags = {111405,111400},
								items = {{190002,1}},
							},
							lineMsg = "获得了伏音木*1。"
						},
						[2] = {
							res = {
								tags = {111405,111400},
							},
						},
					},
				},
			},
		},

		[1015] = {
			name = "谷底",
			pos = {-366,546},
			id = 1015,
			grids = {[2]=1011,[4]=1016,},
			desc = "谷底，雾气反而散开了些，只见沉积砂砾、洞顶穹窿，都浸润在满目的青翠中。",
			triggerDesc = "雾狼正悄无声息地缓缓逼近。",

			npcs = {
				{
					npcName = "雾狼",
					desc = "体型巨大，像白雾中一块块黝黑的山石，只是那碧绿的眼睛，穿透浓雾，闪着嗜血的光。",
					visibleConditions = {noTags = {111409}},
					[0] = {
						player = {
							{content = "驱赶", next = 2},
						}
					},
					[2] = {
						player = "有狼，小心。",
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1411402, level = 30 },
								{ index = 4, id = 1411402, level = 30 },
								{ index = 7, id = 1411402, level = 30 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									tags = 111409,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
				
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = 111409},
					failMsg = "有三只大狼挡住了去路。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1016] = {
			name = "谷底",
			pos = {-133,546},
			id = 1016,
			grids = {[2]=1012,[1]=1019,[3]=1015,},
			desc = "谷底，雾气反而散开了些，只见沉积砂砾、洞顶穹窿，都浸润在满目的青翠中。",
		},

		[1017] = {
			name = "谷底",
			pos = {100,546},
			id = 1017,
			grids = {[4]=1018,[1]=1020,[2]=1013,},
			desc = "谷底，雾气反而散开了些，只见沉积砂砾、洞顶穹窿，都浸润在满目的青翠中。",
		},

		[1018] = {
			name = "谷崖",
			pos = {333,546},
			id = 1018,
			grids = {[3]=1017,[1]=1021,[2]=1014,},
			desc = "谷底，雾气反而散开了些，只见沉积砂砾、洞顶穹窿，都浸润在满目的青翠中。",
			triggerDesc = "雾狼正悄无声息地缓缓逼近。",

			npcs = {
				{
					npcName = "狼王",
					desc = "体型巨大，像白雾中一块块黝黑的山石，只是那碧绿的眼睛，穿透浓雾，闪着嗜血的光。",
					visibleConditions = {noTags = {111410}},
					[0] = {
						player = {
							{content = "驱赶", next = 2},
						}
					},
					[2] = {
						player = "哇！狼王啊！灵儿闪开，看我的！",
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 4, id = 1411403, level = 60 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
					},
					[6] = {
						player = "真难对付，幸好有灵儿你和我一起，不然我可对付不了它",
						npc = "哼，现在知道我的厉害了吧！",npcName = "邵灵儿",
						next = 7,
					},
					[7] = {
						res = {tags = 111410},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = 111410},
					failMsg = "好大一只狼，这可能就是此谷中狼群之王了。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1019] = {
			name = "谷底",
			pos = {-133,650},
			id = 1019,
			grids = {[2]=1016,[4]=1020,},
			desc = "谷底，雾气反而散开了些，只见沉积砂砾、洞顶穹窿，都浸润在满目的青翠中。",
			triggerDesc = "满地碎裂的砂石、折断的枝丫、爪印和血渍……",

			npcs = {
				{
					npcName = "重伤的少年",
					desc = "倒在一块山石旁，衣服被撕成了条缕，暗红色的血渍晕染了一大片砂石枯叶。",
					visibleConditions = {
						noTags = {111400},
					},
					[1] = {
						conditions = {noTags = {111403}},
						talks = {
							{player = "喂喂，你怎么样了，还撑得住么？"},
							{npc = "快去……救人……",player = "哪里救人？喂喂，说清楚呀。",npcName="重伤的少年"},
							{npc = "(已经没有了呼吸)",npcName="重伤的少年"},
							{npc = "那边！听，有呼救声，快去！",npcName="邵灵儿"},

						},
						next = 4,
					},
					[2] = {
						player = "他已经不行了。",
					},
					[4] = {
						res = {
							tags = {111403}
						}
					},
				},
			},
		},

		[1020] = {
			name = "谷底",
			pos = {100,650},
			id = 1020,
			grids = {[2]=1017,[3]=1019,},
			desc = "谷底，雾气反而散开了些，只见沉积砂砾、洞顶穹窿，都浸润在满目的青翠中。",
			triggerDesc = "谷底两侧都是峭壁，湿润润的长满了苔藓，崖石的一处缝隙里，斜插着一根棍子，少年紧紧抱住棍子，下方群狼环伺。",

			npcs = {
				{
					npcName = "上官齐",
					desc = "一个十七八岁的少年，脸色煞白，瑟瑟发抖，也不知道是冻的，还是吓的。",
					visibleConditions = {
						noTags = {111404},
					},
					[1] = {
						talks = {
							{npc = "救我！……啊？你们才两个人？小心，别过来。",npcName="上官齐"},
							{npc = "瞧！这棍子……这不是那根“阳钰之棍”吗？",player = "别愣着了，想喂狼啊！",npcName="邵灵儿"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1411402, level = 30 },
								{ index = 3, id = 1411401, level = 30 },
								{ index = 7, id = 1411402, level = 30 },
								{ index = 9, id = 1411401, level = 30 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
					},
					[6] = {
						talks = {
							{npc = "哇喔，以为死定了……多谢二位出手相救。",player = "你可是邵城上官齐？",npcName="上官齐"},
							{npc = "正是，你如何知道？",player = "你奶奶托我寻你，老人家担心坏了，赶紧回去吧。",npcName="上官齐"},
							{npc = "噢，马上回，我先去找同伴。",player = "你的同伴……我们遇到时，有一个是伤重而亡，其他人，可能已经被雾狼……",npcName="邵灵儿"},
							{npc = "啊！",player = "你快回去吧，也好去别家报个信。",npcName="上官齐"},
							{npc = "哎……那，请二位随我一起吧。",npcName="上官齐"},
							{npc = "雾狼都被我们击溃了，放心吧，这么点能耐还敢乱跑。",npcName="邵灵儿"},
							{npc = "不不，我是想请二位随我一同回去，以谢大恩。",player = "这也是碰巧遇上，不足挂齿。",npcName="上官齐"},
							{npc = "如此那我便先行一步了，<color=#ff0000>此恩先记下，日后二位得便，一定要来邵城</color>。",player = "好！",npcName="上官齐"},
						},
						next = 7,
					},
					[7] = {
						res = {
							tags = {111404,111308,111402},
							items = {{190005,1}},
						},
					},
				},
				{
					npcName = "雾狼",
					desc = "体型巨大，像白雾中一块块黝黑的山石，只是那碧绿的眼睛，穿透浓雾，闪着嗜血的光。",
					visibleConditions = {
						tags = {111404},
						noTags = {111402},
					},
					[0] = {
						player = {
							{content = "驱赶", next = 2},
						}
					},
					[2] = {
						player = "有狼，小心。",
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1411402, level = 30 },
								{ index = 3, id = 1411401, level = 30 },
								{ index = 7, id = 1411402, level = 30 },
								{ index = 9, id = 1411401, level = 30 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 7,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
					},
					[7] = {
						res = {
							tags = {111402},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {
						tags = {111404,111402},
					},
					failMsg = "好多狼，小心！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1021] = {
			name = "谷崖",
			pos = {333,650},
			id = 1021,
			grids = {[2]=1018,[1]=1051},
			desc = "伏音谷崖石嶙峋，人迹罕，鸟飞绝。",
		},
		[1051] = {
			name = "暗河",
			pos = {-107,-375},
			id = 1051,
			grids = {[1]=1062,[4]=1052,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
			enterParts = {
				{
					conditions = { ncou = 75},
					failMsg = "暗河看着十分危险，<color=#ff0000>胆识不够</color>，还是别下去了吧！",	
				},
			},
		},

		[1052] = {
			name = "暗河",
			pos = {126,-375},
			id = 1052,
			grids = {[3]=1051,[4]=1053,[1]=1063,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1053] = {
			name = "暗河",
			pos = {359,-375},
			id = 1053,
			grids = {[3]=1052,[4]=1054,[1]=1064,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1054] = {
			name = "暗河",
			pos = {592,-375},
			id = 1054,
			grids = {[3]=1053,[4]=1055,[2]=1056,[1]=1065,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1055] = {
			name = "暗河",
			pos = {825,-375},
			id = 1055,
			grids = {[3]=1054,[2]=1057,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1056] = {
			name = "暗河",
			pos = {592,-479},
			id = 1056,
			grids = {[1]=1054,[2]=1058,[4]=1057,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1057] = {
			name = "暗河",
			pos = {825,-479},
			id = 1057,
			grids = {[1]=1055,[2]=1059,[3]=1056,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1058] = {
			name = "暗河",
			pos = {592,-583},
			id = 1058,
			grids = {[1]=1056,[4]=1059,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1059] = {
			name = "暗河",
			pos = {825,-583},
			id = 1059,
			grids = {[1]=1057,[3]=1058,[4]=1076,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1060] = {
			name = "暗河",
			pos = {-573,-271},
			id = 1060,
			grids = {[4]=1061,[1]=1066,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1061] = {
			name = "暗河",
			pos = {-340,-271},
			id = 1061,
			grids = {[4]=1062,[3]=1060,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1062] = {
			name = "暗河",
			pos = {-107,-271},
			id = 1062,
			grids = {[2]=1051,[1]=1067,[3]=1061,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1063] = {
			name = "暗河",
			pos = {126,-271},
			id = 1063,
			grids = {[2]=1052,[1]=1068,[4]=1064,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1064] = {
			name = "暗河",
			pos = {359,-271},
			id = 1064,
			grids = {[2]=1053,[1]=1069,[4]=1065,[3]=1063,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1065] = {
			name = "暗河",
			pos = {592,-271},
			id = 1065,
			grids = {[2]=1054,[3]=1064,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",
			triggerDesc = "此处有污流涌动，一些水中动物变换了形态。",

			npcs = {
				{
					npcName = "青鳞大蛤蟆",
					desc = "泛着青光的蛤蟆，个子比普通蛤蟆大的多，腹部鼓动之间犹如内力在运转。",
					visibleConditions = {noTags = {111412}},
					[0] = {
						player = {
							{content = "驱赶", next = 2},
						}
					},
					[2] = {
						talks = {
							{npc = "咻、咻、呱！咻、咻、呱！",player = "这大蛤蟆看着很吓人呢！",npcName="青鳞大蛤蟆"},
							{npc = "这大蛤蟆看着很吓人呢！",npcName="邵灵儿"},
						},
						next = 3,
					},
					[3] = {
						npc = "咻、咻、呱！咻、咻、呱！",
						player = {
							{ content = "必然是毒物，我们为民除害吧！", next = 5 },
							{ content = "这蛤蟆看着太吓人了，还是以后再来收拾它吧！"},
						},
					},
					[5] = {
						battle = {
							limitFriendNum = 7,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 5, id = 1411209, level = 300 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 7,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
				
					},
					[7] = {
						talks = {
							{npc = "青鳞蛤蟆逃走了，遗落了一本册子。",player = "终于击败它了，还挺强呢。",npcName=""},
							{npc = "快瞧瞧地上掉了啥？",npcName="邵灵儿"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = 111412,
							items = 397513,
						}
					},
				},
				{
					npcName = "红鳞大蛤蟆",
					desc = "身披红鳞的大蛤蟆，在漆黑的暗河中如轻功高手般来回穿梭，速度极快。",
					visibleConditions = {noTags = {111413}},
					[0] = {
						player = {
							{content = "驱赶", next = 2},
						}
					},
					[2] = {
						talks = {
							{npc = "咻、咻、呱！咻、咻、呱！",player = "这大蛤蟆看着很吓人呢！",npcName="红鳞大蛤蟆"},
							{npc = "这大蛤蟆看着很吓人呢！",npcName="邵灵儿"},
						},
						next = 3,
					},
					[3] = {
						npc = "咻、咻、呱！咻、咻、呱！",
						player = {
							{ content = "必然是毒物，我们为民除害吧！", next = 5 },
							{ content = "这蛤蟆看着太吓人了，还是以后再来收拾它吧！"},
						},
					},
					[5] = {
						battle = {
							limitFriendNum = 7,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 5, id = 1411210, level = 300 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 7,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
				
					},
					[7] = {
						talks = {
							{npc = "红鳞蛤蟆逃走了，遗落了一本册子。",player = "终于击败它了，还挺强呢。",npcName=""},
							{npc = "快瞧瞧地上掉了啥？",npcName="邵灵儿"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = 111413,
							items = 397513,
						}
					},
				},
				{
					npcName = "黑鳞大蛤蟆",
					desc = "漆黑的巨型蛤蟆，如身披黑甲的战神，腹部鼓动之时有吞噬天地的气魄。",
					visibleConditions = {noTags = {111414}},
					[0] = {
						player = {
							{content = "驱赶", next = 2},
						}
					},
					[2] = {
						talks = {
							{npc = "咻、咻、呱！咻、咻、呱！",player = "这大蛤蟆看着很吓人呢！",npcName="黑鳞大蛤蟆"},
							{npc = "这大蛤蟆看着很吓人呢！",npcName="邵灵儿"},
						},
						next = 3,
					},
					[3] = {
						npc = "咻、咻、呱！咻、咻、呱！",
						player = {
							{ content = "必然是毒物，我们为民除害吧！", next = 5 },
							{ content = "这蛤蟆看着太吓人了，还是以后再来收拾它吧！"},
						},
					},
					[5] = {
						battle = {
							limitFriendNum = 7,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 5, id = 1411211, level = 300 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 7,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
				
					},
					[7] = {
						talks = {
							{npc = "黑鳞蛤蟆逃走了，遗落了一本册子。",player = "终于击败它了，还挺强呢。",npcName=""},
							{npc = "快瞧瞧地上掉了啥？",npcName="邵灵儿"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = 111414,
							items = 397513,
						}
					},
				},
			},


			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1066] = {
			name = "暗河",
			pos = {-573,-167},
			id = 1066,
			grids = {[2]=1060,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",
			triggerDesc = "一只巨大的丑陋无比的大蛤蟆正在此处缓慢的游荡。",

			npcs = {
				{
					npcName = "疙瘩大蛤蟆",
					desc = "全身长满硕大的一颗颗疙瘩的蛤蟆，疙瘩饱满的好似怪兽的果实。",
					visibleConditions = {noTags = {111411}},
					[0] = {
						player = {
							{content = "驱赶", next = 2},
						}
					},
					[2] = {
						talks = {
							{npc = "咻、咻、呱！咻、咻、呱！",player = "这大蛤蟆看着很吓人呢！",npcName="疙瘩大蛤蟆"},
							{npc = "这大蛤蟆看着很吓人呢！",npcName="邵灵儿"},
						},
						next = 3,
					},

					[3] = {
						npc = "咻、咻、呱！咻、咻、呱！",
						player = {
							{ content = "必然是毒物，我们为民除害吧！", next = 5 },
							{ content = "这蛤蟆看着太吓人了，还是以后再来收拾它吧！"},
						},
					},
					[5] = {
						battle = {
							limitFriendNum = 7,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 5, id = 1411208, level = 300 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 7,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
				
					},
					[7] = {
						talks = {
							{npc = "噗嗤、噗嗤，啪，疙瘩大蛤蟆爆炸了，掉出了一双黄色光晕的靴子。",player = "终于击败它了，还挺强呢。",npcName=""},
							{npc = "快瞧瞧地上掉了啥？",npcName="邵灵儿"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = 111411,
							items = 454511,
						}
					},
				},
			},

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1067] = {
			name = "暗河",
			pos = {-107,-167},
			id = 1067,
			grids = {[2]=1062,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1068] = {
			name = "密道",
			pos = {126,-167},
			id = 1068,
			grids = {[2]=1063,[1]=1070,},
			desc = "幽暗河流的尽头，有一条岩道，岩壁微微的泛绿，不知是苔藓还是水中的脏污侵染。",
		},

		[1069] = {
			name = "暗河",
			pos = {359,-167},
			id = 1069,
			grids = {[2]=1064,},
			desc = "地下之河流，全无半点光线，不知会通向何方，而污水急流的冲刷不断的消耗着水中所有生命的气血。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -200,
					},
					lineMsg = "污水急流的冲刷不断的消耗着水中所有生命的气血。"
				},
			},
		},

		[1070] = {
			name = "密道",
			pos = {126,-63},
			id = 1070,
			grids = {[2]=1068,[1]=1071,},
			desc = "幽暗河流的尽头，有一条岩道，岩壁微微的泛绿，不知是苔藓还是水中的脏污侵染。",
		},

		[1071] = {
			name = "密道",
			pos = {126,41},
			id = 1071,
			grids = {[2]=1070,[3]=1072,},
			desc = "幽暗河流的尽头，有一条岩道，岩壁微微的泛绿，不知是苔藓还是水中的脏污侵染。",
			triggerDesc = "三个绿衣男子从密道中跑出拦住了去路。",

			npcs = {
				{
					npcName = "毒血宗弟子",
					desc = "一身草绿色的短打服饰，双手带着爪状的拳套，亦是冒着绿光，一看便知是使毒的邪教弟子。",
					visibleConditions = {noTags = {111415,111417}},
					[1] = {
						talks = {
							{npc = "来者何人！此地乃是毒血宗领地！",player = "原来就是你们施毒，使的附近水源有毒！",npcName="毒血宗弟子"},
							{npc = "既然被你知道了，便别想走了！抓住他们！",npcName="毒血宗弟子"},
							{npc = "看你们的衣服是毒血宗的吧！已找你们多时了，没想到躲在暗河之中！",npcName="田伯光"},
							{npc = "知道我毒血宗的大名，你们小猫两三只也敢前来送死！",npcName="毒血宗弟子"},
							{npc = "今日便是你毒血宗灭宗之日！各位，小心他们的爪毒！",npcName="田伯光"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1411212, level = 300 },
								{ index = 4, id = 1411212, level = 300 },
								{ index = 7, id = 1411212, level = 300 },

							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 7,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
				
					},
					[7] = {
						talks = {
							{npc = "点子扎手，快跑！",player = "贼人休走！追！",npcName="毒血宗弟子"},
							{npc = "快追！",npcName="邵灵儿"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = 111415,
						}
					},
				},
			},
		},

		[1072] = {
			name = "密道",
			pos = {-107,41},
			id = 1072,
			grids = {[4]=1071,[3]=1073,},
			desc = "幽暗河流的尽头，有一条岩道，岩壁微微的泛绿，不知是苔藓还是水中的脏污侵染。",
		},

		[1073] = {
			name = "绿色岩门",
			pos = {-340,41},
			id = 1073,
			grids = {[4]=1072,[3]=1074,},
			desc = "三丈高的绿色岩门，上面纹着一只黑色的阴森蛇头，蛇身却如蜈蚣一般长着两排细长的虫足。",
			triggerDesc = "一位绿衣老者从门后步走来，每一步踏在地上都有绿色的汁液溅起，露出无比高深的毒门功法。",

			npcs = {
				{
					npcName = "毒血宗老者",
					desc = "绿色长衫及地，双手藏于袖中，并无背负兵器，看不出善何功法，然其身边奇香四溢，必有不凡之处。",
					visibleConditions = {noTags = {111416,111417},tags = 111415},
					[1] = {
						talks = {
							{npc = "黄毛小儿，竟敢来我血毒宗撒野！",npcName="毒血宗老者"},
							{npc = "邪魔外道，休得猖狂！",npcName="田伯光"},
							{npc = "受死吧！",npcName="毒血宗老者"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1411212, level = 300 },
								{ index = 5, id = 1411213, level = 300 },
								{ index = 7, id = 1411212, level = 300 },

							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 7,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
				
					},
					[7] = {
						talks = {
							{npc = "年纪轻轻，武功竟然如此高强！这是你们逼我的！",player = "贼人休走！追！",npcName="毒血宗老者"},
							{npc = "快追，这些毒修，大多有急速提升内力的邪术。",npcName="田伯光"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = 111416,
						}
					},
				},
			},
		},

		[1074] = {
			name = "溶洞",
			pos = {-573,41},
			id = 1074,
			grids = {[4]=1073,[3]=1075,},
			desc = "岩门后是一个巨大的溶洞，其中堆积着各种箱子器具，溶洞深处更有不少生活器具。",
		},

		[1075] = {
			name = "毒池",
			pos = {-806,41},
			id = 1075,
			grids = {[4]=1074,},
			desc = "溶洞后的池塘竟然是绿莹莹的一大片如泥沼般的稠液，此起彼伏的冒着大小不一的气泡，一股呛人的酸臭味越发浓重。",
			triggerDesc = "只见绿衣老人跃入正殿中央浑浊大池子，拿起一块散发着渗人的绿光的石头砸进自己胸口。",

			npcs = {
				{
					npcName = "毒血老怪",
					desc = "绿衣老人浑身开始溃烂，绿色的汁液顺着衣袖跌落地面，然其气势却瞬间拔高至匪夷所思的境地！",
					visibleConditions = {noTags = {111417},tags = {111416}},
					[1] = {
						talks = {
							{npc = "啊啊啊！啊啊啊！",player = "大家小心，快走，他融入毒物命不久矣，我们不必和他硬拼，些许时间他便会反噬而亡。",npcName="毒血宗老者"},
							{npc = "哈哈哈哈，你以为你们还跑的了吗！",npcName="毒血宗老者"},
							{npc = "绿色的毒液已经漫过了门口，必须得立刻阻止他，不然毒液进入暗河，附近的河流便全完了！",npcName="邵灵儿"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 5, id = 1411214, level = 300 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 7,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
				
					},
					[7] = {
						talks = {
							{npc = "这个怪物竟然化为灰烬了！",npcName="田伯光"},
							{npc = "毒液已经停止漫延了，而且开始蒸发消失。",player = "地上掉的是什么？那块绿色的大石头竟然掉下来了，这会不会有毒啊。",npcName="邵灵儿"},
							{npc = "不用担心，此乃碧血精，本身无毒，那老毒物许是用了什么手段，将其用来造就毒物。",npcName="田伯光"},
							{npc = "那边柜子中还有本册子呢！",player = "太虚拳？毒血门不是使毒的吗？怎么会有如此刚猛的拳法秘籍？",npcName="邵灵儿"},
							{npc = "太虚宗是沧州的一个拳法宗门，早些年整个门派前去参加武林盛会中途全部失踪，看来是遭了毒血门的暗算了。",npcName="田伯光"},
							{player = "那咱们就收下了吧，放着也是积灰。"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = 111417,
							items = {{190010,1},{397519,1},{200464,1}}
						}
					},
				},
			},
		},

		[1076] = {
			name = "古怪的圆盘",
			pos = {1058,-583},
			id = 1076,
			grids = {[3]=1059,[4]=1077,},
			desc = "浑浊的暗河中一片清蓝色的水流旋转于此，水流中间是一个微微发着柔和白光的圆盘。",

			enterParts = {
				{
					conditions = { nstr = 100},
					failMsg = "这圆盘居于水中，难以施力，看来得更高的臂力才能打开了。",	
				},
			},
		},

		[1077] = {
			name = "长廊",
			pos = {1291,-583},
			id = 1077,
			grids = {[3]=1076,[4]=1078,},
			desc = "从洞口进入后是一条笔直的长廊，光滑之极，触之廊壁，清凉的舒人心脾，长廊的侧面是一间间森然有序的黑色屋子。",
		},

		[1078] = {
			name = "长廊",
			pos = {1524,-583},
			id = 1078,
			grids = {[3]=1077,[4]=1079,},
			desc = "从洞口进入后是一条笔直的长廊，光滑之极，触之廊壁，清凉的舒人心脾，长廊的侧面是一间间森然有序的黑色屋子。",
		},

		[1079] = {
			name = "长廊",
			pos = {1757,-583},
			id = 1079,
			grids = {[3]=1078,[4]=1080,},
			desc = "从洞口进入后是一条笔直的长廊，光滑之极，触之廊壁，清凉的舒人心脾，长廊的侧面是一间间森然有序的黑色屋子。",
		},

		[1080] = {
			name = "灵光泉",
			pos = {1990,-583},
			id = 1080,
			grids = {[3]=1079,[1]=1083,[2]=1081,},
			desc = "无根的浮萍般，凭空悬着一个清泉之池，无水注入却不断流出青蓝色的华彩之水。",
			triggerDesc = "路过之时，神清气爽，感觉身体充满了力量，一切伤痛都愈合了。",

			enterEvents = {
				{
					conditions = { },
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaMaxHpPercentAll = 100,
					}
				},
			},
		},

		[1081] = {
			name = "长廊",
			pos = {1990,-687},
			id = 1081,
			grids = {[1]=1080,[2]=1082,},
			desc = "从洞口进入后是一条笔直的长廊，光滑之极，触之廊壁，清凉的舒人心脾，长廊的侧面是一间间森然有序的黑色屋子。",
		},

		[1082] = {
			name = "长廊",
			pos = {1990,-791},
			id = 1082,
			grids = {[1]=1081,},
			desc = "从洞口进入后是一条笔直的长廊，光滑之极，触之廊壁，清凉的舒人心脾，长廊的侧面是一间间森然有序的黑色屋子。",
		},

		[1083] = {
			name = "长廊",
			pos = {1990,-479},
			id = 1083,
			grids = {[2]=1080,[1]=1084,},
			desc = "从洞口进入后是一条笔直的长廊，光滑之极，触之廊壁，清凉的舒人心脾，长廊的侧面是一间间森然有序的黑色屋子。",
		},

		[1084] = {
			name = "长廊",
			pos = {1990,-375},
			id = 1084,
			grids = {[2]=1083,[1]=1087,[4]=1085,},
			desc = "从洞口进入后是一条笔直的长廊，光滑之极，触之廊壁，清凉的舒人心脾，长廊的侧面是一间间森然有序的黑色屋子。",
		},
		[1085] = {
			name = "长廊",
			pos = {2223,-375},
			id = 1085,
			grids = {[3]=1084,[4]=1086,[1]=1088,},
			desc = "从洞口进入后是一条笔直的长廊，光滑之极，触之廊壁，清凉的舒人心脾，长廊的侧面是一间间森然有序的黑色屋子。",
		},
		[1086] = {
			name = "长廊",
			pos = {2456,-375},
			id = 1086,
			grids = {[3]=1085,[1]=1089,[2]=1090,},
			desc = "从洞口进入后是一条笔直的长廊，光滑之极，触之廊壁，清凉的舒人心脾，长廊的侧面是一间间森然有序的黑色屋子。",
		},

		[1087] = {
			name = "长廊",
			pos = {1990,-271},
			id = 1087,
			grids = {[2]=1084,[4]=1088,},
			desc = "从洞口进入后是一条笔直的长廊，光滑之极，触之廊壁，清凉的舒人心脾，长廊的侧面是一间间森然有序的黑色屋子。",
		},

		[1088] = {
			name = "房间",
			pos = {2223,-271},
			id = 1088,
			grids = {[3]=1087,[2]=1085,},
			desc = "轩辕氏族的兵器陈列之处，千年过去此屋毫无破旧之感，推开阁门，便是一股肃杀之意，一对漆黑的匕首置于中央。",

			npcs = {
				{
					npcName = "暗匕之影",
					desc = "灰色的一刀光影，双手持着长短两把匕首，漆黑如墨。",
					visibleConditions = {noTags = {111419}},
					[1] = {
						npc = "吾乃灰梦双匕之化身，尔等可三人结队，可愿一试？",
						player = {
							{ content = "我们已做好准备，愿意一试！", next = 5 },
							{ content = "我等还需在商量一下。"},
						},
					},
					[5] = {
						battle = {
							limitFriendNum = 3,	
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 5, id = 1411215, level = 300 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									next = 9,
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 8,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									next = 9,
								},
							},
						},
				
					},
					[8] = {
						res = {
							tags = 111419,
							items = {{190011,1},{461201,1}}
						}
					},
					[9] = {
						talks = {
							{npc = "尔等现在武功低微，练一阵再来吧！"},
							{npc = "如现在还想来试可前往灵光泉回复气血。"},
						},
					},
				},
			},
		},

		[1089] = {
			name = "房间",
			pos = {2456,-271},
			id = 1089,
			grids = {[2]=1086,},
			desc = "轩辕氏族的兵器陈列之处，千年过去此屋毫无破旧之感，推开阁门，便是一股肃杀之意，一柄蓝色的长剑置于中央。",

			npcs = {
				{
					npcName = "神剑之光",
					desc = "蓝色的一道虚影，手持一柄长剑，剑身水波流转，凝儿不散。",
					visibleConditions = {noTags = {111418}},
					[1] = {
						npc = "吾乃原水神剑之化身，尔等可三人结队，可愿一试？",
						player = {
							{ content = "我们已做好准备，愿意一试！", next = 5 },
							{ content = "我等还需在商量一下。"},
						},
					},
					[5] = {
						battle = {
							limitFriendNum = 3,	
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 5, id = 1411216, level = 300 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									next = 9,
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 8,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									next = 9,
								},
							},
						},
				
					},
					[8] = {
						res = {
							tags = 111418,
							items = {{190012,1},{461221,1}}
						}
					},
					[9] = {
						talks = {
							{npc = "尔等现在武功低微，练一阵再来吧！"},
							{npc = "如现在还想来试可前往灵光泉回复气血。"},
						},
					},
				},
			},
		},

		[1090] = {
			name = "长廊",
			pos = {2456,-479},
			id = 1090,
			grids = {[1]=1086,[7]=1091,},
			desc = "从洞口进入后是一条笔直的长廊，光滑之极，触之廊壁，清凉的舒人心脾，长廊的侧面是一间间森然有序的黑色屋子。",
		},

		[1091] = {
			name = "七弦阵",
			pos = {2223,-583},
			id = 1091,
			grids = {[6]=1090,[1]=1092,},
			desc = "极其光洁的地面之上刻画的复杂的纹理，上下各有一圆球型的孔洞，中三处刻印如盾、如剑、如枪，两侧皆有一槽。",

			npcs = {
				{
					npcName = "田伯光",
					desc = "剑眉朗目，鼻直口方，束发轻袍，英气逼人，一看便知是个方正君子。",
					visibleConditions = {noTags = {111420}},
					[1] = {
						conditions = {
							items = {{190007,1},{190008,1},{190009,1},{190010,1},{190011,1},{190012,1},{110033,1}}
						},
						talks = {
							{player = "终于凑齐了宝物！",},
							{npc = "那都放到对应位置试试吧。",npcName="田伯光"},
							{npc = "待全部放入后，萤石立刻碎裂然阵法却已启动，通往轩辕遗址的封印打开了。",npcName=""},
							{player = "成功了！走，我们进去瞧瞧！",lineMsg = "七弦阵散发着恢弘的光辉，光墙慢慢淡化，露出了轩辕遗址的真貌。"},
						},
						next = 4,
					},
					[2] = {
						talks = {
							{npc = "哇。此阵看着极为玄妙啊，可惜已经是死物了，大概被水泡坏了吧。",player = "嗯，看来是如此了，那我们便回吧。",npcName="虎小山"},
							{npc = "等等，此阵乃是七弦阵，我曾在书中见过，所需七物集合方能启动。",player = "是哪七物？看看咱们有没有。",npcName="田伯光"},
							{npc = "以古玉【萤石】为底，激活阵法。",npcName="田伯光"},
							{npc = "以灵元天龟之甲【元甲】、神风雕的翎【风剑】、龙蟒的角【蛟枪】为肩，运转阵法。",npcName="田伯光"},
							{npc = "以【灰梦双匕】和【原水神剑】为臂，发动阵法。",npcName="田伯光"},
							{npc = "以【碧血晶】为目，为阵法指引方向，破开封印。",player = "天呐，都是些没听说过的东西，等收集齐了再来吧。",npcName="田伯光"},
						},
					},
					[4] = {
						res = {
							tags = 111420,
							items = {{190007,-1},{190008,-1},{190009,-1},{190010,-1},{190011,-1},{190012,-1},{110033,-1}}
						}
					},
				},
			},

			
		},

		[1092] = {
			name = "轩辕遗址",
			pos = {2223,-479},
			id = 1092,
			grids = {[2]=1091,},
			desc = "古意盎然的淡雾三开，是一间庄严的房间，中央有一个蒲团，一个青蓝色的人影居于半空，虚幻而又神圣。",

			npcs = {
				{
					npcName = "轩辕后裔",
					desc = "青蓝色的光晕之下是一个身穿绣着红边的白色长袍的极美女子，",
					[1] = {
						conditions = {
							noTags = 111421,
						},
						talks = {
							{npc = "这么多年过去了，竟然还有人能前来。",player = "前辈，难道您一直居住在这里吗？",npcName="轩辕后裔"},
							{npc = "并非真人，这是前辈的剑意化身！",npcName="田伯光"},
							{npc = "闲话不续，剑意已现，不能长存！",npcName="轩辕后裔"},
							{npc = "寻到此处，你便是有缘之人，能打开七弦阵，亦是通过了考验，静心沉气，我授你轩辕氏无上剑诀：七弦无形剑！",player = "成功了！走，我们进去瞧瞧！",npcName="轩辕后裔"},
							{npc = "此后你每次前来只要带来一个萤石，吾便能授你一份七弦无形剑宝典。",npcName="轩辕后裔"},
						},
						next = 4,
					},
					[2] = {
						conditions = {
							items = 110033,
						},
						npc = "你愿意消耗一块萤石，来换取一份七弦无形剑宝典吗？",
						player = {
							{ content = "愿意", next = 5 },
							{ content = "不愿意", },
						},
					},
					[3] = {
						npc = "此后你每次前来只要带来一个萤石，吾便能授你一份七弦无形剑宝典。",
					},
					[4] = {
						res = {
							tags = 111421,
							items = 397329,
						}
					},
					[5] = {
						res = {
							items = {{110033,-1},{397323,1}}
						}
					},
				},
			},
			enterParts = {
				{
					conditions = { tags = 111420,},
					failMsg = "淡青色的光晕柔和而坚毅，挡住了前路，看来必须得解开阵法才能进去了。",	
				},
			},
		},
	}
}

return scene_011401
