
-- tags

-- 113301:格子1对话。

-- 113302~113314:战斗后不再战斗
-- 113303:格子6获得


-- 113300:章节结束



local scene_013301 = {
	name = "序章1",
	id = 13301,
	enter = {13301,1001},

	points = {
		[1001] = {
			name = "峨眉派",
			pos = {-244,-174},
			id = 1001,
			grids = {[1]=1002,},
			desc = "峨眉派居于峨眉山峰顶，云雾环绕宛若仙境。",
			triggerDesc = "翠林掩映间，屋舍错落，一尘不染，遥遥拱卫着一座恢弘的大殿。",
			
			npcs = {
				{
					npcName = "虎小山",
					desc = "身体高大却长了张娃娃脸，两只圆铃般的大眼睛，瞧着有些憨憨的。",
					visibleConditions = {noTags = {113301}},
					[1] = {
						talks = {
							{npc = "哎，脑瓜子疼。",npcName = "虎小山"},
							{npc = "哎哎，想不出办法呀！",npcName = "虎小山"},
						},
					},
				},
				{
					npcName = "邵灵儿",
					desc = "邵城武馆之女，精通鞭法，衣着素淡如菊，一双眼睛却着实的灵动清亮。",
					visibleConditions = {noTags = {113301}},
					[1] = {
						talks = {
							{npc = "小山，你别呼呼了，想不出来办法就消停一会。",npcName = "邵灵儿"},
							{npc = "跑那么老远过来，没接着人可不行！",npcName = "虎小山"},
							{npc = "那你总是在那里呼呼的叫也不管用啊，安静一些。",npcName = "邵灵儿"},
							{npc = "噢",npcName = "虎小山"},
						},
					},
				},
				{
					npcName = "田伯光",
					desc = "剑眉朗目，鼻直口方，束发轻袍，英气逼人，一看便知是个方正君子。",
					visibleConditions = {noTags = {113301}},
					[1] = {
						talks = {
							{player = "哎，周姑娘这师傅这么难缠，看来是没指望了。"},
							{npc = "还是得看周姑娘她的意思。",player = "周姐姐被禁足在峨眉祠堂了，我们人都见不到，有什么办法呢。",npcName = "田伯光"},
							{npc = "我们溜进去找她！",npcName = "邵灵儿"},
							{npc = "我看行！但守卫森严，怎么绕得开呢？",npcName = "虎小山"},
							{npc = "没问题的，祠堂在后山，我们饶小路进去，嘿嘿。",player = "行，咱们走。",npcName = "田伯光"},
						},
						next = 3,
					},
					[3] = {
						res = {
							tags = 113301,
						}
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113301}},
					failMsg = "伙伴们聚在门口等待商量下一步行动。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1002] = {
			name = "小路",
			pos = {-244,-70},
			id = 1002,
			grids = {[2]=1001,[1]=1003,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1003] = {
			name = "小路",
			pos = {-244,34},
			id = 1003,
			grids = {[2]=1002,[4]=1004,[1]=1005,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1004] = {
			name = "小路",
			pos = {-11,34},
			id = 1004,
			grids = {[3]=1003,[6]=1007,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1005] = {
			name = "小路",
			pos = {-244,138},
			id = 1005,
			grids = {[2]=1003,[4]=1006,[1]=1009,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "几名巡视的峨眉弟子突然出现，拦住众人！",

			npcs = {
				{
					npcName = "峨眉弟子",
					desc = "面色清冷如峨眉月，一身白衣似峨眉雪，右肩露出青色的剑鞘。",
					visibleConditions = {noTags = {113302}},
					[1] = {
						talks = {
							{npc = "你们偷偷摸摸做什么！",npcName="峨眉弟子"},
							{npc = "打晕她们！咱们蒙面的，她们认不出来！",player = "速战速决！",npcName="邵灵儿"},
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
								{ index = 1, id = 1413301, level = 125 },
								{ index = 4, id = 1413301, level = 125 },
								{ index = 7, id = 1413301, level = 125 },
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
							tags = {113302},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113302}},
					failMsg = "你们偷偷摸摸做什么！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},

		},

		[1006] = {
			name = "小路",
			pos = {-11,138},
			id = 1006,
			grids = {[3]=1005,[4]=1007,[1]=1010,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1007] = {
			name = "小路",
			pos = {222,138},
			id = 1007,
			grids = {[3]=1006,[4]=1008,[7]=1004,[1]=1011,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "几名巡视的峨眉弟子突然出现，拦住众人！",

			npcs = {
				{
					npcName = "峨眉弟子",
					desc = "面色清冷如峨眉月，一身白衣似峨眉雪，右肩露出青色的剑鞘。",
					visibleConditions = {noTags = {113303}},
					[1] = {
						talks = {
							{npc = "你们偷偷摸摸做什么！",npcName="峨眉弟子"},
							{npc = "打晕她们！咱们蒙面的，她们认不出来！",player = "速战速决！",npcName="邵灵儿"},
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
								{ index = 1, id = 1413301, level = 125 },
								{ index = 4, id = 1413301, level = 125 },
								{ index = 7, id = 1413301, level = 125 },
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
							tags = {113303},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113303}},
					failMsg = "你们偷偷摸摸做什么！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1008] = {
			name = "小路",
			pos = {455,138},
			id = 1008,
			grids = {[3]=1007,[1]=1012,[6]=1013,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "几名巡视的峨眉弟子突然出现，拦住众人！",

			npcs = {
				{
					npcName = "峨眉弟子",
					desc = "面色清冷如峨眉月，一身白衣似峨眉雪，右肩露出青色的剑鞘。",
					visibleConditions = {noTags = {113304}},
					[1] = {
						talks = {
							{npc = "你们偷偷摸摸做什么！",npcName="峨眉弟子"},
							{npc = "打晕她们！咱们蒙面的，她们认不出来！",player = "速战速决！",npcName="邵灵儿"},
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
								{ index = 1, id = 1413301, level = 125 },
								{ index = 4, id = 1413301, level = 125 },
								{ index = 7, id = 1413301, level = 125 },
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
							tags = {113304},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113304}},
					failMsg = "你们偷偷摸摸做什么！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1009] = {
			name = "小路",
			pos = {-244,242},
			id = 1009,
			grids = {[2]=1005,[1]=1014,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1010] = {
			name = "小路",
			pos = {-11,242},
			id = 1010,
			grids = {[2]=1006,[1]=1015,[6]=1016,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "几名巡视的峨眉弟子突然出现，拦住众人！",

			npcs = {
				{
					npcName = "峨眉弟子",
					desc = "面色清冷如峨眉月，一身白衣似峨眉雪，右肩露出青色的剑鞘。",
					visibleConditions = {noTags = {113305}},
					[1] = {
						talks = {
							{npc = "你们偷偷摸摸做什么！",npcName="峨眉弟子"},
							{npc = "打晕她们！咱们蒙面的，她们认不出来！",player = "速战速决！",npcName="邵灵儿"},
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
								{ index = 1, id = 1413301, level = 125 },
								{ index = 4, id = 1413301, level = 125 },
								{ index = 7, id = 1413301, level = 125 },
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
							tags = {113305},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113305}},
					failMsg = "你们偷偷摸摸做什么！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1011] = {
			name = "小路",
			pos = {222,242},
			id = 1011,
			grids = {[2]=1007,[1]=1016,[6]=1017,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1012] = {
			name = "小路",
			pos = {455,242},
			id = 1012,
			grids = {[2]=1008,[6]=1018,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1013] = {
			name = "小路",
			pos = {688,242},
			id = 1013,
			grids = {[7]=1008,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "几名巡视的峨眉弟子突然出现，拦住众人！",

			npcs = {
				{
					npcName = "峨眉弟子",
					desc = "面色清冷如峨眉月，一身白衣似峨眉雪，右肩露出青色的剑鞘。",
					visibleConditions = {noTags = {113306}},
					[1] = {
						talks = {
							{npc = "你们偷偷摸摸做什么！",npcName="峨眉弟子"},
							{npc = "打晕她们！咱们蒙面的，她们认不出来！",player = "速战速决！",npcName="邵灵儿"},
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
								{ index = 1, id = 1413301, level = 125 },
								{ index = 4, id = 1413301, level = 125 },
								{ index = 7, id = 1413301, level = 125 },
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
							tags = {113306},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113306}},
					failMsg = "你们偷偷摸摸做什么！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1014] = {
			name = "小路",
			pos = {-244,346},
			id = 1014,
			grids = {[2]=1009,[1]=1019,[6]=1020,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1015] = {
			name = "小路",
			pos = {-11,346},
			id = 1015,
			grids = {[2]=1010,[6]=1021,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "几名巡视的峨眉弟子突然出现，拦住众人！",

			npcs = {
				{
					npcName = "峨眉弟子",
					desc = "面色清冷如峨眉月，一身白衣似峨眉雪，右肩露出青色的剑鞘。",
					visibleConditions = {noTags = {113307}},
					[1] = {
						talks = {
							{npc = "你们偷偷摸摸做什么！",npcName="峨眉弟子"},
							{npc = "打晕她们！咱们蒙面的，她们认不出来！",player = "速战速决！",npcName="邵灵儿"},
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
								{ index = 1, id = 1413301, level = 125 },
								{ index = 4, id = 1413301, level = 125 },
								{ index = 7, id = 1413301, level = 125 },
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
							tags = {113307},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113307}},
					failMsg = "你们偷偷摸摸做什么！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1016] = {
			name = "小路",
			pos = {222,346},
			id = 1016,
			grids = {[2]=1011,[7]=1010,[6]=1022,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "几名巡视的峨眉弟子突然出现，拦住众人！",

			npcs = {
				{
					npcName = "峨眉弟子",
					desc = "面色清冷如峨眉月，一身白衣似峨眉雪，右肩露出青色的剑鞘。",
					visibleConditions = {noTags = {113308}},
					[1] = {
						talks = {
							{npc = "你们偷偷摸摸做什么！",npcName="峨眉弟子"},
							{npc = "打晕她们！咱们蒙面的，她们认不出来！",player = "速战速决！",npcName="邵灵儿"},
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
								{ index = 1, id = 1413301, level = 125 },
								{ index = 4, id = 1413301, level = 125 },
								{ index = 7, id = 1413301, level = 125 },
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
							tags = {113308},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113308}},
					failMsg = "你们偷偷摸摸做什么！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1017] = {
			name = "小路",
			pos = {455,346},
			id = 1017,
			grids = {[7]=1011,[6]=1023,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1018] = {
			name = "小路",
			pos = {688,346},
			id = 1018,
			grids = {[7]=1012,[6]=1024,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "几名巡视的峨眉弟子突然出现，拦住众人！",

			npcs = {
				{
					npcName = "峨眉弟子",
					desc = "面色清冷如峨眉月，一身白衣似峨眉雪，右肩露出青色的剑鞘。",
					visibleConditions = {noTags = {113309}},
					[1] = {
						talks = {
							{npc = "你们偷偷摸摸做什么！",npcName="峨眉弟子"},
							{npc = "打晕她们！咱们蒙面的，她们认不出来！",player = "速战速决！",npcName="邵灵儿"},
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
								{ index = 1, id = 1413301, level = 125 },
								{ index = 4, id = 1413301, level = 125 },
								{ index = 7, id = 1413301, level = 125 },
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
							tags = {113309},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113309}},
					failMsg = "你们偷偷摸摸做什么！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1019] = {
			name = "小路",
			pos = {-244,450},
			id = 1019,
			grids = {[2]=1014,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "几名巡视的峨眉弟子突然出现，拦住众人！",

			npcs = {
				{
					npcName = "峨眉弟子",
					desc = "面色清冷如峨眉月，一身白衣似峨眉雪，右肩露出青色的剑鞘。",
					visibleConditions = {noTags = {113310}},
					[1] = {
						talks = {
							{npc = "你们偷偷摸摸做什么！",npcName="峨眉弟子"},
							{npc = "打晕她们！咱们蒙面的，她们认不出来！",player = "速战速决！",npcName="邵灵儿"},
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
								{ index = 1, id = 1413301, level = 125 },
								{ index = 4, id = 1413301, level = 125 },
								{ index = 7, id = 1413301, level = 125 },
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
							tags = {113310},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113310}},
					failMsg = "你们偷偷摸摸做什么！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1020] = {
			name = "小路",
			pos = {-11,450},
			id = 1020,
			grids = {[7]=1014,[6]=1025,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1021] = {
			name = "小路",
			pos = {222,450},
			id = 1021,
			grids = {[7]=1015,[6]=1026,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1022] = {
			name = "小路",
			pos = {455,450},
			id = 1022,
			grids = {[7]=1016,[6]=1027,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1023] = {
			name = "小路",
			pos = {688,450},
			id = 1023,
			grids = {[7]=1017,[6]=1028,[1]=1027,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1024] = {
			name = "小路",
			pos = {921,450},
			id = 1024,
			grids = {[7]=1018,[1]=1028,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1025] = {
			name = "小路",
			pos = {222,554},
			id = 1025,
			grids = {[7]=1020,[6]=1029,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1026] = {
			name = "小路",
			pos = {455,554},
			id = 1026,
			grids = {[7]=1021,[4]=1027,[6]=1030,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "几名巡视的峨眉弟子突然出现，拦住众人！",

			npcs = {
				{
					npcName = "峨眉弟子",
					desc = "面色清冷如峨眉月，一身白衣似峨眉雪，右肩露出青色的剑鞘。",
					visibleConditions = {noTags = {113311}},
					[1] = {
						talks = {
							{npc = "你们偷偷摸摸做什么！",npcName="峨眉弟子"},
							{npc = "打晕她们！咱们蒙面的，她们认不出来！",player = "速战速决！",npcName="邵灵儿"},
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
								{ index = 1, id = 1413301, level = 125 },
								{ index = 4, id = 1413301, level = 125 },
								{ index = 7, id = 1413301, level = 125 },
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
							tags = {113311},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113311}},
					failMsg = "你们偷偷摸摸做什么！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1027] = {
			name = "小路",
			pos = {688,554},
			id = 1027,
			grids = {[7]=1022,[2]=1023,[3]=1026,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "几名巡视的峨眉弟子突然出现，拦住众人！",

			npcs = {
				{
					npcName = "峨眉弟子",
					desc = "面色清冷如峨眉月，一身白衣似峨眉雪，右肩露出青色的剑鞘。",
					visibleConditions = {noTags = {113312}},
					[1] = {
						talks = {
							{npc = "你们偷偷摸摸做什么！",npcName="峨眉弟子"},
							{npc = "打晕她们！咱们蒙面的，她们认不出来！",player = "速战速决！",npcName="邵灵儿"},
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
								{ index = 1, id = 1413301, level = 125 },
								{ index = 4, id = 1413301, level = 125 },
								{ index = 7, id = 1413301, level = 125 },
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
							tags = {113312},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113312}},
					failMsg = "你们偷偷摸摸做什么！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1028] = {
			name = "小路",
			pos = {921,554},
			id = 1028,
			grids = {[7]=1023,[2]=1024,[5]=1030,[1]=1031,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "几名巡视的峨眉弟子突然出现，拦住众人！",

			npcs = {
				{
					npcName = "峨眉弟子",
					desc = "面色清冷如峨眉月，一身白衣似峨眉雪，右肩露出青色的剑鞘。",
					visibleConditions = {noTags = {113313}},
					[1] = {
						talks = {
							{npc = "你们偷偷摸摸做什么！",npcName="峨眉弟子"},
							{npc = "打晕她们！咱们蒙面的，她们认不出来！",player = "速战速决！",npcName="邵灵儿"},
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
								{ index = 1, id = 1413301, level = 125 },
								{ index = 4, id = 1413301, level = 125 },
								{ index = 7, id = 1413301, level = 125 },
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
							tags = {113313},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113313}},
					failMsg = "你们偷偷摸摸做什么！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1029] = {
			name = "小路",
			pos = {455,658},
			id = 1029,
			grids = {[7]=1025,[4]=1030,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "几名巡视的峨眉弟子突然出现，拦住众人！",

			npcs = {
				{
					npcName = "峨眉弟子",
					desc = "面色清冷如峨眉月，一身白衣似峨眉雪，右肩露出青色的剑鞘。",
					visibleConditions = {noTags = {113314}},
					[1] = {
						talks = {
							{npc = "你们偷偷摸摸做什么！",npcName="峨眉弟子"},
							{npc = "打晕她们！咱们蒙面的，她们认不出来！",player = "速战速决！",npcName="邵灵儿"},
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
								{ index = 1, id = 1413301, level = 125 },
								{ index = 4, id = 1413301, level = 125 },
								{ index = 7, id = 1413301, level = 125 },
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
							tags = {113314},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113314}},
					failMsg = "你们偷偷摸摸做什么！",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1030] = {
			name = "小路",
			pos = {688,658},
			id = 1030,
			grids = {[7]=1026,[8]=1028,[3]=1029,},
			desc = "后山一片翠绿的竹海，一条石径蜿蜒向前，宛如徐徐地展开了一幅画卷。",
			triggerDesc = "一行四人悄无声息地走在石径上，耳边只有风吹竹叶沙沙作响。",
		},

		[1031] = {
			name = "祠堂前厅",
			pos = {921,658},
			id = 1031,
			grids = {[2]=1028,[1]=1032,},
			desc = "小路的尽头有一个小小的院落，散发着温馨的橘色光芒。",
			triggerDesc = "一位老尼正倚在门边，扫把拄在一旁，看似正在歇息。",

			npcs = {
				{
					npcName = "苦庵师太",
					desc = "身材瘦小的一位老人，面容温和，只是看了一眼，便顿时让人安宁下来。",
					visibleConditions = {noTags = {113315}},
					[1] = {
						talks = {
							{player = "师太，你也要阻拦吗？"},
							{npc = "你们进去吧，苦了宛亦这丫头，有那么严厉的师傅。",player = "多谢师太",npcName="苦庵师太"},
						},
						next = 6,
					},
					
					[6] = {
						res = {
							tags = {113315},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113315}},
					failMsg = "一位老尼站在祠堂前，眼看是绕不过去了。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},		
		},

		[1032] = {
			name = "祠堂",
			pos = {921,762},
			id = 1032,
			grids = {[2]=1031,},
			desc = "古意盎然的院落，阵阵檀香环绕院落内外，星星点点的烛光散发着温暖和微光。",
			triggerDesc = "只见一位窈窕女子跪坐于蒲团上，双手合十似在念经，又似在许愿。",

			npcs = {
				{
					npcName = "周宛亦",
					desc = "约莫十七八岁，淡、雅、清、秀、灵、仙，绝美如芙蓉出世、天人下凡。",
					[1] = {
						talks = {
							{npc = "周姐姐，周姐姐。",npcName="邵灵儿"},
							{npc = "灵儿，你们怎么进来的？",npcName="周宛亦"},
							{npc = "瞧你一天天魂不守舍的，我才放他们进来的。",npcName="苦庵师太"},
							{npc = "谢谢师叔，可是师傅不答应，谁都改变不了她的主意的。",player = "别着急，只要你心意已定，就一定有办法的。",npcName="周宛亦"},
							{npc = "我想好了，一定要和你们一起，去游历这山外山、天外天。",player = "那就好，明日再去试试。",npcName="周宛亦"},
							{npc = "嘻嘻，到时候我们说得感天动地的，还怕你师傅她老人家不同意么？",npcName="邵灵儿"},
							{npc = "嗯嗯，好哦！",npcName="周宛亦"},
						},
						next = 6,
					},
					
					[6] = {
						res = {
							tags = {113300},
						},
					},
				},
			},
		},
	}
}

return scene_013301
