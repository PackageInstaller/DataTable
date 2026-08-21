
-- tags

-- 112701:格子4获得
-- 112702:格子4获得（不会再触发）

-- 112703:格子15获得
-- 112704:格子11获得
-- 112705:格子14获得

-- 112700:章节结束

-- 112715:敌人,死路


local scene_012701 = {
	name = "序章1",
	id = 12701,
	enter = {12701,1001},

	points = {
		[1001] = {
			name = "库房",
			pos = {-46,-246},
			id = 1001,
			grids = {[3]=1002,[4]=1003,[1]=1005,},
			desc = "一间堆满了废弃物的库房，柱子结满了蛛网，随处是残破的铠甲和生锈的兵器。",
			triggerDesc = "两人窜进库房，立即反身关上已被剑气震破的大门，并拖出一柄巨型战斧抵住门把，才长长地喘了口气。",

			npcs = {
				{
					npcName = "周宛亦",
					desc = "约莫十七八岁，淡、雅、清、秀、灵、仙，绝美如芙蓉出世、天人下凡。",
					visibleConditions = {noTags = {112702}},
					[1] = {
						talks = {
							{npc = "这里也是死路。",player = "不可能，这个库房一看就是废弃不用，根本不需要门口用如此坚固的铁锁。"},
							{npc = "那你是说？",player = "没错，这里必有暗道，我们快找。"},
						},
					},
				},
			},
		},

		[1002] = {
			name = "库房",
			pos = {-279,-246},
			id = 1002,
			grids = {[4]=1001,[1]=1004,},
			desc = "一间堆满了废弃物的库房，柱子结满了蛛网，随处是残破的铠甲和生锈的兵器。",
		},

		[1003] = {
			name = "库房",
			pos = {187,-246},
			id = 1003,
			grids = {[3]=1001,[1]=1006,},
			desc = "一间堆满了废弃物的库房，柱子结满了蛛网，随处是残破的铠甲和生锈的兵器。",
		},

		[1004] = {
			name = "库房",
			pos = {-279,-142},
			id = 1004,
			grids = {[2]=1002,[4]=1005,},
			desc = "一间堆满了废弃物的库房，柱子结满了蛛网，随处是残破的铠甲和生锈的兵器。",
			triggerDesc = "库房一角有一座战神的雕像，虽也破旧，但与其他杂物不同，光亮亮的蛮干净。",

			npcs = {
				{
					npcName = "周宛亦",
					desc = "约莫十七八岁，淡、雅、清、秀、灵、仙，绝美如芙蓉出世、天人下凡。",
					visibleConditions = {noTags = {112702}},
					[1] = {
						talks = {
							{player = "周姑娘，你看这雕像，是不是有些古怪。"},
							{npc = "是哦，并未布满灰尘。",player = "好像有人常常动它……"},
							{npc = "[用力推了一下，雕像纹丝不动]：要不，用剑气试试？",player = "等等，先转一下试试，来，我们一起用力！"},
							{npc = "（两人从前后合抱住雕像，双手牢牢的握在一起）",player = "一、二、三、转！",npcName = ""},
							{npc = "咔咔，齿轮声响，雕像侧移，不远处一扇窄窄的小门被打开了，密道出现了。",npcName = ""},
						},
						next = 3,
					},
					[3] = {
						res = {
							tags = {112701,112702}
						}
					},
				},
			},
				
		},

		[1005] = {
			name = "库房",
			pos = {-46,-142},
			id = 1005,
			grids = {[3]=1004,[2]=1001,},
			desc = "一间堆满了废弃物的库房，柱子结满了蛛网，随处是残破的铠甲和生锈的兵器。",
		},

		[1006] = {
			name = "库房",
			pos = {187,-142},
			id = 1006,
			grids = {[2]=1003,[1]=1009,},
			desc = "一间堆满了废弃物的库房，柱子结满了蛛网，随处是残破的铠甲和生锈的兵器。",
		},

		[1007] = {
			name = "密道",
			pos = {-279,-38},
			id = 1007,
			grids = {[4]=1008,},
			desc = "密道像迷宫，四通八达，虽墙边每隔三丈都杵着一支火炬，但依然昏暗，很难分辨方向。",
			triggerDesc = "两人正一筹莫展想对策呢，脚步声由远及近，新宿派莫阴带着十几个弟子以及城主府护卫追了过来。",
			
			npcs = {
				{
					npcName = "星宿派莫阴",
					desc = "剥去了伪善的面容，眼神冷冽刺人，狞笑着开了口。",
					visibleConditions = {noTags = {112715}},
					[1] = {
						npc = "嘿嘿，死吧！",
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 2,	
							friends = { 
								-- conditions
								{ index = 5, id = -1},
								{ index = 3, id = 1412705, level = 100  }, 
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412703, level = 55 },
								{ index = 2, id = 1412703, level = 55 },
								{ index = 3, id = 1412703, level = 55 },
								{ index = 4, id = 1412701, level = 250 },
								{ index = 5, id = 1412703, level = 55 },
								{ index = 6, id = 1412702, level = 250 },
								{ index = 7, id = 1412703, level = 55 },
								{ index = 8, id = 1412703, level = 55 },
								{ index = 9, id = 1412703, level = 55 },
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
							tags = {112715},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112715}},
					failMsg = "遭了，<color=#ff0000>走错路</color>被拦住了。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1008] = {
			name = "密道",
			pos = {-46,-38},
			id = 1008,
			grids = {[3]=1007,[6]=1012,},
			desc = "密道像迷宫，四通八达，虽墙边每隔三丈都杵着一支火炬，但依然昏暗，很难分辨方向。",
			triggerDesc = "传来急促的脚步声、和嘈杂的人声，火把将纷乱的人影照在墙上，像一幅魑魅魍魉的图画。",
		},

		[1009] = {
			name = "密道",
			pos = {187,-38},
			id = 1009,
			grids = {[2]=1006,[1]=1012,},
			desc = "密道像迷宫，四通八达，虽墙边每隔三丈都杵着一支火炬，但依然昏暗，很难分辨方向。",
			triggerDesc = "传来急促的脚步声、和嘈杂的人声，火把将纷乱的人影照在墙上，像一幅魑魅魍魉的图画。",
			enterParts = {
				{
					conditions = {tags = {112702}},
					failMsg = "一面墙挡住了通路。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1010] = {
			name = "密道",
			pos = {420,-38},
			id = 1010,
			grids = {[1]=1013,},
			desc = "密道像迷宫，四通八达，虽墙边每隔三丈都杵着一支火炬，但依然昏暗，很难分辨方向。",
			triggerDesc = "两人正一筹莫展想对策呢，脚步声由远及近，新宿派莫阴带着十几个弟子以及城主府护卫追了过来。",
			
			npcs = {
				{
					npcName = "星宿派莫阴",
					desc = "剥去了伪善的面容，眼神冷冽刺人，狞笑着开了口。",
					visibleConditions = {noTags = {112715}},
					[1] = {
						npc = "嘿嘿，死吧！",
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 2,	
							friends = { 
								-- conditions
								{ index = 5, id = -1},
								{ index = 3, id = 1412705, level = 100  }, 
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412703, level = 55 },
								{ index = 2, id = 1412703, level = 55 },
								{ index = 3, id = 1412703, level = 55 },
								{ index = 4, id = 1412701, level = 250 },
								{ index = 5, id = 1412703, level = 55 },
								{ index = 6, id = 1412702, level = 250 },
								{ index = 7, id = 1412703, level = 55 },
								{ index = 8, id = 1412703, level = 55 },
								{ index = 9, id = 1412703, level = 55 },
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
							tags = {112715},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112715}},
					failMsg = "遭了，<color=#ff0000>走错路</color>被拦住了。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1011] = {
			name = "密道",
			pos = {-279,66},
			id = 1011,
			grids = {[1]=1014,[6]=1015,},
			desc = "密道像迷宫，四通八达，虽墙边每隔三丈都杵着一支火炬，但依然昏暗，很难分辨方向。",
			triggerDesc = "城主刘世杰和莫阴带着一大群人赶到，城主府的侍女也在其中。",
			
			npcs = {
				{
					npcName = "刘世杰",
					desc = "永安城城主，受百姓爱戴，江湖上也声名远播，威不外露，气息绵长，一看便知有深厚的内家功力。",
					visibleConditions = {tags = {112703}},
					[1] = {
						talks = {
							{npc = "莫老怪，一起动手啊！",npcName = "刘世杰"},
							{npc = "城主别急，各门各派的高徒都已中了噬心蛊，以他们为质，《倚》必到手，这个小女娃么，还有几分用处！",npcName = "莫阴"},
							{npc = "哦，原来是为了《倚》，可真是为难你老人家布局两年之久了。",npcName = "神秘声音"},
							{npc = "哇。。哇。。哇 。。突然所有的星宿弟子都跪坐在地上大哭起来！",npcName = ""},
							{npc = "不好，有毒气。",npcName = "星宿派莫阴"},
						},
						next = 3,
					},
					[3] = {
						res = {
							tags = {112704},
							removeTags = {112703}
						}
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112704}},
					failMsg = "密道难行，很快又被追上了。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1012] = {
			name = "密道",
			pos = {187,66},
			id = 1012,
			grids = {[7]=1008,[2]=1009,[1]=1016,[6]=1017,},
			desc = "密道像迷宫，四通八达，虽墙边每隔三丈都杵着一支火炬，但依然昏暗，很难分辨方向。",
			triggerDesc = "传来急促的脚步声、和嘈杂的人声，火把将纷乱的人影照在墙上，像一幅魑魅魍魉的图画。",
		},

		[1013] = {
			name = "密道",
			pos = {420,66},
			id = 1013,
			grids = {[2]=1010,[1]=1017,},
			desc = "密道像迷宫，四通八达，虽墙边每隔三丈都杵着一支火炬，但依然昏暗，很难分辨方向。",
			triggerDesc = "传来急促的脚步声、和嘈杂的人声，火把将纷乱的人影照在墙上，像一幅魑魅魍魉的图画。",
		},

		[1014] = {
			name = "密道",
			pos = {-279,170},
			id = 1014,
			grids = {[2]=1011,},
			desc = "密道像迷宫，四通八达，虽墙边每隔三丈都杵着一支火炬，但依然昏暗，很难分辨方向。",
			triggerDesc = "城主刘世杰和莫阴带着一大群人赶到，城主府的侍女也在其中。",
			
			npcs = {
				{
					npcName = "刘世杰",
					desc = "永安城城主，受百姓爱戴，江湖上也声名远播，威不外露，气息绵长，一看便知有深厚的内家功力。",
					visibleConditions = {tags = {112704}},
					[1] = {
						talks = {
							{npc = "这到底是什么毒！！（突然回头指着城主府侍女）你怎么没事！",npcName = "星宿派莫阴"},
							{npc = "此毒乃是我三年前种下的观音泪，我自然没事。",npcName = "侍女"},
							{npc = "[一脸的不可置信]：小婉？？？你究竟是谁！",npcName = "刘世杰"},
							{npc = "小女蜀中唐家堡门，九房内门弟子-唐婉儿，盯你五年了。",npcName = "唐婉儿"},
							{npc = "[神情已有些呆滞]：唐门？五年？那时你才十二岁！",npcName = "刘世杰"},
							{npc = "唐家堡的人！哼，素无嫌隙，为何坏我大事？",npcName = "星宿派莫阴"},
							{npc = "你们做什么，我不关心，但在蜀中之地，行此阴暗之事，影响唐门声誉，便得死！",npcName = "唐婉儿"},
							{npc = "大家都是用毒的，你们又谈何光明磊落？！而且你年纪轻轻，真以为能挡得住老夫？！",npcName = "星宿派莫阴"},
							{npc = "毒只是一种手段，唐门弟子可不是只会用毒。",npcName = "唐婉儿"},

							{npc = "只见唐婉儿双手环抱如太极，单腿弓步前踏，整个人突然如弓弦般蓄满了力。",npcName = ""},
							{npc = "[终于回过了神]：这是哪门哪派？哼，虚张声势，看掌！",npcName = "刘世杰"},
							{npc = "一起上！先杀了这个毒妮子，再回去收拾那两个。",npcName = "星宿派莫阴"},
							{npc = "噗，一声轻笑，只见唐婉儿张开双手之时，数百道破风之声掠过，又有雷音混在其中。",npcName = ""},
							{npc = "莫阴飞身前跃无法闪避，便如滚地葫芦般缩成一团，且掏出一把伞状兵器护住身体。",npcName = ""},
							{npc = "刘世杰却来不及避开，只听雨打芭蕉般一阵噗噗声，倒在地上不动了。",npcName = ""},

							{npc = "久闻唐家堡规矩，只杀一次，如若失手便不追杀，现老夫挡下了这一击，唐姑娘，可遵规矩否？",npcName = "星宿派莫阴"},
							{npc = "嗯，我不杀你（随即转身离开）",player = "看来我们还得有一个了断。",npcName = "唐婉儿"},
							{npc = "计划已经失败，我把解药留下，你们让路吧!",npcName = "星宿派莫阴"},
							{npc = "哼，我可没唐门的规矩，你杀了我的师妹，还想走？！",npcName = "周宛亦"},
							{npc = "小娃娃，真以为老夫怕你们？来吧，受死吧！",npcName = "星宿派莫阴"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 2,	
							friends = { 
								-- conditions
								{ index = 5, id = -1},
								{ index = 3, id = 1412705, level = 100  }, 
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 4, id = 1412702, level = 250 },
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
							tags = {112700,112705},
							removeTags = {112704},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112700}},
					failMsg = "密道走到了尽头。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1015] = {
			name = "密道",
			pos = {-46,170},
			id = 1015,
			grids = {[7]=1011,[1]=1018,},
			desc = "密道像迷宫，四通八达，虽墙边每隔三丈都杵着一支火炬，但依然昏暗，很难分辨方向。",
			triggerDesc = "城主刘世杰和莫阴带着一大群人赶到，城主府的侍女也在其中。",
			
			npcs = {
				{
					npcName = "刘世杰",
					desc = "永安城城主，受百姓爱戴，江湖上也声名远播，威不外露，气息绵长，一看便知有深厚的内家功力。",
					visibleConditions = {tags = {112701}},
					[1] = {
						talks = {
							{npc = "费尽心机布局2年，差点让你们坏了大事！自行了断吧！",npcName = "刘世杰"},
							{npc = "峨眉只有战死的弟子！来吧！",npcName = "周宛亦"},
							{npc = "小妮子，不要抵抗了，老老实实吞下我的噬心蛊，还能饶你一命！",npcName = "星宿派莫阴"},
							{npc = "你这老毒物，休想！",npcName = "周宛亦"},
							{npc = "那边的小家伙，你头脑灵活应该明白，来，吞下噬心蛊吧，为星宿做事两年，之后便还你自由。",player = "嗯？可以考虑，但我如何相信到时会放我离去？",npcName = "星宿派莫阴"},
							{npc = "嘿嘿，由不得你信不信，要么吞下噬心蛊，要么立刻死！",player = "容我再想一想，再想一想。",npcName = "星宿派莫阴"},
							{npc = "小家伙，拖延时间没用，找死！",player = "周姑娘，没办法了，硬冲吧！",npcName = "刘世杰"},
						},
						next = 5,
					},
					[5] = {
						battle = {

							limitFriendNum = 2,	
							friends = { 
			
								{ index = 5, id = -1},	-- conditions
								{ index = 3, id = 1412705, level = 100  }, 
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 4, id = 1412701, level = 250 },
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
							tags = {112703},
							removeTags = {112701},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112703}},
					failMsg = "可恶，被追上了！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
			enterParts = {
				{
					conditions = {noTags = {112704}},
					failMsg = "那边毒气太重了，不能去。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1016] = {
			name = "密道",
			pos = {187,170},
			id = 1016,
			grids = {[2]=1012,[5]=1018,},
			desc = "密道像迷宫，四通八达，虽墙边每隔三丈都杵着一支火炬，但依然昏暗，很难分辨方向。",
			triggerDesc = "传来急促的脚步声、和嘈杂的人声，火把将纷乱的人影照在墙上，像一幅魑魅魍魉的图画。",
		},

		[1017] = {
			name = "密道",
			pos = {420,170},
			id = 1017,
			grids = {[2]=1013,[7]=1012,[5]=1019,},
			desc = "密道像迷宫，四通八达，虽墙边每隔三丈都杵着一支火炬，但依然昏暗，很难分辨方向。",
			triggerDesc = "传来急促的脚步声、和嘈杂的人声，火把将纷乱的人影照在墙上，像一幅魑魅魍魉的图画。",
		},

		[1018] = {
			name = "密道",
			pos = {-46,274},
			id = 1018,
			grids = {[2]=1015,[1]=1020,[8]=1016,},
			desc = "密道像迷宫，四通八达，虽墙边每隔三丈都杵着一支火炬，但依然昏暗，很难分辨方向。",
			triggerDesc = "传来急促的脚步声、和嘈杂的人声，火把将纷乱的人影照在墙上，像一幅魑魅魍魉的图画。",
			enterParts = {
				{
					conditions = {noTags = {112703}},
					failMsg = "大群的星宿弟子在来路上，往前跑吧。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1019] = {
			name = "密道",
			pos = {187,274},
			id = 1019,
			grids = {[8]=1017,},
			desc = "密道像迷宫，四通八达，虽墙边每隔三丈都杵着一支火炬，但依然昏暗，很难分辨方向。",
			triggerDesc = "两人正一筹莫展想对策呢，脚步声由远及近，新宿派莫阴带着十几个弟子以及城主府护卫追了过来。",
			
			npcs = {
				{
					npcName = "星宿派莫阴",
					desc = "剥去了伪善的面容，眼神冷冽刺人，狞笑着开了口。",
					visibleConditions = {noTags = {112715}},
					[1] = {
						npc = "嘿嘿，死吧！",
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 2,	
							friends = { 
								-- conditions
								{ index = 5, id = -1},
								{ index = 3, id = 1412705, level = 100  }, 
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412703, level = 55 },
								{ index = 2, id = 1412703, level = 55 },
								{ index = 3, id = 1412703, level = 55 },
								{ index = 4, id = 1412701, level = 250 },
								{ index = 5, id = 1412703, level = 55 },
								{ index = 6, id = 1412702, level = 250 },
								{ index = 7, id = 1412703, level = 55 },
								{ index = 8, id = 1412703, level = 55 },
								{ index = 9, id = 1412703, level = 55 },
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
							tags = {112715},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112715}},
					failMsg = "遭了，<color=#ff0000>走错路</color>被拦住了。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1020] = {
			name = "密道",
			pos = {-46,378},
			id = 1020,
			grids = {[2]=1018,[4]=1021,},
			desc = "密道像迷宫，四通八达，虽墙边每隔三丈都杵着一支火炬，但依然昏暗，很难分辨方向。",
			triggerDesc = "传来急促的脚步声、和嘈杂的人声，火把将纷乱的人影照在墙上，像一幅魑魅魍魉的图画。",
		},

		[1021] = {
			name = "密道",
			pos = {187,378},
			id = 1021,
			grids = {[3]=1020,},
			desc = "密道像迷宫，四通八达，虽墙边每隔三丈都杵着一支火炬，但依然昏暗，很难分辨方向。",
			triggerDesc = "两人正一筹莫展想对策呢，脚步声由远及近，新宿派莫阴带着十几个弟子以及城主府护卫追了过来。",
			
			npcs = {
				{
					npcName = "星宿派莫阴",
					desc = "剥去了伪善的面容，眼神冷冽刺人，狞笑着开了口。",
					visibleConditions = {noTags = {112715}},
					[1] = {
						npc = "嘿嘿，死吧！",
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 2,	
							friends = { 
								-- conditions
								{ index = 5, id = -1},
								{ index = 3, id = 1412705, level = 100  }, 
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412703, level = 55 },
								{ index = 2, id = 1412703, level = 55 },
								{ index = 3, id = 1412703, level = 55 },
								{ index = 4, id = 1412701, level = 250 },
								{ index = 5, id = 1412703, level = 55 },
								{ index = 6, id = 1412702, level = 250 },
								{ index = 7, id = 1412703, level = 55 },
								{ index = 8, id = 1412703, level = 55 },
								{ index = 9, id = 1412703, level = 55 },
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
							tags = {112715},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112715}},
					failMsg = "遭了，<color=#ff0000>走错路</color>被拦住了。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},



	}
}

return scene_012701
