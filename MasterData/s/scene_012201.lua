
-- tags
-- 112201:擂台1通关
-- 112202:擂台1不再触发

-- 112203:擂台2通关
-- 112204:擂台2通关不再触发

-- 112205:擂台3通关
-- 112206:擂台3通关不再触发

-- 112207:擂台4通关


-- 112200:章节结束



local Juqing1 = {
	[1] = {
		conditions = {noTags = {112202},},
		talks = {
			{npc = "点到为止，一边三人全部失去战斗力即为战败。",player = "请赐教！",npcName = "裁判"},
			{npc = "青城派-陆风、青城派-陆明、青城派-陆有成，请赐教！",player = "请赐教！",npcName = "青城三秀"},
		},
		next = 5,
	},
	[2] = {
		talks = {
			{npc = "恭喜{sex:003}，赢得第一战。",player = "多谢！",npcName = "裁判"},
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
				{ index = 1, id = 1412201, level = 60 },
				{ index = 3, id = 1412202, level = 60 },
				{ index = 5, id = 1412203, level = 60 },
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
			{npc = "甘拜下风。",player = "承让。",npcName = "青城三秀"},
		},
		next = 7,
	},
	[7] = {
		res = {
			tags = {112201,112202},
		},
	},
}

local Juqing2 = {
	[1] = {
		conditions = {noTags = {112204},},
		talks = {
			{npc = "点到为止，一边三人全部失去战斗力即为战败。",player = "请赐教！",npcName = "裁判"},
			{npc = "小娃娃们，咱们使的是千锤百炼的杀人技巧，你们可要小心了，刀剑无眼！",player = "我们也并非绣花枕头，请赐教！",npcName = "沙场雄兵"},
		},
		next = 5,
	},
	[2] = {
		talks = {
			{npc = "恭喜{sex:003}，赢得第二战。",player = "多谢！",npcName = "裁判"},
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
				{ index = 1, id = 1412204, level = 65 },
				{ index = 7, id = 1412204, level = 65 },
				{ index = 6, id = 1412204, level = 65 },
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
			{npc = "少年英雄，佩服佩服！",player = "承让。",npcName = "沙场雄兵"},
		},
		next = 7,
	},
	[7] = {
		res = {
			tags = {112203,112204},
		},
	},
}

local Juqing3 = {
	[1] = {
		conditions = {noTags = {112206},},
		talks = {
			{npc = "点到为止，一边三人全部失去战斗力即为战败。",player = "请赐教！",npcName = "裁判"},
			{npc = "小娃娃们可要小心了，老道我收得住浮尘，两个徒儿却未必能收住手里的剑。",player = "我等自会小心，嘿嘿，道长也要小心。",npcName = "乌鸦道人"},
		},
		next = 5,
	},
	[2] = {
		talks = {
			{npc = "恭喜{sex:003}，赢得第三战。",player = "多谢！",npcName = "裁判"},
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
				{ index = 3, id = 1412206, level = 60 },
				{ index = 4, id = 1412205, level = 90 },
				{ index = 9, id = 1412206, level = 60 },
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
			{npc = "哎，哎，脸面丢尽呐！",player = "道长莫要过谦，单打独斗我们谁都不是您的对手。",npcName = "乌鸦道人"},
		},
		next = 7,
	},
	[7] = {
		res = {
			tags = {112205,112206},
		},
	},
}

local Juqing4 = {
	[1] = {
		conditions = {noTags = {112207},},
		talks = {
			{npc = "点到为止，一边三人全部失去战斗力即为战败。",npcName = "虎小山"},
			{npc = "这个虎头虎脑而且话痨的家伙真是崆峒派的吗？",player = "是啊，一直听说崆峒派的弟子都是闷葫芦，像修了闭口禅似的。",npcName = "邵灵儿"},
			{npc = "嗨，别不理我，快打快完事！崆峒派虎小山，请赐教！",player = "揍趴他们！",npcName = "虎小山"},
		},
		next = 5,
	},
	[2] = {
		talks = {
			{npc = "恭喜{sex:003}，晋级复赛。",player = "多谢！",npcName = "裁判"},
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
				{ index = 4, id = 1412208, level = 80 },
				{ index = 5, id = 1412207, level = 60 },
				{ index = 6, id = 1412207, level = 60 },
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
			{player = "终于胜利了！",npcName = "虎小山"},
			{npc = "还未完。",npcName = "虎小山"},
			{npc = "小虎，别冲动！",npcName = "崆峒派弟子"},
			{npc = "虎小山突然双目泛红，全身骨骼猎猎作响，左臂衣袖突然崩裂，拳锋冒出红光！",player = "[感受到了强大的威势] 灵儿，田兄，小心！",npcName = ""},
			{npc = "虎小山一记七伤拳乘千钧之势扑来，眼看便要击中，却猛地刹住，一口鲜血仰面喷出。",player = "喂，你没事吧？什么情况啊？",npcName = ""},
			{npc = "没有大碍，万幸没有伤到你们，不然可要被师傅骂死了。",npcName = "虎小山"},
			{npc = "你们崆峒派真是怪，竟然修习这种武学，威力虽大，可也会自伤，怎能持久呢？",npcName = "邵灵儿"},
			{npc = "师傅说我是武学奇才，只要修炼得当就不会有事。",npcName = "虎小山"},
			{npc = "铁憨憨吧，还武学奇才呢，且问你刚才为何出招而不攻？",npcName = "邵灵儿"},
			{npc = "看到这位兄弟露出破绽，便本能的出招了，但转念一想只是切磋交流，怎能下此重手，所以刹住了。",player = "哈哈，这位小虎哥，真是耿直憨厚之人，下一轮比武还在几日之后，不如今夜我们一醉方休，煮酒论武。",npcName = "虎小山"},
			{npc = "好啊好啊，喝酒我喜欢！",npcName = "虎小山"},
		},
		next = 7,
	},
	[7] = {
		res = {
			tags = {112207,112200},
		},
	},
}

