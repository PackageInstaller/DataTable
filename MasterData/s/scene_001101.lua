
-- tags
-- 100101:格子5剧情触发完
-- 100102:格子5剧情触发完,格子5父亲、卫峰隐藏所需tag
-- 100103:选完兵器
-- 100104:格子9打完架
-- 100105:父亲告知卧房有爷爷的东西留给我

-- 100100:关卡结束

-- 10112:选了拳
-- 10113:选了刀
-- 10114:选了剑
-- 10115:选了棍
-- 10116:选了鞭


local grid5NonTrigger = {
	conditions = {
		noTags = {100101},
	},

	[1] = {
		talks = {
			{player = "父亲，卫叔来了，您都不叫我。"},
			{npc = "瞧这一头汗，成何体统！", player = "卫叔好！您今天一定要教我两招。",npcName="父亲"},
			{npc = "哈哈哈，几年不见，长高了许多啊。",npcName="卫峰"},
			{npc = "卫兄见笑了，这孩子无心念书，成天舞枪弄棒的。",npcName="父亲"},
			{npc = "哈哈哈，瞧这精气神，练武的好料子啊！",npcName="卫峰"},
			{player = "父亲，卫叔都夸孩儿呢，恳请父亲应允孩儿出门拜师。"},
			{npc = "哈哈哈，有志气！那就和我这弟子切磋一下吧，要是胜了，你父亲也就放心了。", npcName="卫峰"},
			{npc = "罢了罢了，你长大了，为父也不勉强你，去<color=#ff0000>后院</color>选一件趁手的兵器吧，今后行走江湖总不能赤手空拳。",npcName="父亲"},
		},
		next = 3,
	},

	[3] = {
		res = {
			tags = {100101},
		},
	},
}

-- 格子5触发完，准备打架
local grid9NonTrigger = {
	[1] = {
		conditions = {
			tags = {100103},
			noTags = {100104},
		},
		talks = {
			{npc = "只是切磋，点到为止啊！",npcName="父亲"},
			{npc = "哈哈哈，有我在一旁护着，无需担心，各自施展本领吧。",player="父亲放心，孩儿知道。",npcName="卫峰"},

		},
		next = 5,
	},
	[2] = {
		conditions = {
			noTags = {100103},
		},
		talks = {
			{npc = "先去选件兵器吧。"},
		},
	},
	[3] = {
		next = {2},
	},
	
	[5] = {
		battle = {
			friends = { 
				-- conditions-- 约定-1为玩家所在位置
				-- { index = 4, id = xxx }, -- 
			},

			enemies = {
				{ index = 5, id = 1401101, level = 1 },
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
			tags = {100104},
		},
		next = 7,
	},

	[7] = {
		talks = {
			{player = "父亲，孩儿胜了！"},
			{npc = "难道你未看出那个小兄弟谦让你吗？", player = "胜了便是胜了，父亲可不能反悔！",npcName="父亲"},
			{player = "孩儿拜别父亲，这就启程出发啦。"},
			{npc = "果然还是和爷爷做出了一样的决定吗？", player = "我爷爷是武林高手吗？",npcName="父亲"},
			{npc = "嗯，爷爷的事，等你学武有成游历江湖之时便会知晓。",npcName="父亲"},
			{npc = "现在去卧房取出你爷爷留给你的东西吧。",player="爷爷还有东西留给我吗？是不是武功秘籍啊！哈哈哈！",npcName="父亲"},
			{npc = "<color=#ff0000>在客厅右侧卧室的柜子中</color>，你看了便知，看完后便回到后院来找我。",npcName="父亲"},
		},
	},
}

-- 格子9几个人可见的条件
local grid9VisibleCon = {
	tags = {100101},
}

-- 格子5父亲、卫峰可见条件
local grid5VisibleCon = {
	noTags = {100102},
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
			tags = {100100},
		}
	},
	[31] = {
		res = {
			job = JobType.HuaShan,
			tags = {100100},
		}
	},
	[32] = {
		res = {
			job = JobType.XueDao,
			tags = {100100},
		}
	},
	[33] = {
		res = {
			job = JobType.GaiBang,
			tags = {100100},
		}
	},
	[34] = {
		res = {
			job = JobType.GuMu,
			tags = {100100},
		}
	},
	[35] = {
		res = {
			job = JobType.HengShan,
			tags = {100100},
		}
	},
}


