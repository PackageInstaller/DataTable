-- tags
-- 100301:和店小二说完话
-- 100302:和乞丐说完话
-- 100303:和格子5的伙计说完话
-- 100304:不可见伙计，格子5
-- 100305:和格子7的伙计说完话
-- 100306:不可见伙计，道士，和尚，格子7
-- 100103:选完兵器
-- 100308:战斗结束
-- 100309:拿到道具

-- 100300:关卡结束

-- 10112:选了拳
-- 10113:选了刀
-- 10114:选了剑
-- 10115:选了棍
-- 10116:选了鞭

-- 不可见伙计，道士，和尚，格子7

local Juqing1 = {
	[1] = {
		talks = {
			{npc = "臭{sex:014}，跑得倒是麻溜，看我不揍扁你！",player = "大叔，对不起对不起……我实在饿了。",npcName="伙计"},
			{npc = "阿弥陀佛，就一个包子嘛，打人多不好，对吧？臭道士？",npcName="胖和尚"},
			{npc = "臭和尚，你说得对，就一个包子嘛，打人多不好。",npcName="瘦道士"},
			{npc = "看在两位出家人的份上……不行，不能这么算了，臭{sex:014}，我今天一定要教训你！",player = "大叔，那个……你打不过我的。",npcName="伙计"},
			{npc = "哈！好大的口气，我倒要见识一下，喏，去那个<color=#ff0000>空宅子</color>，比划比划吧!",npcName="伙计"},
		},
		next = 2,
	},
	[2] = {
		res = {
			tags = {100305},
		},
	}
}
local Juqing2 = {
	conditions = {
		tags = {100103},
		noTags = 100308,
	},
	[1] = {
		talks = {
			{npc = "这{sex:014}跑起来像蚂蚱似的，臭道士，打完了他得归我。",npcName="胖和尚"},
			{npc = "臭和尚，这么好的根骨，不跟我，跟你这胖木鱼不是浪费了。",npcName="瘦道士"},
			{npc = "别说我没提醒你啊，我这把力气，面可不是白揉的！",player = "哎……好吧！",npcName="伙计"},
		},
		next = 4,
	},
	[4] = {
		battle = {
			friends = { 
				-- conditions-- 约定-1为玩家所在位置
				-- { index = 4, id = xxx }, -- 
			},
			enemies = {
				{ index = 5, id = 1401301, level = 1 },
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
				},
			},
		},

		next = 6,
	},

	[6] = {
		res = {
			tags = {100308},
		},
	},
}
local Juqing3 = {
	conditions = {tags = {100308},noTags = {100309}},
	[1] = {
		talks = {
			{player = "不好意思，我胜了！"},
			{npc = "没想到你这臭{sex:014}还真有两下，我认输，包子送你了。",npcName="伙计"},
			{player = "谢谢大叔！"},
			{npc = "小朋友，我是这道上最能打的高僧大德，你不是要拜师嘛，跟我走吧，能练武能吃肉。",npcName="胖和尚"},
			{npc = "小朋友，我是江湖中最有名的侠义道士，你不是要学武嘛，跟我走吧，能行侠能喝酒。",npcName="瘦道士"},
			{player = "我想学武！"},
			{npc = "那便去<color=#ff0000>巷子口的那个老树</color>那里寻找一下吧，有你需要的东西。",npcName="胖和尚"},
		},
	},
}

