
-- tags

-- 113401:触发格子7获得
-- 113402:触发格子7获得
-- 113403:格子9战斗获得

-- 113404:格子11战斗获得
-- 113405:格子14战斗获得

-- 113406:格子18获得
-- 113407:格子22获得
-- 113408:格子19获得

-- 113400:章节结束

-- 113410:格子17获得
-- 113411:格子21获得

-- 113412:格子27对话石头获得
-- 113413:格子30打败厚土旗获得
-- 113414:格子33打败和尚获得
-- 113415:格子21获得山下矿石






local scene_013401 = {
	name = "序章1",
	id = 13401,
	enter = {13401,1001},

	points = {
		[1001] = {
			name = "客室",
			pos = {-253,-172},
			id = 1001,
			grids = {[4]=1002,},
			desc = "客室位于后山腰，从窗口眺望，峰峦起伏，如女子峨眉微蹙。",
			triggerDesc = "翠林掩映间，屋舍错落，一尘不染，遥遥拱卫着一座恢弘的大殿。",
			
			npcs = {
				{
					npcName = "邵灵儿",
					desc = "邵城武馆之女，精通鞭法，衣着素淡如菊，一双眼睛却着实的灵动清亮",
					[1] = {
						talks = {
							{npc = "愁死了，害的我昨夜都没睡好！",player = "嘁，这会儿愁了？不是你说要感天动地嘛。",npcName = "邵灵儿"},
							{npc = "我安慰一下周姐姐嘛！不管，反正一会儿还是你说",player = "好吧，也许灭绝师太并不是表现的那么决绝，那就让廊外的弟子再去通报一下吧。",npcName = "邵灵儿"},
						},
					},
				},
			},
		},

		[1002] = {
			name = "长廊",
			pos = {-20,-172},
			id = 1002,
			grids = {[3]=1001,[4]=1003,[1]=1005,[2]=1023,},
			desc = "长廊依山而建，蜿蜒向前，廊柱是峨眉白木，脚下是峨眉青石，古雅灵秀。",
			triggerDesc = "翠林掩映间，屋舍错落，一尘不染，遥遥拱卫着一座恢弘的大殿。",
			
			npcs = {
				{
					npcName = "邵灵儿",
					desc = "邵城武馆之女，精通鞭法，衣着素淡如菊，一双眼睛却着实的灵动清亮",
					[1] = {
						talks = {
							{npc = "诶？人呢？",player = "不管了，我们先去吧，路上遇见了再通报不迟。",npcName = "邵灵儿"},
							{npc = "奇怪了，峨眉的弟子都去哪里了？",npcName = "邵灵儿"},
							
						},
					},
				},
			},
		},

		[1003] = {
			name = "长廊",
			pos = {213,-172},
			id = 1003,
			grids = {[3]=1002,[4]=1004,[1]=1006,[2]=1024,},
			desc = "长廊依山而建，蜿蜒向前，廊柱是峨眉白木，脚下是峨眉青石，古雅灵秀。",
			triggerDesc = "翠林掩映间，屋舍错落，一尘不染，遥遥拱卫着一座恢弘的大殿。",
		},

		[1004] = {
			name = "长廊",
			pos = {446,-172},
			id = 1004,
			grids = {[3]=1003,[1]=1007,},
			desc = "长廊依山而建，蜿蜒向前，廊柱是峨眉白木，脚下是峨眉青石，古雅灵秀。",
			triggerDesc = "一阵兵器交加之声传来，间杂着叱喝声！",
			
			npcs = {
				{
					npcName = "邵灵儿",
					desc = "邵城武馆之女，精通鞭法，衣着素淡如菊，一双眼睛却着实的灵动清亮",
					[1] = {
						talks = {
							{npc = "听！有打斗声！",player = "奇怪……走，我们快去看看！",npcName = "邵灵儿"},
							
						},
					},
				},
			},
		},

		[1005] = {
			name = "长廊",
			pos = {-20,-68},
			id = 1005,
			grids = {[2]=1002,[1]=1015,},
			desc = "长廊依山而建，蜿蜒向前，廊柱是峨眉白木，脚下是峨眉青石，古雅灵秀。",
			triggerDesc = "翠林掩映间，屋舍错落，一尘不染，遥遥拱卫着一座恢弘的大殿。",
		},

		[1006] = {
			name = "客室",
			pos = {213,-68},
			id = 1006,
			grids = {[2]=1003,},
			desc = "长廊依山而建，蜿蜒向前，廊柱是峨眉白木，脚下是峨眉青石，古雅灵秀。",
			triggerDesc = "一阵兵器交加之声传来，间杂着叱喝声！",
			
			npcs = {
				{
					npcName = "邵灵儿",
					desc = "邵城武馆之女，精通鞭法，衣着素淡如菊，一双眼睛却着实的灵动清亮",
					[1] = {
						talks = {
							{npc = "听！有打斗声！",player = "奇怪……走，我们快去看看！",npcName = "邵灵儿"},
							
						},
					},
				},
			},
		},

		[1007] = {
			name = "长廊",
			pos = {446,-68},
			id = 1007,
			grids = {[1]=1008,[2]=1004,},
			desc = "长廊依山而建，蜿蜒向前，廊柱是峨眉白木，脚下是峨眉青石，古雅灵秀。",
			triggerDesc = "三名身着深红色波浪纹袍子，身形高大威猛，如赤焰金刚正在围攻静玄师姐。",
			
			npcs = {
				{
					npcName = "静玄",
					desc = "面容清冷，一身白衣，右肩布着绿色云纹，背负青色剑鞘。",
					[1] = {
						conditions = {noTags = {113402}},
						talks = {
							{player = "静玄师姐，我们来帮你！"},
							{npc = "此乃魔教烈火旗弟子，你们小心",npcName = "静玄"},
						},
						next = 5,
					},
					[2] = {
						npc = "快赶去大殿！",
					},
					[5] = {
						battle = {
							friends = { 
								{ index = 5, id = -1}, 
								{ index = 6, id = 1413405, level = 200 }, 
							},
							enemies = {
								{ index = 1, id = 1413403, level = 190 },
								{ index = 3, id = 1413403, level = 205 },
								{ index = 5, id = 1413403, level = 210 },
								{ index = 6, id = 1413403, level = 200 },
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
							{npc = "魔教率洪水、烈火、厚土三旗前来攻山。",player = "怎么这么突然？明教距离此地近两千里呢！",npcName = "静玄"},
							{npc = "为首的是女子一袭紫衣，武功高超，应当是紫衫龙王从波斯回来了。",npcName = "静玄"},
							{npc = "速速赶去大殿！",npcName = "静玄"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = {113401,113402},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113402}},
					failMsg = "只见静玄师姐正在被三名身着深红色波浪纹服装的男子围攻。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1008] = {
			name = "长廊",
			pos = {446,36},
			id = 1008,
			grids = {[2]=1007,[1]=1009,[4]=1025,},
			desc = "长廊依山而建，蜿蜒向前，廊柱是峨眉白木，脚下是峨眉青石，古雅灵秀。",
		},

		[1009] = {
			name = "金刚坡",
			pos = {446,140},
			id = 1009,
			grids = {[2]=1008,[1]=1010,},
			desc = "长廊中央高起的一个石坡，不知是什么用途。",
			triggerDesc = "突然地上泥土翻动，蹦出来四个手持兵器的男子。",
			
			npcs = {
				{
					npcName = "厚土旗弟子",
					desc = "一身土色劲装，土色头巾裹住面庞和发髻，只露出一双眼睛，机敏迅捷。",
					visibleConditions = {noTags = {113403}},
					[1] = {
						talks = {
							{npc = "这里还有几个，一并抓住！",player = "小心",npcName = "厚土旗弟子"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 

							},
							enemies = {
								{ index = 1, id = 1413402, level = 200 },
								{ index = 4, id = 1413402, level = 205 },
								{ index = 5, id = 1413402, level = 205 },
								{ index = 7, id = 1413402, level = 180 },
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
							tags = {113403},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113403}},
					failMsg = "突然地上泥土翻动，蹦出来三个手持兵器的男子。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1010] = {
			name = "拱桥",
			pos = {446,244},
			id = 1010,
			grids = {[2]=1009,[1]=1011,},
			desc = "长廊中央高起的一个石坡，不知是什么用途。",
		},

		[1011] = {
			name = "池塘",
			pos = {446,348},
			id = 1011,
			grids = {[2]=1010,[1]=1012,},
			desc = "池子静谧得有些诡异，水面无一丝涟漪，池边的树附身望着自己的倒影，枝叶仿佛被冻住了一般。",
			triggerDesc = "突然，池塘水面炸裂、水幕冲天，几名青衣人跃出池子。",
			
			npcs = {
				{
					npcName = "洪水旗弟子",
					desc = "一身青色短衫，带着青色面具，兵刃也泛着青光。",
					visibleConditions = {noTags = {113404}},
					[1] = {
						talks = {
							{npc = "制住他们！",player = "小心",npcName = "洪水旗弟子"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
							},
							enemies = {
								{ index = 1, id = 1413401, level = 225 },
								{ index = 4, id = 1413401, level = 180 },
								{ index = 5, id = 1413401, level = 180 },
								{ index = 7, id = 1413401, level = 225 },
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
							tags = {113404},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113404}},
					failMsg = "突然池塘中的水幕爆开，一群黑衣人冲上前来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1012] = {
			name = "长廊",
			pos = {446,452},
			id = 1012,
			grids = {[2]=1011,[1]=1013,},
			desc = "长廊依山而建，蜿蜒向前，廊柱是峨眉白木，脚下是峨眉青石，古雅灵秀。",
		},

		[1013] = {
			name = "长廊",
			pos = {446,556},
			id = 1013,
			grids = {[2]=1012,[3]=1014,},
			desc = "长廊依山而建，蜿蜒向前，廊柱是峨眉白木，脚下是峨眉青石，古雅灵秀。",
		},

		[1014] = {
			name = "前殿",
			pos = {213,556},
			id = 1014,
			grids = {[4]=1013,},
			desc = "恢弘的大殿已然一片狼藉，前殿更是桌倒椅翻，处处刀砍剑挑的痕迹。",
			triggerDesc = "一名少女静静地站在门柱边，浅紫色的裙衫隐隐的泛着冷光。",
			
			npcs = {
				{
					npcName = "殷悠悠",
					desc = "浅紫色的面纱如裙衫一般，泛着冷光，更衬得一双眼睛无比的阴狠凌厉。",
					visibleConditions = {noTags = {113405}},
					[1] = {
						talks = {
							{npc = "哦？现在峨眉还有男弟子了？",player = "我等并非峨眉弟子，但也是峨眉派的朋友。",npcName = "殷悠悠"},
							{npc = "师傅正在里面办事，你们就在这里等着吧",npcName = "殷悠悠"},
							{npc = "（大殿内传来一阵急促的兵铁交击之声）",player = "姑娘，你若不让开，休怪我等人多欺负人少了！",npcName = ""},
							{npc = "哈哈哈，人多？正好一起喂我的小蜘蛛啊！",npcName = "殷悠悠"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
							},
							enemies = {
								{ index = 1, id = 1413404, level = 300 },
								
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
							{npc = "嘿，有几分本事，开溜。",player = "快追",npcName = "殷悠悠"},
							
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = {113405,113400},
						},
					},
				},
			},
		},

		[1015] = {
			name = "长廊",
			pos = {-20,36},
			id = 1015,
			grids = {[2]=1005,[1]=1017,},
			desc = "长廊依山而建，蜿蜒向前，廊柱是峨眉白木，脚下是峨眉青石，古雅灵秀。",
		},

		[1016] = {
			name = "长廊",
			pos = {-253,140},
			id = 1016,
			grids = {[4]=1017,[1]=1019,},
			desc = "长廊依山而建，蜿蜒向前，廊柱是峨眉白木，脚下是峨眉青石，古雅灵秀。",
		},

		[1017] = {
			name = "武阁",
			pos = {-20,140},
			id = 1017,
			grids = {[3]=1016,[4]=1018,[1]=1020,[2]=1015,},
			desc = "此处好像是峨眉弟子修习内功之所，里外共有两间。",

			npcs = {
				{
					npcName = "峨眉弟子",
					desc = "一个穿着峨眉弟子服饰却没有背负长剑的女子。",
					visibleConditions = {noTags = {113410}},
					[1] = {
						talks = {
							{npc = "你！你们是谁！",npcName = "峨眉弟子"},
							{npc = "我们是来做客哒，都来了好几天了，师姐没见过我们吗？",npcName = "邵灵儿"},
							{npc = "此乃峨眉重地，不许入内！",npcName = "峨眉弟子"},
							{npc = "我们这就走开。",player = "等等！此人不是峨眉弟子！",npcName = "虎小山"},
							{npc = "她穿着破海靴，乃是波斯人明教的装束！",npcName = "田伯光"},
							{npc = "本来想放过你们的，既然被发现了就别想走了！守住门口！",npcName = "神秘女子"},
							{npc = "小心，背后还有人！",npcName = "田伯光"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
							},
							enemies = {
								{ index = 1, id = 1413406, level = 300 },
								{ index = 7, id = 1413406, level = 300 },
								{ index = 6, id = 1413407, level = 300 },
								
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
							{npc = "年纪轻轻武功竟然如此高强！撤退！",npcName = "神秘女子"},
							
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = 113410,
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113410}},
					failMsg = "一位峨眉弟子拦住了前路。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1018] = {
			name = "武阁",
			pos = {213,140},
			id = 1018,
			grids = {[3]=1017,},
			desc = "此处好像是峨眉弟子修习内功之所，里外共有两间。",

			npcs = {
				{
					npcName = "蒲团",
					desc = "很陈旧的木制的蒲团，无论是跪是坐都不舒适，许是为了让弟子更专心的修习。",
					[0] = {
						player = {
							{content = "翻开", next = 2},
						}
					},
					[2] = {
						[1] = {
							conditions = {noTags = {113406},},
							talks = {
								{npc = "翻开蒲团看到了一本秘笈。",npcName = "",},
							},
							next = 3,
						},
						[2] = {
							npc = "蒲团下面什么都没有。",npcName = ""
						},
						[3] = {
							res = {
								tags = {113406},
								items = {{303023,1}}
							},
						},
					},
				},
			},
		},

		[1019] = {
			name = "书房",
			pos = {-253,244},
			id = 1019,
			grids = {[4]=1020,[1]=1022,[2]=1016,},
			desc = "书房一尘不染，窗前一把桐木古琴，沿墙两排黄檀书柜，案上摆着文房四宝，和一座墨烟冻石鼎，满屋的书香和墨香。",

			npcs = {
				{
					npcName = "册子",
					desc = "一本黑色的小册子摊在桌子上。",
					[0] = {
						player = {
							{content = "翻开", next = 2},
						}
					},
					[2] = {
						[1] = {
							conditions = {noTags = {113408},},
							talks = {
								{npc = "获得了柳絮剑法秘笈。",npcName = "",},
							},
							next = 3,
						},
						[2] = {
							npc = "已经抄录了此册。",npcName = ""
						},
						[3] = {
							res = {
								tags = {113408},
								items = {{303013,1}}
							},
						},
					},
				},
			},
		},

		[1020] = {
			name = "长廊",
			pos = {-20,244},
			id = 1020,
			grids = {[2]=1017,[4]=1021,[3]=1019,},
			desc = "长廊依山而建，蜿蜒向前，廊柱是峨眉白木，脚下是峨眉青石，古雅灵秀。",
		},

		[1021] = {
			name = "静室",
			pos = {213,244},
			id = 1021,
			grids = {[3]=1020,},
			desc = "长廊的尽头是一座静室，室内一股青烟弥漫，有一个巨大的青蛇雕像居于正中。",

			npcs = {
				{
					npcName = "青蛇雕像",
					desc = "一条巨大的青蛇盘在地面，蛇鳞都栩栩如生。",
					visibleConditions = {noTags = {113411}},
					[1] = {
						talks = {
							{player = "这个青蛇雕像好传神呐！"},
							{npc = "这蛇尾巴还凉凉的呢。",npcName = "虎小山"},
							{npc = "嘶。。随着一声蛇鸣，一个巨大的青色蛇影从雕像中浮现出来。",npcName = ""},
							{npc = "虎小山！你是不是虎啊，总是乱摸东西！",npcName = "邵灵儿"},
							{npc = "大家小心，它冲过来了！",npcName = "田伯光"},
							{player = "小心它的尾巴！"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
							},
							enemies = {
								{ index = 5, id = 1413408, level = 250 },	
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
							{player = "好危险啊，差一点打不过呢！"},
							{npc = "诶，有本册子掉下来了。",npcName = "虎小山"},
							{npc = "青蛇鞭法？",npcName = "邵灵儿"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = 113411,
							items = 397119,
						},
					},
				},
				{
					npcName = "青蛇雕像",
					desc = "一条巨大的青蛇盘在地面，蛇鳞都栩栩如生。",
					visibleConditions = {skills = {{897110,1}}},
					[1] = {
						conditions = {
							items = {{110023,2}},
						},
						talks = {
							{npc = "需要两颗无名之玉才能再次激活青蛇雕像。",player = "正好有呢，青蛇显形吧！",npcName = ""},
						},
						next = 5,
					},
					[2] = {
						talks = {
							{npc = "需要两颗无名之玉才能再次激活青蛇雕像。",npcName = ""},
						},
					},
					[5] = {
						res = {
							items = {{110023,-2},{397113,1}},
						},
					},
				},
			},
		},

		[1022] = {
			name = "书房",
			pos = {-253,348},
			id = 1022,
			grids = {[2]=1019,},
			desc = "书房一尘不染，窗前一把桐木古琴，沿墙两排黄檀书柜，案上摆着文房四宝，和一座墨烟冻石鼎，满屋的书香和墨香。",

			npcs = {
				{
					npcName = "画像",
					desc = "画中一位美丽的女子手持花瓣正在向水中飘洒。",
					[0] = {
						player = {
							{content = "详看", next = 2},
						}
					},
					[2] = {
						[1] = {
							conditions = {noTags = {113407},},
							talks = {
								{npc = "突然这些花瓣从画中跃出，落到了手边。",npcName = "",},
							},
							next = 3,
						},
						[2] = {
							npc = "一副古旧的美人画。",npcName = ""
						},
						[3] = {
							res = {
								tags = {113407},
								items = {{170301,5}}
							},
						},
					},
				},
			},
		},

		[1023] = {
			name = "客室",
			pos = {-20,-276},
			id = 1023,
			grids = {[1]=1002,},
			desc = "客室位于后山腰，从窗口眺望，峰峦起伏，如女子峨眉微蹙。",
			triggerDesc = "翠林掩映间，屋舍错落，一尘不染，遥遥拱卫着一座恢弘的大殿。",
		},

		[1024] = {
			name = "客室",
			pos = {213,-276},
			id = 1024,
			grids = {[1]=1003,},
			desc = "客室位于后山腰，从窗口眺望，峰峦起伏，如女子峨眉微蹙。",
			triggerDesc = "翠林掩映间，屋舍错落，一尘不染，遥遥拱卫着一座恢弘的大殿。",
		},

		[1025] = {
			name = "小路",
			pos = {679,36},
			id = 1025,
			grids = {[3]=1008,[4]=1026,},
			desc = "峨眉后山的小路，虽然细长幽静，却十分整洁，看来时常被打扫着。",
		},

		[1026] = {
			name = "小路",
			pos = {912,36},
			id = 1026,
			grids = {[3]=1025,[4]=1027,},
			desc = "峨眉后山的小路，虽然细长幽静，却十分整洁，看来时常被打扫着。",
		},

		[1027] = {
			name = "巨石",
			pos = {1145,36},
			id = 1027,
			grids = {[1]=1028,[3]=1026,[4]=1034,},
			desc = "峨眉后山的小路，虽然细长幽静，却十分整洁，看来时常被打扫着。",

			npcs = {
				{
					npcName = "巨石",
					desc = "土黄色的巨大石头。",
					visibleConditions = {noTags = {113414}},
					[0] = {
						player = {
							{content = "查看", next = 2},
						}
					},
					[2] = {
						npc = "一块巨大的石头封住了下山的小路。",
					},
				},
				{
					npcName = "田伯光",
					desc = "剑眉朗目，鼻直口方，束发轻袍，英气逼人，一看便知是个方正君子。",
					visibleConditions = {noTags = {113412,113414}},
					[1] = {
						talks = {
							{npc = "快看，他们用巨石堵住了峨眉的下山的道路！",npcName = "田伯光"},
							{npc = "石头还在动，是一个好胖的和尚在推石头跑！",npcName = "邵灵儿"},
							{npc = "说不得，说不得。",player = "明教妖人，竟敢强攻七门八派之一的峨眉派！难道不怕被正道联盟剿灭吗！",npcName = "胖袋和尚"},
							{npc = "说不得说不得，胖和尚我只是挡住路罢了。",player = "再不把石头搬开，休怪我们围攻与你！",npcName = "胖袋和尚"},
							{npc = "说不得我也要活动活动筋骨了！若是敌不过你们，和尚我再搬开石头不迟。",npcName = "胖袋和尚"},
							{npc = "小心，他是五散人之一的胖袋和尚，浑天一气功已经深不可测。",npcName = "田伯光"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
							},
							enemies = {
								{ index = 1, id = 1413409, level = 400 },
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
							{npc = "说不得！说不得！好功夫呐！我跑！能抓住我再说吧！",npcName = "胖袋和尚"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = {113412},
						},
					},
				},
			},
		},
		[1028] = {
			name = "小路",
			pos = {1145,140},
			id = 1028,
			grids = {[2]=1027,[1]=1029,},
			desc = "峨眉后山的小路，虽然细长幽静，却十分整洁，看来时常被打扫着。",
		},

		[1029] = {
			name = "小路",
			pos = {1145,244},
			id = 1029,
			grids = {[2]=1028,[1]=1030,},
			desc = "峨眉后山的小路，虽然细长幽静，却十分整洁，看来时常被打扫着。",
		},

		[1030] = {
			name = "小路",
			pos = {1145,348},
			id = 1030,
			grids = {[2]=1029,[1]=1031,},
			desc = "峨眉后山的小路，虽然细长幽静，却十分整洁，看来时常被打扫着。",

			npcs = {
				{
					npcName = "胖袋和尚",
					desc = "顶着个大光头的胖和尚，穿着粗布的大马甲露出了圆球般的大肚子却背着一个银色发光的大布袋。",
					visibleConditions = {
						noTags = {113413},
						tags = {113412},
					},
					[1] = {
						talks = {
							{player = "你这么胖，能跑的赢我们？哪里跑！"},
							{npc = "厚土旗弟子何在！快来帮和尚挡住他们！",npcName = "胖袋和尚"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
							},
							enemies = {
								{ index = 1, id = 1413402, level = 400 },
								{ index = 4, id = 1413402, level = 400 },
								{ index = 7, id = 1413402, level = 400 },
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
							{npc = "快追！",npcName = "田伯光"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = {113413},
						},
					},
				},
			},
		},

		[1031] = {
			name = "小路",
			pos = {1145,452},
			id = 1031,
			grids = {[2]=1030,[1]=1032,},
			desc = "峨眉后山的小路，虽然细长幽静，却十分整洁，看来时常被打扫着。",
		},

		[1032] = {
			name = "小路",
			pos = {1145,556},
			id = 1032,
			grids = {[2]=1031,[1]=1033,},
			desc = "峨眉后山的小路，虽然细长幽静，却十分整洁，看来时常被打扫着。",
		},

		[1033] = {
			name = "小路",
			pos = {1145,660},
			id = 1033,
			grids = {[2]=1032,},
			desc = "峨眉后山的小路，虽然细长幽静，却十分整洁，看来时常被打扫着。",
			npcs = {
				{
					npcName = "胖袋和尚",
					desc = "顶着个大光头的胖和尚，穿着粗布的大马甲露出了圆球般的大肚子却背着一个银色发光的大布袋。",
					visibleConditions = {noTags = {113414},tags ={113413}},
					[1] = {
						talks = {
							{player = "你这么胖，能跑的赢我们？哪里跑！"},
							{npc = "不跑了不跑了，和尚我跑不动了。",player = "再跑啊！给我把石头搬开！",npcName = "胖袋和尚"},
							{npc = "说不得！不搬就是不搬！",npcName = "胖袋和尚"},
							{npc = "你这胖和尚好生无赖！",npcName = "邵灵儿"},
							{npc = "不对，怎会如此有恃无恐，这和尚必有未出的手段！",npcName = "田伯光"},
							{npc = "哈哈，这个小哥刀法一般，眼光倒是出众，和尚我的武功可不想在厚土旗那般人面前暴露！",npcName = "胖袋和尚"},
							{npc = "你们非得追我，说不得只能让你们见识见识乾坤一气决了！",npcName = "胖袋和尚"},
						},
						next = 5,
					},
					[5] = {
						battle = {
							friends = { 
							},
							enemies = {
								{ index = 1, id = 1413410, level = 400 },
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
							{npc = "和尚输了，这阵子搜集来的宝物便都归你们了吧！石头没了和尚的助力自然就会化成土块。",npcName = "胖袋和尚"},
							{npc = "[说罢，便将身后的布袋丢弃在地]",npcName = ""},
							{npc = "难道这就是江湖盛传的乾坤一气袋吗？",npcName = "田伯光"},
							{npc = "若和尚我带着乾坤一气袋怎会输与你们，正是把袋子拿去洗了，带的备用袋子！",npcName = "胖袋和尚"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = {113414},
							items = {{200529,1}},
						},
					},
				},
			},
		},

		[1034] = {
			name = "山下",
			pos = {1378,36},
			id = 1034,
			grids = {[3]=1027,},
			desc = "通往山下的山路细长而婉约，周围郁郁葱葱加之正是雨季，白色的迷雾与高大的树木形成了独特的色彩。",

			npcs = {
				{
					npcName = "矿石堆",
					desc = "乱石堆里有泛着银光的一小堆矿石！",
					visibleConditions = {noTags = {113415}},
					[0] = {
						player = {
							{content = "查看", next = 4},
						}
					},
					[4] = {
						player = "好大一堆矿石，怪不得那巨石会化开，原来是把矿石都提取了出来。",
						next = 5,
					},
					[5] = {
						res = {
							tags = 113415,
							items = {{200513,100}}
						}
					},
				},
			},

			enterParts = {
				{
					conditions = {tags = 113414,},
					failMsg = "巨石把小路完全封死了。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},
	}
}

return scene_013401
