local map = {
	[1] = {
		name = LocalStrEnum.Jingcheng,
		imageType = 1,
		path = "jingcheng",
		pos = {1889,971},
		itemout = {44180,45230},
		enter = {1,1001},
		nodes = { [600] = 92, [31] = 51, },
	},

	[2] = {
		name = LocalStrEnum.DaLi,
		imageType = 1,
		path = "dali/dali",
		pos = {746,185},
		itemout = {44180,45230},
		enter = {2,1001},
		nodes = { [631] = 33, [1002811] = 47, [100351] = 29, },
	},

	[3] = {
		name = LocalStrEnum.Xixia,
		imageType = 1,
		path = "xixia/xixia",
		pos = {292,894},
		enter = {3,1001},
		nodes = { [100241] = 41, [100242] = 46, [628] = 97, [1002541] = 51, },
	},

	[4] = {
		name = LocalStrEnum.Yangzhou,
		imageType = 1,
		path = "yangzhou/yangzhou",
		pos = {1813,186},
		enter = {4,1001},
		nodes = { [100141] = 33, [100142] = 54, },
		event = {
			[1] = {
				conditions = { tags = 51416  },
				funcType = FuncType.NpcTalk,
				npcId = 100007,
				block = true,
			},

		},
	},

	[31] = {
		name = "京城小镇",
		imageType = 0,
		pos = {1897,919},
		itemout = {45231},
		nodes = { [1] = 51, [602] = 49, },
	},

	[32] = {
		name = "大理镇",
		imageType = 0,
		pos = {675,228},
		npcout = {52005},
		itemout = {45231},
		nodes = { [1002811] = 41, [100292] = 35, },
	},

	[33] = {
		name = "西夏镇",
		imageType = 0,
		pos = {147,958},
		itemout = {45231},
		nodes = { [100255] = 49, },
	},

	[34] = {
		name = "扬州小镇",
		imageType = 0,
		pos = {1838,241},
		itemout = {45231},
		nodes = { [609] = 47, [100140] = 48, [100141] = 29, },
	},

	[36] = {
		name = "梅村",
		imageType = 0,
		pos = {1772,443},
		itemout = {45231},
		nodes = { [607] = 43, [100159] = 46, },
	},

	[37] = {
		name = "怀湘村",
		imageType = 0,
		pos = {1715,768},
		npcout = {3702},
		itemout = {45231},
		nodes = { [603] = 90, [604] = 56, [100186] = 67, [100188] = 102, },
	},

	[38] = {
		name = "欣和村",
		imageType = 0,
		pos = {1507,161},
		itemout = {45231},
		nodes = { [100149] = 55, [100150] = 58, },
	},

	[40] = {
		name = "剑芜村",
		imageType = 0,
		pos = {1259,469},
		itemout = {45231,44356},
		nodes = { [100196] = 70, [100197] = 47, },
	},

	[41] = {
		name = "雁阳村",
		imageType = 0,
		pos = {1244,927},
		itemout = {45231},
		nodes = { [100214] = 60, [352] = 45, [502] = 65, },
	},

	[42] = {
		name = LocalStrEnum.WuMingCun,
		imageType = 0,
		pos = {1110,739},
		npcout = {12026},
		itemout = {45231},
		nodes = { [100209] = 43, [1002101] = 53, [125] = 36, [100316] = 59, },
	},

	[43] = {
		name = "绿柳村",
		imageType = 0,
		pos = {958,459},
		itemout = {45231},
		nodes = { [360] = 69, [115] = 83, },
	},

	[44] = {
		name = "百花村",
		imageType = 0,
		pos = {790,937},
		itemout = {45231},
		nodes = { [100225] = 52, [100232] = 25, },
	},

	[45] = {
		name = "百花村",
		imageType = 0,
		pos = {742,853},
		itemout = {45231},
		nodes = { [100234] = 48, },
	},

	[46] = {
		name = "无名村2",
		imageType = 0,
		pos = {397,159},
		npcout = {21205},
		itemout = {45231},
		nodes = { [100270] = 44, [100271] = 98, [100287] = 37, },
	},

	[47] = {
		name = "天禄村",
		imageType = 0,
		pos = {416,738},
		itemout = {45231},
		nodes = { [100245] = 27, [100246] = 82, },
	},

	[48] = {
		name = "沁阳村",
		imageType = 0,
		pos = {1862,654},
		itemout = {45231},
		nodes = { [604] = 130, [275] = 102, },
	},

	[100] = {
		name = "华山",
		imageType = 0,
		path = "huashan/huashan_shandao",
		pos = {1251,822},
		enter = {100,10001},
		nodes = { [1000171] = 39, },
		event = {
			[1] = {
				conditions = { [1] = {tags = 51362}, [2] = {tags = 51363}, [3] = {tags = 51364},  },
				funcType = FuncType.NpcTalk,
				npcId = 100002,
			},

		},
	},

	[105] = {
		name = LocalStrEnum.ShaoLin,
		imageType = 0,
		path = "shaolin/shaolin_shandao",
		pos = {1892,820},
		npcout = {10509},
		enter = {105,10001},
		nodes = { [100131] = 23, [100133] = 32, },
	},

	[110] = {
		name = "武当山道",
		imageType = 0,
		path = "wudang_shandao",
		pos = {1568,696},
		enter = {110,10000},
		nodes = { [100184] = 22, [100187] = 46, },
	},

	[115] = {
		name = "峨眉大门",
		imageType = 0,
		path = "emei/emei_nei",
		pos = {1036,485},
		enter = {115,10001},
		nodes = { [1002031] = 51, [100204] = 28, [43] = 83, },
	},

	[120] = {
		name = "全真大门",
		imageType = 1,
		path = "quanzhen/quanzhen_damen",
		pos = {1131,553},
		npcout = {12027,12028,12029},
		enter = {120,10001},
		nodes = { [100207] = 27, [100208] = 57, },
	},

	[125] = {
		name = "恒山",
		imageType = 0,
		path = "hengshan/hengshan_shandao",
		pos = {1098,774},
		enter = {125,10000},
		nodes = { [42] = 36, [632] = 42, },
		event = {
			[1] = {
				conditions = { [1] = {tags = 51362}, [2] = {tags = 51363}, [3] = {tags = 51364},  },
				funcType = FuncType.NpcTalk,
				npcId = 100002,
			},

		},
	},

	[130] = {
		name = "丐帮大门",
		imageType = 0,
		path = "gaibang",
		pos = {1614,968},
		enter = {130,10001},
		nodes = { [100009] = 72, },
	},

	[135] = {
		name = LocalStrEnum.XueShanXia,
		imageType = 0,
		path = "xueshan/xueshan_xia",
		pos = {631,541},
		enter = {135,10000},
		nodes = { [100303] = 54, [100308] = 43, },
	},

	[140] = {
		name = LocalStrEnum.SongShanWaiJing,
		imageType = 0,
		path = "songshan/songshan_waijing",
		pos = {1934,833},
		enter = {140,10000},
		nodes = { [100130] = 27, [100131] = 34, },
	},

	[145] = {
		name = LocalStrEnum.KongTongPai,
		imageType = 1,
		path = "kongtongpai/kongtongpai",
		pos = {1024,401},
		enter = {145,10000},
		nodes = { [619] = 52, [1002031] = 49, },
	},

	[155] = {
		name = "血刀大门",
		imageType = 0,
		path = "xuedao/xuedao_damen",
		pos = {576,584},
		enter = {155,10000},
		nodes = { [100306] = 39, [100308] = 31, [100309] = 59, },
	},

	[160] = {
		name = "星宿内",
		imageType = 0,
		path = "xingxiu/xingxiu_nei",
		pos = {155,811},
		enter = {160,10005},
		nodes = { [100253] = 48, },
	},

	[165] = {
		name = "黑木崖",
		imageType = 0,
		path = "heimuya/heimuyaxia",
		pos = {513,28},
		enter = {165,10000},
		nodes = { [100271] = 81, [100272] = 59, },
	},

	[205] = {
		name = LocalStrEnum.LingJiuDaMen,
		imageType = 0,
		path = "lingjiu_menkou",
		pos = {314,970},
		enter = {205,10001},
		nodes = { [100242] = 34, },
	},

	[210] = {
		name = "古墓大门",
		imageType = 0,
		path = "gumu/gumu_damen",
		pos = {1170,605},
		enter = {210,10006},
		nodes = { [100208] = 56, },
	},

	[220] = {
		name = LocalStrEnum.GuangMingDing,
		imageType = 1,
		path = "guangmingding/guangmingding",
		pos = {36,666},
		enter = {220,10000},
		nodes = { [100263] = 33, },
	},

	[240] = {
		name = "河道4",
		imageType = 0,
		path = "yanziwu/yanziwu4",
		pos = {1697,516},
		enter = {240,10000},
		nodes = { [100355] = 43, },
	},

	[245] = {
		name = LocalStrEnum.JueQingGuWai,
		imageType = 0,
		path = "jueqinggu/jueqingguwai",
		pos = {821,802},
		enter = {245,10000},
		nodes = { [100226] = 52, [100227] = 31, [100320] = 25, },
	},

	[275] = {
		name = "泰山",
		imageType = 1,
		path = "taishan/taishan",
		pos = {1778,596},
		enter = {275,10000},
		nodes = { [48] = 102, [1001341] = 37, [100182] = 43, },
	},

	[280] = {
		name = "衡山外景",
		imageType = 1,
		path = "hengshan2/hengshanwaijing",
		pos = {1392,433},
		enter = {280,10000},
		nodes = { [618] = 50, [100171] = 46, },
	},

	[300] = {
		name = LocalStrEnum.XunFengCheng,
		imageType = 0,
		path = "xunfengcheng",
		pos = {1913,763},
		npcout = {15801},
		enter = {300,10000},
		nodes = { [100132] = 25, },
	},

	[304] = {
		name = "武林大会",
		imageType = 0,
		pos = {1411,841},
		nodes = { [100014] = 58, [1000161] = 54, [100193] = 55, },
	},

	[305] = {
		name = LocalStrEnum.GenShanCheng,
		imageType = 0,
		path = "genshancheng",
		pos = {1335,478},
		npcout = {15801},
		enter = {305,10000},
		nodes = { [100173] = 39, [100174] = 71, [617] = 54, },
	},

	[310] = {
		name = LocalStrEnum.TanLangCheng,
		imageType = 0,
		path = "tanlangcheng",
		pos = {1237,758},
		npcout = {15801},
		enter = {310,10000},
		nodes = { [1002101] = 76, [1000171] = 60, [1002111] = 35, },
	},

	[315] = {
		name = LocalStrEnum.TianKuiCheng,
		imageType = 0,
		path = "tiankuicheng",
		pos = {659,646},
		npcout = {15801},
		enter = {315,10000},
		nodes = { [100305] = 29, [500] = 70, [100306] = 66, },
	},

	[320] = {
		name = LocalStrEnum.PoJunCheng,
		imageType = 0,
		path = "pojuncheng",
		pos = {570,719},
		npcout = {15801},
		enter = {320,10000},
		nodes = { [500] = 55, [100307] = 35, },
	},

	[352] = {
		name = "雁门关外",
		imageType = 1,
		path = "yanmenguan/yanmenguanwai",
		pos = {1278,957},
		enter = {352,10000},
		nodes = { [41] = 45, [100325] = 66, },
	},

	[360] = {
		name = "绿柳庄外",
		imageType = 0,
		path = "lvliuzhuang/lvliuzhuangwai",
		pos = {906,505},
		enter = {360,10000},
		nodes = { [43] = 69, [100300] = 24, },
	},

	[370] = {
		name = "摩天崖",
		imageType = 0,
		path = "motianya",
		pos = {429,880},
		npcout = {15801},
		enter = {370,10000},
		nodes = { [100239] = 41, [100240] = 23, },
	},

	[375] = {
		name = "高昌模型1",
		imageType = 0,
		path = "gaochang/gaochang_migong1",
		pos = {38,948},
		enter = {375,10001},
		nodes = { [1002601] = 35, },
	},

	[380] = {
		name = LocalStrEnum.HeiLongTan,
		imageType = 0,
		pos = {1010,981},
		npcout = {52015},
		nodes = { [1002231] = 66, },
	},

	[385] = {
		name = "阎基居",
		imageType = 0,
		pos = {1132,888},
		npcout = {52000},
		nodes = { [439] = 46, [100215] = 37, },
	},

	[390] = {
		name = LocalStrEnum.JianZhong,
		imageType = 0,
		path = "jianzhong/jianzhong",
		pos = {1190,476},
		enter = {390,10000},
		nodes = { [100198] = 32, [100201] = 54, [100197] = 26, },
	},

	[395] = {
		name = LocalStrEnum.MaTou,
		imageType = 0,
		path = "matou",
		pos = {1917,183},
		enter = {395,10001},
		nodes = { [100140] = 53, },
	},

	[400] = {
		name = "码头",
		imageType = 0,
		path = "meizhuang/meizhuangmatou",
		pos = {1638,440},
		enter = {400,10000},
		nodes = { [100156] = 59, [100157] = 33, [608] = 64, [100355] = 58, },
	},

	[408] = {
		name = "百花谷",
		imageType = 0,
		path = "baihuagu",
		pos = {933,865},
		enter = {408,10000},
		nodes = { [100218] = 52, [100219] = 32, [1002241] = 65, [100226] = 78, },
	},

	[411] = {
		name = LocalStrEnum.HuDieGu,
		imageType = 0,
		path = "hudiegu/hudiegu",
		pos = {690,892},
		npcout = {43030},
		enter = {411,10000},
		nodes = { [100233] = 40, [100234] = 31, [100235] = 49, },
	},

	[415] = {
		name = LocalStrEnum.CongBianShanZhuang,
		imageType = 0,
		path = "congbianshanzhuang",
		pos = {645,979},
		enter = {415,10000},
		nodes = { [1002311] = 48, },
	},

	[433] = {
		name = LocalStrEnum.WuDangPoMiao,
		imageType = 0,
		path = "templeout/templeout_wudang",
		pos = {1704,667},
		enter = {433,1001},
		nodes = { [100182] = 61, [605] = 60, },
	},

	[430] = {
		name = LocalStrEnum.QingChengPoMiao,
		imageType = 0,
		path = "templeout/templeout_qingcheng",
		pos = {771,674},
		enter = {430,1001},
		nodes = { [100228] = 63, [100229] = 72, },
	},

	[435] = {
		name = "扬州破庙",
		imageType = 0,
		path = "templeout_yangzhou",
		pos = {1871,390},
		enter = {435,1001},
		nodes = { [100138] = 40, },
	},

	[439] = {
		name = LocalStrEnum.HengShanPoMiao,
		imageType = 0,
		path = "templeout/templeout_hengshan",
		pos = {1141,842},
		enter = {439,1001},
		nodes = { [632] = 38, [385] = 46, },
	},

	[441] = {
		name = "贪狼破庙",
		imageType = 0,
		path = "templeout_tanlang",
		pos = {1338,700},
		enter = {441,1001},
		nodes = { [100200] = 30, [100212] = 32, },
	},

	[445] = {
		name = LocalStrEnum.KunLunShan,
		imageType = 0,
		path = "kunlunxianjing/kunlunshan",
		pos = {196,666},
		enter = {445,10000},
		nodes = { [100248] = 47, [100250] = 27, },
	},

	[450] = {
		name = LocalStrEnum.NanDiYinSuo,
		imageType = 0,
		path = "nandiyinsuo",
		pos = {1324,265},
		enter = {450,10000},
		nodes = { [100162] = 40, [100164] = 51, },
	},

	[455] = {
		name = LocalStrEnum.KunLun,
		imageType = 1,
		path = "kunlun/kunlun",
		pos = {144,695},
		enter = {455,10000},
		nodes = { [100250] = 46, [100252] = 75, [100256] = 78, [100261] = 50, },
	},

	[462] = {
		name = LocalStrEnum.MaDongHou,
		imageType = 0,
		pos = {1120,993},
		npcout = {10072},
		nodes = { [502] = 77, },
	},

	[466] = {
		name = "计老人居",
		imageType = 0,
		path = "jilaorenju",
		pos = {25,811},
		enter = {466,10000},
		nodes = { [1002571] = 43, [100259] = 59, },
	},

	[502] = {
		name = LocalStrEnum.EMeiShanDong,
		imageType = 0,
		path = "shandong_madong",
		pos = {1192,966},
		enter = {502,10000},
		nodes = { [41] = 65, [100215] = 64, [462] = 77, },
		event = {
			[1] = {
				conditions = { tags = 50030  },
				funcType = FuncType.NpcTalk,
				npcId = 100005,
				block = true,
			},

		},
	},

	[506] = {
		name = LocalStrEnum.XiaoYaoDong,
		imageType = 0,
		pos = {1003,265},
		nodes = { [235] = 68, [100168] = 51, },
		event = {
			[1] = {
				conditions = { tags = 51355, },
				funcType = FuncType.NpcTalk,
				npcId = 100001,
			},

		},
	},

	[508] = {
		name = LocalStrEnum.GaiBangDong,
		imageType = 0,
		path = "shandong_gaibang",
		pos = {1602,929},
		enter = {508,10000},
		nodes = { [100010] = 22, },
	},

	[512] = {
		name = LocalStrEnum.TianLudong,
		imageType = 0,
		path = "shandong_tianlu",
		pos = {467,636},
		enter = {512,10000},
		nodes = { [100310] = 49, [100311] = 79, },
	},

	[520] = {
		name = LocalStrEnum.DuLongDong,
		imageType = 0,
		path = "shandong_dulong",
		pos = {995,60},
		npcout = {15801},
		enter = {520,10000},
		nodes = { [100277] = 48, },
	},

	[526] = {
		name = LocalStrEnum.EMeiShanDong,
		imageType = 0,
		path = "shandong_emei",
		pos = {1175,413},
		enter = {526,10000},
		nodes = { [1002021] = 66, },
		event = {
			[1] = {
				conditions = { tags = 50030  },
				funcType = FuncType.NpcTalk,
				npcId = 100005,
				block = true,
			},

		},
	},

	[600] = {
		name = "桥",
		imageType = 0,
		pos = {1808,924},
		itemout = {45232},
		nodes = { [1] = 92, [100006] = 18, },
	},

	[601] = {
		name = "桥",
		imageType = 0,
		pos = {1804,858},
		itemout = {45232},
		nodes = { [100006] = 51, [524] = 31, },
	},

	[602] = {
		name = "桥",
		imageType = 0,
		pos = {1930,883},
		itemout = {45232},
		nodes = { [31] = 49, [100130] = 23, },
	},

	[603] = {
		name = "桥",
		imageType = 0,
		pos = {1799,803},
		itemout = {45232},
		nodes = { [100133] = 66, [37] = 90, },
	},

	[604] = {
		name = "桥",
		imageType = 0,
		pos = {1764,739},
		itemout = {45232},
		nodes = { [37] = 56, [48] = 130, [670] = 71, },
	},

	[605] = {
		name = "桥",
		imageType = 0,
		pos = {1646,653},
		itemout = {45232},
		nodes = { [433] = 60, [100183] = 30, },
	},

	[606] = {
		name = "桥",
		imageType = 0,
		pos = {1837,422},
		itemout = {45232},
		nodes = { [100137] = 48, [100138] = 44, [100159] = 26, },
	},

	[607] = {
		name = "桥",
		imageType = 0,
		pos = {1733,425},
		itemout = {45232},
		nodes = { [100158] = 49, [36] = 43, },
	},

	[608] = {
		name = "桥",
		imageType = 0,
		pos = {1625,503},
		itemout = {45232},
		nodes = { [400] = 64, [510] = 38, },
	},

	[609] = {
		name = "桥",
		imageType = 0,
		pos = {1850,287},
		itemout = {45232},
		nodes = { [100139] = 65, [34] = 47, },
	},

	[610] = {
		name = "桥",
		imageType = 0,
		pos = {1706,84},
		itemout = {45232},
		nodes = { [100146] = 55, [100147] = 45, },
	},

	[611] = {
		name = "桥",
		imageType = 0,
		pos = {1516,458},
		itemout = {45232},
		nodes = { [100155] = 41, [100177] = 51, },
	},

	[612] = {
		name = "桥",
		imageType = 0,
		pos = {1453,570},
		itemout = {45232},
		nodes = { [100176] = 29, [100181] = 23, },
	},

	[613] = {
		name = "桥",
		imageType = 0,
		pos = {1464,622},
		itemout = {45232},
		nodes = { [100181] = 36, [100187] = 81, },
	},

	[614] = {
		name = "桥",
		imageType = 0,
		pos = {1321,869},
		itemout = {45232},
		nodes = { [1000161] = 44, [100214] = 37, },
	},

	[615] = {
		name = "桥",
		imageType = 0,
		pos = {1287,622},
		itemout = {45232},
		nodes = { [1001991] = 80, [100200] = 68, },
	},

	[616] = {
		name = "桥",
		imageType = 0,
		pos = {1210,534},
		itemout = {45232},
		nodes = { [100198] = 32, [1001991] = 37, },
	},

	[617] = {
		name = "桥",
		imageType = 0,
		pos = {1307,525},
		itemout = {45232},
		nodes = { [305] = 54, [100178] = 31, },
	},

	[618] = {
		name = "桥",
		imageType = 0,
		pos = {1400,383},
		itemout = {45232},
		nodes = { [100160] = 26, [280] = 50, },
		event = {
			[1] = {
				conditions = { tags = 53244 ,items = {{53304,1}}, },
				funcType = FuncType.NpcTalk,
				npcId = 100009,
				block = true,	
			},

		},
	},

	[619] = {
		name = "桥",
		imageType = 0,
		pos = {978,376},
		npcout = {12050},
		itemout = {45232},
		nodes = { [260] = 34, [145] = 52, },
	},

	[620] = {
		name = "桥",
		imageType = 0,
		pos = {1043,566},
		itemout = {45232},
		nodes = { [100204] = 58, [100205] = 34, [100206] = 28, },
	},

	[621] = {
		name = "桥",
		imageType = 0,
		pos = {1053,636},
		itemout = {45232},
		nodes = { [100205] = 45, [100209] = 77, },
	},

	[622] = {
		name = "桥",
		imageType = 0,
		pos = {882,631},
		itemout = {45232},
		nodes = { [100229] = 47, [1003141] = 69, },
	},

	[623] = {
		name = "桥",
		imageType = 0,
		pos = {835,540},
		itemout = {45232},
		nodes = { [100300] = 64, [100301] = 43, },
	},

	[624] = {
		name = "桥",
		imageType = 0,
		pos = {768,764},
		itemout = {45232},
		nodes = { [100227] = 35, [100228] = 42, },
	},

	[625] = {
		name = "桥",
		imageType = 0,
		pos = {596,782},
		itemout = {45232},
		nodes = { [100236] = 45, [100307] = 35, },
	},

	[626] = {
		name = "桥",
		imageType = 0,
		pos = {690,177},
		itemout = {45232},
		nodes = { [100282] = 67, [100351] = 31, },
	},

	[627] = {
		name = "桥",
		imageType = 0,
		pos = {192,794},
		itemout = {45232},
		nodes = { [100252] = 35, [100253] = 22, },
	},

	[628] = {
		name = "桥",
		imageType = 0,
		pos = {218,829},
		itemout = {45232},
		nodes = { [100253] = 22, [3] = 97, },
	},

	[629] = {
		name = "桥",
		imageType = 0,
		pos = {426,816},
		itemout = {45232},
		nodes = { [100243] = 36, [100244] = 36, },
	},

	[630] = {
		name = "桥",
		imageType = 0,
		pos = {825,457},
		itemout = {45232},
		nodes = { [100297] = 68, [100300] = 69, },
	},

	[631] = {
		name = "桥",
		imageType = 0,
		pos = {760,155},
		itemout = {45232},
		nodes = { [100280] = 58, [2] = 33, },
	},

	[632] = {
		name = "桥",
		imageType = 0,
		pos = {1122,808},
		itemout = {45232},
		nodes = { [125] = 42, [439] = 38, [100216] = 53, },
	},

	[633] = {
		name = "桥",
		imageType = 0,
		pos = {152,510},
		itemout = {45232},
		nodes = { [100265] = 43, [100266] = 77, },
	},

	[634] = {
		name = "桥",
		imageType = 0,
		pos = {1492,856},
		itemout = {45232},
		nodes = { [100014] = 35, [100014] = 35, },
	},

	[650] = {
		name = "矿区",
		imageType = 0,
		pos = {1676,872},
		itemout = {45234},
		nodes = { [100002] = 71, },
	},

	[651] = {
		name = "矿区",
		imageType = 0,
		pos = {1573,193},
		itemout = {45234},
		nodes = { [100148] = 63, },
	},

	[652] = {
		name = "矿区",
		imageType = 0,
		pos = {1232,682},
		itemout = {45234},
		nodes = { [100212] = 89, },
	},

	[653] = {
		name = "矿区",
		imageType = 0,
		pos = {528,947},
		itemout = {45234},
		nodes = { [100237] = 53, },
	},

	[654] = {
		name = "矿区",
		imageType = 0,
		pos = {242,712},
		itemout = {45234},
		nodes = { [100250] = 55, },
	},

	[655] = {
		name = "矿区",
		imageType = 0,
		pos = {494,536},
		itemout = {45234},
		nodes = { [100309] = 42, },
	},

	[656] = {
		name = "矿区",
		imageType = 0,
		pos = {928,283},
		itemout = {45234},
		nodes = { [100170] = 59, },
	},

	[660] = {
		name = "伐木区",
		imageType = 0,
		pos = {1511,931},
		itemout = {44180,45230},
		nodes = { [100323] = 33, },
	},

	[661] = {
		name = "伐木区",
		imageType = 0,
		pos = {1445,697},
		itemout = {44180,45230},
		nodes = { [100190] = 43, },
	},

	[662] = {
		name = "伐木区",
		imageType = 0,
		pos = {1024,690},
		itemout = {44180,45230},
		nodes = { [100315] = 29, },
	},

	[663] = {
		name = "伐木区",
		imageType = 0,
		pos = {638,296},
		itemout = {44180,45230,44357},
		nodes = { [100293] = 52, },
	},

	[664] = {
		name = "伐木区",
		imageType = 0,
		pos = {172,365},
		itemout = {44180,45230},
		nodes = { [100267] = 87, },
	},

	[665] = {
		name = "伐木区",
		imageType = 0,
		pos = {205,894},
		itemout = {44180,45230},
		nodes = { [1002541] = 55, },
	},

	[666] = {
		name = "伐木区",
		imageType = 0,
		pos = {1384,299},
		itemout = {44180,45230},
		nodes = { [100153] = 50, },
	},

	[667] = {
		name = "伐木区",
		imageType = 0,
		pos = {1913,327},
		itemout = {44180,45230},
		nodes = { [100139] = 84, },
	},

	[670] = {
		name = "狩猎区",
		imageType = 0,
		pos = {1782,670},
		itemout = {45233},
		nodes = { [604] = 71, },
	},

	[671] = {
		name = "狩猎区",
		imageType = 0,
		pos = {1749,355},
		itemout = {45233},
		nodes = { [100138] = 85, },
	},

	[672] = {
		name = "狩猎区",
		imageType = 0,
		pos = {1342,176},
		itemout = {45233},
		nodes = { [100164] = 42, },
	},

	[673] = {
		name = "狩猎区",
		imageType = 0,
		pos = {1352,763},
		itemout = {45233},
		nodes = { [100192] = 59, },
	},

	[674] = {
		name = "狩猎区",
		imageType = 0,
		pos = {913,806},
		itemout = {45233},
		nodes = { [100218] = 48, },
	},

	[675] = {
		name = "狩猎区",
		imageType = 0,
		pos = {485,754},
		itemout = {45233},
		nodes = { [100245] = 45, },
	},

	[676] = {
		name = "狩猎区",
		imageType = 0,
		pos = {361,368},
		itemout = {45233},
		nodes = { [100288] = 70, },
	},

	[677] = {
		name = "狩猎区",
		imageType = 0,
		pos = {1514,537},
		itemout = {45233},
		nodes = { [100175] = 63, },
	},

	[100002] = {
		pos = {1737,907},
		nodes = { [100006] = 60, [1000031] = 64, [100009] = 87, [650] = 71, },
	},

	[1000031] = {
		pos = {1700,959},
		npcout = {11125},
		nodes = { [100002] = 64, [100004] = 30, },
	},

	[1000161] = {
		pos = {1357,841},
		npcout = {10074},
		nodes = { [304] = 54, [1000171] = 86, [614] = 44, },
	},

	[1000171] = {
		pos = {1282,798},
		npcout = {51055},
		nodes = { [1000161] = 86, [100] = 39, [310] = 60, },
	},

	[100133] = {
		pos = {1860,828},
		npcout = {90004},
		nodes = { [105] = 32, [603] = 66, [1003561] = 30, },
	},

	[1001341] = {
		pos = {1811,579},
		npcout = {52001},
		nodes = { [275] = 37, [285] = 44, },
	},

	[1001661] = {
		pos = {1213,185},
		npcout = {12051},
		nodes = { [100164] = 111, [100167] = 91, },
	},

	[100184] = {
		pos = {1584,681},
		nodes = { [100183] = 40, [110] = 22, [100185] = 35, },
	},

	[100197] = {
		pos = {1212,462},
		nodes = { [40] = 47, [390] = 26, },
	},

	[1001991] = {
		pos = {1229,567},
		npcout = {12047},
		nodes = { [616] = 37, [615] = 80, [100208] = 43, },
	},

	[1002021] = {
		pos = {1110,424},
		npcout = {10015},
		nodes = { [100201] = 40, [1002031] = 54, [526] = 66, },
	},

	[1002031] = {
		pos = {1057,438},
		npcout = {10070,11512},
		nodes = { [1002021] = 54, [115] = 51, [145] = 49, },
	},

	[100207] = {
		pos = {1107,539},
		npcout = {15803,15804},
		nodes = { [100206] = 41, [120] = 27, },
	},

	[1002101] = {
		pos = {1161,756},
		npcout = {10017,10018,10019,10020,10021,10022},
		nodes = { [42] = 53, [310] = 76, },
		event = {
			[1] = {
				conditions ={skills = {{476,50},{279,50},},jobSkill = 60,mor = 500,noSkill = 253,noTags = 50218,},
				funcType = FuncType.NpcTalk,
				npcId = 100016,
				block = true,
			},

		},
	},

	[1002111] = {
		pos = {1258,729},
		npcout = {10035},
		nodes = { [310] = 35, [100212] = 55, },
	},

	[100215] = {
		pos = {1164,908},
		nodes = { [502] = 64, [385] = 37, },
	},

	[1002171] = {
		pos = {1014,790},
		npcout = {12040},
		nodes = { [100216] = 56, [100218] = 61, },
	},

	[1002211] = {
		pos = {1071,892},
		npcout = {15710},
		nodes = { [100220] = 42, [100222] = 35, },
	},

	[1002231] = {
		pos = {1073,959},
		npcout = {15712,21205},
		nodes = { [100222] = 38, [380] = 66, },
	},

	[1002241] = {
		pos = {868,859},
		npcout = {12049},
		nodes = { [408] = 65, [100225] = 65, },
	},

	[1002311] = {
		pos = {693,986},
		npcout = {20505},
		nodes = { [100230] = 57, [415] = 48, },
	},

	[1002541] = {
		pos = {251,925},
		npcout = {16015},
		nodes = { [3] = 51, [100255] = 60, [665] = 55, },
	},

	[1002571] = {
		pos = {37,769},
		npcout = {51071},
		nodes = { [100256] = 61, [466] = 43, },
	},

	[1002601] = {
		pos = {16,921},
		npcout = {51099},
		nodes = { [100259] = 51, [375] = 35, },
	},

	[100271] = {
		pos = {445,73},
		nodes = { [46] = 98, [165] = 81, },
	},

	[1002781] = {
		pos = {939,100},
		npcout = {10023},
		nodes = { [100276] = 45, [185] = 67, },
	},

	[100280] = {
		pos = {807,119},
		nodes = { [100279] = 81, [631] = 58, },
	},

	[1002811] = {
		pos = {699,194},
		npcout = {15711,90009},
		nodes = { [2] = 47, [32] = 41, },
	},

	[1003141] = {
		pos = {942,665},
		npcout = {10656},
		nodes = { [622] = 69, [100315] = 68, },
	},

	[100320] = {
		pos = {830,778},
		nodes = { [100319] = 35, [245] = 25, },
	},

	[100325] = {
		pos = {1336,926},
		npcout = {15505},
		nodes = { [100324] = 99, [352] = 66, },
	},

	[560] = {
		name = LocalStrEnum.XiaKeDao,
		imageType = 0,
		path = "xiakedao/xiakedao",
		pos = {2216,454},
		npcout = {15801},
		enter = {560,10000},
	},

	[565] = {
		name = LocalStrEnum.TaoHuaDaoMaTou,
		imageType = 0,
		path = "taohuadao/taohuadaomatou",
		pos = {2111,570},
		enter = {565,10000},
	},

	[570] = {
		name = LocalStrEnum.ShenLongDao,
		imageType = 1,
		path = "shenlongdao/shenlongdao",
		pos = {2212,699},
		enter = {570,10000},
	},

	[1003561] = {
		pos = {1830,832},
		npcout = {52403},
		nodes = { [100133] = 30, [524] = 39, },
	},

	[575] = {
		name = LocalStrEnum.BingHuoDao,
		imageType = 0,
		path = "binghuodao/binghuodao1",
		pos = {2138,866},
		enter = {575,10000},
	},

	[576] = {
		name = LocalStrEnum.BingHuoDao,
		imageType = 0,
		path = "binghuodao/binghuodao2",
		enter = {576,10000},
	},

	[577] = {
		name = LocalStrEnum.BingHuoDao,
		imageType = 0,
		path = "binghuodao/binghuodao3",
		enter = {577,10000},
	},

	[465] = {
		name = LocalStrEnum.DaLiHuangGong,
		imageType = 1,
		path = "dali/dalihuanggong",
		enter = {465,10000},
	},

	[467] = {
		name = "天龙寺",
		imageType = 0,
		path = "dali/tianlongsi",
		enter = {467,10000},
	},

	[478] = {
		name = "天龙寺庙",
		imageType = 0,
		path = "dali/tianlongsimiao",
		enter = {478,10000},
	},

	[2200002] = {
	},

	[2200003] = {
	},

	[2200004] = {
	},

	[2200005] = {
	},

	[2200006] = {
	},

	[2200007] = {
	},

	[2200008] = {
	},

	[2200009] = {
	},

	[2200013] = {
	},

	[2200014] = {
	},

	[2200015] = {
	},

	[221] = {
		name = LocalStrEnum.TongDao,
		imageType = 0,
		path = "guangmingding/tongdao",
		enter = {221,10000},
	},

	[2000001] = {
	},

	[2000002] = {
	},

	[2000003] = {
	},

	[2000004] = {
	},

	[2000005] = {
	},

	[2000006] = {
	},

	[2000007] = {
	},

	[2000008] = {
	},

	[2000011] = {
	},

	[2000012] = {
	},

	[2000013] = {
	},

	[2000014] = {
	},

	[2000015] = {
	},

	[281] = {
		name = "衡山",
		imageType = 1,
		path = "hengshan2/hengshan2",
		enter = {281,10000},
	},

	[416] = {
		name = "监狱",
		imageType = 0,
		path = "prison",
		enter = {416,30001},
	},

	[101] = {
		name = "华山",
		imageType = 1,
		path = "huashan/huashan_nei",
		enter = {101,10004},
	},

	[102] = {
		name = LocalStrEnum.SiGuoYa,
		imageType = 0,
		path = "huashan/huashan_siguoya",
		enter = {102,10001},
	},

	[166] = {
		name = "黑木崖上",
		imageType = 1,
		path = "heimuya/heimuyashang",
		enter = {166,10000},
	},

	[126] = {
		name = "恒山山道",
		imageType = 1,
		path = "hengshan/hengshan_nei",
		enter = {126,10000},
	},

	[391] = {
		name = "剑冢内",
		imageType = 0,
		path = "jianzhong/jianzhong-nei",
		enter = {391,10001},
	},

	[246] = {
		name = LocalStrEnum.JueQingGu,
		imageType = 0,
		path = "jueqinggu/jueqinggunei",
		enter = {246,10000},
	},

	[249] = {
		name = LocalStrEnum.JueQingGuDi,
		imageType = 0,
		path = "jueqinggu/jueqinggudi1",
		enter = {249,10000},
	},

	[248] = {
		name = LocalStrEnum.JueQingGuXia,
		imageType = 0,
		path = "jueqinggu/jueqinggudi2",
		enter = {248,10000},
	},

	[247] = {
		name = LocalStrEnum.JueQingGuShanYa,
		imageType = 0,
		path = "jueqinggu/jueqinggudi3",
		enter = {247,10000},
	},

	[456] = {
		name = LocalStrEnum.KunLunDaDian,
		imageType = 1,
		path = "kunlun/kunlundadian",
		enter = {456,10000},
	},

	[446] = {
		name = LocalStrEnum.SongShanNei,
		imageType = 0,
		path = "kunlunxianjing/kunlunxianjing",
		enter = {446,10000},
	},

	[206] = {
		name = LocalStrEnum.LingJiuNei,
		imageType = 1,
		path = "lingjiu_nei",
		enter = {206,10001},
	},

	[361] = {
		name = "绿柳庄",
		imageType = 1,
		path = "lvliuzhuang/lvliuzhuang",
		enter = {361,10000},
	},

	[401] = {
		name = "梅庄",
		imageType = 1,
		path = "meizhuang/meizhuangnei",
		enter = {401,10000},
	},

	[402] = {
		name = "地牢",
		imageType = 0,
		path = "meizhuang/meizhuangdilao",
		enter = {402,10000},
	},

	[106] = {
		name = "少林",
		imageType = 1,
		path = "shaolin/shaolin_nei",
		enter = {106,10004},
	},

	[141] = {
		name = LocalStrEnum.SongShanNei,
		imageType = 0,
		path = "songshan/songshan_nei",
		enter = {141,10000},
	},

	[142] = {
		name = LocalStrEnum.SongShanHouShan,
		imageType = 0,
		path = "songshan/songshan_houshan",
		enter = {142,10000},
	},

	[566] = {
		name = LocalStrEnum.TaoHuaDao,
		imageType = 1,
		path = "taohuadao/taohuadao",
		enter = {566,10000},
	},

	[121] = {
		name = "重阳山道",
		imageType = 0,
		path = "quanzhen/quanzhen_nei",
		enter = {121,10004},
	},

	[122] = {
		name = "全真后山",
		imageType = 0,
		path = "quanzhen/quanzhen_houshan",
		enter = {122,10003},
	},

	[111] = {
		name = "武当",
		imageType = 0,
		path = "wudang_nei",
		enter = {111,10008},
	},

	[5600001] = {
		enter = {5600001,10000},
	},

	[5600002] = {
		enter = {5600002,10000},
	},

	[5600003] = {
		enter = {5600003,10000},
	},

	[5600004] = {
		enter = {5600004,10000},
	},

	[5600005] = {
		enter = {5600005,10000},
	},

	[5600006] = {
		enter = {5600006,10000},
	},

	[561] = {
		name = LocalStrEnum.XiaKeDao,
		imageType = 0,
		path = "xiakedao/xiakedao_yinbinguan",
		npcout = {15801},
		enter = {561,10000},
	},

	[156] = {
		name = "血刀内",
		imageType = 0,
		path = "xuedao/xuedao_nei",
		enter = {156,10000},
	},

	[157] = {
		name = "血刀练武场",
		imageType = 0,
		path = "xuedao/xuedao_lianwuchang",
		enter = {157,10000},
	},

	[470] = {
		name = "西夏宫殿",
		imageType = 1,
		path = "xixia/xixiagongdian",
		enter = {470,10000},
	},

	[468] = {
		name = "西夏皇宫",
		imageType = 1,
		path = "xixia/xixiahuanggong",
		enter = {468,10000},
	},

	[473] = {
		name = "西夏迷宫1",
		imageType = 1,
		path = "xixia/huanggongmidao1",
		enter = {473,10000},
	},

	[477] = {
		name = "西夏后山",
		imageType = 1,
		path = "xixia/huanggonghoushan",
		enter = {477,10000},
	},

	[474] = {
		name = "西夏迷宫2",
		imageType = 1,
		path = "xixia/huanggongmidao2",
		enter = {474,10000},
	},

	[475] = {
		name = "走廊1",
		imageType = 1,
		path = "xixia/huanggongzoulang1",
		enter = {475,10000},
	},

	[476] = {
		name = "走廊2",
		imageType = 1,
		path = "xixia/huanggongzoulang2",
		enter = {476,10000},
	},

	[472] = {
		name = "冰室",
		imageType = 1,
		path = "xixia/bingshi",
		enter = {468,10000},
	},

	[136] = {
		name = LocalStrEnum.XueShanShanDao,
		imageType = 0,
		path = "xueshan/xueshan_shandao",
		enter = {136,10000},
	},

	[471] = {
		name = LocalStrEnum.LiChunYuan,
		imageType = 0,
		path = "yangzhou/lichunyuan",
		enter = {471,10000},
	},

	[2400001] = {
	},

	[2400002] = {
	},

	[2400003] = {
	},

	[2400011] = {
	},

	[2400012] = {
	},

	[2400013] = {
	},

	[2400014] = {
	},

	[241] = {
		name = "燕子坞",
		imageType = 0,
		path = "yanziwu/yanziwu",
		enter = {241,10000},
	},

	[242] = {
		name = "王语嫣宅",
		imageType = 0,
		path = "yanziwu/yanziwu_nei",
		enter = {242,10000},
	},

	[353] = {
		name = "雁门关山道",
		imageType = 1,
		path = "yanmenguan/yanmenguanshandao",
		enter = {353,10000},
	},

	[354] = {
		name = "雁门关下",
		imageType = 1,
		path = "yanmenguan/yanmenguanxia",
		enter = {354,10000},
	},

	[355] = {
		name = "雁门关上",
		imageType = 1,
		path = "yanmenguan/yanmenguanshang",
		enter = {355,10000},
	},

	[35] = {
		pos = {1881,494},
		nodes = { [100136] = 38, [100137] = 39, },
	},

	[39] = {
		pos = {1330,583},
		nodes = { [100178] = 34, [100179] = 49, },
	},

	[185] = {
		pos = {999,130},
		nodes = { [1002781] = 67, },
	},

	[190] = {
		pos = {171,432},
		nodes = { [100266] = 44, },
	},

	[195] = {
		pos = {1499,377},
		nodes = { [100154] = 46, [100155] = 47, },
	},

	[200] = {
		pos = {260,338},
		nodes = { [100267] = 77, [100268] = 83, [100288] = 64, },
	},

	[235] = {
		pos = {1065,237},
		nodes = { [100167] = 69, [100168] = 50, [506] = 68, },
	},

	[260] = {
		pos = {947,361},
		nodes = { [100170] = 35, [619] = 34, [100299] = 62, },
	},

	[265] = {
		pos = {834,617},
		nodes = { [100229] = 26, [100301] = 40, [100302] = 108, },
	},

	[270] = {
		pos = {284,644},
		nodes = { [100247] = 38, [100248] = 49, [100312] = 38, },
	},

	[285] = {
		pos = {1854,587},
		nodes = { [1001341] = 44, [100135] = 34, },
	},

	[350] = {
		pos = {1780,47},
		nodes = { [100145] = 34, [100146] = 27, },
	},

	[365] = {
		pos = {718,25},
		nodes = { [100273] = 35, [100274] = 134, },
	},

	[500] = {
		pos = {624,706},
		nodes = { [315] = 70, [320] = 55, },
	},

	[504] = {
		pos = {637,377},
		nodes = { [100291] = 73, [100298] = 72, },
	},

	[510] = {
		pos = {1618,540},
		nodes = { [608] = 38, },
	},

	[514] = {
		pos = {772,284},
		nodes = { [100294] = 28, },
	},

	[518] = {
		pos = {1638,166},
		nodes = { [100147] = 64, [100148] = 57, },
	},

	[522] = {
		pos = {585,199},
		nodes = { [100282] = 54, [100283] = 31, },
	},

	[524] = {
		pos = {1791,830},
		nodes = { [601] = 31, [1003561] = 39, },
	},

	[100004] = {
		pos = {1685,986},
		nodes = { [1000031] = 30, },
	},

	[100006] = {
		pos = {1798,909},
		nodes = { [600] = 18, [601] = 51, [100002] = 60, },
	},

	[100009] = {
		pos = {1650,905},
		nodes = { [130] = 72, [100002] = 87, [100010] = 42, },
	},

	[100010] = {
		pos = {1608,907},
		nodes = { [100009] = 42, [508] = 22, [100012] = 56, },
	},

	[100012] = {
		pos = {1551,904},
		nodes = { [100010] = 56, [634] = 76, },
	},

	[100014] = {
		pos = {1469,829},
		nodes = { [634] = 35, [304] = 58, [100189] = 94, },
	},

	[100130] = {
		pos = {1935,860},
		nodes = { [602] = 23, [140] = 27, },
	},

	[100131] = {
		pos = {1911,807},
		nodes = { [140] = 34, [105] = 23, [100132] = 23, },
	},

	[100132] = {
		pos = {1901,786},
		nodes = { [100131] = 23, [300] = 25, },
	},

	[100135] = {
		pos = {1841,555},
		nodes = { [285] = 34, [100136] = 38, },
	},

	[100136] = {
		pos = {1851,517},
		nodes = { [100135] = 38, [35] = 38, },
	},

	[100137] = {
		pos = {1852,468},
		nodes = { [35] = 39, [606] = 48, [100159] = 42, },
	},

	[100138] = {
		pos = {1832,379},
		nodes = { [606] = 44, [435] = 40, [100139] = 28, [671] = 85, },
	},

	[100139] = {
		pos = {1832,350},
		nodes = { [100138] = 28, [609] = 65, [667] = 84, },
	},

	[100140] = {
		pos = {1884,224},
		nodes = { [34] = 48, [395] = 53, },
	},

	[100141] = {
		pos = {1834,211},
		nodes = { [34] = 29, [4] = 33, },
	},

	[100142] = {
		pos = {1843,141},
		nodes = { [4] = 54, [100143] = 34, },
	},

	[100143] = {
		pos = {1845,107},
		nodes = { [100142] = 34, [100144] = 29, },
	},

	[100144] = {
		pos = {1836,79},
		nodes = { [100143] = 29, [100145] = 30, },
	},

	[100145] = {
		pos = {1812,59},
		nodes = { [100144] = 30, [350] = 34, },
	},

	[100146] = {
		pos = {1753,54},
		nodes = { [350] = 27, [610] = 55, },
	},

	[100147] = {
		pos = {1667,108},
		nodes = { [610] = 45, [518] = 64, },
	},

	[100148] = {
		pos = {1592,132},
		nodes = { [518] = 57, [100149] = 51, [651] = 63, },
	},

	[100149] = {
		pos = {1543,118},
		nodes = { [100148] = 51, [38] = 55, },
	},

	[100150] = {
		pos = {1450,146},
		nodes = { [38] = 58, [100151] = 40, },
	},

	[100151] = {
		pos = {1423,177},
		nodes = { [100150] = 40, [100152] = 87, [100165] = 61, },
	},

	[100152] = {
		pos = {1420,264},
		nodes = { [100151] = 87, [100153] = 44, },
	},

	[100153] = {
		pos = {1433,306},
		nodes = { [100152] = 44, [100154] = 50, [666] = 50, },
	},

	[100154] = {
		pos = {1462,349},
		nodes = { [100153] = 50, [195] = 46, [100161] = 32, },
	},

	[100155] = {
		pos = {1525,418},
		nodes = { [195] = 47, [611] = 41, [100156] = 57, },
	},

	[100156] = {
		pos = {1579,436},
		nodes = { [100155] = 57, [400] = 59, },
	},

	[100157] = {
		pos = {1642,406},
		nodes = { [400] = 33, [100158] = 46, },
	},

	[100158] = {
		pos = {1689,403},
		nodes = { [100157] = 46, [607] = 49, },
	},

	[100159] = {
		pos = {1819,442},
		nodes = { [606] = 26, [36] = 46, [100137] = 42, },
	},

	[100160] = {
		pos = {1406,357},
		nodes = { [100161] = 29, [618] = 26, [100162] = 84, },
	},

	[100161] = {
		pos = {1430,341},
		nodes = { [100154] = 32, [100160] = 29, },
	},

	[100162] = {
		pos = {1343,300},
		nodes = { [100160] = 84, [450] = 40, },
	},

	[100164] = {
		pos = {1321,213},
		nodes = { [450] = 51, [100165] = 50, [1001661] = 111, [672] = 42, },
	},

	[100165] = {
		pos = {1371,211},
		nodes = { [100164] = 50, [100151] = 61, },
	},

	[100167] = {
		pos = {1123,198},
		nodes = { [1001661] = 91, [235] = 69, },
	},

	[100168] = {
		pos = {1050,285},
		nodes = { [235] = 50, [506] = 51, [100169] = 39, },
	},

	[100169] = {
		pos = {1022,314},
		nodes = { [100168] = 39, [100170] = 59, },
	},

	[100170] = {
		pos = {965,330},
		nodes = { [100169] = 59, [260] = 35, [656] = 59, },
	},

	[100171] = {
		pos = {1352,409},
		nodes = { [280] = 46, [100172] = 25, },
	},

	[100172] = {
		pos = {1326,409},
		nodes = { [100171] = 25, [100173] = 34, [100194] = 64, },
	},

	[100173] = {
		pos = {1317,443},
		nodes = { [100172] = 34, [305] = 39, },
	},

	[100174] = {
		pos = {1400,508},
		nodes = { [305] = 71, [100175] = 54, },
	},

	[100175] = {
		pos = {1453,519},
		nodes = { [100174] = 54, [100176] = 24, [100177] = 39, [677] = 63, },
	},

	[100176] = {
		pos = {1462,542},
		nodes = { [100175] = 24, [612] = 29, },
	},

	[100177] = {
		pos = {1471,484},
		nodes = { [611] = 51, [100175] = 39, },
	},

	[100178] = {
		pos = {1307,556},
		nodes = { [617] = 31, [39] = 34, },
	},

	[100179] = {
		pos = {1373,558},
		nodes = { [39] = 49, [100180] = 53, },
	},

	[100180] = {
		pos = {1424,575},
		nodes = { [100179] = 53, [100181] = 26, },
	},

	[100181] = {
		pos = {1444,592},
		nodes = { [100180] = 26, [612] = 23, [613] = 36, },
	},

	[100182] = {
		pos = {1739,616},
		nodes = { [275] = 43, [433] = 61, },
	},

	[100183] = {
		pos = {1615,655},
		nodes = { [605] = 30, [100184] = 40, },
	},

	[100185] = {
		pos = {1618,692},
		nodes = { [100184] = 35, [100186] = 63, },
	},

	[100186] = {
		pos = {1651,747},
		nodes = { [100185] = 63, [37] = 67, },
	},

	[100187] = {
		pos = {1531,668},
		nodes = { [110] = 46, [613] = 81, [100190] = 50, },
	},

	[100188] = {
		pos = {1614,787},
		nodes = { [37] = 102, [100189] = 62, },
	},

	[100189] = {
		pos = {1552,785},
		nodes = { [100188] = 62, [100014] = 94, },
	},

	[100190] = {
		pos = {1488,695},
		nodes = { [100187] = 50, [100191] = 51, [661] = 43, },
	},

	[100191] = {
		pos = {1455,735},
		nodes = { [100190] = 51, [100192] = 47, },
	},

	[100192] = {
		pos = {1410,750},
		nodes = { [100191] = 47, [100193] = 37, [673] = 59, },
	},

	[100193] = {
		pos = {1402,786},
		nodes = { [100192] = 37, [304] = 55, },
	},

	[100194] = {
		pos = {1276,368},
		nodes = { [100172] = 64, [100195] = 31, },
	},

	[100195] = {
		pos = {1245,371},
		nodes = { [100194] = 31, [100196] = 39, },
	},

	[100196] = {
		pos = {1227,406},
		nodes = { [100195] = 39, [40] = 70, },
	},

	[100198] = {
		pos = {1209,502},
		nodes = { [390] = 32, [616] = 32, },
	},

	[100200] = {
		pos = {1337,670},
		nodes = { [615] = 68, [441] = 30, },
	},

	[100201] = {
		pos = {1144,447},
		nodes = { [390] = 54, [1002021] = 40, },
	},

	[100204] = {
		pos = {1024,511},
		nodes = { [115] = 28, [620] = 58, },
	},

	[100205] = {
		pos = {1065,593},
		nodes = { [620] = 34, [100206] = 39, [621] = 45, },
	},

	[100206] = {
		pos = {1069,554},
		nodes = { [620] = 28, [100205] = 39, [100207] = 41, },
	},

	[100208] = {
		pos = {1188,551},
		nodes = { [120] = 57, [1001991] = 43, [210] = 56, },
	},

	[100209] = {
		pos = {1079,709},
		nodes = { [621] = 77, [42] = 43, },
	},

	[100212] = {
		pos = {1313,721},
		nodes = { [1002111] = 55, [441] = 32, [652] = 89, },
	},

	[100214] = {
		pos = {1298,899},
		nodes = { [614] = 37, [41] = 60, },
	},

	[100216] = {
		pos = {1070,795},
		nodes = { [632] = 53, [1002171] = 56, },
	},

	[100218] = {
		pos = {960,820},
		nodes = { [1002171] = 61, [408] = 52, [674] = 48, },
	},

	[100219] = {
		pos = {954,891},
		nodes = { [408] = 32, [100220] = 76, },
	},

	[100220] = {
		pos = {1030,881},
		nodes = { [100219] = 76, [1002211] = 42, },
	},

	[100222] = {
		pos = {1088,924},
		nodes = { [1002211] = 35, [1002231] = 38, },
	},

	[100225] = {
		pos = {810,888},
		nodes = { [1002241] = 65, [44] = 52, },
	},

	[100226] = {
		pos = {871,818},
		nodes = { [408] = 78, [245] = 52, },
	},

	[100227] = {
		pos = {802,777},
		nodes = { [245] = 31, [624] = 35, },
	},

	[100228] = {
		pos = {742,731},
		nodes = { [624] = 42, [430] = 63, },
	},

	[100229] = {
		pos = {836,643},
		nodes = { [430] = 72, [622] = 47, [265] = 26, },
	},

	[100230] = {
		pos = {749,975},
		nodes = { [1002311] = 57, [100232] = 29, },
	},

	[100232] = {
		pos = {770,953},
		nodes = { [44] = 25, [100230] = 29, [100233] = 64, },
	},

	[100233] = {
		pos = {711,926},
		nodes = { [100232] = 64, [411] = 40, },
	},

	[100234] = {
		pos = {693,860},
		nodes = { [411] = 31, [45] = 48, },
	},

	[100235] = {
		pos = {642,885},
		nodes = { [411] = 49, [100236] = 71, [100237] = 95, },
	},

	[100236] = {
		pos = {601,827},
		nodes = { [100235] = 71, [625] = 45, },
	},

	[100237] = {
		pos = {547,897},
		nodes = { [100235] = 95, [100238] = 52, [653] = 53, },
	},

	[100238] = {
		pos = {498,879},
		nodes = { [100237] = 52, [100239] = 38, },
	},

	[100239] = {
		pos = {465,860},
		nodes = { [100238] = 38, [370] = 41, },
	},

	[100240] = {
		pos = {407,871},
		nodes = { [370] = 23, [100241] = 76, [100243] = 27, },
	},

	[100241] = {
		pos = {331,881},
		nodes = { [100240] = 76, [3] = 41, },
	},

	[100242] = {
		pos = {310,936},
		nodes = { [3] = 46, [205] = 34, },
	},

	[100243] = {
		pos = {402,844},
		nodes = { [100240] = 27, [629] = 36, },
	},

	[100244] = {
		pos = {447,786},
		nodes = { [629] = 36, [100245] = 34, },
	},

	[100245] = {
		pos = {440,753},
		nodes = { [100244] = 34, [47] = 27, [675] = 45, },
	},

	[100246] = {
		pos = {339,708},
		nodes = { [47] = 82, [100247] = 47, },
	},

	[100247] = {
		pos = {303,678},
		nodes = { [100246] = 47, [270] = 38, },
	},

	[100248] = {
		pos = {235,640},
		nodes = { [270] = 49, [445] = 47, },
	},

	[100250] = {
		pos = {190,693},
		nodes = { [445] = 27, [455] = 46, [654] = 55, },
	},

	[100252] = {
		pos = {171,766},
		nodes = { [455] = 75, [627] = 35, },
	},

	[100253] = {
		pos = {203,813},
		nodes = { [627] = 22, [160] = 48, [628] = 22, },
	},

	[100255] = {
		pos = {191,934},
		nodes = { [1002541] = 60, [33] = 49, },
	},

	[100256] = {
		pos = {69,716},
		nodes = { [455] = 78, [1002571] = 61, },
	},

	[100259] = {
		pos = {10,869},
		nodes = { [466] = 59, [1002601] = 51, },
	},

	[100261] = {
		pos = {109,659},
		nodes = { [455] = 50, [100262] = 31, },
	},

	[100262] = {
		pos = {96,630},
		nodes = { [100261] = 31, [100263] = 37, [100265] = 89, },
	},

	[100263] = {
		pos = {60,643},
		nodes = { [100262] = 37, [220] = 33, },
	},

	[100265] = {
		pos = {127,546},
		nodes = { [100262] = 89, [633] = 43, },
	},

	[100266] = {
		pos = {207,456},
		nodes = { [633] = 77, [190] = 44, [100267] = 56, },
	},

	[100267] = {
		pos = {244,413},
		nodes = { [100266] = 56, [200] = 77, [664] = 87, },
	},

	[100268] = {
		pos = {273,255},
		nodes = { [200] = 83, [100269] = 73, },
	},

	[100269] = {
		pos = {312,194},
		nodes = { [100268] = 73, [100270] = 48, },
	},

	[100270] = {
		pos = {353,167},
		nodes = { [100269] = 48, [46] = 44, },
	},

	[100272] = {
		pos = {569,10},
		nodes = { [165] = 59, [100273] = 115, },
	},

	[100273] = {
		pos = {685,13},
		nodes = { [100272] = 115, [365] = 35, },
	},

	[100274] = {
		pos = {853,28},
		nodes = { [365] = 134, [100275] = 43, },
	},

	[100275] = {
		pos = {895,41},
		nodes = { [100274] = 43, [100276] = 28, },
	},

	[100276] = {
		pos = {916,60},
		nodes = { [100275] = 28, [100277] = 42, [1002781] = 45, [100279] = 48, },
	},

	[100277] = {
		pos = {952,38},
		nodes = { [100276] = 42, [520] = 48, },
	},

	[100279] = {
		pos = {885,98},
		nodes = { [100276] = 48, [100280] = 81, },
	},

	[100282] = {
		pos = {625,162},
		nodes = { [626] = 67, [522] = 54, },
	},

	[100283] = {
		pos = {558,183},
		nodes = { [522] = 31, [100284] = 43, },
	},

	[100284] = {
		pos = {520,204},
		nodes = { [100283] = 43, [100285] = 37, },
	},

	[100285] = {
		pos = {498,233},
		nodes = { [100284] = 37, [100286] = 35, },
	},

	[100286] = {
		pos = {468,214},
		nodes = { [100285] = 35, [100287] = 55, },
	},

	[100287] = {
		pos = {432,171},
		nodes = { [100286] = 55, [46] = 37, },
	},

	[100288] = {
		pos = {319,311},
		nodes = { [200] = 64, [100289] = 137, [676] = 70, },
	},

	[100289] = {
		pos = {456,324},
		nodes = { [100288] = 137, [100290] = 85, },
	},

	[100290] = {
		pos = {529,368},
		nodes = { [100289] = 85, [100291] = 45, },
	},

	[100291] = {
		pos = {566,394},
		nodes = { [100290] = 45, [504] = 73, },
	},

	[100292] = {
		pos = {663,261},
		nodes = { [32] = 35, [100293] = 53, },
	},

	[100293] = {
		pos = {689,308},
		nodes = { [100292] = 53, [100294] = 68, [100295] = 70, [663] = 52, },
	},

	[100294] = {
		pos = {746,271},
		nodes = { [100293] = 68, [514] = 28, },
	},

	[100295] = {
		pos = {755,334},
		nodes = { [100293] = 70, [100296] = 35, },
	},

	[100296] = {
		pos = {779,360},
		nodes = { [100295] = 35, [100297] = 43, },
	},

	[100297] = {
		pos = {782,404},
		nodes = { [100296] = 43, [100298] = 81, [100299] = 109, [630] = 68, },
	},

	[100298] = {
		pos = {701,412},
		nodes = { [504] = 72, [100297] = 81, },
	},

	[100299] = {
		pos = {885,367},
		nodes = { [100297] = 109, [260] = 62, },
	},

	[100300] = {
		pos = {882,497},
		nodes = { [630] = 69, [360] = 24, [623] = 64, },
	},

	[100301] = {
		pos = {817,579},
		nodes = { [623] = 43, [265] = 40, },
	},

	[100302] = {
		pos = {732,579},
		nodes = { [265] = 108, [100303] = 58, [100304] = 37, },
	},

	[100303] = {
		pos = {686,543},
		nodes = { [100302] = 58, [135] = 54, },
	},

	[100304] = {
		pos = {721,615},
		nodes = { [100302] = 37, [100305] = 43, },
	},

	[100305] = {
		pos = {680,625},
		nodes = { [100304] = 43, [315] = 29, },
	},

	[100306] = {
		pos = {613,598},
		nodes = { [315] = 66, [155] = 39, },
	},

	[100307] = {
		pos = {593,746},
		nodes = { [320] = 35, [625] = 35, },
	},

	[100308] = {
		pos = {591,556},
		nodes = { [135] = 43, [155] = 31, },
	},

	[100309] = {
		pos = {518,571},
		nodes = { [155] = 59, [100310] = 39, [655] = 42, },
	},

	[100310] = {
		pos = {482,589},
		nodes = { [100309] = 39, [512] = 49, },
	},

	[100311] = {
		pos = {389,618},
		nodes = { [512] = 79, [100312] = 73, },
	},

	[100312] = {
		pos = {322,648},
		nodes = { [100311] = 73, [270] = 38, },
	},

	[100315] = {
		pos = {998,705},
		nodes = { [1003141] = 68, [100316] = 57, [100317] = 55, [662] = 29, },
	},

	[100316] = {
		pos = {1052,724},
		nodes = { [100315] = 57, [42] = 59, },
	},

	[100317] = {
		pos = {964,748},
		nodes = { [100315] = 55, [100318] = 46, },
	},

	[100318] = {
		pos = {919,760},
		nodes = { [100317] = 46, [100319] = 57, },
	},

	[100319] = {
		pos = {861,761},
		nodes = { [100318] = 57, [100320] = 35, },
	},

	[100322] = {
		pos = {1520,879},
		nodes = { [634] = 37, [100012] = 38, [100323] = 49, },
	},

	[100323] = {
		pos = {1483,912},
		nodes = { [100322] = 49, [100324] = 49, [660] = 33, },
	},

	[100324] = {
		pos = {1436,927},
		nodes = { [100323] = 49, [100325] = 99, },
	},

	[100351] = {
		pos = {721,170},
		nodes = { [626] = 31, [2] = 29, },
	},

	[100355] = {
		pos = {1686,474},
		nodes = { [400] = 58, [240] = 43, },
	},

}

return map
