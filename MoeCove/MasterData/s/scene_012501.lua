-- tags
-- 112501:打完小弟
-- 112502:打完小弟（不会再打）

-- 112503:打完擂台2获得
-- 112504:打完擂2获得（不会再打）

-- 112510: 买秘籍
-- 112511: 买矿石

-- 112512: 获得盖山宝典1
-- 112513: 获得盖山宝典2
-- 112514: 获得盖山宝典3，397623和天蚕宝甲462241

-- 112500:章节结束

local scene_012501 = {
	name = "序章1",
	id = 12501,
	enter = {12501,1001},

	points = {
		[1001] = {
			name = "街道",
			pos = {1,-200},
			id = 1001,
			grids = {[1]=1002,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
			triggerDesc = "路上居民喜气洋洋，好似英雄大会比过节更加喜庆。",

			npcs = {
				{
					npcName = "居民",
					desc = "蜀地富足，永安城尤甚，城中居民大多长衫束冠，精神饱满，面色红润。",
					[1] = {
						talks = {
							{npc = "今日是决赛，我激动得心都蹦蹦跳，你看我这一头汗。",npcName = "居民甲"},
							{npc = "不瞒老兄，我也是，看了这些天，除了紧张，还感觉好像自己有武艺了呢，每天回家后忍不住要蹦跶两下。",npcName = "居民乙"},
							{npc = "哈哈哈，你俩真是……我只关心谁能拔得头筹。",npcName = "居民丙"},
						},
					},
				},
			},
		},

		[1002] = {
			name = "街道",
			pos = {1,-96},
			id = 1002,
			grids = {[2]=1001,[1]=1004,[4]=1014},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
			triggerDesc = "路上居民喜气洋洋，好似英雄大会比过节更加喜庆。",

			npcs = {
				{
					npcName = "居民",
					desc = "蜀地富足，永安城尤甚，城中居民大多长衫束冠，精神饱满，面色红润。",
					[1] = {
						talks = {
							{npc = "哎，只可惜今天看不到周仙子了。",npcName = "居民丁"},
							{npc = "武当宋帅哥也输了，没想到这次的黑马是星宿派，还有那三位{sex:003}。",npcName = "居民戊"},
							{npc = "那星宿派总是阴阴沉沉的，看着吓人。",npcName = "居民己"},
						},
					},
				},
			},
		},

		[1003] = {
			name = "小市集",
			pos = {-232,8},
			id = 1003,
			grids = {[4]=1004,},
			desc = "几个低矮的方台，上面堆了好些书籍。",
			triggerDesc = "几名游侠趁着武林人士聚集的时候，将不知从何处获得的一些武林秘籍、残章拿出来售卖。",

			npcs = {
				{
					npcName = "游侠",
					desc = "袍子有些褪色，皮靴也显出了几分破旧，腰间扣着几把短兵器，像匕首也像飞刀。",
					[1] = {
						conditions = {noTags = {112510}},
						npc = "我们需要一千两银子，以便继续游历江湖，有两种防具出售，{sex:003}想要买哪一种？",
						next = 4,
					},
					[2] = {
						npc = "多谢{sex:003}照顾生意，我们已经凑够了路费，剩下的便不卖了。",
					},
					[4] = {
						player = {
							{ content = "<color=#0099ff>飞马靴</color>，需要1000两银子。", next = 5 },
							{ content = "<color=#0099ff>流云发带</color>，需要1000两银子。", next = 6 },
						},
					},
					[5] = {
						npc = "{sex:003}确定要买<color=#0099ff>飞马靴</color>吗？",
						player = {
							{ content = "决定了！", next = 7 },
							{ content = "我再想想。" },
						},
					},
					[6] = {
						npc = "{sex:003}确定要买<color=#0099ff>流云发带</color>吗？",
						player = {
							{ content = "决定了！", next = 8 },
							{ content = "我再想想。" },
						},
					},
					[7] = {
						res = {
							tags = 112510,
							items = {{2,-1000},{434471,1}}
						}
					},
					[8] = {
						res = {
							tags = 112510,
							items = {{2,-1000},{433311,1}}
						}
					},
				},
			},
		},

		[1004] = {
			name = "街道",
			pos = {1,8},
			id = 1004,
			grids = {[2]=1002,[3]=1003,[4]=1005,[1]=1006,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
			triggerDesc = "路上居民喜气洋洋，好似英雄大会比过节更加喜庆。",

			npcs = {
				{
					npcName = "居民",
					desc = "蜀地富足，永安城尤甚，城中居民大多长衫束冠，精神饱满，面色红润。",
					[1] = {
						talks = {
							{npc = "这些游侠在小市集卖东西呢，咱也去看看呗。",npcName = "居民庚"},
							{npc = "都是卖给武林人士的，咱又用不上。",npcName = "居民辛"},
						},
					},
				},
			},
		},

		[1005] = {
			name = "小市集",
			pos = {234,8},
			id = 1005,
			grids = {[3]=1004,},
			desc = "几个低矮的方台，上面堆了好些矿石。",
			triggerDesc = "几名游侠趁着武林人士多的时候，将不知从何处获得的一些灵木、五行矿拿出来售卖。",

			npcs = {
				{
					npcName = "游侠",
					desc = "袍子有些褪色，皮靴也显出了几分破旧，腰间扣着几把短兵器，像匕首也像飞刀。",
					[1] = {
						conditions = {noTags = {112511}},
						npc = "我们需要一千两银子，以便继续游历江湖，有两种材料出售，{sex:003}想要买哪一种？",
						next = 4,
					},
					[2] = {
						npc = "多谢{sex:003}照顾生意，我们已经凑够了路费，剩下的便不卖了。",
					},
					[4] = {
						player = {
							{ content = "<color=#cc00cc>五彩矿石*10</color>，需要1000两银子。", next = 5 },
							{ content = "<color=#ff9900>灵木*10</color>，需要1000两银子。", next = 6 },
							{ content = "现在身上没那么多钱，我再想想。。", },
						},
					},
					[5] = {
						npc = "{sex:003}确定要买<color=#cc00cc>五彩矿石*10</color>吗？",
						player = {
							{ content = "决定了！", next = 8 },
							{ content = "我再想想。" },
						},
					},
					[6] = {
						npc = "{sex:003}确定要买<color=#ff9900>灵木*10</color>吗？",
						player = {
							{ content = "决定了！", next = 7 },
							{ content = "我再想想。" },
						},
					},
					
					[7] = {
						[1] = {
							conditions = {silver = 1000},
							res = {
								tags = 112511,
								items = {{2,-1000},{100107,10}}
							}
						},
						[2] = {
							next = {13},
						},
					},
					
					[8] = {
						[1] = {
							conditions = {silver = 1000},
							res = {
								tags = 112511,
								items = {{2,-1000},{200496,10}}
							},
						},
						[2] = {
							next = {13},
						},
					},
					
					[13] = {
						npc = "{sex:003}身上的银两不足1000两哦，不够我们路费的",
					},
				},
			},
		},

		[1006] = {
			name = "街道",
			pos = {1,112},
			id = 1006,
			grids = {[2]=1004,[1]=1008,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
			triggerDesc = "几道黑色的身影分开人群踏步而来，周围的人见了都不自觉的退后。",
			npcs = {
				{
					npcName = "星宿派弟子",
					desc = "黑冠黑衣，脸色暗沉，眼神冷冽，却嘴角上翘，堆出笑意，说不出来的怪诞。",
					[1] = {
						conditions = {noTags = {112502}},
						talks = {
							{player = "各位，有何指教？"},
							{npc = "见过几位少侠，{sex:003}击败了峨眉和武当，不愧是英杰才俊!",player = "谬赞了，大家抬爱而已。",npcName = "星宿派弟子"},
							{npc = "不必谦虚，我们新宿派的这几个师弟慕名而来，来向{sex:003}请教!",player = "决赛见啊，为什么这会儿要在这比试呢？",npcName = "星宿派弟子"},
							{npc = "哦，几位师兄才有资格参赛，故而我等只能在此相邀了，望几位少侠不吝赐教!",player = "可决赛在即，此时切磋，不合适也不公平吧。",npcName = "星宿派弟子"},
							{npc = "呵呵，还望{sex:003}成全，我们上了!",player = "硬来吗！你们到底打的什么主意！",npcName = "星宿派弟子"},
						},
						next = 5,
					},
					[2] = {
						talks = {
							{npc = "几位少侠果然名不虚传，佩服佩服，哈哈哈，{sex:003}可要攒好精神应付决赛哦!"},
						},
					},
					[5] = {
						battle = {
							limitFriendNum = 3,	
							friends = { 
								-- conditions
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412501, level = 70 },
								{ index = 5, id = 1412502, level = 90 },
								{ index = 9, id = 1412501, level = 70 },
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
							{npc = "几位少侠果然名不虚传，佩服佩服，哈哈哈，{sex:003}可要攒好精神应付决赛哦!",player = "卑鄙！",npcName = "星宿派弟子"},
						},
						next = 7,
					},
					[7] = {
						res = {
							tags = {112501,112502},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112502}},
					failMsg = "几道黑色的身影分开人群踏步而来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1007] = {
			name = "街道",
			pos = {-232,216},
			id = 1007,
			grids = {[4]=1008,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
			triggerDesc = "路上居民喜气洋洋，好似英雄大会比过节更加喜庆。",
		},

		[1008] = {
			name = "擂台前",
			pos = {1,216},
			id = 1008,
			grids = {[2]=1006,[3]=1007,[4]=1009,[1]=1011,},
			desc = "相隔二十余丈远，便能看到那高挑开阔的擂台，此刻好像永安的百姓都聚在了此处，人山人海，灯火辉煌。",
			triggerDesc = "几名持刀佩剑的军士，正费力的管理着观赛秩序，保持街道的进退畅通。",

			npcs = {
				{
					npcName = "军士",
					desc = "皮甲紧扣在胸前，孔武有力，血气方刚，许是军中小校之职。",
					[1] = {
						talks = {
							{npc = "几位快请，比赛就要开始了。",player = "我等被几位星宿弟子拖延，消耗甚大，可否缓一日再比。",npcName = "军士"},
							{npc = "赛期更改？绝无可能的，城主大人和各位武林前辈已等候多时了，{sex:003}还是请吧。",player = "好，那请带路吧。",npcName = "军士"},
						},
					},
				},
			},
		},

		[1009] = {
			name = "街道",
			pos = {234,216},
			id = 1009,
			grids = {[3]=1008,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
			triggerDesc = "路上居民喜气洋洋，好似英雄大会比过节更加喜庆。",
		},

		[1010] = {
			name = "街道",
			pos = {-232,320},
			id = 1010,
			grids = {[4]=1011,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
			triggerDesc = "路上居民喜气洋洋，好似英雄大会比过节更加喜庆。",
		},

		[1011] = {
			name = "擂台",
			pos = {1,320},
			id = 1011,
			grids = {[2]=1008,[3]=1010,[4]=1012,[1]=1013,},
			desc = "擂台居于永安城的正中心，两面临街，两面建起临时看台，宾客满座，都是刘城主邀来的武林前辈。",
			triggerDesc = "三位星宿弟子立于擂台的边上，貌似正和师门长辈说着什么。",
			npcs = {
				{
					npcName = "裁判",
					desc = "一袭黑衣，双手反握与身后，正安静的等待双方准备。",
					[1] = {
						conditions = {noTags = {112504},tags = {112501}},
						talks = {
							{npc = "双否可准备好？"},
							{npc = "看几位少侠脸色苍白，可是昨日胜了武当派，就沾沾自喜饮酒庆贺，尚未恢复呀？!",player = "阴险小人，设计害我们，居然还满口胡言！",npcName = "星宿派弟子"},
							{npc = "这话说得！不是怕了吧？!",player = "怕？哈哈哈，害我们损了内力，你们就稳操胜券了？做梦去吧！",npcName = "星宿派弟子"},
							{npc = "还嘴硬！那就领教一下几位的草莽武学吧!",npcName = "星宿派弟子"},
						},
						next = 5,
					},
					[2] = {
						talks = {
							{npc = "恭喜{sex:003}获胜，城主就在前方高台，请{sex:003}过去。"},
						},
					},
					[5] = {
						battle = {
							limitFriendNum = 3,	
							friends = { 
								-- conditions
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412503, level = 80 },
								{ index = 5, id = 1412504, level = 100 },
								{ index = 9, id = 1412503, level = 80 },
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
							{player = "哼，邪不压正，真正的武学招式都须千锤百炼，岂是你们这些偷奸耍滑之辈能了悟的？"},
							{npc = "嘿嘿，确实招式精妙，令人佩服，不过你也别骄傲，明日你就笑不出来咯!",player = "什么意思？！",npcName = "星宿派弟子"},
							{npc = "嘿嘿，没事没事!",npcName = "星宿派弟子"},
						},
						next = 7,
					},
					[7] = {
						res = {
							tags = {112503,112504},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {112504}},
					failMsg = "星宿派的弟子等候已久，快点上场吧。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			},
		},

		[1012] = {
			name = "街道",
			pos = {234,320},
			id = 1012,
			grids = {[3]=1011,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
			triggerDesc = "路上居民喜气洋洋，好似英雄大会比过节更加喜庆。",
		},

		[1013] = {
			name = "高台",
			pos = {1,424},
			id = 1013,
			grids = {[2]=1011,},
			desc = "擂台北侧的高台，永安城的大人物们都坐在此处。",
			triggerDesc = "胜了星宿弟子后，三人被军士引至此处。",

			npcs = {
				{
					npcName = "刘世杰",
					desc = "永安城城主，受百姓爱戴，江湖上也声名远播，威不外露，气息绵长，一看便知有深厚的内家功力。",
					visibleConditions = {tags = {112503},noTags = {112505}},
					[1] = {
						talks = {
							{player = "拜见城主大人！"},
							{npc = "哈哈，几位少侠并非永安城百姓，无需向我行礼。",player = "永安百姓安居乐业，全是城主大人的功劳，自然受得起我等之礼，何况我等还是晚辈。",npcName = "刘世杰"},
							{npc = "果然英雄出于少年，草莽不输庙堂，几位少侠一路击败各大门派弟子，实属了得！",player = "大人过奖了！",npcName = "刘世杰"},
							{npc = "莫要谦虚，此次虽是为了各家切磋技艺，但终有个彩头，此物便赠与你们！",player = "多谢城主大人！",npcName = "刘世杰"},
							{npc = "明天府中举办宴会，邀请此次参赛的各位选手，你们拔得头筹，上座以待哦！",player = "谢了，我等必准时上门叨扰。",npcName = "刘世杰"},
						},
						next = 3,
					},
					[3] = {
						[1] = {
							conditions = {
								tags = {112500},
							},
							res = {
								tags = {112505,112500},
								removeTags = 112503,
							}
						},
						[2] = {
							res = {
								tags = {112505,112500},
								removeTags = 112503,
								items = {{441651,1}}
							}
						},
					},


				},
			},
		},
		[1014] = {
			name = "街道",
			pos = {1,112},
			id = 1006,
			grids = {[3]=1002,},
			desc = "永安城的街道已经张灯结彩，热闹非凡，街道两边的酒家都是座无虚席。",
			triggerDesc = "一个穿着黑色斗篷的高大男人站在了街道的阴影中。",
			npcs = {
				{
					npcName = "斗篷怪客",
					desc = "一袭黑色的斗篷长及地面，兜帽也遮住了脸庞，但身材必然极为魁梧，将斗篷撑的如小山一般。",
					visibleConditions = {
						noTags = {112512,112513,112514},
						skills = {{897210,1}},
					},
					[1] = {
						conditions = {
							skills = {{897210,51}},
						},
						talks = {
							{npc = "你是盖山寨的人？",player = "何出此言，盖山寨的匪人已被我抓取官府了！",npcName = "斗篷怪客"},
							{npc = "你右腕巄骨外突，必是学了盖山斧法，躲不过我的眼睛！",player = "咦？不知前辈和盖山寨有和关系？",npcName = "斗篷怪客"},
							{npc = "这不用你关心，现在来接我几招，看看你的盖山斧法练到了什么水平！",npcName = "斗篷怪客"},
						},
						next = 5,
					},
					[2] = {
						conditions = {
							skills = {{897210,{1,50}}},
						},
						talks = {
							{npc = "哼，滚开!",player = "好吧。",npcName = "斗篷怪客"},
							{npc = "走吧走吧，这人看着脑子可能不好，不要惹是非了。",player = "好吧。",npcName = "邵灵儿"},
						},
					},
					[5] = {
						battle = {
							limitFriendNum = 1,	
							friends = { 
								-- conditions
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412505, level = 150 },

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
							{npc = "好，还不错，我便传你盖山斧法宝典！",player = "多谢前辈！",npcName = "斗篷怪客"},
							{npc = "等你练的再高深些，可来寻我。",npcName = "斗篷怪客"},
						},
						next = 7,
					},
					[7] = {
						res = {
							tags = {112512},
							items = {{397213,1},{200497,2}}
						},
					},
				},
				{
					npcName = "斗篷怪客",
					desc = "一袭黑色的斗篷长及地面，兜帽也遮住了脸庞，但身材必然极为魁梧，将斗篷撑的如小山一般。",
					visibleConditions = {
						tags = {112512},
						noTags = {112513},
						skills = {{897211,1}},
					},
					[1] = {
						conditions = {
							skills = {{897211,6}},
						},
						talks = {
							{player = "前辈，盖山斧法继续修炼还需要宝典，可否相传？",},
							{npc = "那便要看看你学的如何了！本次我将全力出手，小心了！",npcName = "斗篷怪客"},
						},
						next = 5,
					},
					[2] = {
						conditions = {
							skills = {{897211,{1,5}}},
						},
						talks = {
							{npc = "学艺不精，等在修炼些日子吧!",player = "好吧。",npcName = "斗篷怪客"},
						},
					},
					[5] = {
						battle = {
							limitFriendNum = 1,	
							friends = { 
								-- conditions
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412505, level = 240 },

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
							{npc = "好，还不错，我便传你盖山斧法宝典！",player = "多谢前辈！",npcName = "斗篷怪客"},
							{npc = "等你练的再高深些，可来寻我。",npcName = "斗篷怪客"},
						},
						next = 7,
					},
					[7] = {
						res = {
							tags = {112513},
							items = {{397213,1},{200497,2}}
						},
					},
				},
				{
					npcName = "斗篷怪客",
					desc = "一袭黑色的斗篷长及地面，兜帽也遮住了脸庞，但身材必然极为魁梧，将斗篷撑的如小山一般。",
					visibleConditions = {
						tags = {112513},
						noTags = {112514},
					},
					[1] = {
						conditions = {
							skills = {{897211,8}},
						},
						talks = {
							{player = "前辈，盖山斧法继续修炼还需要宝典，可否相传？",},
							{npc = "那便要看看你学的如何了！本次我将全力出手，小心了！",npcName = "斗篷怪客"},
						},
						next = 5,
					},
					[2] = {
						conditions = {
							skills = {{897211,{1,7}}},
						},
						talks = {
							{npc = "学艺不精，等在修炼些日子吧!",player = "好吧。",npcName = "斗篷怪客"},
						},
					},
					[5] = {
						battle = {
							limitFriendNum = 1,	
							friends = { 
								-- conditions
								-- { index = 4, id = xxx }, -- 
							},
							enemies = {
								{ index = 1, id = 1412505, level = 300 },

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
							{npc = "我将所有武艺都传与你了！",player = "多谢前辈！",npcName = "斗篷怪客"},
							{npc = "此乃我早年获得的神甲，龙王甲，也一并送与你。",npcName = "斗篷怪客"},
						},
						next = 7,
					},
					[7] = {
						res = {
							tags = {112514},
							items = {{397213,1},{442161,1},{200497,2}}
						},
					},
				},
			},
		},
	}
}

return scene_012501
