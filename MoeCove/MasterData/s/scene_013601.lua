-- tags

-- 113601:格子3战斗
-- 113602:格子6战斗
-- 113603:格子10战斗
-- 113604:格子14战斗
-- 113605:格子16战斗
-- 113606:格子17战斗
-- 113607:格子18战斗
-- 113608:格子21战斗
-- 113609:格子24战斗
-- 113610:格子25战斗
-- 113611:格子27战斗

-- 113612:格子28BOSS战
-- 113613:格子29对话

-- 113600:章节结束


local scene_013601 = {
	name = "序章1",
	id = 13601,
	enter = {13601,1001},

	points = {
		[1001] = {
			name = "大殿",
			pos = {-424,-89},
			id = 1001,
			grids = {[4]=1002,},
			desc = "恢弘的大殿已然一片狼藉，前殿更是桌倒椅翻，处处刀砍剑挑的痕迹。",
			triggerDesc = "紫衫龙王携明教弟子全部赶去追倚天剑了。",

			npcs = {
				{
					npcName = "灭绝师太",
					desc = "只见她约莫四十四五岁年纪，脸如严霜，容貌算得甚美，但两条眉毛斜斜下垂，一副面相变得极是严厉。",
					[1] = {
						npc = "快追倚天剑！",
					},
				},
				{
					npcName = "静虚",
					desc = "面色清冷如峨眉月，一身白衣似峨眉雪，右肩露出青色的剑鞘。",
					[1] = {
						npc = "看样子飞往祠堂方向了。",
					},
				},
				{
					npcName = "峨眉弟子",
					desc = "面色清冷如峨眉月，一身白衣似峨眉雪，右肩露出青色的剑鞘。",
					[1] = {
						npc = "倚天剑飞到哪里去了？",
					},
				},
			},		
		},

		[1002] = {
			name = "后山小路",
			pos = {-191,-89},
			id = 1002,
			grids = {[3]=1001,[4]=1003,[1]=1006,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",

		},

		[1003] = {
			name = "后山小路",
			pos = {42,-89},
			id = 1003,
			grids = {[3]=1002,[4]=1004,[1]=1007,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
			triggerDesc = "一块巨石堵住了道路，巨石上站着几个明教弟子。",

			npcs = {
				{
					npcName = "巨岩",
					desc = "这个巨大的岩石上竟然还长出了尖刺。",
					visibleConditions = {noTags = {113601}},
					[1] = {
						
						talks = {
							{player = "哪里来的石头？"},
							{npc = "久闻明教五行旗掌控金木水火土的力量，竟然能凭空造出巨岩。",npcName = "田伯光"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 

							},
							enemies = {
								{ index = 1, id = 1413601, level = 200 },
								{ index = 4, id = 1413601, level = 200 },
								{ index = 7, id = 1413601, level = 200 },
								{ index = 5, id = 1413602, level = 200 },
								{ index = 3, id = 1413602, level = 200 },
								{ index = 9, id = 1413602, level = 200 },
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
							tags = {113601},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113601}},
					failMsg = "被巨石挡住了去路",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1004] = {
			name = "后山小路",
			pos = {275,-89},
			id = 1004,
			grids = {[3]=1003,[4]=1005,[1]=1008,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
		},

		[1005] = {
			name = "后山小路",
			pos = {508,-89},
			id = 1005,
			grids = {[3]=1004,[1]=1009,[6]=1010,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
		},

		[1006] = {
			name = "后山小路",
			pos = {-191,15},
			id = 1006,
			grids = {[2]=1002,[1]=1011,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
			triggerDesc = "一块巨石堵住了道路，巨石上站着几个明教弟子。",

			npcs = {
				{
					npcName = "巨岩",
					desc = "这个巨大的岩石上竟然还长出了尖刺。",
					visibleConditions = {noTags = {113602}},
					[1] = {
						
						talks = {
							{player = "哪里来的石头？"},
							{npc = "久闻明教五行旗掌控金木水火土的力量，竟然能凭空造出巨岩。",npcName = "田伯光"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 

							},
							enemies = {
								{ index = 1, id = 1413601, level = 200 },
								{ index = 4, id = 1413601, level = 200 },
								{ index = 7, id = 1413601, level = 200 },
								{ index = 5, id = 1413602, level = 200 },
								{ index = 3, id = 1413602, level = 200 },
								{ index = 9, id = 1413602, level = 200 },
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
							tags = {113602},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113602}},
					failMsg = "被巨石挡住了去路",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1007] = {
			name = "后山小路",
			pos = {42,15},
			id = 1007,
			grids = {[2]=1003,[1]=1012,[6]=1013,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
		},

		[1008] = {
			name = "后山小路",
			pos = {275,15},
			id = 1008,
			grids = {[2]=1004,[1]=1013,[6]=1014,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
		},

		[1009] = {
			name = "后山小路",
			pos = {508,15},
			id = 1009,
			grids = {[2]=1005,[6]=1015,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
		},

		[1010] = {
			name = "后山小路",
			pos = {741,15},
			id = 1010,
			grids = {[7]=1005,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
			triggerDesc = "一块巨石堵住了道路，巨石上站着几个明教弟子。",

			npcs = {
				{
					npcName = "巨岩",
					desc = "这个巨大的岩石上竟然还长出了尖刺。",
					visibleConditions = {noTags = {113603}},
					[1] = {
						
						talks = {
							{player = "哪里来的石头？"},
							{npc = "久闻明教五行旗掌控金木水火土的力量，竟然能凭空造出巨岩。",npcName = "田伯光"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 

							},
							enemies = {
								{ index = 1, id = 1413601, level = 200 },
								{ index = 4, id = 1413601, level = 200 },
								{ index = 7, id = 1413601, level = 200 },
								{ index = 5, id = 1413602, level = 200 },
								{ index = 3, id = 1413602, level = 200 },
								{ index = 9, id = 1413602, level = 200 },
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
							tags = {113603},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113603}},
					failMsg = "被巨石挡住了去路",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1011] = {
			name = "后山小路",
			pos = {-191,119},
			id = 1011,
			grids = {[2]=1006,[1]=1016,[6]=1017,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
		},

		[1012] = {
			name = "后山小路",
			pos = {42,119},
			id = 1012,
			grids = {[2]=1007,[6]=1018,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
		},

		[1013] = {
			name = "后山小路",
			pos = {275,119},
			id = 1013,
			grids = {[2]=1008,[7]=1007,[6]=1019,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
		},

		[1014] = {
			name = "后山小路",
			pos = {508,119},
			id = 1014,
			grids = {[7]=1008,[6]=1020,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
			triggerDesc = "一块巨石堵住了道路，巨石上站着几个明教弟子。",

			npcs = {
				{
					npcName = "巨岩",
					desc = "这个巨大的岩石上竟然还长出了尖刺。",
					visibleConditions = {noTags = {113604}},
					[1] = {
						
						talks = {
							{player = "哪里来的石头？"},
							{npc = "久闻明教五行旗掌控金木水火土的力量，竟然能凭空造出巨岩。",npcName = "田伯光"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 

							},
							enemies = {
								{ index = 1, id = 1413601, level = 200 },
								{ index = 4, id = 1413601, level = 200 },
								{ index = 7, id = 1413601, level = 200 },
								{ index = 5, id = 1413602, level = 200 },
								{ index = 3, id = 1413602, level = 200 },
								{ index = 9, id = 1413602, level = 200 },
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
							tags = {113604},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113604}},
					failMsg = "被巨石挡住了去路",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1015] = {
			name = "后山小路",
			pos = {741,119},
			id = 1015,
			grids = {[7]=1009,[6]=1021,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
		},

		[1016] = {
			name = "后山小路",
			pos = {-191,223},
			id = 1016,
			grids = {[2]=1011,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
			triggerDesc = "一块巨石堵住了道路，巨石上站着几个明教弟子。",

			npcs = {
				{
					npcName = "巨岩",
					desc = "这个巨大的岩石上竟然还长出了尖刺。",
					visibleConditions = {noTags = {113605}},
					[1] = {
						
						talks = {
							{player = "哪里来的石头？"},
							{npc = "久闻明教五行旗掌控金木水火土的力量，竟然能凭空造出巨岩。",npcName = "田伯光"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 

							},
							enemies = {
								{ index = 1, id = 1413601, level = 200 },
								{ index = 4, id = 1413601, level = 200 },
								{ index = 7, id = 1413601, level = 200 },
								{ index = 5, id = 1413602, level = 200 },
								{ index = 3, id = 1413602, level = 200 },
								{ index = 9, id = 1413602, level = 200 },
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
							tags = {113605},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113605}},
					failMsg = "被巨石挡住了去路",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1017] = {
			name = "后山小路",
			pos = {42,223},
			id = 1017,
			grids = {[7]=1011,[6]=1022,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
			triggerDesc = "一块巨石堵住了道路，巨石上站着几个明教弟子。",

			npcs = {
				{
					npcName = "巨岩",
					desc = "这个巨大的岩石上竟然还长出了尖刺。",
					visibleConditions = {noTags = {113606}},
					[1] = {
						
						talks = {
							{player = "哪里来的石头？"},
							{npc = "久闻明教五行旗掌控金木水火土的力量，竟然能凭空造出巨岩。",npcName = "田伯光"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 

							},
							enemies = {
								{ index = 1, id = 1413601, level = 200 },
								{ index = 4, id = 1413601, level = 200 },
								{ index = 7, id = 1413601, level = 200 },
								{ index = 5, id = 1413602, level = 200 },
								{ index = 3, id = 1413602, level = 200 },
								{ index = 9, id = 1413602, level = 200 },
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
							tags = {113606},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113606}},
					failMsg = "被巨石挡住了去路",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1018] = {
			name = "后山小路",
			pos = {275,223},
			id = 1018,
			grids = {[7]=1012,[6]=1023,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
			triggerDesc = "一块巨石堵住了道路，巨石上站着几个明教弟子。",

			npcs = {
				{
					npcName = "巨岩",
					desc = "这个巨大的岩石上竟然还长出了尖刺。",
					visibleConditions = {noTags = {113607}},
					[1] = {
						
						talks = {
							{player = "哪里来的石头？"},
							{npc = "久闻明教五行旗掌控金木水火土的力量，竟然能凭空造出巨岩。",npcName = "田伯光"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 

							},
							enemies = {
								{ index = 1, id = 1413601, level = 200 },
								{ index = 4, id = 1413601, level = 200 },
								{ index = 7, id = 1413601, level = 200 },
								{ index = 5, id = 1413602, level = 200 },
								{ index = 3, id = 1413602, level = 200 },
								{ index = 9, id = 1413602, level = 200 },
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
							tags = {113607},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113607}},
					failMsg = "被巨石挡住了去路",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1019] = {
			name = "后山小路",
			pos = {508,223},
			id = 1019,
			grids = {[7]=1013,[6]=1024,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
		},

		[1020] = {
			name = "后山小路",
			pos = {741,223},
			id = 1020,
			grids = {[7]=1014,[6]=1025,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
		},

		[1021] = {
			name = "后山小路",
			pos = {974,223},
			id = 1021,
			grids = {[7]=1015,[1]=1025},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
			triggerDesc = "一块巨石堵住了道路，巨石上站着几个明教弟子。",

			npcs = {
				{
					npcName = "巨岩",
					desc = "这个巨大的岩石上竟然还长出了尖刺。",
					visibleConditions = {noTags = {113608}},
					[1] = {
						
						talks = {
							{player = "哪里来的石头？"},
							{npc = "久闻明教五行旗掌控金木水火土的力量，竟然能凭空造出巨岩。",npcName = "田伯光"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 

							},
							enemies = {
								{ index = 1, id = 1413601, level = 200 },
								{ index = 4, id = 1413601, level = 200 },
								{ index = 7, id = 1413601, level = 200 },
								{ index = 5, id = 1413602, level = 200 },
								{ index = 3, id = 1413602, level = 200 },
								{ index = 9, id = 1413602, level = 200 },
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
							tags = {113608},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113608}},
					failMsg = "被巨石挡住了去路",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1022] = {
			name = "后山小路",
			pos = {275,327},
			id = 1022,
			grids = {[7]=1017,[6]=1026,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
		},

		[1023] = {
			name = "后山小路",
			pos = {508,327},
			id = 1023,
			grids = {[7]=1018,[6]=1027,[1]=1026,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
		},

		[1024] = {
			name = "后山小路",
			pos = {741,327},
			id = 1024,
			grids = {[7]=1019,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
			triggerDesc = "一块巨石堵住了道路，巨石上站着几个明教弟子。",

			npcs = {
				{
					npcName = "巨岩",
					desc = "这个巨大的岩石上竟然还长出了尖刺。",
					visibleConditions = {noTags = {113609}},
					[1] = {
						
						talks = {
							{player = "哪里来的石头？"},
							{npc = "久闻明教五行旗掌控金木水火土的力量，竟然能凭空造出巨岩。",npcName = "田伯光"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 

							},
							enemies = {
								{ index = 1, id = 1413601, level = 200 },
								{ index = 4, id = 1413601, level = 200 },
								{ index = 7, id = 1413601, level = 200 },
								{ index = 5, id = 1413602, level = 200 },
								{ index = 3, id = 1413602, level = 200 },
								{ index = 9, id = 1413602, level = 200 },
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
							tags = {113609},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113609}},
					failMsg = "被巨石挡住了去路",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1025] = {
			name = "后山小路",
			pos = {974,327},
			id = 1025,
			grids = {[7]=1020,[5]=1027,[2]=1021,[1]=1028},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
			triggerDesc = "一块巨石堵住了道路，巨石上站着几个明教弟子。",

			npcs = {
				{
					npcName = "巨岩",
					desc = "这个巨大的岩石上竟然还长出了尖刺。",
					visibleConditions = {noTags = {113610}},
					[1] = {
						
						talks = {
							{player = "哪里来的石头？"},
							{npc = "久闻明教五行旗掌控金木水火土的力量，竟然能凭空造出巨岩。",npcName = "田伯光"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 

							},
							enemies = {
								{ index = 1, id = 1413601, level = 200 },
								{ index = 4, id = 1413601, level = 200 },
								{ index = 7, id = 1413601, level = 200 },
								{ index = 5, id = 1413602, level = 200 },
								{ index = 3, id = 1413602, level = 200 },
								{ index = 9, id = 1413602, level = 200 },
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
							tags = {113610},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113610}},
					failMsg = "被巨石挡住了去路",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1026] = {
			name = "后山小路",
			pos = {508,431},
			id = 1026,
			grids = {[7]=1022,[4]=1027,[2]=1023,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
		},

		[1027] = {
			name = "后山小路",
			pos = {741,431},
			id = 1027,
			grids = {[7]=1023,[8]=1025,[3]=1026,},
			desc = "就如这突如其来的腥风血雨一般，老天也突然下起了暴雨，峨眉后山的小路满是泥泞。",
			triggerDesc = "一块巨石堵住了道路，巨石上站着几个明教弟子。",

			npcs = {
				{
					npcName = "巨岩",
					desc = "这个巨大的岩石上竟然还长出了尖刺。",
					visibleConditions = {noTags = {113611}},
					[1] = {
						
						talks = {
							{player = "哪里来的石头？"},
							{npc = "久闻明教五行旗掌控金木水火土的力量，竟然能凭空造出巨岩。",npcName = "田伯光"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 

							},
							enemies = {
								{ index = 1, id = 1413601, level = 200 },
								{ index = 4, id = 1413601, level = 200 },
								{ index = 7, id = 1413601, level = 200 },
								{ index = 5, id = 1413602, level = 200 },
								{ index = 3, id = 1413602, level = 200 },
								{ index = 9, id = 1413602, level = 200 },
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
							tags = {113611},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113611}},
					failMsg = "被巨石挡住了去路",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1028] = {
			name = "祠堂前厅",
			pos = {974,431},
			id = 1028,
			grids = {[1]=1029,[2]=1025},
			desc = "小路的尽头有一个小小的院落，利剑破空的声音不断的传来。",
			triggerDesc = "一块巨石堵住了祠堂门口，巨石上站着一位紫衣的年轻女子。",

			npcs = {
				{
					npcName = "殷悠悠",
					desc = "淡紫色的面纱遮住了下半边的脸庞，但外露的双眼阴狠凌厉。",
					visibleConditions = {noTags = {113612}},
					[1] = {
						
						talks = {
							{player = "又是你，还要挡路吗？"},
							{npc = "哼，这次定要击败你。",npcName = "殷悠悠"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 

							},
							enemies = {
								{ index = 1, id = 1413601, level = 200 },
								{ index = 4, id = 1413601, level = 200 },
								{ index = 7, id = 1413601, level = 200 },
								{ index = 5, id = 1413603, level = 300 },
								{ index = 3, id = 1413602, level = 200 },
								{ index = 9, id = 1413602, level = 200 },
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
							tags = {113612},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113612}},
					failMsg = "被巨石挡住了去路",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1029] = {
			name = "祠堂",
			pos = {974,535},
			id = 1029,
			grids = {[2]=1028,},
			desc = "祠堂古意盎然，隐隐的透出点点烛光，虽蓬户柴门却让人生畏止步。",
			triggerDesc = "周宛亦扶着苦庵师太，倚天剑竟然在苦庵师太周身盘旋。",

			npcs = {
				{
					npcName = "紫衫龙王",
					desc = "是碧水潭畔的凌波仙子，也是明教圣女紫衫龙王，来如流水兮逝似风，不知何来兮何所终。",
					visibleConditions = {noTags = {113613}},
					[1] = {
						
						talks = {
							{npc = "苦庵上人双手急速的变化姿势，像是在掐着剑诀，倚天剑凌空飞舞。",npcName = ""},
							{npc = "只见紫衫龙王身轻如燕，随风而动，腾挪间击出道道掌风。",npcName = ""},
							{npc = "倚天剑化为一抹白光，穿梭间，威力巨大的掌力被撕的粉碎。",npcName = ""},
							{npc = "任紫衣女子如何趋近闪躲，仍然摆脱不了倚天剑的追击。",npcName = ""},
							{npc = "峨眉竟然还有能以心意驾驭倚天剑的高人，佩服！",npcName = "紫衫龙王"},
							{npc = "走吧，施主此来并未残害我门中弟子，故我就不留你了。",npcName = "苦庵上人"},
							{npc = "（望了一眼被剑气撕裂的左袖）我们走！",npcName = "紫衫龙王"},
							{npc = "师姐，你的身体如何？",npcName = "灭绝师太"},
							{npc = "先仔细查看一下吧，是否还有魔教妖人藏匿，门中弟子可都安好？其他的稍后再议。",npcName = "苦庵上人"},
						},
						next = 5,
					},
					[5] = {
						res = {
							tags = {113613,113600},
						},
					},
				},
			},
		},
	}
}

return scene_013601
