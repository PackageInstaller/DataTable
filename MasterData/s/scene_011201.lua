
-- tags
-- 111201:遇到韦老宝后，无法再看见
-- 111202:遇到小山贼后
-- 111203:遇到小山贼后（不会再遇到）
-- 111204:获得矿石
-- 111205:打完二当家
-- 111206:获得基础武经



-- 111200:章节结束

-- 111207:和仪瑶程素素对话完（visibleConditions = {noTags = {111207,111208,111209}},）
-- 111208:采集完五彩竹,选仪瑶
-- 111209:采集完五彩竹,选程素素

-- 111210:格子23的敌人
-- 111211:格子26的敌人
-- 111212:格子29的敌人
-- 111213:格子31的敌人
-- 111214:格子33的敌人
-- 111215:格子34的敌人
-- 111216:格子38的敌人
-- 111217:格子41的敌人
-- 111218:格子43的敌人
-- 111219:格子45的敌人
-- 111220:格子46的敌人

-- 111221:格子50的龙头拐杖
-- 111222:格子50的宝箱




local scene_011201 = {
	name = "第一卷第一章第二节",
	id = 11201,
	enter = {11201,1001},

	points = {
		[1001] = {
			name = "山脚",
			pos = {46,14},
			id = 1001,
			grids = {[1]=1002,},
			desc = "沿着古道行至山脚下，抬眼只见危峰兀立，气势迫人，偶有行旅路过，皆神色戒备，步履匆匆。",
		},

		[1002] = {
			name = "山脚",
			pos = {46,118},
			id = 1002,
			grids = {[2]=1001,[1]=1004,},
			desc = "沿着古道行至山脚下，抬眼只见危峰兀立，气势迫人，偶有行旅路过，皆神色戒备，步履匆匆。",
		},

		[1003] = {
			name = "山脚",
			pos = {-187,222},
			id = 1003,
			grids = {[4]=1004,},
			desc = "沿着古道行至山脚下，抬眼只见危峰兀立，气势迫人，偶有行旅路过，皆神色戒备，步履匆匆。",
			triggerDesc = "非常突兀的，来了一个卖货郎，把杂货担子往道旁一丢，蹲那儿自得其乐地唱起了小曲：“沧海一声笑……”",

			npcs = {
				{
					npcName = "韦老宝",
					desc = "矮矮胖胖，整个脑袋就是一团蓬蓬松松的白毛，分不清哪是发哪是须，只露出一双眼睛，碧盈盈、滴溜溜，蹲在那儿活像一只大狸猫。",
					visibleConditions = {noTags = {111201}},
					[1] = {
						conditions = {
							noTags = {111201}
						},
						talks = {
							{npc = "喂，小家伙，你是谁呀？打哪儿来呀？到哪儿去呀？",player = "额……这人生三问……",npcName="韦老宝"},
							{npc = "哈哈哈，难住了吧？来来来，买点东西就放你走。",player = "没钱！",npcName="韦老宝"},
							{npc = "买一送一",player = "没钱！",npcName="韦老宝"},
							{npc = "额……那就送一吧……随便挑。",npcName="韦老宝"},
						},
						next = 4,
					},
					[4] = {
						[1] = {
							player = {
								{ content = "绿棉帽", next = 2 },
								{ content = "武士服", next = 3 },
								{ content = "百轮戒", next = 4 },
								{ content = "紫玉佩", next = 5 },
							},
						},
						[2] = {
							res = {
								items = 423281,
								tags = {111201},
							},
							next = 7,
						},
						[3] = {
							res = {
								items = 422131,
								tags = {111201},
							},
							next = 7,
						},
						[4] = {
							res = {
								items = 425131,
								tags = {111201},
							},
							next = 7,
						},
						[5] = {
							res = {
								items = 426291,
								tags = {111201},
							},
							next = 7,
						},
						[7] = {
							talks = {
								{player = "好东西诶，多谢老爷子！",npcName="韦老宝"},
								{npc = "哈，既然选好了，那我就走了！",player = "哎，老爷子等等，您还没说为啥送我东西呢？",npcName="韦老宝"},
								{npc = "哈哈，以后我们还会见面的，下次可要收费了！",npcName="韦老宝"},
							},
						},
					},
				},
			},
		},

		[1004] = {
			name = "山脚",
			pos = {46,222},
			id = 1004,
			grids = {[3]=1003,[1]=1005,[2]=1002,},
			desc = "沿着古道行至山脚下，抬眼只见危峰兀立，气势迫人，偶有行旅路过，皆神色戒备，步履匆匆。",
		},

		[1005] = {
			name = "乱石",
			pos = {46,326},
			id = 1005,
			grids = {[2]=1004,[1]=1008,},
			desc = "乱石嶙峋，杂草丛生，狭窄的山路时断时续。",
		},

		[1006] = {
			name = "小道",
			pos = {-420,430},
			id = 1006,
			grids = {[4]=1007,},
			desc = "齐人高的草丛里，蜿蜒着一条岔道。",
			triggerDesc = "腾身一跃，一记掌刀，巡山的小匪便趴在地上，啃了一嘴土。",

			npcs = {
				{
					npcName = "巡山的小匪",
					desc = "如同这山里的乱石杂草，一身山气，一脸匪气！",
					visibleConditions = {noTags = {111202}},
					[1] = {
						talks = {
							{npc = "哎哟，不要打了，是哪位好汉呐！",player = "带我去见盖山虎！",npcName="巡山的小匪"},
							{npc = "哎，好好，就在山路右边呐。",npcName="巡山的小匪"},
						},
						next = 4,
					},
					[4] = {
						res = {
							tags = {111202,111203},
						}
					},
				},
				{
					npcName = "矿石堆",
					desc = "乱石堆里有泛着银光的一小堆矿石！",
					visibleConditions = {noTags = {111204}},
					[0] = {
						conditions = {noTags = {111204},},
						player = {
							{content = "查看", next = 4},
						}
					},
					[4] = {
						player = "这里竟有矿石，这可不就是师傅说的能够提升装备的好东西嘛！",
						next = 5,
					},
					[5] = {
						res = {
							tags = 111204,
							items = {{100101,200}}
						}
					},
				},
			},
		},

		[1007] = {
			name = "小道",
			pos = {-187,430},
			id = 1007,
			grids = {[4]=1008,[3]=1006,},
			desc = "齐人高的草丛里，蜿蜒着一条岔道。",
		},

		[1008] = {
			name = "山路",
			pos = {46,430},
			id = 1008,
			grids = {[2]=1005,[3]=1007,[4]=1009,[1]=1010,},
			desc = "山势越来越陡峭，不见樵夫，不闻狗吠。",
		},

		[1009] = {
			name = "山路",
			pos = {279,430},
			id = 1009,
			grids = {[3]=1008,[1]=1011,},
			desc = "山势越来越陡峭，不见樵夫，不闻狗吠。",
		},

		[1010] = {
			name = "山路",
			pos = {46,534},
			id = 1010,
			grids = {[2]=1008,[1]=1012,[3]=1016},
			desc = "山势越来越陡峭，不见樵夫，不闻狗吠。",
		},

		[1011] = {
			name = "寨门",
			pos = {279,534},
			id = 1011,
			grids = {[2]=1009,[1]=1013,},
			desc = "乱石堆出半人高的围墙，往里则都是些土夯草盖的矮屋。",
			triggerDesc = "二当家和三当家拦住去路，斜眼睥睨。",

			npcs = {
				{
					npcName = "二当家",
					desc = "一件长袍，三缕长须，挺斯文，走近了一看，却是贼眉鼠眼，一脸猥琐。",
					
					[1] = {
						conditions = {tags = {111203},noTags = {111205},},
						talks = {
							{npc = "嘿嘿嘿嘿……好一个细皮嫩肉的小娃娃，尝尝飞镖吧。",npcName="二当家"},
							{npc = "哇哇哇哇……{sex:014}，送上门来让我砍？瞧见没，三爷的开山刀！",player = "就你俩？呵呵呵呵……来吧！可别求饶！",npcName="三当家"},
						},
						next = 5,
					},
					[2] = {
						conditions = {tags = {111205}},
						talks = {
							{npc = "啊，{sex:003}饶命，我们也是被盖山虎逼迫的啊！",player = "哼，盖山虎就在后面了吧",npcName="二当家"},
							{npc = "对，对，过了石廊就是聚义厅了，盖山虎就在里面！",npcName="二当家"},
						},
					},
					[5] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 6, id = 1411202, level = 12 },
								{ index = 4, id = 1411203, level = 12 },
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
							{npc = "啊，{sex:003}饶命，我们也是被盖山虎逼迫的啊！",player = "哼，盖山虎就在后面了吧？",npcName="二当家"},
							{npc = "对，对，过了石廊就是聚义厅了，盖山虎就在里面！",npcName="二当家"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = {111205},
						},
					},
				},
				{
					npcName = "三当家",
					desc = "一身横肉，光着膀子，扛着开山刀，野人似的在脖子上挂了串骨头。",
					
					[1] = {
						conditions = {tags = {111203},noTags = {111205},},
						talks = {
							{npc = "嘿嘿嘿嘿……好一个细皮嫩肉的小娃娃，尝尝飞镖吧。",npcName="二当家"},
							{npc = "哇哇哇哇……{sex:014}，送上门来让我砍？瞧见没，三爷的开山刀！",player = "就你俩？呵呵呵呵……来吧！可别求饶！",npcName="三当家"},
						},
						next = 5,
					},
					[2] = {
						conditions = {tags = {111205}},
						player = "这看着一身横肉的，尽然被打晕了，也太不抗揍了！"
					},
					[5] = {
						battle = {
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 6, id = 1411202, level = 12 },
								{ index = 4, id = 1411203, level = 12 },
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
							{npc = "啊，{sex:003}饶命，我们也是被盖山虎逼迫的啊！",player = "哼，盖山虎就在后面了吧",npcName="二当家"},
							{npc = "对，对，过了石廊就是聚财厅了，盖山虎就在里面！",npcName="二当家"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = {111205},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {111205}},
					failMsg = "被一个光着膀子的壮汉给挡住了。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
			enterParts = {
				{
					conditions = {tags = {111203}},
					failMsg = "寨门紧紧关着，去看看能不能抓一个山贼来骗开寨门吧。",
				},

			},
		},

		[1012] = {
			name = "山顶",
			pos = {46,638},
			id = 1012,
			grids = {[2]=1010,},
			desc = "山势高耸，云雾环绕，有半截锁链，通往山的对面，不知是何原因，已经断了。",
			npcs = {
				{
				npcName = "巨石",
				desc = "犹如斜插在山壁上的一柄巨剑，上面布满了文字。",
					[0] = {
						conditions = {noTags = {111206},},
						player = {
							{content = "探查", next = 4},
						}
					},
					[4] = {
						player = "这好像是一种练体的技巧？",
						next = 5,
					},
					[5] = {
						res = {
							tags = 111206,
							items = 301,
						}
					},
				},
			},
		},

		[1013] = {
			name = "石廊",
			pos = {279,638},
			id = 1013,
			grids = {[2]=1011,[4]=1014,},
			desc = "号称山寨，不过是一些石块堆积成的小堡，石缝中长出了杂草，草上还染着些暗红色的痕迹。",
		},

		[1014] = {
			name = "石廊",
			pos = {512,638},
			id = 1014,
			grids = {[3]=1013,[1]=1015,[4]=1050,},
			desc = "号称山寨，不过是一些石块堆积成的小堡，石缝中长出了杂草，草上还染着些暗红色的痕迹。",
		},

		[1050] = {
			name = "石洞",
			pos = {512,638},
			id = 1014,
			grids = {[3]=1014,},
			desc = "幽冷的石洞之中有一个黑色的大铁箱，许是盖山匪多年的财宝。",

			npcs = {
				{
				npcName = "龙头拐杖",
				desc = "很多江湖前辈退隐后都喜好使用这种龙头拐杖，与人争斗时可出其不意。",
				visibleConditions = {noTags = {111221}},
					[0] = {
						conditions = {noTags = {111221},},
						player = {
							{content = "拿起", next = 5},
						}
					},
					[5] = {
						res = {
							tags = 111221,
							items = 421441,
						}
					},
				},
				{
				npcName = "铁箱",
				desc = "一只黑色的铁箱，布满了灰尘带着一丝锈迹，锁扣都已裂开了。",
					[0] = {
						player = {
							{content = "打开", next = 2},
						}
					},
					[2] = {
						[1] = {
							conditions = {
								noTags = {111222},
								nstr = 25,
							},
							lineMsg = "费劲全力终于扯碎了锁扣，打开了铁箱，里面竟是一本刀法秘籍！",
							next = 6,
						},
						[2] = {
							conditions = {
								noTags = {111222},
								nstr = {nil, 24}
							},
							player = "哈！太沉了，竟然掰不开，看来<color=#ff0000>至少得要25臂力才行。</color>"
						},
						[3] = {
							talks = {
								{npc = "箱子空空如也。",npcName=""},
							},
						},
						[6] = {
							res = {
								items = 397219,
								tags = 111222,
							}
						},
					},
				},
			},
		},

		[1015] = {
			name = "聚财厅",
			pos = {512,742},
			id = 1015,
			grids = {[2]=1014,},
			desc = "山寨中间是高大的“聚财厅”，有梁有匾，还供了一尊赵公元帅，两旁贴着对联“手执金鞭驱宝至，身骑黑虎送财来”。",
			triggerDesc = "盖山虎提了斧头，大步跨出聚财厅。",

			npcs = {
				{
					npcName = "盖山虎",
					desc = "铁牛似的身板，铁刷似的须发，两条赤黄眉，一双血红目，两把巨斧轮起来虎虎生风。",
					[1] = {
						talks = {
							{player = "你就是盖山虎？那好，不用绕弯了，你抢马还伤人，罪不可恕！"},
							{player = "除非立刻还马，随我去官府投案！"},
							{npc = "哈哈哈哈，{sex:014}，你是在说笑吧？来，抬头看看，“聚财厅”！你居然要我散财？还要投案？哈哈哈哈……",player = "哼！你既然不讲江湖道义，那我就不客气了。",npcName="盖山虎"},
							{npc = "不客气还能咋样？想试试我这两把斧头？",player = "正想领教！",npcName="盖山虎"},
							{npc = "毛头{sex:014}，口气倒不小，就你这小身板，来来来，看不劈叉了你。",npcName="盖山虎"},
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
								{ index = 5, id = 1411204, level = 35 },
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
							{npc = "马都还给你，放过我吧！",player = "哼，你还是去官府承担你的罪孽吧！",npcName="盖山虎",},
								{lineMsg = "将盖山虎抓去了官府。\n" ..
									  "找回了马行的马匹。"},
						},
						next = 8,
					},
					[8] = {
						[1] = {
							conditions = {tags = {111200}},
							res = {
								tags = {111200},
							},
						},
						[2] = {
							res = {
								tags = {111200},
								items = {{190001,1}}
							},
						},


						
					},
				},
			},
		},

		[1016] = {
			name = "山路",
			pos = {-187,534},
			id = 1016,
			grids = {[4]=1010,[1]=1017,},
			desc = "山势越来越陡峭，不见樵夫，不闻狗吠。",
		},

		[1017] = {
			name = "断崖",
			pos = {-187,638},
			id = 1017,
			grids = {[2]=1016,[1]=1018,},
			desc = "山路走到此处便是尽头了，往崖底望去，虽有一些凸起，但轻功不好的人根本下不去。",
		},

		[1018] = {
			name = "谷底",
			pos = {-187,742},
			id = 1018,
			grids = {[2]=1017,[1]=1019,},
			desc = "断崖之下的谷底，依稀能听见水流之声，人迹罕至，往前行便是一片郁郁葱葱的密林。",

			enterParts = {
				{
					conditions = {nagi = 50,},
					failMsg = "如此跃下，必然会受伤的，<color=#ff0000>至少需要半百的机敏。</color>",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1019] = {
			name = "谷底",
			pos = {-187,846},
			id = 1019,
			grids = {[2]=1018,[1]=1020,},
			desc = "断崖之下的谷底，依稀能听见水流之声，人迹罕至，往前行便是一片郁郁葱葱的密林。",
		},

		[1020] = {
			name = "密林",
			pos = {-187,950},
			id = 1020,
			grids = {[2]=1019,[4]=1021,[1]=1025,},
			desc = "巨大的不知品种的树木遮天蔽日，阳光通过树叶间的缝隙洒落下来，斑斑驳驳，泥土都散发着草木香气。",

			npcs = {
				{
				npcName = "仪瑶",
				desc = "看着才十五六岁的模样，提着一个琉璃宝瓶，天真无邪，纯洁善良，就像一杯透明的水。",
				visibleConditions = {noTags = {111207,111208,111209}},
					[1] = {
						talks = {
							{npc = "姐姐，有人来了。",npcName="仪瑶"},
							{npc = "看着年纪轻轻，不像是坏人，不用害怕。",npcName="程素素"},
							{npc = "来者何人？",player = "我从那边山崖下来的，也不知如何就走到这里了，两位姐姐是何人？",npcName="程素素"},
							{npc = "我们是为了附近中毒的村民前来寻找草药的。",player = "哦哦，那不耽误姐姐们了，我这就走。",npcName="程素素"},
							{npc = "哎，等等，看{sex:003}身携兵器，也是武林中人吧？",player = "自然是的，我正闯荡江湖的，不知姐姐有何事？",npcName="仪瑶"},
							{npc = "这。。这。。",npcName="仪瑶"},
							{npc = "哎呀，我来说吧！此处可能有妖怪，我们两个女子不敢进去，不知{sex:003}可否陪同，我代附近中毒的百姓谢过{sex:003}了！",player = "义不容辞！我们这就走！",npcName="程素素"},
						},
						next = 4,
					},
					[4] = {
						res = {
							tags = {111207}
						}
					},
				},
				{
				npcName = "程素素",
				desc = "身着嫩绿色的仕女服，身材纤细，但眉目见透着英武的气息。",
				visibleConditions = {noTags = {111207,111208,111209}},
					[1] = {
						talks = {
							{npc = "姐姐，有人来了。",npcName="仪瑶"},
							{npc = "看着年纪轻轻，不像是坏人，不用害怕。",npcName="程素素"},
							{npc = "来者何人？",player = "我从那边山崖下来的，也不知如何就走到这里了，两位姐姐是何人？",npcName="程素素"},
							{npc = "我们是为了附近中毒的村民前来寻找草药的。",player = "哦哦，那不耽误姐姐们了，我这就走。",npcName="程素素"},
							{npc = "哎，等等，看{sex:003}身携兵器，也是武林中人吧？",player = "自然是的，我正闯荡江湖的，不知姐姐有何事？",npcName="仪瑶"},
							{npc = "这。。这。。",npcName="仪瑶"},
							{npc = "哎呀，我来说吧！此处可能有妖怪，我们两个女子不敢进去，不知{sex:003}可否陪同，我代附近中毒的百姓谢过{sex:003}了！",player = "义不容辞！我们这就走！",npcName="程素素"},
						},
						next = 4,
					},
					[4] = {
						res = {
							tags = {111207}
						}
					},
				},
			},
		},

		[1021] = {
			name = "密林",
			pos = {46,950},
			id = 1021,
			grids = {[3]=1020,[4]=1022,[1]=1026,},
			desc = "巨大的不知品种的树木遮天蔽日，阳光通过树叶间的缝隙洒落下来，斑斑驳驳，泥土都散发着草木香气。",
		},

		[1022] = {
			name = "密林",
			pos = {279,950},
			id = 1022,
			grids = {[3]=1021,[4]=1023,},
			desc = "巨大的不知品种的树木遮天蔽日，阳光通过树叶间的缝隙洒落下来，斑斑驳驳，泥土都散发着草木香气。",
		},

		[1023] = {
			name = "巨草堆",
			pos = {512,950},
			id = 1023,
			grids = {[3]=1022,[4]=1024,[1]=1028,},
			desc = "大堆的青草堆叠在一起形成的鼓包，周围没有草木，格格不入。",
			

			npcs = {
				{
				npcName = "巨草堆",
				desc = "巨大的草堆一颤、一颤、一颤……发出砰、砰的声音，如同活物。",
				visibleConditions = {noTags = {111210}},
					[0] = {
						player = {
							{content = "拨动", next = 2},
						}
					},
					[2] = {
						talks = {
							{npc = "这草堆内有生机，且阴冷刺骨，难道的魔教饲养的妖物？",player = "既然挡住了去路，总得拨开看看里面到底什么个什么！",npcName="程素素"},
							{npc = "那你要小心。",player = "放心！",npcName="仪瑶"},
							{npc = "用长竹调开草堆的瞬间，五六道青色的影子冲了过来。",npcName=""},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 3,	
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								{ index = 4, id = -1 }, 
								{ index = 2, id = 1411205, level = 120 },
								{ index = 8, id = 1411206, level = 120 },
							},
							enemies = {
								{ index = 1, id = 1411207, level = 100 },
								{ index = 4, id = 1411207, level = 100 },
								{ index = 7, id = 1411207, level = 100 },
								{ index = 2, id = 1411207, level = 100 },
								{ index = 5, id = 1411207, level = 100 },
								{ index = 8, id = 1411207, level = 100 },
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
							{npc = "原来是狐狸，青色的倒是非常少见。",npcName="仪瑶"},
							{npc = "狐狸难有如此利爪与速度，更不会主动攻击我们，必与草毒有关！",npcName="程素素"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = {111210}
						}
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {111210}},
					failMsg = "面前的草堆突然动了起来，几道影子直冲过来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1024] = {
			name = "密林",
			pos = {745,950},
			id = 1024,
			grids = {[3]=1023,},
			desc = "巨大的不知品种的树木遮天蔽日，阳光通过树叶间的缝隙洒落下来，斑斑驳驳，泥土都散发着草木香气。",
		},

		[1025] = {
			name = "密林",
			pos = {-187,1054},
			id = 1025,
			grids = {[2]=1020,[4]=1026,},
			desc = "巨大的不知品种的树木遮天蔽日，阳光通过树叶间的缝隙洒落下来，斑斑驳驳，泥土都散发着草木香气。",
		},

		[1026] = {
			name = "巨草堆",
			pos = {46,1054},
			id = 1026,
			grids = {[3]=1025,[2]=1021,[1]=1031,},
			desc = "大堆的青草堆叠在一起形成的鼓包，周围没有草木，格格不入。",
			

			npcs = {
				{
				npcName = "巨草堆",
				desc = "巨大的草堆一颤、一颤、一颤……发出砰、砰的声音，如同活物。",
				visibleConditions = {noTags = {111211}},
					[0] = {
						player = {
							{content = "拨动", next = 2},
						}
					},
					[2] = {
						talks = {
							{npc = "这草堆内有生机，且阴冷刺骨，难道的魔教饲养的妖物？",player = "既然挡住了去路，总得拨开看看里面到底什么个什么！",npcName="程素素"},
							{npc = "那你要小心。",player = "放心！",npcName="仪瑶"},
							{npc = "用长竹调开草堆的瞬间，五六道青色的影子冲了过来。",npcName=""},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 3,	
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								{ index = 4, id = -1 }, 
								{ index = 2, id = 1411205, level = 120 },
								{ index = 8, id = 1411206, level = 120 },
							},
							enemies = {
								{ index = 1, id = 1411207, level = 100 },
								{ index = 4, id = 1411207, level = 100 },
								{ index = 7, id = 1411207, level = 100 },
								{ index = 2, id = 1411207, level = 100 },
								{ index = 5, id = 1411207, level = 100 },
								{ index = 8, id = 1411207, level = 100 },
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
							{npc = "原来是狐狸，青色的倒是非常少见。",npcName="仪瑶"},
							{npc = "狐狸难有如此利爪与速度，更不会主动攻击我们，必与草毒有关！",npcName="程素素"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = {111211}
						}
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {111211}},
					failMsg = "面前的草堆突然动了起来，几道影子直冲过来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1027] = {
			name = "密林",
			pos = {279,1054},
			id = 1027,
			grids = {[4]=1028,},
			desc = "巨大的不知品种的树木遮天蔽日，阳光通过树叶间的缝隙洒落下来，斑斑驳驳，泥土都散发着草木香气。",
		},

		[1028] = {
			name = "密林",
			pos = {512,1054},
			id = 1028,
			grids = {[3]=1027,[2]=1023,[6]=1034,},
			desc = "巨大的不知品种的树木遮天蔽日，阳光通过树叶间的缝隙洒落下来，斑斑驳驳，泥土都散发着草木香气。",
		},

		[1029] = {
			name = "密林",
			pos = {745,1054},
			id = 1029,
			grids = {[6]=1035,},
			desc = "巨大的不知品种的树木遮天蔽日，阳光通过树叶间的缝隙洒落下来，斑斑驳驳，泥土都散发着草木香气。",

			npcs = {
				{
				npcName = "巨草堆",
				desc = "巨大的草堆一颤、一颤、一颤……发出砰、砰的声音，如同活物。",
				visibleConditions = {noTags = {111212}},
					[0] = {
						player = {
							{content = "拨动", next = 2},
						}
					},
					[2] = {
						talks = {
							{npc = "这草堆内有生机，且阴冷刺骨，难道的魔教饲养的妖物？",player = "既然挡住了去路，总得拨开看看里面到底什么个什么！",npcName="程素素"},
							{npc = "那你要小心。",player = "放心！",npcName="仪瑶"},
							{npc = "用长竹调开草堆的瞬间，五六道青色的影子冲了过来。",npcName=""},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 3,	
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								{ index = 4, id = -1 }, 
								{ index = 2, id = 1411205, level = 120 },
								{ index = 8, id = 1411206, level = 120 },
							},
							enemies = {
								{ index = 1, id = 1411207, level = 100 },
								{ index = 4, id = 1411207, level = 100 },
								{ index = 7, id = 1411207, level = 100 },
								{ index = 2, id = 1411207, level = 100 },
								{ index = 5, id = 1411207, level = 100 },
								{ index = 8, id = 1411207, level = 100 },
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
							tags = {111212}
						}
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {111212}},
					failMsg = "面前的草堆突然动了起来，几道影子直冲过来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1030] = {
			name = "河流",
			pos = {-187,1158},
			id = 1030,
			grids = {[4]=1031,[1]=1036,},
			desc = "环绕着密林的一条溪流，溪流对面是寸草不生的荒土，与岸的这边的生机勃勃截然不同。",
		},

		[1031] = {
			name = "巨草堆",
			pos = {46,1158},
			id = 1031,
			grids = {[3]=1030,[4]=1032,[2]=1026,},
			desc = "大堆的青草堆叠在一起形成的鼓包，周围没有草木，格格不入。",
			

			npcs = {
				{
				npcName = "巨草堆",
				desc = "巨大的草堆一颤、一颤、一颤……发出砰、砰的声音，如同活物。",
				visibleConditions = {noTags = {111213}},
					[0] = {
						player = {
							{content = "拨动", next = 2},
						}
					},
					[2] = {
						talks = {
							{npc = "这草堆内有生机，且阴冷刺骨，难道的魔教饲养的妖物？",player = "既然挡住了去路，总得拨开看看里面到底什么个什么！",npcName="程素素"},
							{npc = "那你要小心。",player = "放心！",npcName="仪瑶"},
							{npc = "用长竹调开草堆的瞬间，五六道青色的影子冲了过来。",npcName=""},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 3,	
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								{ index = 4, id = -1 }, 
								{ index = 2, id = 1411205, level = 120 },
								{ index = 8, id = 1411206, level = 120 },
							},
							enemies = {
								{ index = 1, id = 1411207, level = 100 },
								{ index = 4, id = 1411207, level = 100 },
								{ index = 7, id = 1411207, level = 100 },
								{ index = 2, id = 1411207, level = 100 },
								{ index = 5, id = 1411207, level = 100 },
								{ index = 8, id = 1411207, level = 100 },
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
							tags = {111213}
						}
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {111213}},
					failMsg = "面前的草堆突然动了起来，几道影子直冲过来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1032] = {
			name = "密林",
			pos = {279,1158},
			id = 1032,
			grids = {[3]=1031,[4]=1033,},
			desc = "巨大的不知品种的树木遮天蔽日，阳光通过树叶间的缝隙洒落下来，斑斑驳驳，泥土都散发着草木香气。",
		},

		[1033] = {
			name = "巨草堆",
			pos = {512,1158},
			id = 1033,
			grids = {[3]=1032,[4]=1034,[1]=1039,},
			desc = "大堆的青草堆叠在一起形成的鼓包，周围没有草木，格格不入。",
			

			npcs = {
				{
				npcName = "巨草堆",
				desc = "巨大的草堆一颤、一颤、一颤……发出砰、砰的声音，如同活物。",
				visibleConditions = {noTags = {111214}},
					[0] = {
						player = {
							{content = "拨动", next = 2},
						}
					},
					[2] = {
						talks = {
							{npc = "这草堆内有生机，且阴冷刺骨，难道的魔教饲养的妖物？",player = "既然挡住了去路，总得拨开看看里面到底什么个什么！",npcName="程素素"},
							{npc = "那你要小心。",player = "放心！",npcName="仪瑶"},
							{npc = "用长竹调开草堆的瞬间，五六道青色的影子冲了过来。",npcName=""},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 3,	
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								{ index = 4, id = -1 }, 
								{ index = 2, id = 1411205, level = 120 },
								{ index = 8, id = 1411206, level = 120 },
							},
							enemies = {
								{ index = 1, id = 1411207, level = 100 },
								{ index = 4, id = 1411207, level = 100 },
								{ index = 7, id = 1411207, level = 100 },
								{ index = 2, id = 1411207, level = 100 },
								{ index = 5, id = 1411207, level = 100 },
								{ index = 8, id = 1411207, level = 100 },
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
							tags = {111214}
						}
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {111214}},
					failMsg = "面前的草堆突然动了起来，几道影子直冲过来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1034] = {
			name = "巨草堆",
			pos = {745,1158},
			id = 1034,
			grids = {[3]=1033,[7]=1028,[6]=1041,},
			desc = "大堆的青草堆叠在一起形成的鼓包，周围没有草木，格格不入。",
			

			npcs = {
				{
				npcName = "巨草堆",
				desc = "巨大的草堆一颤、一颤、一颤……发出砰、砰的声音，如同活物。",
				visibleConditions = {noTags = {111215}},
					[0] = {
						player = {
							{content = "拨动", next = 2},
						}
					},
					[2] = {
						talks = {
							{npc = "这草堆内有生机，且阴冷刺骨，难道的魔教饲养的妖物？",player = "既然挡住了去路，总得拨开看看里面到底什么个什么！",npcName="程素素"},
							{npc = "那你要小心。",player = "放心！",npcName="仪瑶"},
							{npc = "用长竹调开草堆的瞬间，五六道青色的影子冲了过来。",npcName=""},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 3,	
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								{ index = 4, id = -1 }, 
								{ index = 2, id = 1411205, level = 120 },
								{ index = 8, id = 1411206, level = 120 },
							},
							enemies = {
								{ index = 1, id = 1411207, level = 100 },
								{ index = 4, id = 1411207, level = 100 },
								{ index = 7, id = 1411207, level = 100 },
								{ index = 2, id = 1411207, level = 100 },
								{ index = 5, id = 1411207, level = 100 },
								{ index = 8, id = 1411207, level = 100 },
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
							tags = {111215}
						}
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {111215}},
					failMsg = "面前的草堆突然动了起来，几道影子直冲过来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1035] = {
			name = "密林",
			pos = {978,1158},
			id = 1035,
			grids = {[7]=1029,[1]=1041,},
			desc = "巨大的不知品种的树木遮天蔽日，阳光通过树叶间的缝隙洒落下来，斑斑驳驳，泥土都散发着草木香气。",
		},

		[1036] = {
			name = "河流",
			pos = {-187,1262},
			id = 1036,
			grids = {[2]=1030,[1]=1042,},
			desc = "环绕着密林的一条溪流，溪流对面是寸草不生的荒土，与岸的这边的生机勃勃截然不同。",
		},

		[1037] = {
			name = "密林",
			pos = {46,1262},
			id = 1037,
			grids = {[1]=1043,},
			desc = "环绕着密林的一条溪流，溪流对面是寸草不生的荒土，与岸的这边的生机勃勃截然不同。",

			npcs = {
				{
				npcName = "五彩竹",
				desc = "半人高的矮小竹子，一共五节，每一节都有一种淡淡的色彩。",
				visibleConditions = {
					tags = {111207},
					noTags = {111208,111209}
				},
					[1] = {
						talks = {
							{npc = "这是五彩竹！终于找到了！",npcName="仪瑶"},
							{npc = "多谢这位{sex:003}，如此便谢过了！",player = "这。。两位姐姐，我正寻找一些伙伴共同游历江湖呢，不知姐姐们可有兴趣一起啊？",npcName="程素素"},
							{npc = "嗯，这倒是可以呢，不过我们两总得有一个去救村民的。",npcName="仪瑶"},
							{npc = "对哦，不知这位{sex:003}更想要我们姐妹俩的哪一个一起陪你闯荡江湖呢，嘻嘻？",npcName="程素素"},
						},
						next = 4,
					},
					[4] = {
						npc = "对哦，不知这位{sex:003}更想要我们姐妹俩的哪一个一起陪你闯荡江湖呢，嘻嘻？",npcName="程素素",
						player = {
							{ content = "仪瑶师姐，久闻恒山派医术高超，我们正缺少一个懂医术的同伴。", next = 6, },
							{ content = "程师姐，药王谷的高徒，听闻是医毒双绝，久仰了！", next = 7, },
						},
					},
					[6] = {
						res = {
							tags = {111200,111208},
							getChar = {706010},
							items = {{441171,1}},
						}
					},
					[7] = {
						res = {
							tags = {111200,111209},
							getChar = {780010},
							items = {{441801,1}},
						}
					},
				},
			},
		},

		[1038] = {
			name = "密林",
			pos = {279,1262},
			id = 1038,
			grids = {[4]=1039,},
			desc = "巨大的不知品种的树木遮天蔽日，阳光通过树叶间的缝隙洒落下来，斑斑驳驳，泥土都散发着草木香气。",

			npcs = {
				{
				npcName = "巨草堆",
				desc = "巨大的草堆一颤、一颤、一颤……发出砰、砰的声音，如同活物。",
				visibleConditions = {noTags = {111216}},
					[0] = {
						player = {
							{content = "拨动", next = 2},
						}
					},
					[2] = {
						talks = {
							{npc = "用长竹调开草堆的瞬间，五六道青色的影子冲了过来。",npcName=""},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 3,	
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								{ index = 4, id = -1 }, 
								{ index = 2, id = 1411205, level = 120 },
								{ index = 8, id = 1411206, level = 120 },
							},
							enemies = {
								{ index = 1, id = 1411207, level = 100 },
								{ index = 4, id = 1411207, level = 100 },
								{ index = 7, id = 1411207, level = 100 },
								{ index = 2, id = 1411207, level = 100 },
								{ index = 5, id = 1411207, level = 100 },
								{ index = 8, id = 1411207, level = 100 },
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
							tags = {111216}
						}
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {111216}},
					failMsg = "面前的草堆突然动了起来，几道影子直冲过来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1039] = {
			name = "密林",
			pos = {512,1262},
			id = 1039,
			grids = {[3]=1038,[2]=1033,},
			desc = "巨大的不知品种的树木遮天蔽日，阳光通过树叶间的缝隙洒落下来，斑斑驳驳，泥土都散发着草木香气。",
		},

		[1040] = {
			name = "密林",
			pos = {745,1262},
			id = 1040,
			grids = {[5]=1045,},
			desc = "巨大的不知品种的树木遮天蔽日，阳光通过树叶间的缝隙洒落下来，斑斑驳驳，泥土都散发着草木香气。",
		},

		[1041] = {
			name = "巨草堆",
			pos = {978,1262},
			id = 1041,
			grids = {[7]=1034,[5]=1046,[2]=1035,},
			desc = "大堆的青草堆叠在一起形成的鼓包，周围没有草木，格格不入。",
			

			npcs = {
				{
				npcName = "巨草堆",
				desc = "巨大的草堆一颤、一颤、一颤……发出砰、砰的声音，如同活物。",
				visibleConditions = {noTags = {111217}},
					[0] = {
						player = {
							{content = "拨动", next = 2},
						}
					},
					[2] = {
						talks = {
							{npc = "用长竹调开草堆的瞬间，五六道青色的影子冲了过来。",npcName=""},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 3,	
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								{ index = 4, id = -1 }, 
								{ index = 2, id = 1411205, level = 120 },
								{ index = 8, id = 1411206, level = 120 },
							},
							enemies = {
								{ index = 1, id = 1411207, level = 100 },
								{ index = 4, id = 1411207, level = 100 },
								{ index = 7, id = 1411207, level = 100 },
								{ index = 2, id = 1411207, level = 100 },
								{ index = 5, id = 1411207, level = 100 },
								{ index = 8, id = 1411207, level = 100 },
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
							tags = {111217}
						}
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {111217}},
					failMsg = "面前的草堆突然动了起来，几道影子直冲过来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1042] = {
			name = "河流",
			pos = {-187,1366},
			id = 1042,
			grids = {[2]=1036,[6]=1047,},
			desc = "环绕着密林的一条溪流，溪流对面是寸草不生的荒土，与岸的这边的生机勃勃截然不同。",
		},

		[1043] = {
			name = "密林",
			pos = {46,1366},
			id = 1043,
			grids = {[2]=1037,[4]=1044,},
			desc = "巨大的不知品种的树木遮天蔽日，阳光通过树叶间的缝隙洒落下来，斑斑驳驳，泥土都散发着草木香气。",

			npcs = {
				{
				npcName = "巨草堆",
				desc = "巨大的草堆一颤、一颤、一颤……发出砰、砰的声音，如同活物。",
				visibleConditions = {noTags = {111218}},
					[0] = {
						player = {
							{content = "拨动", next = 2},
						}
					},
					[2] = {
						talks = {
							{npc = "用长竹调开草堆的瞬间，五六道青色的影子冲了过来。",npcName=""},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 3,	
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								{ index = 4, id = -1 }, 
								{ index = 2, id = 1411205, level = 120 },
								{ index = 8, id = 1411206, level = 120 },
							},
							enemies = {
								{ index = 1, id = 1411207, level = 150 },
								{ index = 4, id = 1411207, level = 100 },
								{ index = 7, id = 1411207, level = 150 },
								{ index = 2, id = 1411207, level = 100 },
								{ index = 5, id = 1411207, level = 150 },
								{ index = 8, id = 1411207, level = 100 },
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
							tags = {111218}
						}
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {111218}},
					failMsg = "面前的草堆突然动了起来，几道影子直冲过来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1044] = {
			name = "密林",
			pos = {279,1366},
			id = 1044,
			grids = {[3]=1043,[4]=1045,},
			desc = "巨大的不知品种的树木遮天蔽日，阳光通过树叶间的缝隙洒落下来，斑斑驳驳，泥土都散发着草木香气。",
		},

		[1045] = {
			name = "巨草堆",
			pos = {512,1366},
			id = 1045,
			grids = {[3]=1044,[4]=1046,[8]=1040,},
			desc = "大堆的青草堆叠在一起形成的鼓包，周围没有草木，格格不入。",
			

			npcs = {
				{
				npcName = "巨草堆",
				desc = "巨大的草堆一颤、一颤、一颤……发出砰、砰的声音，如同活物。",
				visibleConditions = {noTags = {111219}},
					[0] = {
						player = {
							{content = "拨动", next = 2},
						}
					},
					[2] = {
						talks = {
							{npc = "用长竹调开草堆的瞬间，五六道青色的影子冲了过来。",npcName=""},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 3,	
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								{ index = 4, id = -1 }, 
								{ index = 2, id = 1411205, level = 120 },
								{ index = 8, id = 1411206, level = 120 },
							},
							enemies = {
								{ index = 1, id = 1411207, level = 100 },
								{ index = 4, id = 1411207, level = 100 },
								{ index = 7, id = 1411207, level = 100 },
								{ index = 2, id = 1411207, level = 100 },
								{ index = 5, id = 1411207, level = 100 },
								{ index = 8, id = 1411207, level = 100 },
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
							tags = {111219}
						}
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {111219}},
					failMsg = "面前的草堆突然动了起来，几道影子直冲过来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1046] = {
			name = "巨草堆",
			pos = {745,1366},
			id = 1046,
			grids = {[3]=1045,[8]=1041,[5]=1049,},
			desc = "大堆的青草堆叠在一起形成的鼓包，周围没有草木，格格不入。",
			

			npcs = {
				{
				npcName = "巨草堆",
				desc = "巨大的草堆一颤、一颤、一颤……发出砰、砰的声音，如同活物。",
				visibleConditions = {noTags = {111220}},
					[0] = {
						player = {
							{content = "拨动", next = 2},
						}
					},
					[2] = {
						talks = {
							{npc = "用长竹调开草堆的瞬间，五六道青色的影子冲了过来。",npcName=""},
						},
						next = 5,
					},
					[5] = {
						battle = {
							limitFriendNum = 3,	
							friends = { 
								-- conditions-- 约定-1为玩家所在位置
								{ index = 4, id = -1 }, 
								{ index = 2, id = 1411205, level = 120 },
								{ index = 8, id = 1411206, level = 120 },
							},
							enemies = {
								{ index = 1, id = 1411207, level = 100 },
								{ index = 4, id = 1411207, level = 100 },
								{ index = 7, id = 1411207, level = 100 },
								{ index = 2, id = 1411207, level = 100 },
								{ index = 5, id = 1411207, level = 100 },
								{ index = 8, id = 1411207, level = 100 },
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
							tags = {111220}
						}
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {111220}},
					failMsg = "面前的草堆突然动了起来，几道影子直冲过来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1047] = {
			name = "河流",
			pos = {46,1470},
			id = 1047,
			grids = {[7]=1042,[4]=1048,},
			desc = "环绕着密林的一条溪流，溪流对面是寸草不生的荒土，与岸的这边的生机勃勃截然不同。",
		},

		[1048] = {
			name = "河流",
			pos = {279,1470},
			id = 1048,
			grids = {[3]=1047,[4]=1049,},
			desc = "环绕着密林的一条溪流，溪流对面是寸草不生的荒土，与岸的这边的生机勃勃截然不同。",
		},

		[1049] = {
			name = "河流",
			pos = {512,1470},
			id = 1049,
			grids = {[3]=1048,[8]=1046,},
			desc = "环绕着密林的一条溪流，溪流对面是寸草不生的荒土，与岸的这边的生机勃勃截然不同。",
		},

	}
}

return scene_011201