local common_chooseJob = {
	[5] = {
		npc = "少林派有七十二项绝技，兼拳、棍、鞭、刀之所长，你确定想要去少林吗？",
		player = {
			{ content = "决定了！", next = 30 },
			{ content = "我再想想。。" },
		},
	},
	[6] = {
		npc = "华山派剑法武学冠绝江湖，你确定想去华山派吗？",
		player = {
			{ content = "决定了！", next = 31 },
			{ content = "我再想想。。" },
		},
	},
	[7] = {
		npc = "血刀门以血炼刀，极重攻伐之术，你确定想去血刀门吗？",
		player = {
			{ content = "决定了！", next = 32 },
			{ content = "我再想想。。" },
		},
	},
	[8] = {
		npc = "丐帮拳法和棍法皆是天下闻名的，且帮众人员众多，你确定想去丐帮吗？",
		player = {
			{ content = "决定了！", next = 33 },
			{ content = "我再想想。。" },
		},
	},
	[9] = {
		npc = "古墓派剑法、鞭法、拳法皆有高深的江湖顶级的武学，你确定想去古墓派吗？",
		player = {
			{ content = "决定了！", next = 34 },
			{ content = "我再想想。。" },
		},
	},
	[10] = {
		npc = "恒山派剑法和医术皆是江湖闻名的，亦是只有女子能够拜师的门派，你确定想去恒山派吗？",
		player = {
			{ content = "决定了！", next = 35 },
			{ content = "我再想想。。" },
		},
	},

	[30] = {
		res = {
			job = JobType.ShaoLin,
			tags = {100300},
		}
	},
	[31] = {
		res = {
			job = JobType.HuaShan,
			tags = {100300},
		}
	},
	[32] = {
		res = {
			job = JobType.XueDao,
			tags = {100300},
		}
	},
	[33] = {
		res = {
			job = JobType.GaiBang,
			tags = {100300},
		}
	},
	[34] = {
		res = {
			job = JobType.GuMu,
			tags = {100300},
		}
	},
	[35] = {
		res = {
			job = JobType.HengShan,
			tags = {100300},
		}
	},
}

