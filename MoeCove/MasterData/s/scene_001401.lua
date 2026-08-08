-- tags
-- 100401:打完架获得
-- 100402:和富家子弟对话
-- 100103:选完兵器
-- 100404:打完架获得,之后不能看见富家子弟
-- 100405:和父亲对话完
-- 100406:拿到了天赋

-- 100400:关卡结束

-- 10112:选了拳
-- 10113:选了刀
-- 10114:选了剑
-- 10115:选了棍
-- 10116:选了鞭

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
			tags = {100400},
		}
	},
	[31] = {
		res = {
			job = JobType.HuaShan,
			tags = {100400},
		}
	},
	[32] = {
		res = {
			job = JobType.XueDao,
			tags = {100400},
		}
	},
	[33] = {
		res = {
			job = JobType.GaiBang,
			tags = {100400},
		}
	},
	[34] = {
		res = {
			job = JobType.GuMu,
			tags = {100400},
		}
	},
	[35] = {
		res = {
			job = JobType.HengShan,
			tags = {100400},
		}
	},
}

local scene_001401 = {
	name = "卷0章1节4",
	id = 1401,
	enter = {1401,1001},

	points = {
		[1001] = {
			name = "山林",
			pos = {93,-54},
			id = 1001,
			grids = {[1]=1002,},
			desc = "蝉噪林愈静，鸟鸣山更幽。",
			triggerDesc = "富家子弟带着一班家奴游山狩猎，打破了山林的幽静。",
		},

		[1002] = {
			name = "山谷",
			pos = {93,50},
			id = 1002,
			grids = {[2]=1001,[1]=1003,},
			desc = "清泉叮咚，穿过嶙峋山石，在谷底缓缓流淌。几只小虾在水里嬉戏，一旁草木葱葱，蝶舞蜂飞。",
			triggerDesc = "一只火狐忽的从草丛中跃起，追赶受惊的野兔。",

			npcs = {
				{
					npcName = "火狐",
					desc = "如一团流光火球在草丛里跳跃，蓬松的长尾，像舞蹈的火焰。",
					visibleConditions = {noTags = {100402}},
					[0] = {
						player = {
							{content = "探查", next = 2},
						}
					},
					[2] = {
						talks = {
							{player = "哇，火狐狸，这可是很少见的，看我的弹弓能不能射到你。"},
							{npc = "噗嗤噗嗤，灵活的避开了。",npcName=""},
						},
					}
				}
			},
		},

		[1003] = {
			name = "山谷",
			pos = {93,154},
			id = 1003,
			grids = {[2]=1002,[1]=1004,},
			desc = "清泉叮咚，穿过嶙峋山石，在谷底缓缓流淌。几只小虾在水里嬉戏，一旁草木葱葱，蝶舞蜂飞。",
			triggerDesc = "噗的一声，火狐被弹弓打中，翻身倒地，刚要跃起踉跄奔逃，又被利箭射中，抽搐几下，再也不动了。",

			npcs = {
				{
					npcName = "富家子弟",
					desc = "一身箭袖轻袍的富家子弟，习得花拳绣腿，却面目骄横，趾高气昂。",
					visibleConditions = {noTags = {100404}},
					[1] = {
						conditions = {tags = 100103},
						talks = {
							{npc = "你可选好了，别输了抵赖！",player = "选好了，来吧，我才不怕你！",npcName="富家子弟"},
						},
						next = 8,
					},
					[2] = {
						talks = {
							{npc = "{sex:014}，你给我放下！火狐是本少爷射中的。",player = "明明是我先打中的，阿爹做的弹弓，最厉害了！",npcName="富家子弟"},
							{npc = "呦呵，敢和本少爷争？不教训你一顿，不知道本少爷的厉害。",player = "你不讲道理，还要仗着人多，欺负我是一个人。",npcName="富家子弟"},
							{npc = "好！那本少爷今天就以理服人、以武服人，单挑吧！",player = "打就打！不过你有兵器，不公平。",npcName="富家子弟"},
							{npc = "小的们，把你们手里的家伙给他使使，必须揍得他心服口服，你向我<color=#ff0000>跟班</color>要件兵器吧！",npcName="富家子弟"},
						},
						next = 3,
					},
					[3] = {
						res = {
							tags = {100402},
						},
					},


					[8] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							
							enemies = {
								{ index = 5, id = 1401401, level = 1 },
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

						next = 9,
					},
					[9] = {
						talks = {
							{npc = "竟敢伤我们少爷，你给我们等着！",npcName="少爷的跟班"},
						},
						next = 10,
					},
					[10] = {
						res = {
							tags = {100401,100404},
						},
					},
				},
				{
					npcName = "跟班",
					desc = "跟在富家子弟身后的几个伙计，看着凶神恶煞的样子便不像是仆人。",
					visibleConditions = {noTags = {100404}},
					[1] = {
						conditions = {
							tags = {100402},
							noTags = {100103}
						},
						talks = {
							{npc = "呐，兵器都在这里，输了可别说我们欺负你！",npcName="少爷的跟班"},
						},
						next = 8,
					},
					[2] = {
						talks = {
							{npc = "竟然和我们少爷抢猎物，我们少爷的师傅可是附近有名的拳法大宗师！",npcName="少爷的跟班"},
						},
					},
					[8] = {
						player = {
							{ content = "铁爪", next = 3 },
							{ content = "朴刀", next = 4 },
							{ content = "短剑", next = 5 },
							{ content = "狼牙棒", next = 6 },
							{ content = "九节鞭", next = 7 },
						},
					},
					[3] = {
						res = {
							items = 411591,
							tags = {100103,10112},
						},
					},
					[4] = {
						res = {
							items = 411261,
							tags = {100103,10113},
						},
					},
					[5] = {
						res = {
							items = 411101,
							tags = {100103,10114},
						},
					},
					[6] = {
						res = {
							items = 411421,
							tags = {100103,10115},
						},
					},
					[7] = {
						res = {
							items = 411741,
							tags = {100103,10116},
						},
					},
				}
			},
		},

		[1004] = {
			name = "山谷",
			pos = {93,258},
			id = 1004,
			grids = {[2]=1003,[3]=1006,},
			desc = "清泉叮咚，穿过嶙峋山石，在谷底缓缓流淌。几只小虾在水里嬉戏，一旁草木葱葱，蝶舞蜂飞。",
			triggerDesc = "富家子弟花拳绣腿，没几个回合就受伤而败，被家奴们手忙脚乱地护送下山。",

			enterParts = {
				{
					conditions = {tags = 100404},
					failMsg = "火狐被富家少爷给射中了。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1006] = {
			name = "木屋",
			pos = {-373,258},
			id = 1006,
			grids = {[4]=1004,[1]=1007,},
			desc = "木屋隐在密林深处，人迹罕至。",
			triggerDesc = "天色已晚，阿爹在木屋前张望，带着一丝焦虑。",

			npcs = {
				{
					npcName = "阿爹",
					desc = "面容沧桑，眼神却坚忍刚毅，身形如松柏般挺拔",
					visibleConditions = {tags = {100401}},
					[1] = {
						talks = {
							{player = "阿爹阿爹，我回来啦，您看，这是什么？"},
							{npc = "呦呦，火狐啊！这可是难得……咦？怎么是箭射中的？",player = "阿爹，事情是这样的……最后失手打伤了他，抢回了火狐。",npcName="阿爹"},
							{npc = "哎，你这孩子，又闯祸！都14岁了，还是这么浮躁，爱逞一时意气",player = "阿爹，不是孩儿的错……",npcName="阿爹"},
							{npc = "罢了，原想明年让你下山拜师的，武艺能精进，也能去一去浮躁气，如今既然这样，现在就去吧。",player = "好吧， 我听阿爹的。",npcName="阿爹"},
							{npc = "现在去<color=#ff0000>山洞</color>吧，你以前一直想去看看，现在可以去了，里面有你母亲留给你的东西。",player = "啊，我现在就去！",npcName=" 阿爹"},
							{npc = "过了山洞就能下山了，我在<color=#ff0000>山脚下</color>等你。",npcName=" 阿爹"},
						},
						next = 2,
					},
					[2] = {
						res = {
							tags = {100405},
							removeTags = 100401,
						},
					},
				},
			},
		},

		[1007] = {
			name = "山洞",
			pos = {-373,362},
			id = 1007,
			grids = {[2]=1006,[1]=1008,},
			desc = "后山，山涧潺潺汩汩，自峭壁而下，喷珠吐玉，经一洞口却泛起团团水雾。",
			triggerDesc = "山洞内静悄悄的没有任何声音。",

			npcs = {
				{
					npcName = "山洞",
					desc = "洞口隐于峭壁山涧，洞内无法窥觊，却掩不住灵气氤氲，不入俗尘。",
					[0] = {
						conditions = {noTags = {100406},},
						player = {
							{content = "探查", next = 2},
						}
					},
					[2] = {
						[1] = {
							conditions = {tags = {100405},noTags = {100406},},
							talks = {
								{npc = "走进洞内，看到一个石台，石台上只有一卷竹简和一根绳子。",npcName = ""},
								{npc = "拿起绳子的时候，掌心灼热了一瞬，然后绳子便不见了。",lineMsg = "体魄+6 臂力+6 根骨+4 机敏+6 灵巧+6 福源+3 定力+3 胆识+6",npcName = "",},
								{npc = "再打开竹简，光芒一闪，竹简也成了粉末，但好似脑海中多了些什么。",npcName = "",
								lineMsg = "获得天赋技能（猎户之子）：猎风\n每回合开始时，降低敌方速度最快的角色10%速度，增加自身10%速度。\n" ..
										  "获得天赋技能（猎户之子）：狩魔\n当目标有增益状态时，则对目标额外造成25%伤害。"},
							},
							next = 5,
						},
						[2] = {
							conditions = {noTags = {100405,100406}},
							npc = "树里有股奇怪的光芒散溢着。"
						},
	
						[5] = {
							res = {
								tags = {100406},
							}
						},
					},
				},
			}, 
		},
		[1008] = {
			name = "山脚下",
			pos = {-373,466},
			id = 1008,
			grids = {[2]=1007,},
			desc = "木屋隐在密林深处，人迹罕至。",
			triggerDesc = "天色已晚，阿爹在木屋前张望，带着一丝焦虑。",

			npcs = {
				{
					npcName = "阿爹",
					desc = "面容沧桑，眼神却坚忍刚毅，身形如松柏般挺拔",
					visibleConditions = {tags = {100406}},
					[1] = {
						talks = {
							{player = "阿爹，东西找到了，但是都不见了呢。"},
							{npc = "以后自己体会吧，这些东西会永远跟随你的。",player = "那阿爹给我推荐门派吧。",npcName="阿爹"},
						},
						next = 3,
					},
					[3] = {
						[1] = {
							next = 2,
						},
						[2] = {
							conditions = {
								tags = {100406},
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
			},
		},
	}
}

return scene_001401