local scene_012201 = {
	name = "序章1",
	id = 12201,
	enter = {12201,1001},

	points = {
		[1001] = {
			name = "练武场",
			pos = {17,-187},
			id = 1001,
			grids = {[1]=1002,},
			desc = "一个小小的练武场，一位身着绿色侠士服的持枪汉子站在中间。",
			triggerDesc = "啪的一棍，又一个挑战者被扫出圆圈，看来又是失败了。",

			npcs = {
				{
					npcName = "蜀中大侠李正",
					desc = "英武不凡、正气凛然，看上去是个非常严肃的中年人。",
					[1] = {
						talks = {
							{npc = "去吧，你们已经够资格了！",player = "现在就开始了吗？",npcName = "蜀中大侠李正"},
							{npc = "是啊，先来者先比试，人太多了，聚在一起比，何时能够结束。",npcName = "蜀中大侠李正"},
							{npc = "此番连胜4场者就能晋级，进行最后的大比。",player = "好嘞，那我便去试试身手了！",npcName = "蜀中大侠李正"},
						},
					},
				},
			},
		},

		[1002] = {
			name = "街道",
			pos = {17,-83},
			id = 1002,
			grids = {[2]=1001,[1]=1003,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
		},

		[1003] = {
			name = "街道",
			pos = {17,21},
			id = 1003,
			grids = {[2]=1002,[1]=1004,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
		},

		[1004] = {
			name = "擂台",
			pos = {17,125},
			id = 1004,
			grids = {[2]=1003,[1]=1005,},
			desc = "南4号擂台，长宽五丈有余，高一丈，四面挤满了凑热闹的百姓。",
			triggerDesc = "擂台四角站着4个士兵，台上已有3位侠客正在等待。",

			npcs = {
				{
					npcName = "裁判",
					desc = "一袭黑衣，双手反握与身后，正安静的等待双方准备。",
					[1] = Juqing1
				},
				{
					npcName = "青城三秀",
					desc = "一身天蓝色武士服，三人皆配长剑。",
					visibleConditions = {noTags = {112202}},
					[1] = Juqing1
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112202}},
					failMsg = "这便是第一场了",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1005] = {
			name = "街道",
			pos = {17,229},
			id = 1005,
			grids = {[2]=1004,[1]=1006,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
		},

		[1006] = {
			name = "街道",
			pos = {17,333},
			id = 1006,
			grids = {[2]=1005,[1]=1007,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
		},

		[1007] = {
			name = "擂台",
			pos = {17,437},
			id = 1007,
			grids = {[2]=1006,[1]=1008,},
			desc = "南4号擂台，长宽五丈有余，高一丈，四面挤满了凑热闹的百姓。",
			triggerDesc = "擂台四角站着4个士兵，台上已有3位侠客正在等待。",

			npcs = {
				{
					npcName = "裁判",
					desc = "一袭黑衣，双手反握与身后，正安静的等待双方准备。",
					[1] = Juqing2
				},
				{
					npcName = "沙场雄兵",
					desc = "一身军中铠甲、三人皆持刀盾。",
					visibleConditions = {noTags = {112204}},
					[1] = Juqing2
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112204}},
					failMsg = "这便是第二场了",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1008] = {
			name = "街道",
			pos = {17,541},
			id = 1008,
			grids = {[2]=1007,[1]=1009,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
		},

		[1009] = {
			name = "街道",
			pos = {17,645},
			id = 1009,
			grids = {[2]=1008,[1]=1010,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
		},

		[1010] = {
			name = "擂台",
			pos = {17,749},
			id = 1010,
			grids = {[2]=1009,[1]=1011,},
			desc = "南2号擂台，长宽十丈有余，高一丈，四面挤满了凑热闹的百姓。",
			triggerDesc = "擂台四角站着4个士兵，台上已有一位老道士带着两位道童正在等候。",

			npcs = {
				{
					npcName = "裁判",
					desc = "一袭黑衣，双手反握与身后，正安静的等待双方准备。",
					[1] = Juqing3
				},
				{
					npcName = "乌鸦道人",
					desc = "脚踏白色布鞋，左手浮尘置于右臂之上，脸色发黑，眼白也是灰暗的，怪不得人称“乌鸦道人”。",
					visibleConditions = {noTags = {112206}},
					[1] = Juqing3
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112206}},
					failMsg = "这便是第三场了",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1011] = {
			name = "街道",
			pos = {17,853},
			id = 1011,
			grids = {[2]=1010,[1]=1012,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
		},

		[1012] = {
			name = "街道",
			pos = {17,957},
			id = 1012,
			grids = {[2]=1011,[1]=1013,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
		},

		[1013] = {
			name = "擂台",
			pos = {17,1061},
			id = 1013,
			grids = {[2]=1012,},
			desc = "南1号擂台，长宽十五丈有余，高两丈，四面挤满了凑热闹的百姓。",
			triggerDesc = "台上两位崆峒派弟子如青松般站着，还有一个独自盘腿坐在地上，有些瞌睡，大脑袋一点一点的。",

			npcs = {
				{
					npcName = "裁判",
					desc = "一袭黑衣，双手反握与身后，正安静的等待双方准备。",
					[1] = Juqing4
				},
				{
					npcName = "崆峒派虎小山",
					desc = "身体高大却长了张娃娃脸，两只圆铃般的大眼睛，瞧着有些憨憨的。",
					visibleConditions = {noTags = {112207}},
					[1] = Juqing4
				},
			}
		},



	}
}

return scene_012201
