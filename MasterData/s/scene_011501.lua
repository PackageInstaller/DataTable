
-- tags
-- 111501:获得居民对话tag
-- 111502:获得居民对话tag
-- 111503:获得居民对话tag

-- 111504:触发格子9，战斗完
-- 111505:触发格子9，战斗完（不会再战斗了）
-- 111506:和尚送完道具了（看不到和尚了）

-- 111507:打完卤味馆（才能触发武馆）
-- 111508:打完卤味馆（不会再打）

-- 111509:触发完武馆（触发银号的前置）
-- 111510:触发完银号（不会再次触发武馆）

-- 111512:药店不会再给金疮药了

-- 111511:格子21去过后，获得

-- 111513:采集到瓜瓜木

-- 111515:打赢虚竹1701022，200
-- 111516:打赢虚竹1701022，300
-- 111517:打赢虚竹
-- 111518:打赢虚竹
-- 111519:打赢虚竹
-- 111520:打赢虚竹
-- 111521:打赢虚竹
-- 111522:打赢虚竹
-- 111523:打赢虚竹
-- 111524:打赢虚竹
-- 111525:打赢虚竹
-- 111526:打赢虚竹
-- 111527:打赢虚竹
-- 111528:打赢虚竹
-- 111529:打赢虚竹

-- 111535:打赢黄蓉
-- 111536:打赢黄蓉
-- 111537:打赢黄蓉
-- 111538:打赢黄蓉
-- 111539:打赢黄蓉
-- 111540:打赢黄蓉
-- 111541:打赢黄蓉
-- 111542:打赢黄蓉
-- 111543:打赢黄蓉
-- 111544:打赢黄蓉
-- 111545:打赢黄蓉
-- 111546:打赢黄蓉
-- 111547:打赢黄蓉
-- 111548:打赢黄蓉
-- 111549:打赢黄蓉


-- 111500:打完格子20，章节结束(要有111506,111510,111511才能触发)



