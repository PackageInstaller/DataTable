require "CommonType"

local pos1 = {
	name = "小喽啰们",
	friends = { 
		{ index = 11, uid = -1 },
	},

	enemies = {
		{ index = 11, uid = 90000 },
		{ index = 12, uid = 90002 },
	},
}

local pos2 = {
	name = "日月会四护法",
	friends = { 
		{ index = 11, uid = -1 },
	},

	enemies = {
		{ index = 7, uid = 51082 },
		{ index = 9, uid = 51083 },
		{ index = 13, uid = 51084 },
		{ index = 15, uid = 51085 },
	},
}
local pos3 = {
	name = "侠客岛主",
	friends = { 
		{ index = 11, uid = -1 },
	},

	enemies = {
		{ index = 4, uid = 51025 },
		{ index = 18, uid = 51026 },
	},
}
local pos4 = {
	name = "全真七子",
	friends = { 
		{ index = 11, uid = -1 },
	},

	enemies = {
		{ index = 1, uid = 12011 },
		{ index = 5, uid = 51062 },
		{ index = 9, uid = 12008 },
		{ index = 11, uid = 12014 },
		{ index = 15, uid = 12017 },
		{ index = 17, uid = 12006 },
		{ index = 19, uid = 12015 },
	},
}
local pos5 = {
	name = "日月会左右使",
	friends = { 
		{ index = 11, uid = -1 },
	},

	enemies = {
		{ index = 8, uid = 50038 },
		{ index = 14, uid = 51054 },
	},
}

local pos6 = {
	name = "武当七侠",
	friends = { 
		{ index = 11, uid = -1 },
	},

	enemies = {
		{ index = 1, uid = 11111 },
		{ index = 4, uid = 11112 },
		{ index = 8, uid = 11123 },
		{ index = 11, uid = 11109 },
		{ index = 15, uid = 11125 },
		{ index = 18, uid = 11118 },
		{ index = 19, uid = 11105 },
	},
}

local pos7 = {
	name = "苦门三老",
	friends = { 
		{ index = 11, uid = -1 },
	},

	enemies = {
		{ index = 7, uid = 10610},
		{ index = 14, uid = 10611 },
		{ index = 21, uid = 10612 },
	},
}

