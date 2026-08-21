
-- tags
-- 100201:和魏风说完话
-- 100202:和魏风说话完了，魏风和父亲不可见的tag
-- 100103:选完兵器
-- 100204:战胜之后
-- 100205:获得天赋之后

-- 100200:关卡结束

-- 10112:选了拳
-- 10113:选了刀
-- 10114:选了剑
-- 10115:选了棍
-- 10116:选了鞭

-- 格子4父亲、格子6卫峰可见条件
local Tiaojian1 = {
	noTags = {100202},
}

local Juqing1 = {
	[1] = {
		conditions = {
			tags = {100103},
		},
			talks = {
				{npc = "只是切磋，点到为止啊。",npcName="父亲"},
				{npc = "哈哈哈，有我在一旁护着，无需担心，各自施展本领吧。",npcName="魏风"},
				{player = "父亲放心，孩儿知道！"},
			},
			next = 4,
	},
	[4] = {
		battle = {
			friends = { 
				conditions-- 约定-1为玩家所在位置
				-- { index = 4, id = xxx }, -- 
			},

			enemies = {
				{ index = 5, id = 1401201, level = 1 },
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
			tags = {100204},
			removeTags = {100103},
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
			tags = {100200},
		}
	},
	[31] = {
		res = {
			job = JobType.HuaShan,
			tags = {100200},
		}
	},
	[32] = {
		res = {
			job = JobType.XueDao,
			tags = {100200},
		}
	},
	[33] = {
		res = {
			job = JobType.GaiBang,
			tags = {100200},
		}
	},
	[34] = {
		res = {
			job = JobType.GuMu,
			tags = {100200},
		}
	},
	[35] = {
		res = {
			job = JobType.HengShan,
			tags = {100200},
		}
	},
}

local scene_001201 = {
	name = "卷1章1场景1",
	id = 1201,
	enter = {1201,1001},

	points = {
		[1001] = {
			name = "大门",
			pos = {25,-16},
			id = 1001,
			grids = {[1]=1002,},
			desc = "一座雕梁画栋的大宅，琉璃瓦下鎏金匾额熠熠生辉，匾额下朱红门、乌金环、青玉狮，一派商贾巨富的华丽气象。",
			triggerDesc = "才进门，便被账房拽着往里走。",

			npcs = {
				{
					npcName = "账房",
					desc = "清瘦的中年人，相貌精明，却满脸无奈。",
					[1] = {
						npc = "{sex:001}，又去打架了？快随我去，老爷吩咐，让你学着看账呢。",
						player = "我才不看呢，看见账本头都大了。",
					}
				}
			},
		},

		[1002] = {
			name = "庭院",
			pos = {25,88},
			id = 1002,
			grids = {[2]=1001,[1]=1003,},
			desc = "绕过影壁，便是花团锦簇的大庭院，碧水池天光云影，太湖石玲珑叠嶂。",
			triggerDesc = "管家气喘吁吁地跑来。",
			npcs = {
				{
					npcName = "管家",
					desc = "一颗七窍玲珑心，一张八面玲珑嘴，笑容好似长在了脸上。",
					[1] = {
						npc = "{sex:001}，可算找着你了，老爷大宴宾客，来的都是大主顾，你要好好表现啊。",
						player = "哎……这成天迎来送往的，烦死人了。",
					}
				}
			},
		},

		[1003] = {
			name = "长廊",
			pos = {25,192},
			id = 1003,
			grids = {[2]=1002,[1]=1004,},
			desc = "长廊依势而建，通花渡壑，移步换景，蜿蜒向前通往宴客大厅。",
			triggerDesc = "丫鬟端着酒器朝大厅走去。",

			npcs = {
				{
					npcName = "丫鬟",
					desc = "自小就在府内，一起玩耍一起长大，笑起来俩酒窝，机灵可爱。",
					[1] = {
						talks = {
							{npc = "我的好{sex:001}，看我拿了这么重也不帮一下，亏你还说将来要行侠仗义呢！",player = "烦着呢！又让我陪客。"},
							{npc = "那，要是陪义父呢？",player = "哇！义父来啦？你这鬼丫头，也不早说。"},
							{npc = "嗳！跑慢点，瞧把你乐的!"},
						},
					}
				}
			},
		},

		[1004] = {
			name = "大厅",
			pos = {25,296},
			id = 1004,
			grids = {[2]=1003,[3]=1006,[4]=1008,},
			desc = "宴客大厅富丽堂皇，迎头便是朱红匾额“紫华富贵”，大厅内琉璃灯、落地屏、博古架……满目生辉。",
			triggerDesc = "宾客觥筹交错，老爷眉开眼笑。",
			npcs = {
				{
					npcName = "老爷",
					desc = "一身团花袍子，脸圆，身圆，连握着酒杯的手指头也是圆的，笑起来眼睛都挤没了，那一个富态！那一个和气！",
					visibleConditions = Tiaojian1,
					[1] = {
						npc = "这么匆匆忙忙的，是找你义父吧，他在<color=#ff0000>偏厅</color>呢。",
					}
				}
			},
		},



		[1006] = {
			name = "偏厅",
			pos = {-441,296},
			id = 1006,
			grids = {[4]=1004,[1]=1009,},
			desc = "偏厅十分幽静，陈设精巧细致，原是品茗小憩之处。",
			triggerDesc = "魏风端坐喝茶，弟子一旁站立。",
			npcs = {
				{
					npcName = "大镖师魏风",
					desc = "气息凛然，不怒自威。多年来与宅邸主人亦商亦友、相互成就。如今，一个是家财万贯，一个则打响了“龙威”的名头。",
					visibleConditions = Tiaojian1,
					[1] = {
						talks = {
							{player = "义父义父，我就知道您在这儿！"},
							{npc = "哈哈，是啊，走镖的哪能沾酒啊，不如在这儿等你父亲，免得扫了大家的酒兴。", player = "义父，您就和父亲说说吧，这次带上我呗。",npcName="魏风"},
							{npc = "又胡闹！你父亲还指望你好好学生意，继承家业呢！",player = "我才不要做生意，我要跟着您闯荡江湖，多威风啊！",npcName="魏风"}, -- 这里有点奇怪
							{npc = "傻孩子，就你这两下子，哪经得起江湖风浪？",player = "小看人！要不我和这位小哥哥比试一下？",npcName="魏风"},
							{npc = "这……也好，稍后等你父亲来了，切磋一下吧，要是胜了，我便给你说说情，去名门正派拜师学艺，都14了，也该历练一下了。",player = "好嘞！还是义父好。",npcName="魏风"},
							{npc = "嘴甜没用，要能胜！快去<color=#ff0000>后院</color>选一件趁手的兵器吧，我和你父亲去后院等你。",npcName="魏风"},
						},
						next = 2,
					},
					[2] = {
						res = {
							tags = {100201},
						}
					},
				},
			},
			leaveEvents = {
				{
					conditions = {tags = 100201,noTags = {100202}},
					funcType = GE.FuncType.ExeRes,
					res = {
						tags = {100202},
					}
				},
			},
		},


		[1008] = {
			name = "库房",
			pos = {491,296},
			id = 1008,
			grids = {[3]=1004,},
			desc = "库房很大，堆满了南来北往的货物。可是，角落里的这扇小门，却透着一丝古怪。",
			triggerDesc = "库房里静悄悄的。",
			npcs = {
				{
					npcName = "库房里的小门",
					desc = "小门灰扑扑的，好像许久未曾开过，然而，隐隐的有股寒气，从门缝渗出来……",
					[0] = {
						conditions = {noTags = {100205},},
						player = {
							{content = "打开", next = 2},
						}
					},
					[2] = {
						[1] = {
							conditions = {tags = {100204},noTags = {100205},},
							talks = {
								{npc = "打开库房的小门，一把古老的算盘映入眼前，算珠竟然是纸制的。",npcName = "",},
								{npc = "握住算盘的刹那，算盘突然腐朽了，而双手却晶莹了一瞬。",lineMsg = "体魄+5 臂力+5 根骨+6 机敏+8 灵巧+4 福源+6 定力+2 胆识+4",npcName = "",},
								{npc = "算珠从腐朽的算盘上掉落，平铺成了一张张纸，文字从纸上跃出而消失不见。",npcName = "",
								lineMsg = "获得天赋技能（商贾之家）：数界\n如果攻击未命中，则命中提升30%，攻击提升15%，持续2回合。\n" ..
										  "获得天赋技能（商贾之家）：不惑\n受到降低属性的负面效果时，效果降低40%。"},
							},
							next = 5,
						},
						[2] = {
							conditions = {noTags = {100204,100205}},
							npc = "库房似乎锁着，打不开，但隐隐从中透出一丝光芒。"
						},
	
						[5] = {
							res = {
								tags = {100205},
							}
						},
					},
				}
			},
		},

		[1009] = {
			name = "后院",
			pos = {-208,400},
			id = 1009,
			grids = {[2]=1006,},
			desc = "后院方方正正，长宽三十余丈，墙边有几株高大的香樟树，郁郁葱葱，树下立着兵器架。",
			triggerDesc = "兵器架上有刀、剑、棍、鞭、拳套。",

			npcs = {
				{
					npcName = "父亲",
					desc = "一身团花袍子，脸圆，身圆，连握着酒杯的手指头也是圆的，笑起来眼睛都挤没了，那一个富态！那一个和气！,",
					visibleConditions = {tags = {100201}},
					[1] = {
						conditions = {
							tags = {100201},
							noTags = {100103,100204},
						},
							talks = {
								{npc = "先去选把兵器吧。",npcName="父亲"},
							},
					},
					[2] = {
						conditions = {
							tags = {100204},
						},
						[1] = {
							conditions = {
								noTags = {100205},
							},
							talks = {
								{player = "父亲，孩儿胜了！"},
								{npc = "难道你未看出那个小兄弟谦让你吗？", player = "胜了便是胜了，父亲可不能反悔！",npcName="父亲"},
								{npc = "罢了罢了，没想到你终于也走上了习武之路。", player = "哈哈，孩儿必将刻苦修习武学！",npcName="父亲"},
								{npc = "你拜师之前，去<color=#ff0000>大厅右侧的库房</color>一趟吧，那里有你爷爷留给你的宝物，就放在我从不让你打开的小门内。", player = "诶，我这就去。",npcName="父亲"},
							},
						},
						[2] = {
							conditions = {
								tags = {100205},
							},
							talks = {
								{player = "孩儿看到宝物了，不过刚抓起来便不见了。"},
								{npc = "我也不知你爷爷留给你的是什么，以后慢慢体会吧。", player = "那孩儿便告辞了，前去拜师啦！",npcName="父亲"},
								{npc = "请魏兄指教，小儿这资质该拜入哪个门派。",npcName="父亲"},
							},
						}
					},
					[3] = Juqing1,
				},
				{
					npcName = "大镖师魏风",
					desc = "气息凛然，不怒自威。多年来与宅邸主人亦商亦友、相互成就。如今，一个是家财万贯，一个则打响了“龙威”的名头。",
					visibleConditions = {tags = {100201}},
					[1] = {
						conditions = {
							tags = {100201},
							noTags = {100103,100204},
						},
							talks = {
								{npc = "先去选把兵器吧。",npcName="大镖师魏风"},
							},
					},
					[2] = {
						conditions = {
							tags = {100204},
						},
						[1] = {
							conditions = {
								noTags = {100205},
							},
								npc = "真是后生可畏啊！",
						},
						[2] = {
							conditions = {
								tags = {100205},
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
					},
					[3] = Juqing1,
				},
				{
					npcName = "龙威镖局弟子",
					desc = "十六七岁的身量，腰背挺得笔直，黝黑的脸庞青涩未退，却装出一副老成的样子",
					visibleConditions = {tags = {100201}},
					[1] = {
						conditions = {
							tags = {100201},
							noTags = {100103,100204},
						},
							talks = {
								{npc = "先去选把兵器吧。",npcName="龙威镖局弟子"},
							},
					},
					[2] = {
						conditions = {
							tags = {100204},
						},
						[1] = {
							npc = "厉害厉害！",
						}
					},
					[3] = Juqing1,
				},
				{
					npcName = "兵器架",
					desc = "兵器架上有刀、剑、棍、鞭、拳套。",
					[0] = {
						conditions = {
							tags = {100201},
							noTags = {100103,100204},
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

return scene_001201