local fatherDesc = "一身玄色云纹长衫，松风竹韵，气息内敛，面目儒雅端方，举止气度不凡。"
local weifengDesc = "虎背熊腰，声如洪钟，紫红脸膛上，太阳穴鼓鼓的，一看便知硬功了得。"

local scene_001101 = {
	name = "序章",
	enter = {1101,1001},
	id = 1101,

	points = {
		[1001] = {
			name = "大门",
			pos = {-12,-58},
			grids = {[1]=1002,},
			desc = "一座古朴雅致的院落，青瓦粉墙、白石台叽，藤蔓间透着书香世家的清贵。",
			triggerDesc = "门童踩着梯子，擦拭云纹透雕的黑底匾额“耕读轩”。",

			npcs = {
				{
					npcName = "门童",
					desc = "十来岁的小男孩，干净利落，弯眉笑眼。",
					[1] = {
						npc = "{sex:001}，还想着学武啊？老爷说要把你关在房里背书呢。",
						player = "哼哼！闯荡江湖是我的梦想，我这就去求父亲。",
					}
				}
			},
		},

		[1002] = {
			name = "长廊",
			pos = {-12,46},
			grids = {[2]=1001,[4]=1003,[1]=1004,},
			desc = "长廊十分幽雅，青砖白墙，云纹廊窗，窗外绿竹疏桐，窗内光影摇曳。",
			triggerDesc = "丫鬟端着一杯香茶，朝花园走去。",

			npcs = {
				{
					npcName = "丫鬟",
					desc = "自小被夫人收留，身量纤细，眉清目秀。",
					[1] = {
						npc = "{sex:001}，夫人在赏花呢，蕙兰开啦，好香好美啊。",
						player = "哎……母亲每日赏心乐事，却不让我做自己喜欢的，气死我了!",
					}
				}
			},
		},

		[1003] = {
			name = "花园",
			pos = {221,46},
			grids = {[3]=1002,},
			desc = "翠竹掩映，曲径通幽，花园里的一池一亭一石一木，皆错落有致、清心悦目。",
			triggerDesc = "母亲倚栏赏花。",

			npcs = {
				{
					npcName = "母亲",
					desc = "一身素色长裙，白缎坎肩云纹饰边，一眼望去知书达理、温婉可亲。",
					[1] = {
						player = "母亲，孩儿要拜师习武，您就帮我向父亲求求情吧！",
						next = 2,
					},
					[2] = {
						npc = "哎……都十四了，还这样顽皮。今儿的诗文作了么？",
						player = "母亲，您明明知道我不喜欢读书的，我要闯荡江湖行侠仗义！",
						next = 3,
					},
					[3] = {
						npc = "又说傻话了，让你父亲知道，可又要罚你了。",
					},
				}
			},
		},

		[1004] = {
			name = "长廊",
			pos = {-12,150},
			grids = {[2]=1002,[1]=1005,},
			desc = "长廊十分幽雅，青砖白墙，云纹廊窗，窗外绿竹疏桐，窗内光影摇曳。",
			triggerDesc = "黎管家乐呵呵的走来。",

			npcs = {
				{
					npcName = "黎管家",
					desc = "黎管家似这院落一般古朴，又似这院墙藤蔓一般的强韧，白须白发、满脸皱纹，不经意间眼底有一丝精光闪过。",
					[1] = {
						npc = "{sex:001}，快去<color=#ff0000>客厅</color>吧，龙拳帮卫香主来啦，你不是闹着拜师学艺嘛，这可是好机会啊。",
						player = "真的啊？太好了！黎爷爷，我这就去。",
					},
				}
			},
		},

		[1005] = {
			name = "客厅",
			pos = {-12,254},
			grids = {[2]=1004,[4]=1008,[1]=1009,},
			desc = "客厅格局周正、陈设疏朗，一幅中堂大气磅礴、两侧条幅行云流水，一看便是出于名家手笔。",
			triggerDesc = "卫香主和父亲相谈甚欢，弟子一旁站立。",

			npcs = {
				{
					npcName = "父亲",
					desc = fatherDesc,
					visibleConditions = grid5VisibleCon,
					[1] = grid5NonTrigger,
					[2] = {
						conditions = {
							tags = {100101},
						},
						[1] = {
							npc = "快去吧。"
						}
					}
				},
				{
					npcName = "龙拳帮卫峰",
					desc = weifengDesc,
					visibleConditions = grid5VisibleCon,
					[1] = grid5NonTrigger,
					[2] = {
						conditions = {
							tags = {100101},
						},
						[1] = {
							npc = "去后院选把兵器吧，就在后院比试。"
						}
					}
				}
			},

			leaveEvents = {
				{
					conditions = {tags = 100101,noTags = {100102}},
					funcType = GE.FuncType.ExeRes,
					res = {
						tags = {100102},
					}
				},
			},
		},



		[1008] = {
			name = "卧房",
			pos = {454,254},
			grids = {[3]=1005,},
			desc = "陈设精致，纱幔低垂，“博山炉中沉香火， 双烟一气凌紫霞”，老爷夫人的卧房一切都那么风雅，除了屏风后的柜子。",

			npcs = {
				{
					npcName = "柜子",
					desc = "乌木柜子朴实无华，细看则隐隐的有古意氤氲、气息森然。",
					[0] = {
						conditions = {noTags = {100105},},
						player = {
							{content = "打开", next = 2},
						}
					},

					[2] = {
						[1] = {
							conditions = {tags = {100104}, noTags = {100105},},
							talks = {
								{npc = "打开柜子，便看到了一颗浑圆的念珠，以及一本小册子。",npcName = "",},
								{npc = "握住珠子的刹那，便感觉有一股真气从珠子中往身上涌动。",lineMsg = "体魄+4 臂力+4 根骨+8 机敏+4 灵巧+6 福源+4 定力+6 胆识+4",npcName = "",},
								{npc = "翻开小册子，亦是白芒一闪，册中文字全然不见，但一颗向武之心却更加坚固。",npcName = "",
								lineMsg = "获得天赋技能（书香门第）：投笔\n当气血低于40%，所有的友方侠客武学冷却降低1回合，仅触发一次。\n" ..
										  "获得天赋技能（书香门第）：风骨\n对体魄低于自身的敌人，造成0.92倍伤害，对体魄高于自身的侠客造成1.12倍伤害。"},
							},
							next = 5,
						},

						[2] = {
							conditions = {noTags = {100104,100105}},
							npc = "柜子似乎锁着，打不开，但隐隐从中透出一丝光芒。"
						},

						[5] = {
							res = {
								tags = {100105},
							}
						},
					},
				},
			}
		},

		[1009] = {
			name = "后院",
			pos = {-12,358},
			grids = {[2]=1005,},
			desc = "后院方方正正，长宽三十余丈，墙边有几株高大的香樟树，郁郁葱葱，树下立着兵器架。",
			triggerDesc = "兵器架上有刀、剑、棍、鞭、拳套。",

			npcs = {
				{
					npcName = "父亲",
					desc = fatherDesc,
					visibleConditions = grid9VisibleCon,
					[1] = grid9NonTrigger,
					[2] = {
						[1] = {
							conditions = {
								tags = {100104},
								noTags = {100105},
							},
							[1] = {
								npc = "<color=#ff0000>东西在客厅右侧卧室的柜子中</color>，看完后便回到后院来找我。",
							},
						},
						[2] = {
							conditions = {	-- 取完东西
								tags = {100105},
							},
							npc = "罢了罢了，请卫兄指教，小儿这资质该拜入哪个门派。"
						},
					}
				},
				{
					npcName = "龙拳帮卫峰",
					desc = weifengDesc,
					visibleConditions = grid9VisibleCon,
					[1] = grid9NonTrigger,
					[2] = {
						[1] = {
							conditions = {
								tags = {100104},
								noTags = {100105},
							},
							[1] = {
								npc = "真是后生可畏啊！",
							}
						},
						[2] = {
							conditions = {
								tags = {100105},
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
											{ content = "古墓派", next = {2,2,1,1,9,9} },
											{ content = "恒山派", next = {2,2,1,1,9,10} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = 5 },
											{ content = "华山派", next = {2,2,1,1,9,6} },
											{ content = "血刀门", next = {2,2,1,1,9,7} },
											{ content = "丐帮", next = {2,2,1,1,9,8} },
											{ content = "古墓派", next = {2,2,1,1,9,9} },
											{ content = "恒山派（仅女子可加入）", next = {2,2,1,1,9,10} },
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
											{ content = "血刀门", next = {2,2,1,2,9,7} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = 5 },
											{ content = "华山派", next = {2,2,1,2,9,6} },
											{ content = "血刀门", next = {2,2,1,2,9,7} },
											{ content = "丐帮", next = {2,2,1,2,9,8} },
											{ content = "古墓派", next = {2,2,1,2,9,9} },
											{ content = "恒山派（仅女子可加入）", next = {2,2,1,2,9,10} },
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
											{ content = "华山派", next = {2,2,1,3,9,6} },
											{ content = "恒山派", next = {2,2,1,3,9,10} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = 5 },
											{ content = "华山派", next = {2,2,1,3,9,6} },
											{ content = "血刀门", next = {2,2,1,3,9,7} },
											{ content = "丐帮", next = {2,2,1,3,9,8} },
											{ content = "古墓派", next = {2,2,1,3,9,9} },
											{ content = "恒山派（仅女子可加入）", next = {2,2,1,3,9,10} },
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
											{ content = "丐帮", next = {2,2,1,4,9,8} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = 5 },
											{ content = "华山派", next = {2,2,1,4,9,6} },
											{ content = "血刀门", next = {2,2,1,4,9,7} },
											{ content = "丐帮", next = {2,2,1,4,9,8} },
											{ content = "古墓派", next = {2,2,1,4,9,9} },
											{ content = "恒山派（仅女子可加入）", next = {2,2,1,4,9,10} },
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
											{ content = "古墓", next = {2,2,1,5,9,9} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = 5 },
											{ content = "华山派", next = {2,2,1,5,9,6} },
											{ content = "血刀门", next = {2,2,1,5,9,7} },
											{ content = "丐帮", next = {2,2,1,5,9,8} },
											{ content = "古墓派", next = {2,2,1,5,9,9} },
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
											{ content = "少林派", next = {2,2,1,6,9,5} },
											{ content = "丐帮", next = {2,2,1,6,9,8} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = {2,2,1,6,9,5} },
											{ content = "华山派", next = {2,2,1,6,9,6} },
											{ content = "血刀门", next = {2,2,1,6,9,7} },
											{ content = "丐帮", next = {2,2,1,6,9,8} },
											{ content = "古墓派", next = {2,2,1,6,9,9} },
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
											{ content = "少林派", next = {2,2,1,7,9,5} },
											{ content = "血刀门", next = {2,2,1,7,9,7} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = {2,2,1,7,9,5} },
											{ content = "华山派", next = {2,2,1,7,9,6} },
											{ content = "血刀门", next = {2,2,1,7,9,7} },
											{ content = "丐帮", next = {2,2,1,7,9,8} },
											{ content = "古墓派", next = {2,2,1,7,9,9} },
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
											{ content = "华山派", next = {2,2,1,8,9,6} },
											{ content = "古墓派", next = {2,2,1,8,9,9} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = {2,2,1,8,9,5} },
											{ content = "华山派", next = {2,2,1,8,9,6} },
											{ content = "血刀门", next = {2,2,1,8,9,7} },
											{ content = "丐帮", next = {2,2,1,8,9,8} },
											{ content = "古墓派", next = {2,2,1,8,9,9} },
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
											{ content = "少林派", next = {2,2,1,9,9,5} },
											{ content = "丐帮", next = {2,2,1,9,9,8} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = {2,2,1,9,9,5} },
											{ content = "华山派", next = {2,2,1,9,9,6} },
											{ content = "血刀门", next = {2,2,1,9,9,7} },
											{ content = "丐帮", next = {2,2,1,9,9,8} },
											{ content = "古墓派", next = {2,2,1,9,9,9} },
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
											{ content = "少林派", next = {2,2,1,1,9,5} },
											{ content = "古墓", next = {2,2,1,1,9,9} },
											{ content = "还想看看其他门派", next = 3 },
										},
									},

									[3] = {
										npc = "这是目前我所知晓的门派，不过有的门派有性别限制",
										player = {
											{ content = "少林派（仅男子可加入）", next = {2,2,1,10,9,5} },
											{ content = "华山派", next = {2,2,1,10,9,6} },
											{ content = "血刀门", next = {2,2,1,10,9,7} },
											{ content = "丐帮", next = {2,2,1,10,9,8} },
											{ content = "古墓派", next = {2,2,1,10,9,9} },
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
					}
				},
				{
					npcName = "龙拳帮弟子",
					desc = "十六七岁的身量，腰背挺得笔直，黝黑的脸庞青涩未退，却装出一副老成的样子",
					visibleConditions = grid9VisibleCon,
					[1] = grid9NonTrigger,
					[2] = {
						conditions = {
							tags = {100104},
						},
						[1] = {
							npc = "厉害厉害！",
						}
					}
				},
				{
					npcName = "兵器架",
					desc = "兵器架上有刀、剑、棍、鞭、拳套。",
					[0] = {
						conditions = {
							tags = {100101},
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

return scene_001101