local pos8 = {
	name = "梅庄四友",
	friends = { 
		{ index = 11, uid = -1 },
	},

	enemies = {
		{ index = 1, uid = 10028},
		{ index = 7, uid = 10029 },
		{ index = 13, uid = 10030 },
		{ index = 19, uid = 10031 },
	},
}
local pos9 = {
	name = "曲洋刘正风",
	friends = { 
		{ index = 11, uid = -1 },
	},

	enemies = {
		{ index = 10, uid = 10025},
		{ index = 12, uid = 10012 },

	},
}
local pos10 = {
	name = "四大恶人",
	friends = { 
		{ index = 11, uid = -1 },
	},

	enemies = {
		{ index = 1, uid = 51110},
		{ index = 3, uid = 51111 },
		{ index = 5, uid = 51112 },
		{ index = 7, uid = 51113 },
	},
}
local pos11 = {
	name = "阿朱阿碧",
	friends = { 
		{ index = 11, uid = -1 },
	},

	enemies = {
		{ index = 11, uid = 51118},
		{ index = 12, uid = 51119 },
	},
}
local pos12 = {
	name = "慕容四家将",
	friends = { 
		{ index = 11, uid = -1 },
	},

	enemies = {
		{ index = 14, uid = 51114},
		{ index = 10, uid = 51115 },
		{ index = 8, uid = 51116 },
		{ index = 11, uid = 51117 },
	},
}
local pos13 = {
	name = "胖瘦头陀",
	friends = { 
		{ index = 11, uid = -1 },
	},

	enemies = {
		{ index = 7, uid = 51120},
		{ index = 13, uid = 51121 },
	},
}
local pos14 = {
	name = "桃谷六仙",
	friends = { 
		{ index = 11, uid = -1 },
	},

	enemies = {
		{ index = 3, uid = 10017},
		{ index = 6, uid = 10018 },
		{ index = 9, uid = 10019 },
		{ index = 12, uid = 10020 },
		{ index = 15, uid = 10021 },
		{ index = 18, uid = 10022 },
	},
}
local compete_rank = {

	-- 琅琊榜
	[-1] = {
		{ id = 51001, level = 500, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 达摩祖师
		{ id = 51002, level = 495, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 无名老僧
		{ id = 51003, level = 490, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 逍遥祖师
		{ id = 51006, level = 485, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 独孤求败
		{ id = 51007, level = 480, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 黄裳
		{ id = 11605, level = 480, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 段誉
		{ id = 51009, level = 475, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 东方不败
		{ id = 11101, level = 475, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 张三丰
		{ id = 51011, level = 470, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 萧峰
		{ id = 11604, level = 470, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 虚竹
		{ id = 51013, level = 465, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 石破天
		{ id = 51014, level = 465, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 无崖子
		{ id = 51015, level = 460, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 萧远山
		{ id = 51016, level = 460, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 慕容博
		{ id = 51017, level = 455, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 鸠摩智
		{ id = 51018, level = 455, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 空见神僧
		{ id = 51019, level = 450, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 王重阳
		{ id = 51020, level = 450, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 天山童姥
		{ id = 11130, level = 445, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 张无忌
		{ id = 51022, level = 440, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 李秋水
		{ id = 51023, level = 430, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 郭靖
		{ id = 51024, level = 425, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 杨过
		{ id = 51028, level = 415, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 北丐
		{ id = 51029, level = 410, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 南帝
		{ id = 51030, level = 405, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 西毒
		{ id = 51031, level = 400, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 东邪
		{ id = 51027, level = 395, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 周伯通
		{ id = 51032, level = 390, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 丁春秋
		{ id = 51033, level = 385, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 郭襄
		{ id = 51034, level = 375, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 游坦之
		{ id = 51035, level = 370, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 枯荣大师
		{ id = 51036, level = 360, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 慕容复
		{ id = 51037, level = 355, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 晓风师太
		{ id = 51038, level = 350, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 阳顶天
		{ id = 10074, level = 345, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 令狐冲
		{ id = 51039, level = 335, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 林朝英
		{ id = 51040, level = 330, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 方证大师
		{ id = 10024, level = 325, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 风清扬
		{ id = 51042, level = 320, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 东灵道长
		{ id = 51043, level = 315, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 金轮法王
		{ id = 15609, level = 310, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 血门老祖
		{ id = 51045, level = 305, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 任我行
		{ id = 51046, level = 300, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 裘千仞
		{ id = 11601, level = 290, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 灭绝师太
		{ id = 51048, level = 285, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 黄蓉
		{ id = 51049, level = 280, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 公孙止
		{ id = 51050, level = 275, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 小龙女
		{ id = 51054, level = 270, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 左冷禅
		{ id = 51055, level = 265, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 岳不群
		{ id = 51056, level = 260, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 向问天
		{ id = 51047, level = 250, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 梅超风
		{ id = 51057, level = 245, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 林平之
		{ id = 51053, level = 240, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 谢烟客
		{ id = 51058, level = 235, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 狄云
		{ id = 51059, level = 230, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 丁典
		{ id = 51060, level = 230, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 天门道长
		{ id = 51044, level = 225, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 段正淳
		{ id = 51061, level = 220, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 成昆
		{ id = 51062, level = 215, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 袁承志
		{ id = 51063, level = 180, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 夏雪宜
		{ id = 51064, level = 205, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 胡一刀
		{ id = 51065, level = 200, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 归辛树
		{ id = 51066, level = 195, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 洪安通
		{ id = 51067, level = 190, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 木桑道人
		{ id = 51068, level = 185, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 玉真子
		{ id = 51069, level = 150, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 独臂神尼
		{ id = 51070, level = 170, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 陈家洛
		{ id = 51071, level = 165, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 苗人凤
		{ id = 51072, level = 160, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 胡斐
		{ id = 51084, level = 155, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 霍都
		{ id = 51086, level = 145, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 文泰来
		{ id = 51087, level = 130, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 张兆重
		{ id = 51088, level = 120, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 冯锡范
		{ id = 51089, level = 110, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 陈近南
		{ id = 51090, level = 100, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 陆菲青
		{ id = 51091, level = 100, res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 定闲师太
		{ id = 51092, level = 90,  res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 任盈盈
		{ id = 51093, level = 80,  res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 何太冲
		{ id = 10005, level = 70,  res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 田伯光
		{ id = 51094, level = 65,  res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 郭芙
		{ id = 51095, level = 55,  res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 鳌拜
		{ id = 51096, level = 50,  res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 欧阳克
		{ id = 51097, level = 45,  res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 蓝凤凰
		{ id = 51098, level = 40,  res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 杨莲亭
		{ id = 51099, level = 35,  res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 霍青桐
		{ id = 51100, level = 30,  res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 达尔巴
		{ id = 51101, level = 20,  res = {gold = 100, silver = 50000, items = {{44037, 2}, {44038, 2}}} },-- 不戒和尚
	},

	[JobType.None] = {
		{ id = 51024, level = 425, res = {gold = 100, items = {{44038, 2}}} },-- 杨过
		{ id = 51031, level = 395, res = {gold = 100, items = {{44038, 2}}} },-- 东邪
		{ id = 51039, level = 335, res = {gold = 100, items = {{44039, 1}}} },-- 金轮法王
		{ id = 51045, level = 305, res = {gold = 100, items = {{44039, 1}}} },-- 任我行
		{ id = 51056, level = 260, res = {gold = 100, items = {{44038, 2}}} },-- 向问天
		{ id = 51058, level = 235, res = {gold = 100, items = {{44038, 2}}} },-- 狄云
		{ id = pos10, level = 175, res = {gold = 100, items = {{44039, 1}}} },-- 四大恶人
		{ id = 51125, level = 150, res = {gold = 100, items = {{44039, 1}}} },-- 韦一笑
		{ id = 51089, level = 110, res = {gold = 100, items = {{44039, 1}}} },-- 陈近南
		{ id = 10005, level = 70, res = {gold = 100, items = {{44039, 1}}} },-- 田伯光
		{ id = 51116, level = 60 , res = {gold = 100, items = {{44039, 1}}} },-- 包不同
		{ id = pos14, level = 25 , res = {gold = 100, items = {{44039, 1}}} },-- 桃谷六仙
		{ id = 11608, level = 10 , res = {gold = 100, items = {{44039, 1}}} },-- 韦小宝
	}, 

	[JobType.ShaoLin] = {
		{ id = 10657, level = 350, res = {gold = 100, items = {{44038, 2}}} },-- 无色禅师
		{ id = 10649, level = 330, res = {gold = 100, items = {{44039, 1}}} },-- 玄难
		{ id = 10652, level = 310, res = {gold = 100, items = {{44039, 1}}} },-- 玄痛
		{ id = 10504, level = 290, res = {gold = 100, items = {{44039, 1}}} },-- 觉远
		{ id = 10625, level = 250, res = {gold = 100, items = {{44039, 1}}} },-- 金刚
		{ id = 10619, level = 220, res = {gold = 100, items = {{44039, 1}}} },-- 慧虚
		{ id = 10618, level = 190, res = {gold = 100, items = {{44039, 1}}} },-- 慧修
		{ id = 10627, level = 160, res = {gold = 100, items = {{44039, 1}}} },-- 普刚
		{ id = 10628, level = 130, res = {gold = 100, items = {{44039, 1}}} },-- 普戒
		{ id = 10605, level = 100, res = {gold = 100, items = {{44039, 1}}} },-- 澄明
		{ id = 10604, level = 80 , res = {gold = 100, items = {{44039, 1}}} },-- 澄净
		{ id = 10609, level = 60 , res = {gold = 100, items = {{44039, 1}}} },-- 道实
		{ id = 10607, level = 40 , res = {gold = 100, items = {{44039, 1}}} },-- 道尘
	},

	[JobType.WuDang] = {
		{ id = 11101, level = 475, res = {gold = 100, items = {{44038, 2}}} },-- 张三丰
		{ id = 11111, level = 220, res = {gold = 100, items = {{44039, 1}}} },-- 宋远桥
		{ id = 11112, level = 210, res = {gold = 100, items = {{44039, 1}}} },-- 俞莲舟
		{ id = 11123, level = 200, res = {gold = 100, items = {{44039, 1}}} },-- 俞岱岩
		{ id = 11109, level = 190, res = {gold = 100, items = {{44039, 1}}} },-- 张松溪
		{ id = 11125, level = 180, res = {gold = 100, items = {{44039, 1}}} },-- 张翠山
		{ id = 11118, level = 170, res = {gold = 100, items = {{44039, 1}}} },-- 殷梨亭
		{ id = 11105, level = 160, res = {gold = 100, items = {{44039, 1}}} },-- 莫声谷
		{ id = 11102, level = 130, res = {gold = 100, items = {{44039, 1}}} },-- 宋青书
		{ id = 11103, level = 100, res = {gold = 100, items = {{44039, 1}}} },-- 真勇
		{ id = 11108, level = 80 , res = {gold = 100, items = {{44039, 1}}} },-- 真悟
		{ id = 11110, level = 50 , res = {gold = 100, items = {{44039, 1}}} },-- 真意
		{ id = 11121, level = 40 , res = {gold = 100, items = {{44039, 1}}} },-- 真阳
	},

	[JobType.EMei] = {
		{ id = 11601, level = 290, res = {gold = 100, items = {{44038, 2}}} },-- 灭绝师太
		{ id = 11603, level = 270, res = {gold = 100, items = {{44039, 1}}} },-- 静玄
		{ id = 11602, level = 260, res = {gold = 100, items = {{44039, 1}}} },-- 静迦
		{ id = 11701, level = 250, res = {gold = 100, items = {{44039, 1}}} },-- 周芷若
		{ id = 11510, level = 220, res = {gold = 100, items = {{44039, 1}}} },-- 丁敏君
		{ id = 11512, level = 200, res = {gold = 100, items = {{44039, 1}}} },-- 纪晓芙
		{ id = 11702, level = 170, res = {gold = 100, items = {{44039, 1}}} },-- 静象
		{ id = 11703, level = 140, res = {gold = 100, items = {{44039, 1}}} },-- 静阵
		{ id = 11704, level = 120, res = {gold = 100, items = {{44039, 1}}} },-- 静绝
		{ id = 11706, level = 100, res = {gold = 100, items = {{44039, 1}}} },-- 静灭
		{ id = 11708, level = 80 , res = {gold = 100, items = {{44039, 1}}} },-- 静光
		{ id = 11709, level = 60 , res = {gold = 100, items = {{44039, 1}}} },-- 静照
		{ id = 11710, level = 40 , res = {gold = 100, items = {{44039, 1}}} },-- 静罡
	},

	[JobType.QuanZhen] = {
		{ id = 12108, level = 415, res = {gold = 100, items = {{44038, 2}}} },-- 周伯通
		{ id = 12051, level = 300, res = {gold = 100, items = {{44039, 1}}} },-- 云游隐士
		{ id = 12050, level = 280, res = {gold = 100, items = {{44039, 1}}} },-- 漱流隐士
		{ id = 12049, level = 260, res = {gold = 100, items = {{44039, 1}}} },-- 山居隐士
		{ id = 12011, level = 230, res = {gold = 100, items = {{44039, 1}}} },-- 马钰
		{ id = 11132, level = 220, res = {gold = 100, items = {{44039, 1}}} },-- 谭处端
		{ id = 12008, level = 210, res = {gold = 100, items = {{44039, 1}}} },-- 刘处玄
		{ id = 12014, level = 200, res = {gold = 100, items = {{44039, 1}}} },-- 丘处机
		{ id = 12017, level = 190, res = {gold = 100, items = {{44039, 1}}} },-- 王处一
		{ id = 12006, level = 180, res = {gold = 100, items = {{44039, 1}}} },-- 郝大通
		{ id = 12015, level = 150 , res = {gold = 100, items = {{44039, 1}}} },-- 孙不二
		{ id = 12028, level = 80 , res = {gold = 100, items = {{44039, 1}}} },-- 朱清廷
		{ id = 12022, level = 60 , res = {gold = 100, items = {{44039, 1}}} },-- 尹志平
	},

	[JobType.HuaShan] = {
		{ id = 10074, level = 345, res = {gold = 100, items = {{44038, 2}}} },-- 令狐冲
		{ id = 10024, level = 325, res = {gold = 100, items = {{44039, 1}}} },-- 风清扬
		{ id = 10001, level = 265, res = {gold = 100, items = {{44039, 1}}} },-- 岳不群
		{ id = 10027, level = 240, res = {gold = 100, items = {{44039, 1}}} },-- 宁中则
		{ id = 10064, level = 230, res = {gold = 100, items = {{44039, 1}}} },-- 丛不弃
		{ id = 10066, level = 200, res = {gold = 100, items = {{44039, 1}}} },-- 成不忧
		{ id = 10067, level = 180, res = {gold = 100, items = {{44039, 1}}} },-- 封不平
		{ id = 10068, level = 160, res = {gold = 100, items = {{44039, 1}}} },-- 何不易
		{ id = 10057, level = 130, res = {gold = 100, items = {{44039, 1}}} },-- 诸葛士
		{ id = 10056, level = 100, res = {gold = 100, items = {{44039, 1}}} },-- 逢纪子
		{ id = 10056, level = 80 , res = {gold = 100, items = {{44039, 1}}} },-- 陆大有
		{ id = 10013, level = 50 , res = {gold = 100, items = {{44039, 1}}} },-- 劳德诺
		{ id = 10036, level = 40 , res = {gold = 100, items = {{44039, 1}}} },-- 罗冶礼
	},

	[JobType.HengShan] = {
		{ id = 12701, level = 270, res = {gold = 100, items = {{44038, 2}}} },-- 代理掌门
		{ id = 12706, level = 260, res = {gold = 100, items = {{44039, 1}}} },-- 大师姐
		{ id = 12703, level = 250, res = {gold = 100, items = {{44039, 1}}} },-- 二师姐
		{ id = 12601, level = 220, res = {gold = 100, items = {{44039, 1}}} },-- 仪灵
		{ id = 12602, level = 200, res = {gold = 100, items = {{44039, 1}}} },-- 仪芝
		{ id = 12603, level = 180, res = {gold = 100, items = {{44039, 1}}} },-- 仪婉
		{ id = 12605, level = 160, res = {gold = 100, items = {{44039, 1}}} },-- 仪萱
		{ id = 12606, level = 140, res = {gold = 100, items = {{44039, 1}}} },-- 仪艾
		{ id = 12607, level = 120, res = {gold = 100, items = {{44039, 1}}} },-- 仪清
		{ id = 12610, level = 100, res = {gold = 100, items = {{44039, 1}}} },-- 仪心
		{ id = 12611, level = 80 , res = {gold = 100, items = {{44039, 1}}} },-- 仪悲
		{ id = 12613, level = 60 , res = {gold = 100, items = {{44039, 1}}} },-- 仪文
		{ id = 12614, level = 40 , res = {gold = 100, items = {{44039, 1}}} },-- 仪贞
	},

	[JobType.GaiBang] = {
		{ id = 13101, level = 410, res = {gold = 100, items = {{44038, 2}}} },-- 北丐
		{ id = 13111, level = 285, res = {gold = 100, items = {{44039, 1}}} },-- 黄蓉
		{ id = 13009, level = 260, res = {gold = 100, items = {{44039, 1}}} },-- 掌棒龙头
		{ id = 13010, level = 240, res = {gold = 100, items = {{44039, 1}}} },-- 掌钵龙头
		{ id = 13011, level = 210, res = {gold = 100, items = {{44039, 1}}} },-- 执法长老
		{ id = 13012, level = 190, res = {gold = 100, items = {{44039, 1}}} },-- 助功长老
		{ id = 13113, level = 160, res = {gold = 100, items = {{44039, 1}}} },-- 孟长老
		{ id = 13013, level = 140, res = {gold = 100, items = {{44039, 1}}} },-- 简长老
		{ id = 13014, level = 130, res = {gold = 100, items = {{44039, 1}}} },-- 蒋长老
		{ id = 13108, level = 100, res = {gold = 100, items = {{44039, 1}}} },-- 游启明
		{ id = 13005, level = 80 , res = {gold = 100, items = {{44039, 1}}} },-- 裘富财
		{ id = 13008, level = 60 , res = {gold = 100, items = {{44039, 1}}} },-- 章起盖
		{ id = 13102, level = 40 , res = {gold = 100, items = {{44039, 1}}} },-- 大葫芦
	},

	[JobType.XueDao] = {
		{ id = 15609, level = 310, res = {gold = 100, items = {{44038, 2}}} },-- 血门老祖
		{ id = 15708, level = 300, res = {gold = 100, items = {{44039, 1}}} },-- 血魔老祖
		{ id = 15709, level = 290, res = {gold = 100, items = {{44039, 1}}} },-- 血海老祖
		{ id = 15608, level = 260, res = {gold = 100, items = {{44039, 1}}} },-- 善勇
		{ id = 15607, level = 240, res = {gold = 100, items = {{44039, 1}}} },-- 胜谛
		{ id = 15705, level = 220, res = {gold = 100, items = {{44039, 1}}} },-- 胜武
		{ id = 15706, level = 190, res = {gold = 100, items = {{44039, 1}}} },-- 纵武
		{ id = 16707, level = 160, res = {gold = 100, items = {{44039, 1}}} },-- 式武
		{ id = 15603, level = 130, res = {gold = 100, items = {{44039, 1}}} },-- 新武
		{ id = 15602, level = 100, res = {gold = 100, items = {{44039, 1}}} },-- 苦集
		{ id = 15601, level = 80 , res = {gold = 100, items = {{44039, 1}}} },-- 哀晦
		{ id = 15605, level = 50 , res = {gold = 100, items = {{44039, 1}}} },-- 见戾
		{ id = 15502, level = 40 , res = {gold = 100, items = {{44039, 1}}} },-- 灭命
	},

	[JobType.XingXiu] = {
		{ id = 16101, level = 390, res = {gold = 100, items = {{44038, 2}}} },-- 丁春秋
		{ id = 16301, level = 280, res = {gold = 100, items = {{44039, 1}}} },-- 天狼子
		{ id = 16302, level = 260, res = {gold = 100, items = {{44039, 1}}} },-- 新武子
		{ id = 16303, level = 240, res = {gold = 100, items = {{44039, 1}}} },-- 化功子
		{ id = 16304, level = 220, res = {gold = 100, items = {{44039, 1}}} },-- 飞星子
		{ id = 16305, level = 200, res = {gold = 100, items = {{44039, 1}}} },-- 斩武子
		{ id = 16201, level = 170, res = {gold = 100, items = {{44039, 1}}} },-- 灿极子
		{ id = 16202, level = 140, res = {gold = 100, items = {{44039, 1}}} },-- 疏斗子
		{ id = 16203, level = 120, res = {gold = 100, items = {{44039, 1}}} },-- 楚礼子
		{ id = 16204, level = 100, res = {gold = 100, items = {{44039, 1}}} },-- 出尘子
		{ id = 16205, level = 80 , res = {gold = 100, items = {{44039, 1}}} },-- 狮吼子
		{ id = 16104, level = 60 , res = {gold = 100, items = {{44039, 1}}} },-- 风行子
		{ id = 16105, level = 40 , res = {gold = 100, items = {{44039, 1}}} },-- 延儒子
	},

	[JobType.LingJiu] = {
		{ id = 20615, level = 450, res = {gold = 100, items = {{44038, 2}}} },-- 天山童姥
		{ id = 20504, level = 440, res = {gold = 100, items = {{44039, 1}}} },-- 李秋水
		{ id = 20601, level = 250, res = {gold = 100, items = {{44039, 1}}} },-- 飘云
		{ id = 20602, level = 230, res = {gold = 100, items = {{44039, 1}}} },-- 吴梅
		{ id = 20603, level = 210, res = {gold = 100, items = {{44039, 1}}} },-- 叶悠晴
		{ id = 20604, level = 190, res = {gold = 100, items = {{44039, 1}}} },-- 沈薇
		{ id = 20605, level = 160, res = {gold = 100, items = {{44039, 1}}} },-- 金娟
		{ id = 20606, level = 140, res = {gold = 100, items = {{44039, 1}}} },-- 萧诗盈
		{ id = 20611, level = 120, res = {gold = 100, items = {{44039, 1}}} },-- 小玉
		{ id = 20612, level = 100, res = {gold = 100, items = {{44039, 1}}} },-- 石嫂
		{ id = 20613, level = 80 , res = {gold = 100, items = {{44039, 1}}} },-- 周婆婆
		{ id = 20614, level = 60 , res = {gold = 100, items = {{44039, 1}}} },-- 小彩
		{ id = 20616, level = 40 , res = {gold = 100, items = {{44039, 1}}} },-- 符敏仪
	},

	[JobType.GuMu] = {
		{ id = 21130, level = 330, res = {gold = 100, items = {{44038, 2}}} },-- 隐门掌门
		{ id = 21202, level = 275, res = {gold = 100, items = {{44039, 1}}} },-- 小龙女
		{ id = 12047, level = 250, res = {gold = 100, items = {{44039, 1}}} },-- 李莫愁
		{ id = 21002, level = 230, res = {gold = 100, items = {{44039, 1}}} },-- 孙婆婆
		{ id = 21101, level = 200, res = {gold = 100, items = {{44039, 1}}} },-- 小玉
		{ id = 21102, level = 180, res = {gold = 100, items = {{44039, 1}}} },-- 小紫
		{ id = 21103, level = 160, res = {gold = 100, items = {{44039, 1}}} },-- 小仙
		{ id = 21104, level = 140, res = {gold = 100, items = {{44039, 1}}} },-- 小萱
		{ id = 21105, level = 120, res = {gold = 100, items = {{44039, 1}}} },-- 小榆
		{ id = 21106, level = 100, res = {gold = 100, items = {{44039, 1}}} },-- 小珍
		{ id = 21107, level = 80 , res = {gold = 100, items = {{44039, 1}}} },-- 小俐
		{ id = 21108, level = 60 , res = {gold = 100, items = {{44039, 1}}} },-- 小香
		{ id = 21109, level = 40 , res = {gold = 100, items = {{44039, 1}}} },-- 小雯
	},
}

-- dd = {
-- 	{ level = 0,   title = "不堪一击", color = Color.New(168/255,168/255,168/255) }, -- white
--     { level = 20,  title = "毫不足虑", color = Color.New(200/255,200/255,200/255) },
--     { level = 50,  title = "不足挂齿", color = Color.New(162/255,184/255,163/255) },
--     { level = 80,  title = "初学乍练", color = Color.New(162/255,202/255,163/255) }, -- green
--     { level = 110, title = "勉勉强强", color = Color.New(162/255,230/255,163/255) },					1
--     { level = 130, title = "初窥门径", color = Color.New(121/255,230/255,122/255) },
--     { level = 150, title = "初出茅庐", color = Color.New(98 /255,230/255,99 /255) },
--     { level = 170, title = "略知一二", color = Color.New(64 /255,230/255,66 /255) },	
--     { level = 190, title = "普普通通", color = Color.New(64 /255,229/255,112/255) },					2
--     { level = 210, title = "平淡无奇", color = Color.New(65 /255,234/255,137/255) },
--     { level = 230, title = "粗通皮毛", color = Color.New(60 /255,216/255,254/255) },	
--     { level = 250, title = "半生不熟", color = Color.New(62 /255,221/255,179/255) },
--     { level = 270, title = "马马虎虎", color = Color.New(59 /255,210/255,197/255) },					3
--     { level = 290, title = "略有小成", color = Color.New(79 /255,172/255,223/255) }, -- blue
--     { level = 310, title = "已有小成", color = Color.New(79 /255,156/255,223/255) },
--     { level = 325, title = "鹤立鸡群", color = Color.New(79 /255,147/255,223/255) },					4
--     { level = 340, title = "驾轻就熟", color = Color.New(79 /255,128/255,223/255) },
--     { level = 355, title = "青出于蓝", color = Color.New(79 /255,102/255,223/255) },
--     { level = 370, title = "融会贯通", color = Color.New(79 /255,80/ 255,223/255) },	
--     { level = 385, title = "心领神会", color = Color.New(100/255,84/ 255,223/255) },					5
--     { level = 400, title = "了然于胸", color = Color.New(147/255,84/ 255,223/255) },
--     { level = 410, title = "略有大成", color = Color.New(167/255,77/ 255,242/255) }, -- purple
--     { level = 420, title = "已有大成", color = Color.New(205/255,78/ 255,244/255) },					6
--     { level = 430, title = "登堂入室", color = Color.New(210/255,67/ 255,181/255) },
--     { level = 440, title = "炉火纯青", color = Color.New(178/255,57/ 255,153/255) },
--     { level = 450, title = "出类拔萃", color = Color.New(152/255,144/255,48 /255) },
--     { level = 455, title = "技压群雄", color = Color.New(218/255,180/255,69 /255) },					7
--     { level = 460, title = "出神入化", color = Color.New(216/255,140/255,69 /255) }, -- orange
--     { level = 465, title = "傲视群雄", color = Color.New(218/255,115/255,69 /255) },
--     { level = 470, title = "登峰造极", color = Color.New(216/255,88/ 255,69 /255) },					8
--     { level = 475, title = "惊世骇俗", color = Color.New(216/255,69/ 255,75 /255) },
--     { level = 480, title = "震古铄今", color = Color.New(189/255,60/ 255,60 /255) }, 
--     { level = 485, title = "威镇寰宇", color = Color.New(195/255,62/ 255,62 /255) }, -- red
--     { level = 490, title = "空前绝后", color = Color.New(195/255,37/ 255, 37/255) },					9
--     { level = 495, title = "天人合一", color = Color.New(195/255,28/ 255, 28/255) },
--     { level = 500, title = "返璞归真", color = Color.New(226/255,18/ 255,18 /255) },
--     { level = 99999999, title = "天堂之路", color = Color.New(255/255,0/255,0/255) },				10
-- }

-- preprocess
for k,v in pairs(compete_rank) do
	for i1,v1 in ipairs(v) do
		v1.index = i1
		v1.total = #v
	end
end

function compete_rank.getCompeteNum(job)
	local rank = compete_rank[job]
	if not rank then
		return 0
	end

	return #rank
end

function compete_rank.getCompeteData(job, index)
	local rank = compete_rank[job]
	if not rank then
		return
	end

	if index then
		return rank[index]
	else
		return rank
	end
end

return compete_rank