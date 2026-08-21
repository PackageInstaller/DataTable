
local chooseToContinue = 
{
	{ content = "消息可以啊！再多告诉我一些消息，这是100两。", next = {7} },
	{ content = "行了。。不再花冤枉钱了" },
}

local tag_grid1003Visible = 10000
local tag_passLevel = 20000

-- 测试用
local scene_511101 = {
	id = 511101,
	name = "卷1章1场景1",
	enter = {511101,1001},

	points = {
		[1030] = {
			name = "底层",
			desc = "底层描述1",
			triggerDesc = "底层触发格子描述",
			grids = {[1]=1001},
		},

		[1001] = {
			name = "道路1",
			desc = "格子描述1",
			triggerDesc = "触发格子描述",
			pos = {-38,-49},
			grids = {[1]=1002,[4]=1003,[3]=1009,[2]=1030},

			-- leaveParts = {
			-- 	{
			-- 		conditions = {ndex={150,185}},
			-- 		failMsg = "不能离开的原因1",	-- 打算离开本格子但是conditions不满足时弹出的信息
			-- 	},
			-- },

			npcs = {
				{
					npcName = "战斗npc",
					desc = "战斗测试xxxxxxxxxxx",
					[1] = {
						conditions = { noTags = {10000,10001} },
						npc = "你没战斗过，战斗要开始了！我是1101012",
						next = 5,
					},
					[2] = {
						conditions = { tags = {10000} },
						npc = "你刚赢过我，我要翻盘！我是1101012",
						next = 5,
					},
					[3] = {
						conditions = { tags = {10001} },
						npc = "输了还来，有志气！我是1101012",
						next = 5,
					},

					[5] = {

						battle = {
							limitFriendNum = 4,
							friends = {
								-- conditions
								-- { index = 9, id = 1412405, level = 160 },
								-- { index = 5, id = 1412406, level = 160 },
							},
							enemies = {
								{ index = 1, id = 1412407, level = 1 },
								-- { index = 7, id = 1412408, level = 200 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1,
									--next = 8,
								},
							},
							
						},
						
						--battle = {
						--	friends = { 
						--		-- { index = 1, id = -1, fixed = true }, -- 约定-1为玩家所在位置,fixed 表示不能拖动
						--		-- { index = 5, id = 1790010 }, -- 
						--	},
						--
						--	enemies = {
						--		{ index = 4, id = 1411202, level = 1 },
						--		{ index = 5, id = 1411202, level = 1 },
						--	},
						--
						--	-- 禁止上场的id列表，-1代表主角
						--	--banList = {
						--	--	-- -1,10001,
						--	--},
						--
						--	-- 只允许上场的id列表
						--	--limitList = {
						--	--	-- -1,10001,
						--	--},
						--
						--	limitFriendNum = 4,	-- 限制己方的总人数
						--
						--	-- 胜利条件，不设则为id=1
						--	winCond = {
						--		-- {id = 1},	-- 默认选项，击败所有敌人
						--		-- {id = 2, npc = 12345},{id = 2, npc = 54321}, -- 击杀指定敌人
						--		-- {id = 3, round = 4}, -- 4回合内击杀敌人
						--		-- {id = 4, round = 1}, -- 坚持4回合
						--	},
						--	
						--	-- 获胜结果，根据战斗结果产生结果(todo:更多条件)
						--	battleRes = {
						--		-- 平局
						--		[1] = {
						--			conditions = { battleWin = 0, },
						--			-- 奖励
						--			silver = 10,
						--			next = 10,
						--		},
						--		-- 胜利
						--		[2] = {
						--			conditions = { battleWin = 1, },
						--			-- 奖励
						--			silver = 10,
						--			tags = {10000},
						--			equips = {{411101,1}},
						--			items = {{110001,1},{2,1},{5,2},{6,3}},
						--			next = 11,
						--		},
						--		-- 失败
						--		[3] = {
						--			conditions = { battleWin = 2, },
						--			-- 奖励
						--			silver = -10,
						--			tags = {10001},
						--			equips = {{411101,1}},
						--			items = {{110001,1},{2,1},{5,2},{6,3}},
						--			next = 12,
						--		},
						--	},
						--},

						-- next = 8,
					},

					[8] = {
						[1] = {
							conditions = { battleWin = 0, },
							npc = "居然跟我打成平手，武功还行",
							player = "过奖",
							res = {
								levelFinished = -1,
							},
						},

						[2] = {
							conditions = { battleWin = 1, },
							npc = "你赢了。。",
							player = "哈哈哈哈！",
							res = {
								levelFinished = -1,
							},
						},

						[3] = {
							conditions = { battleWin = 2, },
							npc = "输了吧，打的爽不爽？",
							player = "还行",
							res = {
								levelFinished = -1,
							},
						},

						[4] = {
							conditions = { battleWin = nil, },
							npc = "你没发数据过来吧。。",
							player = "好像是。。出bug了。。",
						},
					},

					[10] = {
						conditions = { battleWin = 0, },
						npc = "[10]居然跟我打成平手，武功还行",
						player = "过奖",
					},

					[11] = {
						npc = "[11]你赢了。。",
						player = "哈哈哈哈！",
					},

					[12] = {
						npc = "[12]输了吧，打的爽不爽？",
						player = "还行",
					},

				},
				{
					npcName = "月无影",
					desc = "双眼回盼流波，像是俏丽的青州女子；但又挂着一丝倔犟的波纹，又带着北国女儿的神韵。",
					[1] = {
						talks = {
							{player = "不负所托，我寻到了珠钗。"},
							{npc = "哼，不白拿你东西，我早年的兵器便赠与你吧！",npcName="年轻女子"},
							{npc = "说罢，月无影把一对明黄色的爪状兵器丢与桌上便走了。",npcName=""},
						},
						next = 3,
					},
					[2] = {
						npc = "还没找到珠钗吗？那还不快去找！",
					},
					[3] = {
						res = {
							tags = {111313},
							removeTags = {111312,111311},
							items = {{413271,-1},{431621,1}}
						}
					},
				},
			},
		},

		[1002] = {
			name = "道路1002",
			pos = {-38,55},
			grids = {[2]=1001,[1]=1005,},

			npcs = {
				{
					npcId = 10001,
					npcName = "测试Npc",
					desc = "测试Npc描述xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
					-- triggerDesc = "触发描述",
					-- icon = "222",
					[1] = {
						npc = "这位客官有什么需要的吗？",
						player = {
							{ content = "我想休息一下", next = 2 },
							{ content = "你平时接触的人多，可否告知最近江湖上有什么值得注意的消息吗？", next = 6 },
						},
					},

					[2] = {
						npc = "休息一下需要花费10两，现在安排客房吗？",
						player = {
							{ content = "好的，麻烦你了", next = 3 },
							{ content = "暂时不用了，谢谢" },
						},
					},

					[3] = {
						res = {
							silver = -10,
						},
						-- npcFunc = FuncType.Rest,
					},

					[6] = {
						npc = "从我这打听消息可是要收费的哦，而且不保证不重复，100两一个，舍得花么？",
						player = {
							{ content = "好的，麻烦你了", next = 7 },
							{ content = "那么贵，算了。", next = 8 },
						},
					},

					[7] = {
						res = {
							silver = -100,
						},
						next = 10,
					},

					[8] = {
						lineMsg = "这家伙真坑！"
					},

					[10] = {
						seqType = SequenceType.Random,
						[1] = {
							npc = "终南山还有一个门派很古怪，但是最近裡面冒出了一个女魔头，害了不少人，所以大家都叫她们做『古墓派』！",
							player = chooseToContinue,
						},

						[2] = {
							npc = "进入少林寺需要先行剃度，出家当和尚喔！",
							player = chooseToContinue,
						},

						[3] = {
							npc = "血刀门目前的的掌教是血刀老祖，他是第四代掌教。",
							player = chooseToContinue,
						},

						[4] = {
							npc = "灵鹫宫里面是不准有男子进入的，更不要说加入他们了，去的人往往只是去送死罢了!",
							player = chooseToContinue,
						},
					},
				},
				
				{
					npcId = 10002,
					npcName = "Npc2_talks",

					[1] = {
						talks = {
							{player = "弟子拜见祖师。"},
							{npc = "徒儿怎么有空来看师父啊？有什么事吗", player = "弟子...觉得自己学武已到了一个瓶颈了..."},
							{npc = "喔？且说来听听", player = "弟子自从加入血刀门，每天都不眠不休的勤练师门武艺，在纷纷扰扰与人争强斗狠的江湖旅途中，更是体会认识到基本武学的重要，而加紧督促自己苦练。"},
							{player = "好不容易通过老祖的试炼学到血海魔功，但翻来覆去的修炼下总觉得进展不大，虽然有血海老祖的相助，但还是效果不显。"},
							{player = "弟子实在是不知道该怎么样才好..."},
							{npc = "我问问你，武学有极限吗？", player = "我...我想是有的..."},
							{npc = "徒儿啊！我血刀门的弟子可不能这么没志气！武学是一种自我的超越，如果你战胜不了自己懦弱的心，那么这就是你的极限了！", player = "师父的意思是，一切都看我有没有心去努力吗？"},
							{npc = "小子，你下的苦功还不够吗？得到什么成果没有？", },
							{npc = "学武是一种机缘，为什么有些苦练的人能有所成就，有些人却走火入魔？有时候超越不了自我，不妨就停下脚步顺其自然吧！", },
							{npc = "话虽如此，我知道你这小子也听不进去的...我师兄，也就是血魔老祖，这次带回了血刀失传已久的武功口诀，我这就把口诀传授给你！", },
							{npc = "【腰劲运肩，肩通于臂，臂须无劲，腕须无力........】", },
							{npc = "这些法门你可都记住了？自己好好参详参详，等有所小成，可以找血魔老祖助你修炼", player = "谢谢师父传授武功！"},
						},
						next = 2,
					},
					[2] = {
						res = {
							tags = 13333,
							-- skills = {205, 1},
						}
					}
				},
			},
		},

		[1003] = {
			name = "道路1003",
			pos = {195,-49},
			grids = {[3]=1001,[1]=1004,[4]=1011,},

			-- 走到这个格子会触发的事件
			enterEvents = {
				{
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaHpAll = -30,				-- 所有人血量绝对值改变
						-- deltaMaxHpPercentAll = -10,		-- 所有人血量百分比改变
					}
				},
			},
			-- visibleConditions = {
			-- 	tags = {tag_grid1003Visible}
			-- },
		},

		[1004] = {
			name = "道路1004",
			pos = {195,55},
			grids = {[2]=1003,[1]=1007,},

			npcs = {
				{
					npcName = "龙拳帮香主卫峰",
					desc = "描述",
					[1] = {conditions = {tags = {111111}}},	-- 不可能的条件
					[2] = {
						[1] = {
							conditions = {
								tags = {111112}, -- 不可能的条件
							},
							[1] = {
								npc = "真是后生可畏啊！",
							}
						},
						[2] = {
							[1] = {
								[1] = {
									conditions = {
										tags = {10114}, -- 选了剑
									},
									[1] = {
										npc = "看你选择了铁剑作为兵器，又是女孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "华山派", next = {2,2,1,9,1} },
											{ content = "恒山派", next = {2,2,1,9,2} },
											{ content = "跳到第一层", next = {5} },
											-- { content = "还想看看其他门派", next = 3 },
										},
									},
								},
								[2] = {
									conditions = {
										tags = {10115}, -- 选了棍
									},
									[1] = {
										npc = "看你选择了棍作为兵器，又是女孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "华山派", next = {2,2,1,9,1} },
											{ content = "恒山派", next = {2,2,1,9,2} },
											{ content = "跳到第一层", next = {5} },
											-- { content = "还想看看其他门派", next = 3 },
										},
									},
								},
								[3] = {
									npc = "啥都没有！",
									player = "哦",
								},

								[9] = {
									[1] = {
										npc = "你选了华山派",
										player = "华山！",
									},
									[2] = {
										npc = "你选了恒山派",
										player = "恒山！",
									},
								},
							}
						}
					},
					[5] = {
						npc = "这是第一层 5",
						player = "5!!!!!!!!!!"
					},
				}
			}
		},

		[1005] = {
			name = "道路1005",
			pos = {-38,159},
			grids = {[2]=1002,[6]=1006,[1]=1008,[5]=1015,},

			npcs = {
				{
					npcName = "npc1005",
					desc = "npc1 on 1005",
					[1] = {
						npc = "content1",
						player = "hahahaha",
						next = 2,
					},
					[2] = {
						npc = "content2",
						player = "ddddd",
						res = {
							tags = {12345},
						},
						next = 3,
					},
					[3] = {
						npc = "content3",
						player = "ffffffff",
						res = {
							tags = {12346}
						}
					}
				},
			}
		},

		[1006] = {
			name = "道路1006",
			pos = {195,263},
			grids = {[7]=1005,},

			npcs = {
				{
					npcName = "0索引",
					desc = "0基础选项无嵌套",
					[0] = {
						conditions = {tags = {11111}},
						player = {
							{content = "跳转", next = 2},
						},
					},

					[2] = {
						npc = "从0跳转到了2",
					},
				},
			},
		},

		[1007] = {
			name = "道路1007",
			pos = {195,159},
			grids = {[2]=1004,},

			npcs = {
				{
					npcName = "0索引嵌套",
					desc = "0基础多选项无嵌套",
					[0] = {
						[1] = {
							conditions = {tags = {11111}},
							player = {
								{content = "备选1", next = {2}},
							},
						},
						[2] = {
							conditions = {tags = {11112}},
							player = {
								{content = "备选2", next = {5}},
							},
						},
					},

					[2] = {
						npc = "即将添加tag11112，去掉tag11111",
						player = "哇！！！",
						next = 3,
					},

					[3] = {
						res = {
							tags = {11112},
							removeTags = {11111}
						},
					},

					[5] = {
						npc = "即将添加tag11111，去掉tag11112",
						player = "哦！！！",
						next = 6,
					},

					[6] = {
						res = {
							tags = {11111},
							removeTags = {11112}
						},
					},
				},
			},
		},

		[1008] = {
			name = "道路1008",
			pos = {-38,263},
			grids = {[2]=1005,},

			npcs = {
				{
					npcName = "箱子",
					choice = "查看",
					[1] = {
						npc = "这是一个空箱子",
						res = {
							items = {{2,-1},{110001,-5}}
						}
					},
				},
			},
		},

		[1009] = {
			name = "道路1009",
			pos = {-271,-49},
			grids = {[4]=1001,[3]=1010,[5]=1014,},

			npcs = {
				{
					npcName = "店小二",
					desc = "年岁不大，一双黑亮的眼睛滴溜溜的，十分机灵。",
					[1] = {
						talks = {
							{player = "小二，可有空座？",npc = "xxx"},
							{npc = "今天小店生意好，楼下都满了，烦劳客官去楼上瞧瞧吧，兴许还有空座",npcName="店小二"},
						},
					},
				},
				{
					npcName = "npcFirst",
					[1] = {
						player = "我第一个说话",
						next = 4,
					},

					[4] = {
						res = {tags = {111}}
					}
				},
			},
		},

		[1010] = {
			name = "道路1010",
			pos = {-504,-49},
			grids = {[4]=1009,[3]=1013,},


			npcs = {
				{
					npcName = "npcFirst",
					[1] = {
						-- conditions = {tags = {111}},
						talks = {
							{player = "我第一个说话1"},
							{player = "我第一个说话2"},
						},
						next = 4,
					},

					[4] = {
						res = {tags = {111}}
					}
				},
			},
		},

		[1011] = {
			name = "道路1011",
			pos = {428,-49},
			grids = {[3]=1003,[4]=1012,},

			npcs = {
				{
					npcName = "终结者",
					desc = "在这里获得结束tag",
					[1] = {
						res = {
							tags = {20000},
						}
					}
				}
			}
		},

		[1012] = {
			name = "道路1012",
			pos = {661,-49},
			grids = {[3]=1011,},

			npcs = {
				{
					npcName = "获得角色701020",
					desc = "获得角色701020",
					[1] = {
						res = {
							getChar = {701020},
						}
					}
				}
			}
		},

		[1013] = {
			name = "道路1013",
			pos = {-737,-49},
			grids = {[4]=1010,},

			
			enterEvents = {
				{
					funcType = GE.FuncType.ExeRes,
					res = {
						deltaMaxHpPercentAll = -10,		-- 全体扣血10%(百分比)
					}
				},
			},

			-- name = "暗室",
			-- pos = {-124,357},
			-- id = 1018,
			-- grids = {[4]=1019,},
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
							friends = { 
								{ index = 5, id = -1 }, 
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412601, level = 35 },
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
									levelFinished = -1,
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1,
									next = 6,
								},
							},
						},
					},
					[6] = {
						res = {
							-- tags = {112614},
						},
					},
				},
			},
			-- leaveParts = {
			-- 	{
			-- 		conditions = {tags = {112614}},
			-- 		failMsg = "又是死路，还被杀手堵住了！",	-- 打算离开本格子但是conditions不满足时弹出的信息
			-- 	},
			-- },
		},

		[1014] = {
			name = "道路1014",
			pos = {-504,55},
			grids = {[8]=1009,},

			npcs = {
				{
					npcName = "测试14",
					desc = "测试14描述xxx",
					[1] = {
						-- conditions = {
						-- 	noTags = {111},
						-- },
						npc = "第一句话",
						player = {
							{content = "1111", next = 2,},
							{content = "2222"},
						},
						
					},
					[2] = {
						npc = "第二句话",
						player = {
							{content = "1111"},
							{content = "2222"},
						}
					},
				},
			}
		},

		[1015] = {
			name = "道路15",
			pos = {-271,263},
			grids = {[8]=1005,[5]=1016,},

			npcs = {
				{
					npcName = "测试1015",
					desc = "测试15描述xxx",
					[1] = {
						npc = "给你秘籍",
						player = "哦",
					},

					[2] = {
						items = {{301052,1}}
					},
				},
			},
		},

		[1016] = {
			name = "道路16",
			pos = {-504,367},
			grids = {[8]=1015,},

			enterParts = {
				{
					conditions = {tags = {11111}},
					failMsg = "不能过去的原因",
				},
			},
			leaveParts = {
				{
					conditions = {tags = {11112}},	-- 不可能有的tag
					failMsg = "不能离开的原因",
				},
			},
		},



	}
}

return scene_511101