local scene_011501 = {
	name = "序章1",
	id = 11501,
	enter = {11501,1001},

	points = {
		[1001] = {
			name = "南门",
			pos = {-5,31},
			id = 1001,
			grids = {[1]=1002,},
			desc = "岳城的南门朝着官道，故而人来人往、车水马龙，招呼声、吆喝声、欢笑声……人声鼎沸。",
		},

		[1002] = {
			name = "南门",
			pos = {-5,135},
			id = 1002,
			grids = {[2]=1001,[1]=1003,},
			desc = "入了南门便是岳城主街，街面开阔，两旁商户鳞次栉比，招幌、牌匾目不暇接。",
			triggerDesc = "邵灵儿兴奋地眉飞色舞、东张西望。",

			npcs = {
				{
					npcName = "邵灵儿",
					desc = "邵城武馆之女，精通鞭法，衣着素淡如菊，一双眼睛却着实的灵动清亮。",
					[1] = {
						talks = {
							{npc = "哇喔，岳城比邵城热闹多了，这么多人！你看，城门都这么高大，多威武啊！",player = "瞧你这傻样儿！跟紧点，走丢了我可不管哈。"},
							{npc = "[白了一眼]嘁……"},
						},
					},
				},
			},
		},

		[1003] = {
			name = "街道",
			pos = {-5,239},
			id = 1003,
			grids = {[2]=1002,[1]=1004,},
			desc = "入了南门便是岳城主街，街面开阔，两旁商户鳞次栉比，招幌、牌匾目不暇接。",
		},

		[1004] = {
			name = "街道",
			pos = {-5,343},
			id = 1004,
			grids = {[2]=1003,[1]=1005,},
			desc = "入了南门便是岳城主街，街面开阔，两旁商户鳞次栉比，招幌、牌匾目不暇接。",
			triggerDesc = "不少本城居民三三两两地驻足交谈，或说得神色飞扬、或听得屏气凝神，或惊呼或淡定、或欢欣或担忧……",

			npcs = {
				{
					npcName = "岳城居民",
					desc = "正在驻足聊天，兴致勃勃，好似知晓了一些大秘密。",
					[1] = {
						talks = {
							{npc = "听说没？血魂帮被田沐阳剿灭了。",npcName="居民甲"},
							{npc = "知道！这不都在说田家呢么。",npcName="居民乙"},
							{npc = "是啊，田家这娃厉害，单人单骑啊！",npcName="居民丙"},
						},
						next = 2,
					},
					[2] = {
						res = {
							tags = {111501},
						},
					},
				},
			},

			leaveParts = {
				{
					conditions = {tags = 111501},
					failMsg = "诶，居民们在聊什么呢，去听听。",
				},
			},
		},

		[1005] = {
			name = "街道",
			pos = {-5,447},
			id = 1005,
			grids = {[2]=1004,[1]=1006,},
			desc = "入了南门便是岳城主街，街面开阔，两旁商户鳞次栉比，招幌、牌匾目不暇接。",
			triggerDesc = "不少本城居民三三两两地驻足交谈，或说得神色飞扬、或听得屏气凝神，或惊呼或淡定、或欢欣或担忧……",

			npcs = {
				{
					npcName = "岳城居民",
					desc = "正在驻足聊天，兴致勃勃，好似知晓了一些大秘密。",
					[1] = {
						talks = {
							{npc = "这下田老爷子的金盆洗手更风光了，血魂帮帮主的脑袋可是大礼啊。",npcName="居民丁"},
							{npc = "谁说不是呢，还有那妖狼，祸害了多少人呐，这下可好了，和它主子的脑袋一起祭了。",npcName="居民戊"},
							{npc = "是啊，可算能踏踏实实地过日子咯。",npcName="居民丁"},
						},
						next = 2,
					},
					[2] = {
						res = {
							tags = {111502},
						},
					},
				},
			},

			leaveParts = {
				{
					conditions = {tags = 111502},
					failMsg = "诶，居民们在聊什么呢，去听听。",
				},
			},
		},

		[1006] = {
			name = "街道",
			pos = {-5,551},
			id = 1006,
			grids = {[2]=1005,[1]=1007,},
			desc = "入了南门便是岳城主街，街面开阔，两旁商户鳞次栉比，招幌、牌匾目不暇接。",
			triggerDesc = "不少本城居民三三两两地驻足交谈，或说得神色飞扬、或听得屏气凝神，或惊呼或淡定、或欢欣或担忧……",

			npcs = {
				{
					npcName = "岳城居民",
					desc = "正在驻足聊天，兴致勃勃，好似知晓了一些大秘密。",
					[1] = {
						talks = {
							{npc = "听说田家这娃伤得不轻。",npcName="居民甲"},
							{npc = "我也听说了，不过这娃算不得田家的命根子，不然……",npcName="居民庚"},
							{npc = "听说田老爷子偏心得厉害。",npcName="居民辛"},
							{npc = "这大户人家哪，正房偏房、嫡出庶出的，十根手指头还有长短呢！",npcName="居民庚"},
							{npc = "不管怎样，这次为民除害，咱只记得田家便是了。",npcName="居民辛"},
						},
						next = 2,
					},
					[2] = {
						res = {
							tags = {111503},
						},
					},
				},
			},

			leaveParts = {
				{
					conditions = {tags = 111503},
					failMsg = "诶，居民们在聊什么呢，去听听。",
				},
			},
		},

		[1007] = {
			name = "街道",
			pos = {-5,655},
			id = 1007,
			grids = {[2]=1006,[1]=1008,},
			desc = "入了南门便是岳城主街，街面开阔，两旁商户鳞次栉比，招幌、牌匾目不暇接。",
		},

		[1008] = {
			name = "道口",
			pos = {-5,759},
			id = 1008,
			grids = {[2]=1007,[3]=1009,[4]=1011,[1]=1014,},
			desc = "道口居于城中，通往东西南北各方向，故而尤为热闹，行人比肩接踵。",
			triggerDesc = "邵灵儿望着这一派安乐气象，不由得感叹起来。",

			npcs = {
				{
					npcName = "邵灵儿",
					desc = "邵城武馆之女，精通鞭法，衣着素淡如菊，一双眼睛却着实的灵动清亮。",
					[1] = {
						talks = {
							{npc = "看起来田家在岳城很得人心呢！",player = "武学世家嘛，守护一方百姓也是义不容辞的。"},
							{npc = "那田家的武学也是出神入化咯？",player = "应该非同一般，要是有机会切磋一下就好了！"},
							{npc = "[眼睛转得滴溜溜的]嘻嘻……找机会咯！"},
						},
					},
				},
			},
		},

		[1009] = {
			name = "商铺",
			pos = {-238,759},
			id = 1009,
			grids = {[4]=1008,[3]=1010,[1]=1013,},
			desc = "街边店铺林立，酒肆、银号、茶馆、酱园、绸缎铺……家家都客来客往，生意兴隆。",
			triggerDesc = "和尚在店铺门口化缘，衙役跑来驱赶，恶声恶气。",

			npcs = {
				{
					npcName = "衙役",
					desc = "体格魁梧，满脸骄横。",
					visibleConditions = {noTags = {111505}},
					[1] = {
						talks = {
							{npc = "哪来的和尚在这儿要饭，去去去！",npcName="衙役"},
							{npc = "[双手合十、微微垂目]贫僧游方化缘，佛祖佑人平安。",npcName="和尚"},
							{npc = "什么佛祖佛孙的，别来这套，这儿可是岳城！田府威震四方，谁敢来岳城撒野？",npcName="衙役"},
							{npc = "施主，对佛祖不可言语不敬啊。",npcName="和尚"},
							{npc = "还神神叨叨的？看我不呼你一棍！",player = "你这当差的，太过分了，欠揍！",npcName="衙役"},
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
								{ index = 3, id = 1411501, level = 25 },
								{ index = 5, id = 1411501, level = 25 },
								{ index = 9, id = 1411501, level = 25 },

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
						res = {
							tags = {111504,111505}
						},
					},
				},
				{
					npcName = "和尚",
					desc = "身形清瘦，僧袍也有了几分破旧，却面目洁净、神色祥和。",
					visibleConditions = {noTags = {111505}},
					[1] = {
						talks = {
							{npc = "哪来的和尚在这儿要饭，去去去！",npcName="衙役"},
							{npc = "[双手合十、微微垂目]贫僧游方化缘，佛祖佑人平安。",npcName="和尚"},
							{npc = "什么佛祖佛孙的，别来这套，这儿可是岳城！田府威震四方，谁敢来岳城撒野？",npcName="衙役"},
							{npc = "施主，对佛祖不可言语不敬啊。",npcName="和尚"},
							{npc = "还神神叨叨的？看我不呼你一棍！",player = "你这当差的，太过分了，欠揍！",npcName="衙役"},
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
								{ index = 3, id = 1411501, level = 20 },
								{ index = 5, id = 1411501, level = 20 },
								{ index = 9, id = 1411501, level = 20 },

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
						res = {
							tags = {111504,111505},
						},
					},
				},
			},
		},

		[1010] = {
			name = "西门",
			pos = {-471,759},
			id = 1010,
			grids = {[4]=1009,[3]=1022,},
			desc = "西门外是农郊，故而西大街也略显冷清。",
			
			npcs = {
				{
					npcName = "悬赏纸",
					desc = "岳城西门的墙上贴了一长串的悬赏纸，许是希望江湖游侠儿见到了这些贼人能够擒住。",
					[0] = {
						player = {
							{content = "查看", next = 2},
						}
					},
					[2] = {
						player = "【兽形门逆徒】弑师夺宝……善鹤形、蛇形，闪躲腾挪之术冠绝西南一带。",
					},
				},
				{
					npcName = "悬赏纸",
					desc = "县北门的墙上贴了一长串的悬赏纸，许是希望江湖游侠儿见到了这些贼人能够擒住。",
					[0] = {
						player = {
							{content = "查看", next = 2},
						}
					},
					[2] = {
						player = "【蛮夷斥候】十多人入关，被捕七人，还有多人逃脱……欲众人……抓捕归案……",
					},
				}, 
				{
					npcName = "悬赏纸",
					desc = "县北门的墙上贴了一长串的悬赏纸，许是希望江湖游侠儿见到了这些贼人能够擒住。",
					[0] = {
						player = {
							{content = "查看", next = 2},
						}
					},
					[2] = {
						player = "【金钩魔镰】异形兵器……高手……极其残暴，【玄青双蝠】吸食人血……疑似明教青翼蝠王之徒……与树中休息。",
					},
				},
			}
		},

		[1011] = {
			name = "卤味馆",
			pos = {228,759},
			id = 1011,
			grids = {[3]=1008,[4]=1012,[1]=1015,},
			desc = "茴香、陈皮、豆蔻、甘草、山楂、花椒……一阵阵香味把人勾了往东大街去，原来街口新开了一家卤味馆。",
			triggerDesc = "条案上摆了一溜刚出锅的卤鸡、卤鸭、卤猪蹄，油淋淋的，那色香真叫人垂涎欲滴，几个武馆弟子跑来随手抓了好多。",

			npcs = {
				{
					npcName = "武馆弟子",
					desc = "个个体格精壮，耀武扬威。",
					visibleConditions = {noTags = {111508}},
					[1] = {
						talks = {
							{npc = "[急忙上前拦住]哎呦呦，几位爷，若瞧得上小店这一口，小店就包上一些送几位尝尝，可拿这么多……",npcName="卤味馆老板"},
							{npc = "新来的？没规矩！",npcName="武馆弟子"},
							{npc = "[拱手作揖]小的初来乍到，不知道这里的规矩，失礼了。",npcName="卤味馆老板"},
							{npc = "好！那我就告诉你，什么是岳城的规矩，来，给我全部包上！",npcName="武馆弟子"},
							{npc = "[哭丧了脸]各位爷，小店是小本生意啊！",player = "有你们这么欺负人的吗？！",npcName="卤味馆老板"},
							{npc = "管闲事？知道我们是谁么？",player = "不管你们是谁，总要讲道理！",npcName="武馆弟子"},
							{npc = "哈哈哈，讲道理可以，不过我们田氏武馆可不是用嘴巴讲！",npcName="武馆弟子"},
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
								{ index = 1, id = 1411504, level = 30 },
								{ index = 3, id = 1411504, level = 30 },
								{ index = 5, id = 1411504, level = 30 },

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
							{npc = "哎哟，我的手，流血了啊！",player = "再敢欺负人，下次可不会这么轻易就放过你！",npcName="武馆弟子"},
							{npc = "三个汉子跑远后又回头叫嚣。",npcName=""},
							{npc = "你等着，竟敢在岳城和我们田氏武馆的人动手！",npcName="武馆弟子"},
							{npc = "多谢两位{sex:003}，不过武馆势大，两位可要小心了。",player = "不怕他们，欺软怕硬之辈！",npcName="卤味馆老板"},
						},
						next = 7,
					},
					[7] = {
						res = {
							tags = {111507,111508}
						},
					},
				},
				{
					npcName = "卤味馆老板",
					desc = "满面堆笑，躬着背，殷勤地招呼客人。",
					[1] = {
						conditions = {noTags = {111508}},
						talks = {
							{npc = "[急忙上前拦住]哎呦呦，几位爷，若瞧得上小店这一口，小店就包上一些送几位尝尝，可拿这么多……",npcName="卤味馆老板"},
							{npc = "新来的？没规矩！",npcName="武馆弟子"},
							{npc = "[拱手作揖]小的初来乍到，不知道这里的规矩，失礼了",npcName="卤味馆老板"},
							{npc = "好！那我就告诉你，什么是岳城的规矩，来，给我全部包上！",npcName="武馆弟子"},
							{npc = "[哭丧了脸]各位爷，小店是小本生意啊",player = "有你们这么欺负人的吗？！",npcName="卤味馆老板"},
							{npc = "管闲事？知道我们是谁么？",player = "不管你们是谁，总要讲道理！",npcName="武馆弟子"},
							{npc = "哈哈哈，讲道理可以，不过我们田氏武馆可不是用嘴巴讲！",npcName="武馆弟子"},
						},
						next = 5,
					},
					[2] = {
						npc = "刚做的卤鸡、卤鸭、卤猪蹄咯，肥而不腻，唇齿余香！",
					},
					[5] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1411504, level = 30 },
								{ index = 3, id = 1411504, level = 30 },
								{ index = 5, id = 1411504, level = 30 },

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
							{npc = "哎哟，我的手，流血了啊！",player = "再敢欺负人，下次可不会这么轻易就放过你！",npcName="武馆弟子"},
							{npc = "三个汉子跑远后又回头叫嚣。",npcName=""},
							{npc = "你等着，竟敢在岳城和我们田氏武馆的人动手！",npcName="武馆弟子"},
							{npc = "多谢两位{sex:003}，不过武馆势大，两位可要小心了。",player = "不怕他们，欺软怕硬之辈！",npcName="卤味馆老板"},
						},
						next = 7,
					},
					[7] = {
						res = {
							tags = {111507,111508}
						},
					},
				},
			},
		},

		[1012] = {
			name = "田氏武馆",
			pos = {461,759},
			id = 1012,
			grids = {[3]=1011,},
			desc = "田氏武馆占了半条东大街，高大的槐树将阳光细碎地洒在了武馆门前的石板路上，两个狮头铜环在漆黑的大门上显得威风凛凛。",
			triggerDesc = "被武馆的仆人拦下，说管事在偏厅谈事，正想算了转身走人，偏厅传出了说话声，便转眼望去。",

			npcs = {
				{
					npcName = "武馆管事",
					desc = "一脸皮笑肉不笑，看似躬身拢袖的，却眼神倨傲。",
					visibleConditions = {tags = {111507}},
					[1] = {
						talks = {
							{npc = "这位差爷，何事？",npcName="武馆管事"},
							{npc = "呵呵呵，想请管事帮个忙。",npcName="捕快"},
							{npc = "客气！差爷说来听听。",npcName="武馆管事"},
							{npc = "是这么回事哈，东二街的银号前日不是“失窃”了嘛，这报了官，自然是要查的，可在下却不大好查……",npcName="捕快"},
							{npc = "哦？",npcName="武馆管事"},
							{npc = "呵呵呵，这说是“失窃”，其实是……",npcName="捕快"},
							{npc = "银号失窃，差爷查案，这和我们田氏武馆无关啊！",npcName="武馆管事"},
							{npc = "呵呵呵，这银号报官时说……当然咯，也可能认错了人，所以请管事的帮忙查查。",npcName="捕快"},
							{npc = "明日咱田老爷子的典礼，知府大人也要来拜贺的，你觉得这案该怎么查呢？",npcName="武馆管事"},
							{npc = "这……",npcName="捕快"},
							{npc = "依我看，差爷还是请回吧！",npcName="武馆管事"},
							{npc = "[悻悻地告辞]",player = "灵儿，咱们去银号瞧瞧。",npcName="捕快"},
						},
						next = 5,
					},
					[5] = {
						res = {
							tags = {111509},
							removeTags = {111507},
						},
					},
				},
				{
					npcName = "捕快",
					desc = "整个人灰扑扑的，一身捕快服也皱了吧唧，勉强在嘴角拉出几分笑意。",
					visibleConditions = {tags = {111507}},
					[1] = {
						talks = {
							{npc = "这位差爷，何事？",npcName="武馆管事"},
							{npc = "呵呵呵，想请管事帮个忙。",npcName="捕快"},
							{npc = "客气！差爷说来听听。",npcName="武馆管事"},
							{npc = "是这么回事哈，东二街的银号前日不是“失窃”了嘛，这报了官，自然是要查的，可在下却不大好查……",npcName="捕快"},
							{npc = "哦？",npcName="武馆管事"},
							{npc = "呵呵呵，这说是“失窃”，其实是……",npcName="捕快"},
							{npc = "银号失窃，差爷查案，这和我们田氏武馆无关啊！",npcName="武馆管事"},
							{npc = "呵呵呵，这银号报官时说……当然咯，也可能认错了人，所以请管事的帮忙查查。",npcName="捕快"},
							{npc = "明日咱田老爷子的典礼，知府大人也要来拜贺的，你觉得这案该怎么查呢？",npcName="武馆管事"},
							{npc = "这……",npcName="捕快"},
							{npc = "依我看，差爷还是请回吧！",npcName="武馆管事"},
							{npc = "[悻悻地告辞]",player = "灵儿，咱们去银号瞧瞧。",npcName="捕快"},
						},
						next = 5,
					},
					[5] = {
						res = {
							tags = {111509},
							removeTags = {111507},
						},
					},
				},
			},
		},

		[1013] = {
			name = "街道",
			pos = {-238,863},
			id = 1013,
			grids = {[2]=1009,[1]=1017,},
			desc = "街边店铺林立，酒肆、银号、茶馆、酱园、绸缎铺……家家都客来客往，生意兴隆。",
		},

		[1014] = {
			name = "街道",
			pos = {-5,863},
			id = 1014,
			grids = {[1]=1018,[2]=1008,},
			desc = "街边店铺林立，酒肆、银号、茶馆、酱园、绸缎铺……家家都客来客往，生意兴隆。",
		},

		[1015] = {
			name = "街道",
			pos = {228,863},
			id = 1015,
			grids = {[4]=1016,[1]=1019,[2]=1011,},
			desc = "街边店铺林立，酒肆、银号、茶馆、酱园、绸缎铺……家家都客来客往，生意兴隆。",
		},

		[1016] = {
			name = "银号",
			pos = {461,863},
			id = 1016,
			grids = {[3]=1015,},
			desc = "东二街的银号是传了三代的老字号，东家厚道，掌柜实诚，伙计们也和气，一向声誉很好。",
			triggerDesc = "见银号伙计耷拉着脑袋，说得委委屈屈的，心下更是愤愤不平，正巧药铺掌柜的又送药来。",

			npcs = {
				{
					npcName = "银号伙计",
					desc = "一个清爽利落的小伙子，白净的脸上一大片青紫，眼角和嘴角都肿了起来",
					[1] = {
						conditions = {tags = {111509}},
						talks = {
							{npc = "那几个武馆弟子，仗着有些武艺，又仗着武馆是田府开的，平时没少欺负人。",npcName="银号伙计"},
							{npc = "以前都还是酒楼、商铺什么的，没想到前日灌了酒，竟然到银号来闹事了。",npcName="银号伙计"},
							{npc = "……兑完银子又把银票抢回去了……",npcName="银号伙计"},
							{npc = "天底下哪有这种事？我上前说理……瞧把我打得……",npcName="银号伙计"},
							{npc = "哎，多说无益，来换药吧……咱街里街坊的，还是自己个儿相互帮衬吧。",player = "太嚣张了，这银号的事还没了结呢，刚才卤味馆那儿又闹了，田老爷子不教训，我来教训！",npcName="药铺掌柜"},
							{npc = "原来刚刚是{sex:003}出的手啊，真是……咱听了都偷着乐呢！",npcName="药铺掌柜"},
							{npc = "{sex:003}小小年纪，侠肝义胆，老朽佩服得紧，这些行军丹是家传方子熬的，送些给{sex:003}吧！",npcName="药铺掌柜"},
						},
						next = 5,
					},
					[2] = {
						npc = "那几个武馆弟子，仗着有些武艺，又仗着武馆是田府开的，平时没少欺负人。",

					},
					[5] = {
						[1] = {
							conditions = {noTags = {111512}},
							res = {
								tags = {111510,111512},
								removeTags = {111509},
								items = {{110302,2}},
							},
						},
						[2] = {
							res = {
								tags = {111510},
								removeTags = {111509},
							},
						},

					},
				},
				{
					npcName = "药铺掌柜",
					desc = "有了年纪，腰背有些佝偻，脸上也满是皱纹，像药铺里的老山参",
					[1] = {
						conditions = {tags = {111509}},
						talks = {
							{npc = "那几个武馆弟子，仗着有些武艺，又仗着武馆是田府开的，平时没少欺负人。",npcName="银号伙计"},
							{npc = "以前都还是酒楼、商铺什么的，没想到前日灌了酒，竟然到银号来闹事了。",npcName="银号伙计"},
							{npc = "……兑完银子又把银票抢回去了……",npcName="银号伙计"},
							{npc = "天底下哪有这种事？我上前说理……瞧把我打得……",npcName="银号伙计"},
							{npc = "哎，多说无益，来换药吧……咱街里街坊的，还是自己个儿相互帮衬吧。",player = "太嚣张了，这银号的事还没了结呢，刚才卤味馆那儿又闹了，田老爷子不教训，我来教训！",npcName="药铺掌柜"},
							{npc = "原来刚刚是{sex:003}出的手啊，真是……咱听了都偷着乐呢！",npcName="药铺掌柜"},
							{npc = "{sex:003}小小年纪，侠肝义胆，老朽佩服得紧，这些行军是家传方子熬的，送些给{sex:003}吧！",npcName="药铺掌柜"},
						},
						next = 5,
					},
					[2] = {
						npc = "那几个武馆弟子，仗着有些武艺，又仗着武馆是田府开的，平时没少欺负人。",

					},
					[5] = {
						[1] = {
							conditions = {noTags = {111512}},
							res = {
								tags = {111510,111512},
								removeTags = {111509},
								items = {{110302,2}},
							},
						},
						[2] = {
							res = {
								tags = {111510},
								removeTags = {111509},
							},
						},

					},
				},
			},
		},

		[1017] = {
			name = "街道",
			pos = {-238,967},
			id = 1017,
			grids = {[2]=1013,[4]=1018,},
			desc = "街边店铺林立，酒肆、银号、茶馆、酱园、绸缎铺……家家都客来客往，生意兴隆。",
		},

		[1018] = {
			name = "街道",
			pos = {-5,967},
			id = 1018,
			grids = {[3]=1017,[4]=1019,[2]=1014,[1]=1021,},
			desc = "街边店铺林立，酒肆、银号、茶馆、酱园、绸缎铺……家家都客来客往，生意兴隆。",
		},

		[1019] = {
			name = "街道",
			pos = {228,967},
			id = 1019,
			grids = {[3]=1018,[4]=1020,[2]=1015,},
			desc = "街边店铺林立，酒肆、银号、茶馆、酱园、绸缎铺……家家都客来客往，生意兴隆。",
		},

		[1020] = {
			name = "客栈",
			pos = {461,967},
			id = 1020,
			grids = {[3]=1019,},
			desc = "东三街的客栈是岳城最大最好的客栈，老远就能看见高高翘起的四角屋檐，屋檐外呼啦啦的旗幡飘展，屋檐下一长溜灯笼红红火火。",
			triggerDesc = "依了邵灵儿，在这家最大最好的客栈里要了两间上房，打算好好休息一晚，明日观礼。刚上楼，便听见客栈门外马嘶人呵的嘈杂声。",

			npcs = {
				{
					npcName = "田流林",
					desc = "宽腰束带，身量颇高，面相却不善，一双吊睛三角眼透着几分凌厉。",
					visibleConditions = {tags = {111506,111510,111511}},
					[1] = {
						talks = {
							{npc = "掌柜的，明日老爷子大礼，今日这儿的上房我们全包了！",npcName="田府弟子"},
							{npc = "[满脸堆笑]小店借老爷子的光，生意比平时好了许多，上房都满了，赶巧最后两间刚刚也被两位{sex:003}要了。",npcName="客栈掌柜"},
							{npc = "上房满了？那容易，让他们换地方吧。",npcName="田府弟子"},
							{npc = "这可使不得啊！没这规矩啊。",npcName="客栈掌柜"},
							{npc = "规矩？你不知道岳城的规矩？",npcName="田府弟子"},
							{npc = "不用废话了，今日上房不空出来，你就不要在岳城开客栈了!",npcName="田府弟子"},
							{npc = "[目瞪口呆]啊？",player = "呦呵！又一个不讲道理的，难道这就是岳城的规矩？",npcName="客栈掌柜"},
							{npc = "哪来的{sex:014}？没看见田三少爷在此？找揍么？!",npcName="田府弟子"},
							{npc = "[挑衅地撇了撇]嘁……还不知道谁揍谁呢!",npcName="邵灵儿"},
							{npc = "[眼神凌厉起来]敢在岳城撒野？不给你点厉害，你不知道田家！",player = "[不耐烦地挥了挥手]知道知道，哪那么多废话，开打呗，正好让我瞧瞧田家绝学！",npcName="田流林"},
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
								{ index = 1, id = 1411503, level = 30 },
								{ index = 3, id = 1411502, level = 40 },
								{ index = 5, id = 1411503, level = 30 },

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
							{npc = "[眼神怨毒，灰溜溜的跑了。]",npcName="田流林"},
							{player = "田府根本就是金玉其外败絮其中，田府弟子各个嚣张跋扈，明日的金盆洗手不去也罢。"},
							{npc = "哎，消消气，来都来了，明日还是去看看吧！",npcName="邵灵儿"},
							{player = "灵儿说的是，差点被一叶障目了。"},

						},
						next = 7,
					},
					[7] = {
						res = {
							tags = {111500},
							removeTags = {111510,111511},
						},
					},
				},
				{
					npcName = "田府弟子",
					desc = "个个体格精壮，耀武扬威。",
					visibleConditions = {tags = {111506,111510,111511}},
					[1] = {
						talks = {
							{npc = "掌柜的，明日老爷子大礼，今日这儿的上房我们全包了！",npcName="田府弟子"},
							{npc = "[满脸堆笑]小店借老爷子的光，生意比平时好了许多，上房都满了，赶巧最后两间刚刚也被两位{sex:003}要了。",npcName="客栈掌柜"},
							{npc = "上房满了？那容易，让他们换地方吧。",npcName="田府弟子"},
							{npc = "这可使不得啊！没这规矩啊。",npcName="客栈掌柜"},
							{npc = "规矩？你不知道岳城的规矩？",npcName="田府弟子"},
							{npc = "不用废话了，今日上房不空出来，你就不要在岳城开客栈了!",npcName="田府弟子"},
							{npc = "[目瞪口呆]啊？",player = "呦呵！又一个不讲道理的，难道这就是岳城的规矩？",npcName="客栈掌柜"},
							{npc = "哪来的{sex:014}？没看见田三少爷在此？找揍么？!",npcName="田府弟子"},
							{npc = "[挑衅地撇了撇]嘁……还不知道谁揍谁呢!",npcName="邵灵儿"},
							{npc = "[眼神凌厉起来]敢在岳城撒野？不给你点厉害，你不知道田家！",player = "[不耐烦地挥了挥手]知道知道，哪那么多废话，开打呗，正好让我瞧瞧田家绝学。",npcName="田流林"},
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
								{ index = 1, id = 1411503, level = 30 },
								{ index = 3, id = 1411502, level = 40 },
								{ index = 5, id = 1411503, level = 30 },

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
							{npc = "[眼神怨毒，灰溜溜的跑了。]",npcName="田流林"},
							{player = "田府根本就是金玉其外败絮其中，田府弟子各个嚣张跋扈，明日的金盆洗手不去也罢。"},
							{npc = "哎，消消气，来都来了，明日还是去看看吧！",npcName="邵灵儿"},
							{player = "灵儿说的是，差点被一叶障目了。"},

						},
						next = 7,
					},
					[7] = {
						res = {
							tags = {111500},
							removeTags = {111510,111511},
						},
					},
				},
				{
					npcName = "客栈掌柜",
					desc = "看着小二脚不点地地跑进跑出招呼客人，肩上搭着毛巾都没工夫擦一把汗，掌柜乐得合不上嘴",
					[1] = {
						conditions = {tags = {111506,111510,111511}},
						talks = {
							{npc = "掌柜的，明日老爷子大礼，今日这儿的上房我们全包了！",npcName="田府弟子"},
							{npc = "[满脸堆笑]小店借老爷子的光，生意比平时好了许多，上房都满了，赶巧最后两间刚刚也被两位{sex:003}要了。",npcName="客栈掌柜"},
							{npc = "上房满了？那容易，让他们换地方吧。",npcName="田府弟子"},
							{npc = "这可使不得啊！没这规矩啊。",npcName="客栈掌柜"},
							{npc = "规矩？你不知道岳城的规矩？",npcName="田府弟子"},
							{npc = "不用废话了，今日上房不空出来，你就不要在岳城开客栈了!",npcName="田府弟子"},
							{npc = "[目瞪口呆]啊？",player = "呦呵！又一个不讲道理的，难道这就是岳城的规矩？",npcName="客栈掌柜"},
							{npc = "哪来的{sex:014}？没看见田三少爷在此？找揍么？!",npcName="田府弟子"},
							{npc = "[挑衅地撇了撇]嘁……还不知道谁揍谁呢!",npcName="邵灵儿"},
							{npc = "[眼神凌厉起来]敢在岳城撒野？不给你点厉害，你不知道田家！",player = "[不耐烦地挥了挥手]知道知道，哪那么多废话，开打呗，正好让我瞧瞧田家绝学。",npcName="田流林"},
						},
						next = 5,
					},
					[2] = {
						talks = {
							{npc = "客官，来的真巧，今日可是最后两间客房了！",npcName="客栈掌柜"},
							{npc = "成，咱们都要了。",player = "那灵儿，咱们便休息一宿吧，金盆大典明日才开呢。",npcName="邵灵儿"},
							{npc = "还是再逛逛吧，难得来岳城，现在天还早呢。",npcName="邵灵儿"},
						},
					},
					[5] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1411503, level = 30 },
								{ index = 3, id = 1411502, level = 40 },
								{ index = 5, id = 1411503, level = 30 },

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
							{npc = "[眼神怨毒，灰溜溜的跑了。]",npcName="田流林"},
							{npc = "田府根本就是金玉其外败絮其中，田府弟子各个嚣张跋扈，明日的金盆洗手不去也罢。",player = "哎，消消气，来都来了，明日还是去看看吧！",npcName="邵灵儿"},
						},
						next = 7,
					},
					[7] = {
						res = {
							tags = {111500},
							removeTags = {111510,111511},
						},
					},
				},
			},
		},

		[1021] = {
			name = "田府大门",
			pos = {-5,1071},
			id = 1021,
			grids = {[2]=1018,},
			desc = "院落皆是桶瓦泥鳅脊、虎皮白石墙，正门面南背北，蹲着两个大石狮子，三开间的兽头黑漆大门，门头上一块青地大匾，写着斗大的魏碑楷书“田岳堂”， 好不威风气派！",
			triggerDesc = "管家指挥着田府弟子和仆役，为明日申时的金盆洗手大典做最后的准备：擦拭牌匾、兽头，给石狮子扎上红绸绣球。",

			npcs = {
				{
					npcName = "田府管家",
					desc = "矮矮胖胖，一身赭石色团花锦袍，像个土财主，一张圆团脸笑眯眯地包住了鹰隼般的眸子。",
					[1] = {
						talks = {
							{npc = "明天你们都规矩点啊，别像平时那样的不管不顾，没事惹事。",npcName="田府管家"},
							{npc = "哪能呢！都是来拜贺的，咱自然要热情。",npcName="田府弟子"},
							{npc = "那到未必……反正都机灵着点儿，看我眼色行事吧。",npcName="田府管家"},
						},
						next = 5,
					},
					[5] = {
						res = {
							tags = {111511},
						},
					},
				},
				{
					npcName = "田府弟子",
					desc = "个个体格精壮，耀武扬威。",
					[1] = {
						talks = {
							{npc = "明天你们都规矩点啊，别像平时那样的不管不顾，没事惹事。",npcName="田府管家"},
							{npc = "哪能呢！都是来拜贺的，咱自然要热情。",npcName="田府弟子"},
							{npc = "那到未必……反正都机灵着点儿，看我眼色行事吧。",npcName="田府管家"},
						},
						next = 5,
					},
					[5] = {
						res = {
							tags = {111511},
						},
					},
				},
			},
		},
		[1022] = {
			name = "树林",
			pos = {-5,1071},
			id = 1021,
			grids = {[4]=1010,[3]=1024,[2]=1023,[1]=1025,},
			desc = "岳城西边的大树林，郁郁葱葱。",
			triggerDesc = "和尚轻轻地摇了摇头，转身向城外走去。",

			npcs = {
				{
					npcName = "和尚",
					desc = "身形清瘦，僧袍也有了几分破旧，却面目洁净、神色祥和。",
					visibleConditions = {tags = {111504},noTags = {111506},},
					[1] = {
						talks = {
							{player = "大师，请留步。"},
							{npc = "[停住脚步，转身施礼]小施主，有礼了。",player = "大师见谅，一时没忍住，冒失了。",npcName="和尚"},
							{npc = "呵呵呵，小施主侠义心肠，老衲谢过。",npcName="和尚"},
							{npc = "老衲有句话送与小施主：多些历练，耐些性子，来日方能得道啊。",player = "多谢大师教诲，吾当每日三省。",npcName="和尚"},
							{npc = "小施主如此心性，来日成就不可估量！",player = "嘿嘿嘿……对了，这儿有些吃食，请大师收下！",npcName="和尚"},
							{npc = "多谢，老衲以这串佛珠相赠，小施主收好，今后若有机缘，或可帮到一二。",npcName="和尚"},
						},
						next = 5,
					},
					[5] = {
						res = {
							tags = {111506},
							removeTags = {111504},
							items = {{446331,1}}
						},
					},
				},
			},
		},
		[1023] = {
			name = "树林",
			pos = {-5,1071},
			id = 1021,
			grids = {[1]=1022,},
			desc = "岳城西边的大树林，郁郁葱葱。",
			npcs = {
				{
					npcName = "虚寒竹",
					desc = "少林寺内的无名小僧，木讷老实但记忆超群，忠厚善良但功夫平常。",
					visibleConditions = {
						noTags = {111515},
						hasChar = 701020,
					},
					[1] = {
						talks = {
							{npc = "施主，第一次交手，请！",npcName="虚寒竹"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1701022, level = 200 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111515},
							items = {{170102,2}}
						},
					},
				},
				{
					npcName = "虚寒竹",
					desc = "少林寺内的无名小僧，木讷老实但记忆超群，忠厚善良但功夫平常。",
					visibleConditions = {
						noTags = {111516},
						tags = {111515},
					},
					[1] = {
						talks = {
							{npc = "施主，第二次交手，请！",npcName="虚寒竹"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1701022, level = 400 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111516},
							items = {{170102,2}}
						},
					},
				},
				{
					npcName = "虚寒竹",
					desc = "少林寺内的无名小僧，木讷老实但记忆超群，忠厚善良但功夫平常。",
					visibleConditions = {
						noTags = {111517},
						tags = {111516},
					},
					[1] = {
						talks = {
							{npc = "施主，第三次交手，请！",npcName="虚寒竹"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1701023, level = 200 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111517},
							items = {{170102,2}}
						},
					},
				},
				{
					npcName = "虚寒竹",
					desc = "少林寺内的无名小僧，木讷老实但记忆超群，忠厚善良但功夫平常。",
					visibleConditions = {
						noTags = {111518},
						tags = {111517},
					},
					[1] = {
						talks = {
							{npc = "施主，第四次交手，请！",npcName="虚寒竹"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1701023, level = 400 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111518},
							items = {{170102,2}}
						},
					},
				},
				{
					npcName = "虚寒竹",
					desc = "少林寺内的无名小僧，木讷老实但记忆超群，忠厚善良但功夫平常。",
					visibleConditions = {
						noTags = {111519},
						tags = {111518},
					},
					[1] = {
						talks = {
							{npc = "施主，第五次交手，请！",npcName="虚寒竹"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1701024, level = 200 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111519},
							items = {{170102,2}}
						},
					},
				},
				{
					npcName = "虚寒竹",
					desc = "少林寺内的无名小僧，木讷老实但记忆超群，忠厚善良但功夫平常。",
					visibleConditions = {
						noTags = {111520},
						tags = {111519},
					},
					[1] = {
						talks = {
							{npc = "施主，第六次交手，请！",npcName="虚寒竹"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1701024, level = 400 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111520},
							items = {{170102,2}}
						},
					},
				},
				{
					npcName = "虚寒竹",
					desc = "少林寺内的无名小僧，木讷老实但记忆超群，忠厚善良但功夫平常。",
					visibleConditions = {
						noTags = {111521},
						tags = {111520},
					},
					[1] = {
						talks = {
							{npc = "施主，第七次交手，请！",npcName="虚寒竹"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1701025, level = 600 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111521},
							items = {{170102,2}}
						},
					},
				},
				{
					npcName = "虚寒竹",
					desc = "少林寺内的无名小僧，木讷老实但记忆超群，忠厚善良但功夫平常。",
					visibleConditions = {
						noTags = {111522},
						tags = {111521},
					},
					[1] = {
						talks = {
							{npc = "施主，第八次交手，请！",npcName="虚寒竹"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1701025, level = 800 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111522},
							items = {{170102,2}}
						},
					},
				},
				{
					npcName = "虚寒竹",
					desc = "少林寺内的无名小僧，木讷老实但记忆超群，忠厚善良但功夫平常。",
					visibleConditions = {
						noTags = {111523},
						tags = {111522},
					},
					[1] = {
						talks = {
							{npc = "施主，第九次交手，请！",npcName="虚寒竹"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1701026, level = 300 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111523},
							items = {{170102,2}}
						},
					},
				},
				{
					npcName = "虚寒竹",
					desc = "少林寺内的无名小僧，木讷老实但记忆超群，忠厚善良但功夫平常。",
					visibleConditions = {
						noTags = {111524},
						tags = {111523},
					},
					[1] = {
						talks = {
							{npc = "施主，第十次交手，请！",npcName="虚寒竹"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1701026, level = 500 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111524},
							items = {{170102,2}}
						},
					},
				},
				{
					npcName = "虚寒竹",
					desc = "少林寺内的无名小僧，木讷老实但记忆超群，忠厚善良但功夫平常。",
					visibleConditions = {
						noTags = {111525},
						tags = {111524},
					},
					[1] = {
						talks = {
							{npc = "施主，第十一次交手，请！",npcName="虚寒竹"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1701027, level = 300 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111525},
							items = {{170102,2}}
						},
					},
				},
				{
					npcName = "虚寒竹",
					desc = "少林寺内的无名小僧，木讷老实但记忆超群，忠厚善良但功夫平常。",
					visibleConditions = {
						noTags = {111526},
						tags = {111525},
					},
					[1] = {
						talks = {
							{npc = "施主，第十二次交手，请！",npcName="虚寒竹"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1701027, level = 500 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111526},
							items = {{170102,2}}
						},
					},
				},
				{
					npcName = "虚寒竹",
					desc = "少林寺内的无名小僧，木讷老实但记忆超群，忠厚善良但功夫平常。",
					visibleConditions = {
						noTags = {111527},
						tags = {111526},
					},
					[1] = {
						talks = {
							{npc = "施主，第十三次交手，请！",npcName="虚寒竹"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1701028, level = 300 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111527},
							items = {{170102,2}}
						},
					},
				},
				{
					npcName = "虚寒竹",
					desc = "少林寺内的无名小僧，木讷老实但记忆超群，忠厚善良但功夫平常。",
					visibleConditions = {
						noTags = {111528},
						tags = {111527},
					},
					[1] = {
						talks = {
							{npc = "施主，第十四次交手，请！",npcName="虚寒竹"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1701028, level = 500 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111528},
							items = {{170102,2}}
						},
					},
				},
				{
					npcName = "虚寒竹",
					desc = "少林寺内的无名小僧，木讷老实但记忆超群，忠厚善良但功夫平常。",
					visibleConditions = {
						noTags = {111529},
						tags = {111528},
					},
					[1] = {
						talks = {
							{npc = "施主，第十五次交手，请！",npcName="虚寒竹"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1701029, level = 500 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111529},
							items = {{170102,2}}
						},
					},
				},
			},
		},
		[1024] = {
			name = "树林",
			pos = {-5,1071},
			id = 1021,
			grids = {[4]=1022,},
			desc = "岳城西边的大树林，郁郁葱葱。",

			npcs = {
				{
					npcName = "瓜瓜树",
					desc = "好粗好大的一颗树。",
					[1] = {
						conditions = {tags = {111105},noTags = {111513}},
						talks = {
							{player = "这就是瓜瓜树了吧，也没啥不同嘛，为啥名字这么古怪，我砍一段下来瞧瞧。"},
							{npc = "咱们折一截树枝便好了吧。",npcName="邵灵儿"},
							{player = "树枝太细也许看不出什么，还是砍一颗吧。"},
							{npc = "呱！",npcName=""},
							{npc = "你有听到声音吗？",npcName="邵灵儿"},
							{player = "没啊，我正砍树呢！"},
							{npc = "呱！呱！",npcName=""},
							{npc = "真有声音，你停一下，仔细听！",npcName="邵灵儿"},
							{npc = "呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！呱！",npcName=""},
							{player = "哇，什么东西。"},
							{npc = "看天上，小心！",npcName="邵灵儿"},
							{npc = "大群黑鸟俯冲而下！",npcName=""},
						},
						next = 5
					},
					[2] = {
						talks = {
							{player = "哇，好大一颗树啊！"},
							{npc = "呱呱呱。。",npcName=""},
							{player = "好像有什么声音呢。"},
						},
					},
					[5] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 2, id = 1411505, level = 100 },
								{ index = 3, id = 1411505, level = 100 },
								{ index = 4, id = 1411505, level = 100 },
								{ index = 5, id = 1411505, level = 100 },
								{ index = 6, id = 1411505, level = 100 },
								{ index = 8, id = 1411505, level = 100 },
								{ index = 9, id = 1411505, level = 100 },

							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									next = 8,
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									next = 8,
								},
							},
						},
					},
					[6] = {
						talks = {
							{player = "终于打跑了，怪不得这叫瓜瓜树，原来树上住着这么多呱呱叫的鸟儿。",},
						},
						next = 7,
					},
					[7] = {
						res = {
							tags = {111513},
							items = {{190006,1}}
						},
					},
					[8] = {
						talks = {
							{player = "哇，这群鸟太厉害了，我们快跑吧！",},
						},
					},

				},
			},
		},
		[1025] = {
			name = "树林",
			pos = {-5,1071},
			id = 1021,
			grids = {[2]=1022,},
			desc = "岳城西边的大树林，郁郁葱葱。",

			npcs = {
				{
					npcName = "黄珑",
					desc = "桃花岛主之女，集天地灵气于一身，艳绝天下、冰雪聪明、博古通今。",
					visibleConditions = {
						noTags = {111535},
						hasChar = 707010,
					},
					[1] = {
						talks = {
							{npc = "{sex:003}，第一次交手，请！",npcName="黄珑"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1707012, level = 300 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111535},
							items = {{170701,2}}
						},
					},
				},
				{
					npcName = "黄珑",
					desc = "桃花岛主之女，集天地灵气于一身，艳绝天下、冰雪聪明、博古通今。",
					visibleConditions = {
						noTags = {111536},
						tags = 111535,
					},
					[1] = {
						talks = {
							{npc = "{sex:003}，第二次交手，请！",npcName="黄珑"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1707012, level = 500 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111536},
							items = {{170701,2}}
						},
					},
				},
				{
					npcName = "黄珑",
					desc = "桃花岛主之女，集天地灵气于一身，艳绝天下、冰雪聪明、博古通今。",
					visibleConditions = {
						noTags = {111537},
						tags = 111536,
					},
					[1] = {
						talks = {
							{npc = "{sex:003}，第三次交手，请！",npcName="黄珑"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1707013, level = 300 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111537},
							items = {{170701,2}}
						},
					},
				},
				{
					npcName = "黄珑",
					desc = "桃花岛主之女，集天地灵气于一身，艳绝天下、冰雪聪明、博古通今。",
					visibleConditions = {
						noTags = {111538},
						tags = 111537,
					},
					[1] = {
						talks = {
							{npc = "{sex:003}，第四次交手，请！",npcName="黄珑"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1707013, level = 500 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111538},
							items = {{170701,2}}
						},
					},
				},
				{
					npcName = "黄珑",
					desc = "桃花岛主之女，集天地灵气于一身，艳绝天下、冰雪聪明、博古通今。",
					visibleConditions = {
						noTags = {111539},
						tags = 111538,
					},
					[1] = {
						talks = {
							{npc = "{sex:003}，第五次交手，请！",npcName="黄珑"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1707014, level = 300 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111539},
							items = {{170701,2}}
						},
					},
				},
				{
					npcName = "黄珑",
					desc = "桃花岛主之女，集天地灵气于一身，艳绝天下、冰雪聪明、博古通今。",
					visibleConditions = {
						noTags = {111540},
						tags = 111539,
					},
					[1] = {
						talks = {
							{npc = "{sex:003}，第六次交手，请！",npcName="黄珑"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1707014, level = 500 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111540},
							items = {{170701,2}}
						},
					},
				},
				{
					npcName = "黄珑",
					desc = "桃花岛主之女，集天地灵气于一身，艳绝天下、冰雪聪明、博古通今。",
					visibleConditions = {
						noTags = {111541},
						tags = 111540,
					},
					[1] = {
						talks = {
							{npc = "{sex:003}，第七次交手，请！",npcName="黄珑"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1707015, level = 700 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111541},
							items = {{170701,2}}
						},
					},
				},
				{
					npcName = "黄珑",
					desc = "桃花岛主之女，集天地灵气于一身，艳绝天下、冰雪聪明、博古通今。",
					visibleConditions = {
						noTags = {111542},
						tags = 111541,
					},
					[1] = {
						talks = {
							{npc = "{sex:003}，第八次交手，请！",npcName="黄珑"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1707015, level = 900 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111542},
							items = {{170701,2}}
						},
					},
				},
				{
					npcName = "黄珑",
					desc = "桃花岛主之女，集天地灵气于一身，艳绝天下、冰雪聪明、博古通今。",
					visibleConditions = {
						noTags = {111543},
						tags = 111542,
					},
					[1] = {
						talks = {
							{npc = "{sex:003}，第九次交手，请！",npcName="黄珑"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1707016, level = 400 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111543},
							items = {{170701,2}}
						},
					},
				},
				{
					npcName = "黄珑",
					desc = "桃花岛主之女，集天地灵气于一身，艳绝天下、冰雪聪明、博古通今。",
					visibleConditions = {
						noTags = {111544},
						tags = 111543,
					},
					[1] = {
						talks = {
							{npc = "{sex:003}，第十次交手，请！",npcName="黄珑"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1707016, level = 600 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111544},
							items = {{170701,2}}
						},
					},
				},
				{
					npcName = "黄珑",
					desc = "桃花岛主之女，集天地灵气于一身，艳绝天下、冰雪聪明、博古通今。",
					visibleConditions = {
						noTags = {111545},
						tags = 111544,
					},
					[1] = {
						talks = {
							{npc = "{sex:003}，第十一次交手，请！",npcName="黄珑"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1707017, level = 400 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111545},
							items = {{170701,2}}
						},
					},
				},
				{
					npcName = "黄珑",
					desc = "桃花岛主之女，集天地灵气于一身，艳绝天下、冰雪聪明、博古通今。",
					visibleConditions = {
						noTags = {111546},
						tags = 111545,
					},
					[1] = {
						talks = {
							{npc = "{sex:003}，第十二次交手，请！",npcName="黄珑"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1707017, level = 600 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111546},
							items = {{170701,2}}
						},
					},
				},
				{
					npcName = "黄珑",
					desc = "桃花岛主之女，集天地灵气于一身，艳绝天下、冰雪聪明、博古通今。",
					visibleConditions = {
						noTags = {111547},
						tags = 111546,
					},
					[1] = {
						talks = {
							{npc = "{sex:003}，第十三次交手，请！",npcName="黄珑"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1707018, level = 400 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111547},
							items = {{170701,2}}
						},
					},
				},
				{
					npcName = "黄珑",
					desc = "桃花岛主之女，集天地灵气于一身，艳绝天下、冰雪聪明、博古通今。",
					visibleConditions = {
						noTags = {111548},
						tags = 111547,
					},
					[1] = {
						talks = {
							{npc = "{sex:003}，第十四次交手，请！",npcName="黄珑"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1707018, level = 600 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111548},
							items = {{170701,2}}
						},
					},
				},
				{
					npcName = "黄珑",
					desc = "桃花岛主之女，集天地灵气于一身，艳绝天下、冰雪聪明、博古通今。",
					visibleConditions = {
						noTags = {111549},
						tags = 111548,
					},
					[1] = {
						talks = {
							{npc = "{sex:003}，第十五次交手，请！",npcName="黄珑"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1707019, level = 600 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {111549},
							items = {{170701,2}}
						},
					},
				},
			},
		},
	}
}

return scene_011501
