local scene_063120 = {
	name = "序章1",
	id = 063120,
	enter = {063120,1001},

	points = {
		[1001] = {
			name = "入口",
			pos = {-221,-179},
			id = 1001,
			grids = {[1]=1002,},
			desc = "月映镜湖水，鹤鸣空涧松。真境久寂寥，苍苔掩迷踪……风过，雾散，见入口。",
		},

		[1002] = {
			name = "登云梯",
			pos = {-221,-75},
			id = 1002,
			grids = {[2]=1001,[1]=1004,},
			desc = "雾迷眼，云裹身，风声阵阵。吴刚桂树悬镜中，抬手便可摘星辰。“你别晃啊！”“我没晃！”",
		},

		[1003] = {
			name = "镜室",
			pos = {-454,29},
			id = 1003,
			grids = {[4]=1004,},
			desc = "晶莹剔透的房间，模糊的光晕透出仅能进入一人的小缝隙。最小的镜中阁。",
			npcs = {
				{
					npcName = "镜中人",
					desc = "镜中灰色的身影不断闪动，时而突进时而腾空辗转，似是正在演武。",
					visibleConditions = "visibleConditionsA",
					[1] = {
						talks = {
							{npc = "来战斗吧！",player = "好",npcName="镜中人"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 1,
							-- banList = {
								-- 707010,701010,723010,723020,790030,790040,
							-- },-- 棍
							banList = {
								780030,743020,701020,743010,749010,741010,760020,721010,710010,
							},-- 拳
							-- banList = {
							-- 	770010,745010,780020,790020,720010,760010,
							-- },-- 刀
							-- banList = {
							-- 	705010,705020,749020,725010,706010,703010,
							-- },-- 剑
							-- banList = {
							-- 	780010,724010,790010,724020,741020,
							-- },-- 鞭
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},

							enemies = "EnemyA",
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
						res = "ResA",
					},
				},
			},
		},

		[1004] = {
			name = "长廊",
			pos = {-221,29},
			id = 1004,
			grids = {[2]=1002,[3]=1003,[1]=1006,[4]=1005,},
			desc = "长廊古色古香，曲折蜿蜒、似断似连，与楼阁连为一体。风过，竹声如萧……",
		},

		[1005] = {
			name = "镜中阁",
			pos = {12,29},
			id = 1005,
			grids = {[3]=1004,[1]=1007,},
			desc = "晶莹剔透的房间，模糊的光晕透出仅能进入三人的小缝隙。适中的镜中阁。",
			npcs = {
				{
					npcName = "镜中人",
					desc = "镜中灰色的身影不断闪动，时而突进时而腾空辗转，似是正在演武。",
					visibleConditions = "visibleConditionsC",
					[1] = {
						talks = {
							{npc = "来战斗吧！",player = "好",npcName="镜中人"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 3,
							-- banList = {
								-- 707010,701010,723010,723020,790030,790040,
							-- },-- 棍
							-- banList = {
								-- 780030,743020,701020,743010,749010,741010,760020,721010,710010,
							-- },-- 拳
							banList = {
								770010,745010,780020,790020,720010,760010,
							},-- 刀
							-- banList = {
								-- 705010,705020,749020,725010,706010,703010,
							-- },-- 剑
							-- banList = {
							-- 	780010,724010,790010,724020,741020,
							-- },-- 鞭
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = "EnemyC",
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
						res = "ResC",
					},
				},
			},
		},

		[1006] = {
			name = "小镜阁",
			pos = {-221,133},
			id = 1006,
			grids = {[2]=1004,},
			desc = "晶莹剔透的房间，模糊的光晕透出仅能进入两人的小缝隙。较小的镜中阁。",

			npcs = {
				{
					npcName = "镜中人",
					desc = "镜中灰色的身影不断闪动，时而突进时而腾空辗转，似是正在演武。",
					visibleConditions = "visibleConditionsB",
					[1] = {
						talks = {
							{npc = "来战斗吧！",player = "好",npcName="镜中人"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 2,
							-- banList = {
								-- 707010,701010,723010,723020,790030,790040,
							-- },-- 棍
							-- banList = {
								-- 780030,743020,701020,743010,749010,741010,760020,721010,710010,
							-- },-- 拳
							-- banList = {
							-- 	770010,745010,780020,790020,720010,760010,
							-- },-- 刀
							banList = {
								705010,705020,749020,725010,706010,703010,
							},-- 剑
							-- banList = {
							-- 	780010,724010,790010,724020,741020,
							-- },-- 鞭
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = "EnemyB",
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
						res = "ResB",
					},
				},
			},
		},

		[1007] = {
			name = "长廊",
			pos = {12,133},
			id = 1007,
			grids = {[2]=1005,[4]=1008,[1]=1009,},
			desc = "长廊古色古香，曲折蜿蜒、似断似连，与楼阁连为一体。风过，竹声如萧……",
		},

		[1008] = {
			name = "大镜阁",
			pos = {245,133},
			id = 1008,
			grids = {[3]=1007,},
			desc = "晶莹剔透的房间，模糊的光晕透出仅能进入四人的小缝隙。较大的镜中阁。",

			npcs = {
				{
					npcName = "镜中人",
					desc = "镜中灰色的身影不断闪动，时而突进时而腾空辗转，似是正在演武。",
					visibleConditions = "visibleConditionsD",
					[1] = {
						talks = {
							{npc = "来战斗吧！",player = "好",npcName="镜中人"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 4,
							banList = {
								707010,701010,723010,723020,790030,790040,
							},-- 棍
							-- banList = {
								-- 780030,743020,701020,743010,749010,741010,760020,721010,710010,
							-- },-- 拳
							-- banList = {
								-- 770010,745010,780020,790020,720010,760010,
							-- },-- 刀
							-- banList = {
								-- 705010,705020,749020,725010,706010,703010,
							-- },-- 剑
							-- banList = {
							-- 	780010,724010,790010,724020,741020,
							-- },-- 鞭
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = "EnemyD",
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
						res = "ResD",
					},
				},
			},
		},

		[1009] = {
			name = "登云梯",
			pos = {12,237},
			id = 1009,
			grids = {[2]=1007,[1]=1010,},
			desc = "雾迷眼，云裹身，风声阵阵。吴刚桂树悬镜中，抬手便可摘星辰。“你别晃啊！”“我没晃！”",
		},

		[1010] = {
			name = "石台",
			pos = {12,341},
			id = 1010,
			grids = {[2]=1009,},
			desc = "山间晓露重，石台藤蔓深，谁为扫秋云，残花落晚风。",

			npcs = {
				{
					npcName = "老人",
					desc = "镜中灰色的身影不断闪动，时而突进时而腾空辗转，似是正在演武。",
					visibleConditions = "visibleConditionEnd",
					[1] = {
						talks = {
							{npc = "少侠，恭喜你首次通关了【监德】，这是给你的节玉。",player = "好",npcName="老人"},
						},
						next = 6,
					},
					[6] = {
						res = "FirstRes",
					},
				},
				{
					npcName = "老人",
					desc = "镜中灰色的身影不断闪动，时而突进时而腾空辗转，似是正在演武。",
					visibleConditions = "FirstRes",
					[1] = {
						talks = {
							{npc = "少侠，直接前来拿奖励吧！",player = "好",npcName="老人"},
						},
						next = 6,
					},
					[6] = {
						res = "FinishRes",
					},
				},
			},
		},
	}
}

return scene_063120