local scene_001301 = {
	name = "卷0章1节2",
	id = 1301,
	enter = {1301,1001},

	points = {
		[1001] = {
			name = "街市",
			pos = {0,33},
			id = 1001,
			grids = {[1]=1002,},
			desc = "商户林立的街市熙熙攘攘，有衣着光鲜的闲客，风尘仆仆的行人，还有挑担吆喝的小贩，和破衣烂衫的乞丐。",
		},

		[1002] = {
			name = "酒楼",
			pos = {0,137},
			id = 1002,
			grids = {[2]=1001,[1]=1003,},
			desc = "醉仙楼是最热闹的酒楼，宾客络绎不绝，“一城繁华半城烟，多少世人醉里仙”。",
			triggerDesc = "小二门口迎客，一僧一道临窗而坐，大口吃面。",

			npcs = {
				{
					npcName = "酒楼小二",
					desc = "阅人无数，随时变换着腰背和眉眼的弧度。",
					[1] = {
						talks = {
							{npc = "去去去，哪来的野{sex:014}，别站门口影响生意。",player = "小哥，我走了很远的路，很饿，能不能……",npcName="酒楼小二"},
							{npc = "还啰嗦！再不走，让大黑咬你。",player = "我只是……",npcName="酒楼小二"},
							{npc = "大黑，上！",npcName="酒楼小二"},
						},
						next = 2,
					},
					[2] = {
						res = {
							tags = {100301},
						}
					}
				}
			},
		},

		[1003] = {
			name = "旮旯",
			pos = {0,241},
			id = 1003,
			grids = {[2]=1002,[1]=1004,},
			desc = "一个脏兮兮的犄角旮旯，乞丐占着地儿。",
			triggerDesc = "乞丐挥着棍子赶走恶犬，而后击掌嘲笑。",

			npcs = {
				{
					npcName = "乞丐",
					desc = "蓬头垢面、浑身恶臭，手里的棍子却十分光洁。",
					visibleConditions = {tags = {100301}},
					[1] = {
						talks = {
							{npc = "哈哈哈，傻{sex:014}，瞧你那狼狈样！要个饭都不会，来跟我混吧。",player = "大哥，我虽落魄，但不是……",npcName="乞丐"},
							{npc = "哎呦，在我的地盘上，口气还不小。",player = "我是去拜师习武，路过此地的，多谢大哥替我解围。",npcName="乞丐"},
							{npc = "哦，这样啊……嗨，这打打杀杀的，哪有我逍遥自在啊！",player = "大哥，我身负家仇，当寝苫枕干才能雪恨，后会有期了！",npcName="乞丐"},
						},
						next = 2,
					},
					[2] = {
						res = {
							removeTags = {100301},
							tags = {100302},
						}
					}
				},
			},
		},
		[1004] = {
			name = "街市",
			pos = {0,345},
			id = 1004,
			grids = {[2]=1003,[1]=1005,},
			desc = "商户林立的街市熙熙攘攘，有衣着光鲜的闲客，有风尘仆仆的行人，还有挑担吆喝的小贩，和破衣烂衫的乞丐。",
		},
		[1005] = {
			name = "包子铺",
			pos = {0,449},
			id = 1005,
			grids = {[2]=1004,[3]=1006,},
			desc = "包子铺离街市的热闹处稍远，光顾者也大多是引车卖浆、贩夫走卒。",
			triggerDesc = "笼屉一掀，热气腾腾，香味飘出老远。",

			npcs = {
				{
					npcName = "包子铺伙计",
					desc = "天天揉面团，胳膊像铁棍，拳头像铁锤，手掌像铁饼。",
					visibleConditions = {noTags = {100304}},
					[1] = {
						npc = "嗬！臭{sex:014}，敢抢包子，你给我站住！",
						player = "大叔，我记着您，日后一定还钱",
						npc = "还敢跑！看我不抓住你打断你的腿。",
						next = 2,
							talks = {
								{npc = "抓起一个包子便跑。",npcName=""},
								{npc = "嗬！臭{sex:014}，敢抢包子，你给我站住！", player = "大叔，我记着您，日后一定还钱！",npcName="伙计"},
								{npc = "还敢跑！看我不抓住你打断你的腿。",npcName="伙计"},
							},
					},
					[2] = {
						res = {
							tags = {100303},
							removeTags = {100302},
						},
					}
				}
			},
			leaveEvents = {
				{
					conditions = {tags = 100303,noTags = {100304}},
					funcType = GE.FuncType.ExeRes,
					res = {
						tags = {100304},
					}
				},
			},
			leaveParts = {
				{
					conditions = {tags = 100303},
					failMsg = "太饿了，包子好香啊。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1006] = {
			name = "巷子口",
			pos = {-233,449},
			id = 1006,
			grids = {[4]=1005,[3]=1007,},
			desc = "巷子口有一棵老树，被雷劈开。",
			triggerDesc = "周围十分寂静，却让人感觉生机勃勃。",

			npcs = {
				{
					npcName = "老树",
					desc = "老树枝叶全无，可树身却苍劲虬曲、气息森然，仿佛蕴藉着巨大的能量。",
					[0] = {
						conditions = {noTags = {100309},},
						player = {
							{content = "查看", next = 2},
						}
					},
					[2] = {
						[1] = {
							conditions = {tags = {100308},noTags = {100309},},
							talks = {
								{npc = "手掌触碰到老树的瞬间，一股热浪洗刷了四肢百骸。",lineMsg = "体魄+3 臂力+4 根骨+5 机敏+5 灵巧+5 福源+8 定力+2 胆识+8",npcName = "",},
								{npc = "心头记忆也是突然清晰的浮现，父母的音容笑貌和仇人的邪笑与利刃。",npcName = "",
								lineMsg = "获得天赋技能（流浪乞儿）：无念\n对气血低于30%的对手，造成30%的额外伤害。\n" ..
										  "获得天赋技能（流浪乞儿）：意志\n气血低于50%时，所有己方队友都增加25%速度，持续2回合。"},
							},
							next = 5,
						},
						[2] = {
							conditions = {noTags = {100308,100309}},
							npc = "树里有股奇怪的光芒散溢着。"
						},
	
						[5] = {
							res = {
								tags = {100309},
							}
						},
					},
				}
			},
		},

		[1007] = {
			name = "巷子",
			pos = {-466,449},
			id = 1007,
			grids = {[4]=1006,[3]=1008,},
			desc = "巷子狭窄幽暗，地上的砖石高低不平，两边堆着垃圾和杂物。",
			triggerDesc = "伙计气喘吁吁地追进巷子，一僧一道驻足探头，挤眉弄眼。",

			npcs = {
				{
					npcName = "包子铺伙计",
					desc = "天天揉面团，胳膊像铁棍，拳头像铁锤，手掌像铁饼。",
					visibleConditions = {Tags = {100303},noTags = {100306}},
					[1] = Juqing1,
				},
				{
					npcName = "胖和尚",
					desc = "又矮又胖，像个天天被敲的木鱼。",
					visibleConditions = {Tags = {100303},noTags = {100306}},
					[1] = {
						conditions = {tags = {100305}},
						talks = {
							{npc = "小家伙，你可得下手轻一点。",npcName = "胖和尚",},
							{npc = "什么！难道我还需要小屁孩让我嘛！",npcName = "包子铺伙计",},
						},
					},
					[2] = Juqing1,
				},
				{
					npcName = "瘦道士",
					desc = "又高又瘦，站那儿像戳了根树枝。",
					visibleConditions = {Tags = {100303},noTags = {100306}},
					[1] = {
						conditions = {tags = {100305}},
						talks = {
							{npc = "哈哈哈，有趣有趣。",npcName = "瘦道士",},
						},
					},
					[2] = Juqing1,
				}
			},
			leaveEvents = {
				{
					conditions = {tags = 100305},
					funcType = GE.FuncType.ExeRes,
					res = {
						tags = {100306},
					}
				},
			},
			leaveParts = {
				{
					conditions = {tags = 100305},
					failMsg = "被包子铺伙计挡住了去路。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1008] = {
			name = "空宅子",
			pos = {-699,449},
			id = 1008,
			grids = {[4]=1007,},
			desc = "巷子尽头是一座空宅，门前枯叶层叠，貌似很久没人住了。",
			triggerDesc = "院子里长了荒草，角落里散着竹竿、木棍……",

			npcs = {
				{
					npcName = "包子铺伙计",
					desc = "天天揉面团，胳膊像铁棍，拳头像铁锤，手掌像铁饼。",
					visibleConditions = {Tags = {100305}},
					[1] = Juqing2,
					[2] = Juqing3,
					[3] = {
						[1] = {
							conditions = {
								noTags = {100308},
							},
							npc = "臭{sex:014}，选一件趁手的家伙吧，别说我以大欺小！",
						},
						[2] = {
							conditions = {
								tags = {100308},
							},
							npc = "算你厉害，下次可不许再抢包子了！",
						},
					},
				},
				{
					npcName = "胖和尚",
					desc = "又矮又胖，像个天天被敲的木鱼。",
					visibleConditions = {Tags = {100305}},
					[1] = Juqing2,
					[2] = Juqing3,
					[3] = {
						[1] = {
							conditions = {
								noTags = {100309},
							},
							npc = "观你身形，适合用棍呐，不过还是看你自己喜欢，去选一把趁手的兵器吧！",
						},
						[2] = {
							conditions = {
								tags = {100309},
							},
							[1] = {
								[1] = {
									conditions = {
										tags = {10112}, -- 选了拳
										sex = SexType.Female,
									},
									[1] = {
										npc = "看你选择了铁爪作为兵器，又是女孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "古墓派", next = {3,2,1,1,9,9} },
											{ content = "恒山派", next = {3,2,1,1,9,10} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = 5 },
											{ content = "华山派", next = {3,2,1,1,9,6} },
											{ content = "血刀门", next = {3,2,1,1,9,7} },
											{ content = "丐帮", next = {3,2,1,1,9,8} },
											{ content = "古墓派", next = {3,2,1,1,9,9} },
											{ content = "恒山派（仅女子可加入）", next = {3,2,1,1,9,10} },
										},
									},

									[5] = {
										npc = "该门派不收女弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[2] = {
									conditions = {
										tags = {10113}, -- 选了刀
										sex = SexType.Female,
									},
									[1] = {
										npc = "看你选择了朴刀作为兵器，又是女孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "血刀门", next = {3,2,1,2,9,7} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = 5 },
											{ content = "华山派", next = {3,2,1,2,9,6} },
											{ content = "血刀门", next = {3,2,1,2,9,7} },
											{ content = "丐帮", next = {3,2,1,2,9,8} },
											{ content = "古墓派", next = {3,2,1,2,9,9} },
											{ content = "恒山派（仅女子可加入）", next = {3,2,1,2,9,10} },
										},
									},

									[5] = {
										npc = "该门派不收女弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[3] = {
									conditions = {
										tags = {10114}, -- 选了剑
										sex = SexType.Female,
									},
									[1] = {
										npc = "看你选择了铁剑作为兵器，又是女孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "华山派", next = {3,2,1,3,9,6} },
											{ content = "恒山派", next = {3,2,1,3,9,10} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = 5 },
											{ content = "华山派", next = {3,2,1,3,9,6} },
											{ content = "血刀门", next = {3,2,1,3,9,7} },
											{ content = "丐帮", next = {3,2,1,3,9,8} },
											{ content = "古墓派", next = {3,2,1,3,9,9} },
											{ content = "恒山派（仅女子可加入）", next = {3,2,1,3,9,10} },
										},
									},

									[5] = {
										npc = "该门派不收女弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[4] = {
									conditions = {
										tags = {10115}, -- 选了棍
										sex = SexType.Female,
									},
									[1] = {
										npc = "看你选择了狼牙棒作为兵器，又是女孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "丐帮", next = {3,2,1,4,9,8} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = 5 },
											{ content = "华山派", next = {3,2,1,4,9,6} },
											{ content = "血刀门", next = {3,2,1,4,9,7} },
											{ content = "丐帮", next = {3,2,1,4,9,8} },
											{ content = "古墓派", next = {3,2,1,4,9,9} },
											{ content = "恒山派（仅女子可加入）", next = {3,2,1,4,9,10} },
										},
									},

									[5] = {
										npc = "该门派不收女弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[5] = {
									conditions = {
										tags = {10116}, -- 选了鞭
										sex = SexType.Female,
									},
									[1] = {
										npc = "看你选择了九节鞭作为兵器，又是女孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "古墓", next = {3,2,1,5,9,9} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = 5 },
											{ content = "华山派", next = {3,2,1,5,9,6} },
											{ content = "血刀门", next = {3,2,1,5,9,7} },
											{ content = "丐帮", next = {3,2,1,5,9,8} },
											{ content = "古墓派", next = {3,2,1,5,9,9} },
											{ content = "恒山派（仅女子可加入）", next = {3,2,1,5,9,10} },
										},
									},

									[5] = {
										npc = "该门派不收女弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[6] = {
									conditions = {
										tags = {10112}, -- 选了拳
										sex = SexType.Male,
									},
									[1] = {
										npc = "看你选择了铁爪作为兵器，又是男孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "少林派", next = {3,2,1,6,9,5} },
											{ content = "丐帮", next = {3,2,1,6,9,8} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = {3,2,1,6,9,5} },
											{ content = "华山派", next = {3,2,1,6,9,6} },
											{ content = "血刀门", next = {3,2,1,6,9,7} },
											{ content = "丐帮", next = {3,2,1,6,9,8} },
											{ content = "古墓派", next = {3,2,1,6,9,9} },
											{ content = "恒山派（仅女子可加入）", next = 5 },
										},
									},

									[5] = {
										npc = "该门派不收男弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[7] = {
									conditions = {
										tags = {10113}, -- 选了刀
										sex = SexType.Male,
									},
									[1] = {
										npc = "看你选择了朴刀作为兵器，又是男孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "少林派", next = {3,2,1,7,9,5} },
											{ content = "血刀门", next = {3,2,1,7,9,7} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = {3,2,1,7,9,5} },
											{ content = "华山派", next = {3,2,1,7,9,6} },
											{ content = "血刀门", next = {3,2,1,7,9,7} },
											{ content = "丐帮", next = {3,2,1,7,9,8} },
											{ content = "古墓派", next = {3,2,1,7,9,9} },
											{ content = "恒山派（仅女子可加入）", next = 5 },
										},
									},

									[5] = {
										npc = "该门派不收男弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[8] = {
									conditions = {
										tags = {10114}, -- 选了剑
										sex = SexType.Male,
									},
									[1] = {
										npc = "看你选择了铁剑作为兵器，又是男孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "华山派", next = {3,2,1,8,9,6} },
											{ content = "古墓派", next = {3,2,1,8,9,9} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = {3,2,1,8,9,5} },
											{ content = "华山派", next = {3,2,1,8,9,6} },
											{ content = "血刀门", next = {3,2,1,8,9,7} },
											{ content = "丐帮", next = {3,2,1,8,9,8} },
											{ content = "古墓派", next = {3,2,1,8,9,9} },
											{ content = "恒山派（仅女子可加入）", next = 5 },
										},
									},

									[5] = {
										npc = "该门派不收男弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[9] = {
									conditions = {
										tags = {10115}, -- 选了棍
										sex = SexType.Male,
									},
									[1] = {
										npc = "看你选择了狼牙棒作为兵器，又是男孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "少林派", next = {3,2,1,9,9,5} },
											{ content = "丐帮", next = {3,2,1,9,9,8} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = {3,2,1,9,9,5} },
											{ content = "华山派", next = {3,2,1,9,9,6} },
											{ content = "血刀门", next = {3,2,1,9,9,7} },
											{ content = "丐帮", next = {3,2,1,9,9,8} },
											{ content = "古墓派", next = {3,2,1,9,9,9} },
											{ content = "恒山派（仅女子可加入）", next = 5 },
										},
									},

									[5] = {
										npc = "该门派不收男弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[10] = {
									conditions = {
										tags = {10116}, -- 选了鞭
										sex = SexType.Male,
									},
									[1] = {
										npc = "看你选择了九节鞭作为兵器，又是男孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "少林派", next = {3,2,1,1,9,5} },
											{ content = "古墓", next = {3,2,1,1,9,9} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = {3,2,1,10,9,5} },
											{ content = "华山派", next = {3,2,1,10,9,6} },
											{ content = "血刀门", next = {3,2,1,10,9,7} },
											{ content = "丐帮", next = {3,2,1,10,9,8} },
											{ content = "古墓派", next = {3,2,1,10,9,9} },
											{ content = "恒山派（仅女子可加入）", next = 5 },
										},
									},

									[5] = {
										npc = "该门派不收男弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
							},

						},
					},
				},
				{
					npcName = "瘦道士",
					desc = "又高又瘦，站那儿像戳了根树枝。",
					visibleConditions = {Tags = {100305}},
					[1] = Juqing2,
					[2] = Juqing3,
					[3] = {
						[1] = {
							conditions = {
								noTags = {100309},
							},
							npc = "你身法灵动，要不选剑吧！飘逸潇洒！",
						},
						[2] = {
							conditions = {
								tags = {100309},
							},
							[1] = {
								[1] = {
									conditions = {
										tags = {10112}, -- 选了拳
										sex = SexType.Female,
									},
									[1] = {
										npc = "看你选择了铁爪作为兵器，又是女孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "古墓派", next = {3,2,1,1,9,9} },
											{ content = "恒山派", next = {3,2,1,1,9,10} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = 5 },
											{ content = "华山派", next = {3,2,1,1,9,6} },
											{ content = "血刀门", next = {3,2,1,1,9,7} },
											{ content = "丐帮", next = {3,2,1,1,9,8} },
											{ content = "古墓派", next = {3,2,1,1,9,9} },
											{ content = "恒山派（仅女子可加入）", next = {3,2,1,1,9,10} },
										},
									},

									[5] = {
										npc = "该门派不收女弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[2] = {
									conditions = {
										tags = {10113}, -- 选了刀
										sex = SexType.Female,
									},
									[1] = {
										npc = "看你选择了朴刀作为兵器，又是女孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "血刀门", next = {3,2,1,2,9,7} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = 5 },
											{ content = "华山派", next = {3,2,1,2,9,6} },
											{ content = "血刀门", next = {3,2,1,2,9,7} },
											{ content = "丐帮", next = {3,2,1,2,9,8} },
											{ content = "古墓派", next = {3,2,1,2,9,9} },
											{ content = "恒山派（仅女子可加入）", next = {3,2,1,2,9,10} },
										},
									},

									[5] = {
										npc = "该门派不收女弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[3] = {
									conditions = {
										tags = {10114}, -- 选了剑
										sex = SexType.Female,
									},
									[1] = {
										npc = "看你选择了铁剑作为兵器，又是女孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "华山派", next = {3,2,1,3,9,6} },
											{ content = "恒山派", next = {3,2,1,3,9,10} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = 5 },
											{ content = "华山派", next = {3,2,1,3,9,6} },
											{ content = "血刀门", next = {3,2,1,3,9,7} },
											{ content = "丐帮", next = {3,2,1,3,9,8} },
											{ content = "古墓派", next = {3,2,1,3,9,9} },
											{ content = "恒山派（仅女子可加入）", next = {3,2,1,3,9,10} },
										},
									},

									[5] = {
										npc = "该门派不收女弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[4] = {
									conditions = {
										tags = {10115}, -- 选了棍
										sex = SexType.Female,
									},
									[1] = {
										npc = "看你选择了狼牙棒作为兵器，又是女孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "丐帮", next = {3,2,1,4,9,8} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = 5 },
											{ content = "华山派", next = {3,2,1,4,9,6} },
											{ content = "血刀门", next = {3,2,1,4,9,7} },
											{ content = "丐帮", next = {3,2,1,4,9,8} },
											{ content = "古墓派", next = {3,2,1,4,9,9} },
											{ content = "恒山派（仅女子可加入）", next = {3,2,1,4,9,10} },
										},
									},

									[5] = {
										npc = "该门派不收女弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[5] = {
									conditions = {
										tags = {10116}, -- 选了鞭
										sex = SexType.Female,
									},
									[1] = {
										npc = "看你选择了九节鞭作为兵器，又是女孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "古墓", next = {3,2,1,5,9,9} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = 5 },
											{ content = "华山派", next = {3,2,1,5,9,6} },
											{ content = "血刀门", next = {3,2,1,5,9,7} },
											{ content = "丐帮", next = {3,2,1,5,9,8} },
											{ content = "古墓派", next = {3,2,1,5,9,9} },
											{ content = "恒山派（仅女子可加入）", next = {2,2,1,5,9,10} },
										},
									},

									[5] = {
										npc = "该门派不收女弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[6] = {
									conditions = {
										tags = {10112}, -- 选了拳
										sex = SexType.Male,
									},
									[1] = {
										npc = "看你选择了铁爪作为兵器，又是男孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "少林派", next = {3,2,1,6,9,5} },
											{ content = "丐帮", next = {3,2,1,6,9,8} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = {3,2,1,6,9,5} },
											{ content = "华山派", next = {3,2,1,6,9,6} },
											{ content = "血刀门", next = {3,2,1,6,9,7} },
											{ content = "丐帮", next = {3,2,1,6,9,8} },
											{ content = "古墓派", next = {3,2,1,6,9,9} },
											{ content = "恒山派（仅女子可加入）", next = 5 },
										},
									},

									[5] = {
										npc = "该门派不收男弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[7] = {
									conditions = {
										tags = {10113}, -- 选了刀
										sex = SexType.Male,
									},
									[1] = {
										npc = "看你选择了朴刀作为兵器，又是男孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "少林派", next = {3,2,1,7,9,5} },
											{ content = "血刀门", next = {3,2,1,7,9,7} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = {3,2,1,7,9,5} },
											{ content = "华山派", next = {3,2,1,7,9,6} },
											{ content = "血刀门", next = {3,2,1,7,9,7} },
											{ content = "丐帮", next = {3,2,1,7,9,8} },
											{ content = "古墓派", next = {3,2,1,7,9,9} },
											{ content = "恒山派（仅女子可加入）", next = 5 },
										},
									},

									[5] = {
										npc = "该门派不收男弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[8] = {
									conditions = {
										tags = {10114}, -- 选了剑
										sex = SexType.Male,
									},
									[1] = {
										npc = "看你选择了铁剑作为兵器，又是男孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "华山派", next = {3,2,1,8,9,6} },
											{ content = "古墓派", next = {3,2,1,8,9,9} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = {3,2,1,8,9,5} },
											{ content = "华山派", next = {3,2,1,8,9,6} },
											{ content = "血刀门", next = {3,2,1,8,9,7} },
											{ content = "丐帮", next = {3,2,1,8,9,8} },
											{ content = "古墓派", next = {3,2,1,8,9,9} },
											{ content = "恒山派（仅女子可加入）", next = 5 },
										},
									},

									[5] = {
										npc = "该门派不收男弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[9] = {
									conditions = {
										tags = {10115}, -- 选了棍
										sex = SexType.Male,
									},
									[1] = {
										npc = "看你选择了狼牙棒作为兵器，又是男孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "少林派", next = {3,2,1,9,9,5} },
											{ content = "丐帮", next = {3,2,1,9,9,8} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = {3,2,1,9,9,5} },
											{ content = "华山派", next = {3,2,1,9,9,6} },
											{ content = "血刀门", next = {3,2,1,9,9,7} },
											{ content = "丐帮", next = {3,2,1,9,9,8} },
											{ content = "古墓派", next = {3,2,1,9,9,9} },
											{ content = "恒山派（仅女子可加入）", next = 5 },
										},
									},

									[5] = {
										npc = "该门派不收男弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
								[10] = {
									conditions = {
										tags = {10116}, -- 选了鞭
										sex = SexType.Male,
									},
									[1] = {
										npc = "看你选择了九节鞭作为兵器，又是男孩，那便推荐你去这些门派吧。",
										player = {
											{ content = "少林派", next = {3,2,1,1,9,5} },
											{ content = "古墓", next = {3,2,1,1,9,9} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制。",
										player = {
											{ content = "少林派（仅男子可加入）", next = {3,2,1,10,9,5} },
											{ content = "华山派", next = {3,2,1,10,9,6} },
											{ content = "血刀门", next = {3,2,1,10,9,7} },
											{ content = "丐帮", next = {3,2,1,10,9,8} },
											{ content = "古墓派", next = {3,2,1,10,9,9} },
											{ content = "恒山派（仅女子可加入）", next = 5 },
										},
									},

									[5] = {
										npc = "该门派不收男弟子，再看看其他门派。",
										player = "。。好吧，没注意！",
										next = 3,
									},

									[9] = common_chooseJob,
								},
							},

						},
					},
				},
				{
					npcName = "枯草堆",
					desc = "枯草堆上有刀、剑、棍、鞭、拳套。",
					[0] = {
						conditions = {
							tags = {100306},
							noTags = {100103},
						},
						player = {
							{content = "查看", next = 2},
						}
					},
					[2] = {
						[1] = {
							player = {
								{ content = "铁爪", next = 2 },
								{ content = "朴刀", next = 3 },
								{ content = "短剑", next = 4 },
								{ content = "狼牙棒", next = 5 },
								{ content = "九节鞭", next = 6 },
							},
						},

						[2] = {
							res = {
								items = 411591,
								tags = {100103,10112},
							}
						},
						[3] = {
							res = {
								items = 411261,
								tags = {100103,10113},
							}
						},
						[4] = {
							res = {
								items = 411101,
								tags = {100103,10114},
							}
						},
						[5] = {
							res = {
								items = 411421,
								tags = {100103,10115},
							}
						},
						[6] = {
							res = {
								items = 411741,
								tags = {100103,10116},
							}
						},
					},

					-- [2] = {
					-- },
				},
			},
		},
	}
}

return scene_001301
