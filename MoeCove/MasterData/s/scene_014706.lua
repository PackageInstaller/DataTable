local scene_014706 = {
	name = "序章1",
	id = 014706,
	enter = {14701,1001},

	points = {

		[1001] = {
			name = "幻境-力",
			pos = {-187,743},
			id = 1001,
			grids = {[1]=1041,},
			desc = "力之境，不知需要多少臂力才能破除。",

			enterParts = {
				{
					conditions = {nstr = 180,},
					failMsg = "力之境，不知需要多少臂力才能破除。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},
		[1041] = {
			name = "幻境-定",
			pos = {-187,744},
			id = 1041,
			grids = {[1]=1042,},
			desc = "定之境，不知需要多少定力才能破除。",

			enterParts = {
				{
					conditions = {ncon = 180,},
					failMsg = "定之境，不知需要多少定力才能破除。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},
		[1042] = {
			name = "幻境-魄",
			pos = {-187,745},
			id = 1042,
			grids = {[1]=1043,},
			desc = "魄之境，不知需要多少胆识才能破除。",

			enterParts = {
				{
					conditions = {ncou = 180,},
					failMsg = "魄之境，不知需要多少胆识才能破除。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},
		[1043] = {
			name = "幻境-敏",
			pos = {-187,746},
			id = 1043,
			grids = {[1]=1044,},
			desc = "敏之境，不知需要多少机敏才能破除。",

			enterParts = {
				{
					conditions = {nagi = 180,},
					failMsg = "敏之境，不知需要多少机敏才能破除。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},
		[1044] = {
			name = "幻境-骨",
			pos = {-187,747},
			id = 1044,
			grids = {[1]=1045,},
			desc = "骨之境，不知需要多少根骨才能破除。",

			enterParts = {
				{
					conditions = {nbon = 180,},
					failMsg = "骨之境，不知需要多少根骨才能破除。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},
		[1045] = {
			name = "幻境-缘",
			pos = {-187,748},
			id = 1045,
			grids = {[1]=1046,},
			desc = "缘之境，不知需要多少福源才能破除。",

			enterParts = {
				{
					conditions = {nluk = 180,},
					failMsg = "缘之境，不知需要多少福源才能破除。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},
		[1046] = {
			name = "幻境-巧",
			pos = {-187,749},
			id = 1046,
			grids = {[1]=1047,},
			desc = "巧之境，不知需要多少灵巧才能破除。",

			enterParts = {
				{
					conditions = {ndex = 180,},
					failMsg = "巧之境，不知需要多少灵巧才能破除。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},
		[1047] = {
			name = "幻境-体",
			pos = {-187,751},
			id = 1047,
			grids = {[1]=1048,},
			desc = "体之境，不知需要多少体魄才能破除。",

			enterParts = {
				{
					conditions = {nsou = 180,},
					failMsg = "体之境，不知需要多少灵巧才能破除。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},
		[1048] = {
			name = "幻境-终",
			pos = {-187,752},
			id = 1048,
			grids = {},
			desc = "一片霞光之中浮现着金色的文字，隐约显示着一种刀法武学。",

			npcs = {
				{
					npcName = "霞光文字",
					desc = "一片霞光之中浮现着金色的文字，隐约显示着一种刀法武学。",
					[0] = {
						player = {
							{content = "阅读", next = 2},
						}
					},

					[2] = {
						[1] = {
							talks = {
								{npc = "注视隐隐若现的文字许久，原是一种刀法传承！",npcName = "",},
								{npc = "世上第一等的破甲刀法，如灼日耀空，似雷霆万钧，所有硬功在其面前都不堪一击。",npcName = "",},
								{npc = "霎息之间上下左右连砍十二刀，以一股狠辣内力，化解对手繁复招式，如烈日融雪一般。",npcName = "",},
								{npc = "赤日炎炎无残云，烈焰灼心不留情。金乌刀法口诀之第一诀：使棍使拳之敌手，杀无赦！",npcName = "",},
							},
							next = 5,
						},

						[5] = {
							res = {
								tags = {1147128},
								items = {{397229,1}},
							},
						},
					},
				},
			},
		},


	}
}

return scene_014706
