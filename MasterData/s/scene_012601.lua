-- tags

-- 112601:格子3获得
-- 112602:格子3获得（不会再触发）

-- 112603:格子15获得（获得后，删除112601）
-- 112604:打格子21获得（获得后，删除112603）

-- 112600:章节结束

-- 112610-112615:敌人

-- 112616:获得虎小山





local scene_012601 = {
	name = "序章1",
	id = 12601,
	enter = {12601,1001},

	points = {
		[1001] = {
			name = "城主府",
			pos = {109,-163},
			id = 1001,
			grids = {[1]=1003,},
			desc = "城主府位于永安城城西，一大片宅院鳞次栉比，占地极广，但一眼望去白墙黑瓦肃穆大气，府门外除了一块城主府的牌匾并无他物。",
			triggerDesc = "刚过申时，拜访者络绎不绝，想来都是邀请参加宴会的武林人士。",

			npcs = {
				{
					npcName = "侍者",
					desc = "侧立于府门边，殷勤地迎候着来客，嘴角往上翘起，像是努力挤出笑容，看着令人不适。",
					visibleConditions = {noTags = {112700}},
					[1] = {
						talks = {
							{npc = "榜首到了，快请，城主在宴客厅等候各位。",player = "辛苦了。"},
						},
					},
				},
				{
					npcName = "虎小山",
					desc = "身体高大却长了张娃娃脸，两只圆铃般的大眼睛，瞧着有些憨憨的。",
					visibleConditions = {noTags = {112616},tags = {112700}},
					[1] = {
						talks = {
							{npc = "此次经历真是丰富，可惜我没到见那唐家堡的女子。",player = "哈哈，机会有的是，以后我们共闯江湖！小山，你可愿一起？",npcName = "虎小山"},
							{npc = "真的吗，那可太好了！",player = "那咱们便一起出发吧！",npcName = "虎小山"},
							{npc = "可我得回去请示师父啊。",npcName = "虎小山"},
							{npc = "师弟，师父知道你性子野，特地关照过如果有人挡住七伤拳，便允了你随他去游历江湖！{sex:003}，你可愿接我的七伤拳？",npcName = "崆峒弟子"},
							{player = "好，擂台上可惜没见识到，非常遗憾，能见识崆峒派的镇派绝学，非常荣幸！"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,	
							friends = { 
								-- conditions
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412603, level = 200 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									next = 7,
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									next = 7,
								},
							},
						},
					},
					[6] = {
						talks = {
							{npc = "{sex:003}武功高强，在下佩服。",player = "哈哈，崆峒派绝学果然名不虚传！",npcName = "崆峒弟子"},
							{npc = "如此我便能和师傅交代了，小山，外出游历可得多加小心呐。",npcName = "崆峒弟子"},
							{npc = "师兄放心！我会时常回来看你们的！",npcName = "虎小山"},
						},
						next = 8,
					},
					[7] = {
						talks = {
							{npc = "{sex:003}承让。",player = "崆峒派绝学果然名不虚传！受教了！",npcName = "崆峒弟子"},
							{npc = "小山你看，这你还是安心随我回去吧。",player = "且慢，我经历连翻大战并未休息好，过几日再来领教七伤拳的威力！",npcName = "崆峒弟子"},
							{npc = "唉，那你一定记得再来找我啊！",npcName = "虎小山"},
						},
					},
					[8] = {
						res = {
							tags = {112616,112600},
							getChar = {710010},
						}
					},
				},
				{
					npcName = "周宛亦",
					desc = "约莫十七八岁，淡、雅、清、秀、灵、仙，绝美如芙蓉出世、天人下凡。",
					visibleConditions = {
						noTags = {113400},
						tags = {112700},
					},
					[1] = {
						talks = {
							{npc = "周姐姐，可愿与我等一同游历这江湖？",npcName = "邵灵儿"},
							{npc = "我自是愿意，可此番两位师妹殒命，我须得先回山面见师傅才行",player = "唉，好吧，那江湖路远，我等必有重逢之日！",npcName = "周宛亦"},
							{npc = "傻子，你们可以来峨眉找我呀，若是师傅不许我下山，你可还得帮我说服师傅才行。",player = "收到！保证完成任务！",npcName = "周宛亦"},
						},
					},
				},

			},
		},

		[1002] = {
			name = "侍者居所",
			pos = {-124,-59},
			id = 1002,
			grids = {[4]=1003,},
			desc = "两间平屋相连而建，内里空间极大，却仅有十来个小床，空空荡荡的。",
			triggerDesc = "此刻房内空无一人，床铺收拾得非常整洁。",
		},

		[1003] = {
			name = "拱桥",
			pos = {109,-59},
			id = 1003,
			grids = {[2]=1001,[3]=1002,[6]=1008,[1]=1007,},
			desc = "入府便见一池清水碧叶，中间白石拱桥，清爽大气，过了桥便是进入了内府。",
			triggerDesc = "一个瘦削的老人站在拱桥之上，像是在等人，表情淡定，眼神却冷冽刺人。",

			npcs = {
				{
					npcName = "老者",
					desc = "侧立于府门边，殷勤地迎候着来客，嘴角往上翘起，像是努力挤出笑容，看着令人不适。",
					[1] = {
						conditions = {noTags = {112602}},
						talks = {
							{npc = "[笑眯眯地迎上来，上下打量]：真是后生可畏啊！",player = "老人家好！"},
							{npc = "{sex:003}小小年纪，武学造诣不凡，老夫佩服！",player = "老人家过奖了，大家只为交流，未尽全力，我们则莽撞了些，获胜实属侥幸。"},
							{npc = "{sex:003}谦虚了，嘿嘿，也许我们有机会共事也说不定呢。",player = "嗯？老人家何出此言？"},
							{npc = "哈哈，老糊涂了，{sex:003}莫要在意，庆功宴已经开始了，{sex:003}快去吧！"},
						},
						next = 3,
					},
					[3] = {
						res = {
							tags = {112601,112602}
						}
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112602}},
					failMsg = "一名老者站在了拱桥中央。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
			enterParts = {
				{
					conditions = {noTags = {112603}},
					failMsg = "一群星宿派弟子堵住了出府的通路。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},

			},
		},

		[1004] = {
			name = "长廊",
			pos = {342,-59},
			id = 1004,
			grids = {[4]=1005,[6]=1009,},
			desc = "府中各院落有回廊相连，木栏杆、泥瓦檐、青石铺地，虽看着幽静朴素，实则格局很大。",
		},

		[1005] = {
			name = "长廊",
			pos = {575,-59},
			id = 1005,
			grids = {[3]=1004,},
			desc = "府中各院落有回廊相连，木栏杆、泥瓦檐、青石铺地，虽看着幽静朴素，实则格局很大。",
			triggerDesc = "一位穿着侍女衣服的女子，身形纤细婀娜，静静的倚在长廊柱子旁。",

			npcs = {
				{
					npcName = "侍女",
					desc = "虽带着面纱，一双眼睛却明媚灵动，整个人风姿绰约。",
					[1] = {
						talks = {
							{npc = "{sex:003}请到宴会厅，城主大人已备好宴席静候各位了"},
						},
					},
				},
			},
		},

		[1006] = {
			name = "侍者居所",
			pos = {-124,45},
			id = 1006,
			grids = {[4]=1007,},
			desc = "两间平屋相连而建，内里空间极大，却仅有十来个小床，空空荡荡的。",
			triggerDesc = "此刻房内空无一人，床铺收拾得非常整洁。",
		},

		[1007] = {
			name = "长廊",
			pos = {109,45},
			id = 1007,
			grids = {[3]=1006,[4]=1008,[1]=1011,[5]=1010,[2]=1003,},
			desc = "府中各院落有回廊相连，木栏杆、泥瓦檐、青石铺地，虽看着幽静朴素，实则格局很大。",
		},

		[1008] = {
			name = "长廊",
			pos = {342,45},
			id = 1008,
			grids = {[3]=1007,[4]=1009,[7]=1003,},
			desc = "府中各院落有回廊相连，木栏杆、泥瓦檐、青石铺地，虽看着幽静朴素，实则格局很大。",
			triggerDesc = "一位穿着侍女衣服的女子，身形纤细婀娜，静静的倚在长廊柱子旁。",

			npcs = {
				{
					npcName = "侍女",
					desc = "虽带着面纱，一双眼睛却明媚灵动，整个人风姿绰约。",
					[1] = {
						talks = {
							{npc = "{sex:003}请到宴会厅，城主大人已备好宴席静候各位了"},
						},
					},
				},
			},
		},

		[1009] = {
			name = "长廊",
			pos = {575,45},
			id = 1009,
			grids = {[3]=1008,[7]=1004,},
			desc = "府中各院落有回廊相连，木栏杆、泥瓦檐、青石铺地，虽看着幽静朴素，实则格局很大。",
		},

		[1010] = {
			name = "花园",
			pos = {-124,149},
			id = 1010,
			grids = {[8]=1007,},
			desc = "竹影参差，苔痕浓淡，水光潋滟……花园看起来很美。",
			triggerDesc = "可这看起来很美的花园，却透着古怪……因为感觉不到一丝生气。",
		},

		[1011] = {
			name = "长廊",
			pos = {109,149},
			id = 1011,
			grids = {[2]=1007,[1]=1015},
			desc = "府中各院落有回廊相连，木栏杆、泥瓦檐、青石铺地，虽看着幽静朴素，实则格局很大。",
		},

		[1012] = {
			name = "长廊",
			pos = {342,149},
			id = 1012,
			grids = {[4]=1013,[6]=1017,[1]=1016,},
			desc = "府中各院落有回廊相连，木栏杆、泥瓦檐、青石铺地，虽看着幽静朴素，实则格局很大。",
			triggerDesc = "转过一道回廊，突然被几名星宿派弟子挡住了去路。",
			npcs = {
				{
					npcName = "星宿派弟子",
					desc = "黑冠黑衣，脸色暗沉，眼神冷冽，却嘴角上翘，堆出笑意，说不出来的怪诞。",
					visibleConditions = {noTags = {112610}},
					[1] = {
						npc = "嘿，哪里跑！",
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,	
							friends = { 
								-- conditions
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 4, id = 1412602, level = 60 },
								{ index = 5, id = 1412602, level = 55 },
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
							tags = {112610},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112610}},
					failMsg = "遭了，被拦住了。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1013] = {
			name = "暗室",
			pos = {575,149},
			id = 1013,
			grids = {[3]=1012,},
			desc = "房间很昏暗，空荡荡的，墙角处还结了蛛丝，灰尘在透进小窗的微弱光线里飞飞扬扬。",
			triggerDesc = "突然四名蒙面杀手，握着泛着青光的利剑，围了上来。",
			npcs = {
				{
					npcName = "持剑杀手",
					desc = "动作僵硬迅捷，却又无声无息，如傀儡一般地游移。",
					visibleConditions = {noTags = {112611}},
					[1] = {
						npc = "杀！",
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,	
							friends = { 
								-- conditions
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412601, level = 20 },
								{ index = 7, id = 1412601, level = 20 },
								{ index = 5, id = 1412601, level = 20 },
								{ index = 6, id = 1412601, level = 20 },
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
							tags = {112611},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112611}},
					failMsg = "又是死路，还被杀手堵住了！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1014] = {
			name = "暗室",
			pos = {-124,253},
			id = 1014,
			grids = {[4]=1015,},
			desc = "房间很昏暗，空荡荡的，墙角处还结了蛛丝，灰尘在透进小窗的微弱光线里飞飞扬扬。",
			triggerDesc = "突然四名蒙面杀手，握着泛着青光的利剑，围了上来。",
			npcs = {
				{
					npcName = "持剑杀手",
					desc = "动作僵硬迅捷，却又无声无息，如傀儡一般地游移。",
					visibleConditions = {noTags = {112612}},
					[1] = {
						npc = "杀！",
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,	
							friends = { 
								-- conditions
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412601, level = 20 },
								{ index = 7, id = 1412601, level = 20 },
								{ index = 5, id = 1412601, level = 20 },
								{ index = 6, id = 1412601, level = 20 },
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
							tags = {112612},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112612}},
					failMsg = "又是死路，还被杀手堵住了！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1015] = {
			name = "宴客厅",
			pos = {109,253},
			id = 1015,
			grids = {[3]=1014,[4]=1016,[1]=1019,[2]=1011},
			desc = "宴客大厅十分宽敞，除了待客的桌椅器物，并没有华丽繁缛之物，除了靠墙的一架四叠落地屏。",
			triggerDesc = "此刻，城主刘世杰并未于上首就座，而是在赴宴者之间到处寒暄。",

			npcs = {
				{
					npcName = "刘世杰",
					desc = "永安城城主，受百姓爱戴，江湖上也声名远播，威不外露，气息绵长，一看便知有深厚的内家功力、",
					visibleConditions = {tags = {112601}},
					[1] = {
						talks = {
							{npc = "[抱拳四顾]：各位，承蒙各位看得起刘某，远道赶来参加英雄擂。",npcName = "刘世杰"},
							{npc = "各位都是后起之秀，武林未来的中流砥柱，这次英雄擂只为切磋技艺互相提高，并非争个高下输赢。",npcName = "刘世杰"},
							{npc = "所以，现在请各位举杯，祝贺这次英雄擂的圆满过程。",npcName = "刘世杰"},
							{npc = "同时，共饮此酒，也是希望大家能同心同德，同为武林出力，守护地方百姓。",npcName = "刘世杰"},
							{npc = "刘城主义薄云天，为民着想，与城主共饮此杯，老道幸哉！",npcName = "乌鸦道人"},
							{npc = "哈哈，谢谢刘城主款待，这酒闻着真香！",npcName = "虎小山"},
							{npc = "久闻刘城主一手浩然掌法大气磅礴，青书在此也敬刘城主一杯！",npcName = "宋清书"},
							{npc = "一时间，觥筹交错，宾主同乐，只有峨眉周宛亦举了举手中的酒杯，然后轻轻放下。",npcName = ""},
							{npc = "峨眉门规不许饮酒，望刘城主见谅。",npcName = "周宛亦"},
							{npc = "如此盛会，周女侠不能破例一次吗？",npcName = "刘世杰"},
							{npc = "实在抱歉，掌门有令，弟子不敢违背。",npcName = "周宛亦"},
							{npc = "哦。。那可真遗憾……动手！",npcName = "刘世杰"},
							{npc = "啊！（只见两截利刃从两个峨眉弟子胸口穿出）",npcName = "峨眉弟子"},
							{npc = "噌一声，周宛亦反身拔剑挡住身后侍者刺来的匕首。",npcName = "周宛亦"},
							{npc = "刘城主，这是干什么！呃，酒里有毒。。（突然跪倒在地，抽搐起来）",npcName = "宋清书"},
							{npc = "[从落地屏后走了出来]：各位已中了噬心蛊，切勿运功了哦，不然，嘿嘿，看看这个武当姓宋的小子。",
							player = "田兄、灵儿，你们怎么样（还好我昨日中了星宿派的毒，喉咙如烈火灼烧，无法饮酒）",npcName = "星宿派莫阴"},
							{npc = "不行，已无法运功。",npcName = "田伯光"},
							{npc = "你快跑，很多门派的前辈还在城中，快去找他们！",npcName = "邵灵儿"},
							{npc = "想走！拦住他们！",player = "周姑娘，就咱俩了，分头突围！<color=#ff0000>田兄、灵儿，我必会寻人前来救你们！</color>",npcName = "星宿派莫阴"},
						},
						next = 3,
					},
					[3] = {
						res = {
							tags = {112603},
							removeTags = {112601},
						}
					},
				},
				{
					npcName = "宋清书",
					desc = "好一个人物儿，俊美之中透着轩昂气度，端如玉树临风，令人一见心折。",
					visibleConditions = {noTags = {112603}},
					[1] = {
						talks = {
							{npc = "哼。",npcName = "宋清书"},
							{npc = "这人脑子不好，咱们别理他。",player = "哈哈，灵儿说的对。",npcName = "邵灵儿"},
						},
					},
				},
				{
					npcName = "乌鸦道人",
					desc = "脚踏白色布鞋，左手浮尘置于右臂之上，脸色发黑，眼白也是灰暗的，怪不得人称“乌鸦道人”。",
					visibleConditions = {noTags = {112603}},
					[1] = {
						talks = {
							{npc = "恭喜{sex:003}夺冠啊！",player = "道长莫要说笑了，我等几斤几两，道长最清楚不过，皆是运气使然。",npcName = "乌鸦道人"},
							{npc = "年纪轻轻却能如此沉稳，将来必非池中之物。",npcName = "乌鸦道人"},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112603}},
					failMsg = "大家已经全部落座。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1016] = {
			name = "长廊",
			pos = {342,253},
			id = 1016,
			grids = {[3]=1015,[2]=1012,},
			desc = "府中各院落有回廊相连，木栏杆、泥瓦檐、青石铺地，虽看着幽静朴素，实则格局很大。",
		},

		[1017] = {
			name = "长廊",
			pos = {575,253},
			id = 1017,
			grids = {[1]=1021,[7]=1012,},
			desc = "府中各院落有回廊相连，木栏杆、泥瓦檐、青石铺地，虽看着幽静朴素，实则格局很大。",
			triggerDesc = "转过一道回廊，突然被几名星宿派弟子挡住了去路。",
			npcs = {
				{
					npcName = "星宿派弟子",
					desc = "黑冠黑衣，脸色暗沉，眼神冷冽，却嘴角上翘，堆出笑意，说不出来的怪诞。",
					visibleConditions = {noTags = {112613}},
					[1] = {
						npc = "嘿，哪里跑！",
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,	
							friends = { 
								-- conditions
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412602, level = 60 },
								{ index = 5, id = 1412602, level = 55 },
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
							tags = {112613},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112613}},
					failMsg = "又是死路，还被杀手堵住了！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1018] = {
			name = "暗室",
			pos = {-124,357},
			id = 1018,
			grids = {[4]=1019,},
			desc = "房间很昏暗，空荡荡的，墙角处还结了蛛丝，灰尘在透进小窗的微弱光线里飞飞扬扬。",
			triggerDesc = "突然四名蒙面杀手，握着泛着青光的利剑，围了上来。",
			npcs = {
				{
					npcName = "持剑杀手",
					desc = "动作僵硬迅捷，却又无声无息，如傀儡一般地游移。",
					visibleConditions = {noTags = {112614}},
					[1] = {
						npc = "杀！",
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,	
							friends = { 
								-- conditions
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412601, level = 20 },
								{ index = 7, id = 1412601, level = 20 },
								{ index = 5, id = 1412601, level = 20 },
								{ index = 6, id = 1412601, level = 20 },
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
							tags = {112614},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112614}},
					failMsg = "又是死路，还被杀手堵住了！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1019] = {
			name = "长廊",
			pos = {109,357},
			id = 1019,
			grids = {[3]=1018,[4]=1020,[2]=1015,},
			desc = "府中各院落有回廊相连，木栏杆、泥瓦檐、青石铺地，虽看着幽静朴素，实则格局很大。",
		},

		[1020] = {
			name = "暗室",
			pos = {342,357},
			id = 1020,
			grids = {[3]=1019,},
			desc = "房间很昏暗，空荡荡的，墙角处还结了蛛丝，灰尘在透进小窗的微弱光线里飞飞扬扬。",
			triggerDesc = "突然四名蒙面杀手，握着泛着青光的利剑，围了上来。",
			npcs = {
				{
					npcName = "持剑杀手",
					desc = "动作僵硬迅捷，却又无声无息，如傀儡一般地游移。",
					visibleConditions = {noTags = {112615}},
					[1] = {
						npc = "杀！",
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,	
							friends = { 
								-- conditions
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412601, level = 20 },
								{ index = 7, id = 1412601, level = 20 },
								{ index = 5, id = 1412601, level = 20 },
								{ index = 6, id = 1412601, level = 20 },
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
							tags = {112615},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112615}},
					failMsg = "又是死路，还被杀手堵住了！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1021] = {
			name = "库房",
			pos = {575,357},
			id = 1021,
			grids = {[2]=1017,},
			desc = "一间巨石建造的房屋挡住了去路，厚重的铁门挂着一把巨型铁锁，沉得纹丝不动。",
			triggerDesc = "前无去路，后有追兵，两人分头冲杀，却都被堵在此处。两人的影子伴着主人，忽短忽长，显出了几分紧张与不安。",
			npcs = {
				{
					npcName = "周宛亦",
					desc = "约莫十七八岁，淡、雅、清、秀、灵、仙，绝美如芙蓉出世、天人下凡。",
					visibleConditions = {tags = {112603}},
					[1] = {
						talks = {
							{npc = "你也没找到出路吗？",player = "出府的路被星宿派众多弟子围住，强行突围肯定不行了。",npcName = "周宛亦"},
							{npc = "你护我身后，我试试以峨眉九阳功催动绝剑破开这铁锁！",player = "周姑娘放心，你的背后有我！",npcName = "周宛亦"},
							{npc = "在这里，抓住他们！",npcName = "星宿弟子"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,	
							friends = { 
								-- conditions
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 4, id = 1412602, level = 45 },
								{ index = 1, id = 1412602, level = 55 },
								{ index = 7, id = 1412602, level = 45 },
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
							{player = "周姑娘，好了吗？"},
							{npc = "就看此剑了！",npcName = "周宛亦"},
							{npc = "一股龙吟之声出鞘，而后便是金铁被斩爆的声响。",npcName = ""},
							{player = "快走！"},
						},
						next = 7,
					},
					[7] = {
						res = {
							tags = {112600,112604},
							removeTags = {112603}
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112604}},
					failMsg = "后面已无退路，必须要打开这个铁门！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},



	}
}

return scene_012601
