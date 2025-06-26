-- chunkname: @IQIGame\\Config\\CfgGmTable.lua

local CfgGmTable = {
	[101] = {
		TypeName = "常用",
		Name = "设置玩家等级10",
		Cmd = "/cmd setlv 10",
		Type = 1,
		Id = 101
	},
	[102] = {
		TypeName = "常用",
		Name = "获得10000000金币",
		Cmd = "/cmd additem 1 10000000",
		Type = 1,
		Id = 102
	},
	[103] = {
		TypeName = "常用",
		Name = "获得10000000钻石",
		Cmd = "/cmd additem 2 10000000",
		Type = 1,
		Id = 103
	},
	[104] = {
		TypeName = "常用",
		Name = "开启所有功能",
		Cmd = "/cmd openfunction",
		Type = 1,
		Id = 104
	},
	[105] = {
		TypeName = "常用",
		Name = "清理背包",
		Cmd = "/cmd cleanwarehouse",
		Type = 1,
		Id = 105
	},
	[106] = {
		TypeName = "常用",
		Name = "重置玩家每日数据",
		Cmd = "/cmd dailyreset",
		Type = 1,
		Id = 106
	},
	[107] = {
		TypeName = "常用",
		Name = "清理卡死对话",
		Cmd = "/cmd clearDialog",
		Type = 1,
		Id = 107
	},
	[108] = {
		TypeName = "常用",
		Name = "获得100体力",
		Cmd = "/cmd additem 104 100",
		Type = 1,
		Id = 108
	},
	[109] = {
		TypeName = "常用",
		Name = "灵魂解锁大礼包",
		Cmd = "/cmd exec 1023",
		Type = 1,
		Id = 109
	},
	[110] = {
		TypeName = "常用",
		Name = "灵魂升级大礼包",
		Cmd = "/cmd exec 1024",
		Type = 1,
		Id = 110
	},
	[111] = {
		TypeName = "常用",
		Name = "升星材料大礼包",
		Cmd = "/cmd exec 1025",
		Type = 1,
		Id = 111
	},
	[112] = {
		TypeName = "常用",
		Name = "灵魂魂印大礼包",
		Cmd = "/cmd exec 1027",
		Type = 1,
		Id = 112
	},
	[113] = {
		TypeName = "常用",
		Name = "技能材料大礼包",
		Cmd = "/cmd exec 1026",
		Type = 1,
		Id = 113
	},
	[114] = {
		TypeName = "常用",
		Name = "蕴灵升级大礼包",
		Cmd = "/cmd exec 1029",
		Type = 1,
		Id = 114
	},
	[115] = {
		TypeName = "常用",
		Name = "礼物大礼包",
		Cmd = "/cmd exec 1009",
		Type = 1,
		Id = 115
	},
	[116] = {
		TypeName = "常用",
		Name = "发送邮件",
		Cmd = "/cmd sendmail 35010002 标题 内容",
		Type = 1,
		Id = 116
	},
	[117] = {
		TypeName = "常用",
		Name = "跳转指定指引",
		Cmd = "/cmd OpenGuide 1000",
		Type = 1,
		Id = 117
	},
	[118] = {
		TypeName = "常用",
		Name = "648",
		Cmd = "/cmd recharge 6",
		Type = 1,
		Id = 118
	},
	[119] = {
		TypeName = "常用",
		Name = "蕴灵卡池",
		Cmd = "/cmd lottery 9996 999906 100 2030",
		Type = 1,
		Id = 119
	},
	[120] = {
		TypeName = "常用",
		Name = "人偶卡池",
		Cmd = "/cmd lottery 9997 999702 100 1027",
		Type = 1,
		Id = 120
	},
	[121] = {
		TypeName = "常用",
		Name = "改系统时间",
		Cmd = "/cmd date 2025/1/23 23:02:00",
		Type = 1,
		Id = 121
	},
	[122] = {
		TypeName = "常用",
		Name = "关闭运营活动（1001换成活动ID）",
		Cmd = "/cmd closeOpEvent 1001",
		Type = 1,
		Id = 122
	},
	[123] = {
		TypeName = "常用",
		Name = "完成任务",
		Cmd = "/cmd setquestpay {任务Id}",
		Type = 1,
		Id = 123
	},
	[124] = {
		TypeName = "常用",
		Name = "给人偶添加魂芯强化点",
		Cmd = "/cmd addSoulSpecialSpirit 1010201",
		Type = 1,
		Id = 124
	},
	[125] = {
		TypeName = "常用",
		Name = "完成全部小镇剧情",
		Cmd = "/cmd CompleteAllTownEvent",
		Type = 1,
		Id = 125
	},
	[126] = {
		TypeName = "常用",
		Name = "所有礼物食物",
		Cmd = "/cmd exec 1032",
		Type = 1,
		Id = 126
	},
	[401] = {
		TypeName = "家园",
		Name = "初级家具套装",
		Cmd = "/cmd exec 2015",
		Type = 4,
		Id = 401
	},
	[402] = {
		TypeName = "家园",
		Name = "中级家具套装",
		Cmd = "/cmd exec 2016",
		Type = 4,
		Id = 402
	},
	[403] = {
		TypeName = "家园",
		Name = "家园宿舍解锁大礼包",
		Cmd = "/cmd exec 2015",
		Type = 4,
		Id = 403
	},
	[404] = {
		TypeName = "家园",
		Name = "家园制造大礼包",
		Cmd = "/cmd exec 1010",
		Type = 4,
		Id = 404
	},
	[405] = {
		TypeName = "家园",
		Name = "家园种子大礼包",
		Cmd = "/cmd exec 1011",
		Type = 4,
		Id = 405
	},
	[406] = {
		TypeName = "家园",
		Name = "家园食材大礼包",
		Cmd = "/cmd exec 1012",
		Type = 4,
		Id = 406
	},
	[407] = {
		TypeName = "家园",
		Name = "家园材料包",
		Cmd = "/cmd exec 2038",
		Type = 4,
		Id = 407
	},
	[408] = {
		TypeName = "家园",
		Name = "解锁全部房间",
		Cmd = "/cmd exec 2039",
		Type = 4,
		Id = 408
	},
	[409] = {
		TypeName = "家园",
		Name = "解锁全钓鱼图鉴",
		Cmd = "/cmd fishing",
		Type = 4,
		Id = 409
	},
	[501] = {
		TypeName = "相伴",
		Name = "回忆材料大礼包",
		Cmd = "/cmd exec 1005",
		Type = 5,
		Id = 501
	},
	[502] = {
		TypeName = "相伴",
		Name = "礼物大礼包",
		Cmd = "/cmd exec 1003",
		Type = 5,
		Id = 502
	},
	[503] = {
		TypeName = "相伴",
		Name = "约会门票大礼包",
		Cmd = "/cmd exec 1006",
		Type = 5,
		Id = 503
	},
	[504] = {
		TypeName = "相伴",
		Name = "好感度上限至50",
		Cmd = "/cmd exec 1007",
		Type = 5,
		Id = 504
	},
	[505] = {
		TypeName = "相伴",
		Name = "全人偶誓约",
		Cmd = "/cmd ActivationOath 1",
		Type = 5,
		Id = 505
	},
	[506] = {
		TypeName = "相伴",
		Name = "获取所有时装",
		Cmd = "/cmd exec 1031",
		Type = 5,
		Id = 506
	},
	[301] = {
		TypeName = "试炼",
		Name = "设置爬塔层数为70",
		Cmd = "/cmd settowerfloor 70",
		Type = 3,
		Id = 301
	},
	[302] = {
		TypeName = "试炼",
		Name = "设置恐惧层数为70层（1.冰霜、2.魔法、3.火焰、4.物理、5雷电）",
		Cmd = "/cmd SingleWeakTowerFloor 1 70",
		Type = 3,
		Id = 302
	},
	[303] = {
		TypeName = "试炼",
		Name = "设置人偶数据（等级，星级，技能等级，魂印等级）",
		Cmd = "/cmd testdoll 40 4 4 3",
		Type = 3,
		Id = 303
	},
	[304] = {
		TypeName = "试炼",
		Name = "设置蕴灵数据（等级，星级）",
		Cmd = "/cmd testequip 40 3",
		Type = 3,
		Id = 304
	},
	[305] = {
		TypeName = "试炼",
		Name = "设置相伴数据（好感度等级，约会等级，新篇等级，回忆等级）",
		Cmd = "/cmd testgirl 40 9 14 5",
		Type = 3,
		Id = 305
	},
	[306] = {
		TypeName = "试炼",
		Name = "设置人偶魂芯属性数据（灵魂id（填0改全部）, 魂芯属性（0-50））",
		Cmd = "/cmd testSoulSpecialSpirit 20010001 1 50",
		Type = 3,
		Id = 306
	},
	[307] = {
		TypeName = "试炼",
		Name = "设置人偶魂芯1系奥义（灵魂id（填0改全部）, 1系技能（0-5））",
		Cmd = "/cmd testSoulSpecialSpirit 20010001 2 5",
		Type = 3,
		Id = 307
	},
	[308] = {
		TypeName = "试炼",
		Name = "设置人偶魂芯2系奥义（灵魂id（填0改全部），2系技能（0-5））",
		Cmd = "/cmd testSoulSpecialSpirit 20010001 3 5",
		Type = 3,
		Id = 308
	},
	[309] = {
		TypeName = "试炼",
		Name = "蕴灵-ssr",
		Cmd = "/cmd exec 2022",
		Type = 3,
		Id = 309
	},
	[310] = {
		TypeName = "试炼",
		Name = "蕴灵-sr",
		Cmd = "/cmd exec 2021",
		Type = 3,
		Id = 310
	},
	[311] = {
		TypeName = "试炼",
		Name = "开启世界BOSS",
		Cmd = "/cmd closeDailyDup 6",
		Type = 3,
		Id = 311
	},
	[312] = {
		TypeName = "试炼",
		Name = "调整世界BOSS等级",
		Cmd = "/cmd setworldbosslv 1",
		Type = 3,
		Id = 312
	},
	[313] = {
		TypeName = "试炼",
		Name = "蕴灵-专属",
		Cmd = "/cmd exec 2040",
		Type = 3,
		Id = 313
	},
	[314] = {
		TypeName = "试炼",
		Name = "蕴灵-r",
		Cmd = "/cmd exec 2020",
		Type = 3,
		Id = 314
	},
	[315] = {
		TypeName = "试炼",
		Name = "蕴灵-n",
		Cmd = "/cmd exec 2019",
		Type = 3,
		Id = 315
	},
	[316] = {
		TypeName = "试炼",
		Name = "获得1000勋章",
		Cmd = "/cmd additem 105 1000",
		Type = 3,
		Id = 316
	},
	[317] = {
		TypeName = "试炼",
		Name = "饰品-5星",
		Cmd = "/cmd exec 3003",
		Type = 3,
		Id = 317
	},
	[201] = {
		TypeName = "迷宫",
		Name = "通关第一章所有关卡",
		Cmd = "/cmd passchapter 25011001",
		Type = 2,
		Id = 201
	},
	[202] = {
		TypeName = "迷宫",
		Name = "通关第二章所有关卡",
		Cmd = "/cmd passchapter 25011002",
		Type = 2,
		Id = 202
	},
	[203] = {
		TypeName = "迷宫",
		Name = "重置RPG迷宫",
		Cmd = "/cmd resetrpgmaze",
		Type = 2,
		Id = 203
	},
	[204] = {
		TypeName = "迷宫",
		Name = "迷宫内与指定怪物组战斗",
		Cmd = "/cmd _fight 10109601",
		Type = 2,
		Id = 204
	},
	[205] = {
		TypeName = "迷宫",
		Name = "结算次元深渊排行奖励",
		Cmd = "/cmd clearRank 1",
		Type = 2,
		Id = 205
	},
	[206] = {
		TypeName = "迷宫",
		Name = "直接结算关卡",
		Cmd = "/cmd service 140103000",
		Type = 2,
		Id = 206
	},
	[207] = {
		TypeName = "迷宫",
		Name = "踢出迷宫（角色迷宫卡死",
		Cmd = "/cmd abandonMaze",
		Type = 2,
		Id = 207
	},
	[208] = {
		TypeName = "迷宫",
		Name = "添加次元深渊神圣结晶",
		Cmd = "/cmd additem 4 1000",
		Type = 2,
		Id = 208
	},
	[209] = {
		TypeName = "迷宫",
		Name = "次元深渊门票",
		Cmd = "/cmd additem 10009 100",
		Type = 2,
		Id = 209
	},
	[210] = {
		TypeName = "迷宫",
		Name = "添加刻印",
		Cmd = "/cmd addRune 1020100",
		Type = 2,
		Id = 210
	},
	[211] = {
		TypeName = "迷宫",
		Name = "隐藏迷宫召唤材料礼包",
		Cmd = "/cmd exec 1022",
		Type = 2,
		Id = 211
	},
	[212] = {
		TypeName = "迷宫",
		Name = "获得10次元深渊积分",
		Cmd = "/cmd addbuff 2 100000001",
		Type = 2,
		Id = 212
	},
	[213] = {
		TypeName = "迷宫",
		Name = "清除刻印",
		Cmd = "/cmd clearrune",
		Type = 2,
		Id = 213
	},
	[214] = {
		TypeName = "迷宫",
		Name = "设置深渊胜利次数为10",
		Cmd = "/cmd setfightwincount 10",
		Type = 2,
		Id = 214
	},
	[215] = {
		TypeName = "迷宫",
		Name = "获得1个宝箱钥匙",
		Cmd = "/cmd additem 1201035 1",
		Type = 2,
		Id = 215
	},
	[216] = {
		TypeName = "迷宫",
		Name = "获得普通刻印",
		Cmd = "/cmd exec 3001",
		Type = 2,
		Id = 216
	},
	[217] = {
		TypeName = "迷宫",
		Name = "获得专属刻印",
		Cmd = "/cmd exec 3002",
		Type = 2,
		Id = 217
	},
	[218] = {
		TypeName = "迷宫",
		Name = "清空迷宫进度(+关卡id)",
		Cmd = "/cmd cleanmaze 25020100",
		Type = 2,
		Id = 218
	},
	[219] = {
		TypeName = "迷宫",
		Name = "获得幻境遗迹全道具",
		Cmd = "/cmd service 82610398",
		Type = 2,
		Id = 219
	},
	[220] = {
		TypeName = "迷宫",
		Name = "打印当前迷宫参数值",
		Cmd = "/cmd showplayerparams",
		Type = 2,
		Id = 220
	},
	[221] = {
		TypeName = "迷宫",
		Name = "秒杀怪物",
		Cmd = "/cmd addbuff 2 10000003",
		Type = 2,
		Id = 221
	},
	[222] = {
		TypeName = "迷宫",
		Name = "清除横版RPG迷宫存档",
		Cmd = "/cmd clearHorizontal",
		Type = 2,
		Id = 222
	},
	[223] = {
		TypeName = "迷宫",
		Name = "获得rpg迷宫装备，可安歇的黎明",
		Cmd = "/cmd exec 3004",
		Type = 2,
		Id = 223
	},
	[601] = {
		TypeName = "小镇",
		Name = "获得1000暗金物质",
		Cmd = "/cmd additem 12101 1000",
		Type = 6,
		Id = 601
	},
	[602] = {
		TypeName = "小镇",
		Name = "获得1000白银物质",
		Cmd = "/cmd additem 12102 1000",
		Type = 6,
		Id = 602
	},
	[603] = {
		TypeName = "小镇",
		Name = "获得100巡查证",
		Cmd = "/cmd additem 101 100",
		Type = 6,
		Id = 603
	},
	[604] = {
		TypeName = "小镇",
		Name = "图书馆-新闻解锁",
		Cmd = "/cmd exec 1013",
		Type = 6,
		Id = 604
	},
	[605] = {
		TypeName = "小镇",
		Name = "图书馆-主线剧情解锁",
		Cmd = "/cmd exec 1014",
		Type = 6,
		Id = 605
	},
	[606] = {
		TypeName = "小镇",
		Name = "图书馆-npc资料解锁",
		Cmd = "/cmd exec 1015",
		Type = 6,
		Id = 606
	},
	[607] = {
		TypeName = "小镇",
		Name = "图书馆-区域资料解锁",
		Cmd = "/cmd exec 1016",
		Type = 6,
		Id = 607
	},
	[608] = {
		TypeName = "小镇",
		Name = "图书馆-怪物图鉴全解锁",
		Cmd = "/cmd unlockmonster 0",
		Type = 6,
		Id = 608
	},
	[701] = {
		TypeName = "活动",
		Name = "开启活动 -活动ID (只有恶域蚀入需要后两个参数)",
		Cmd = "/cmd openDailyDup dupId {持续时间} {有效进入时间}",
		Type = 7,
		Id = 701
	},
	[702] = {
		TypeName = "活动",
		Name = "关闭活动 -活动ID",
		Cmd = "/cmd closeDailyDup dupId",
		Type = 7,
		Id = 702
	},
	[703] = {
		TypeName = "活动",
		Name = "重置通行证赛季记录 -9 -赛季（重置到该赛季结束，到1则填0）",
		Cmd = "/cmd resetDailyDup 9 count",
		Type = 7,
		Id = 703
	},
	[704] = {
		TypeName = "活动",
		Name = "增加卢纳战线区域的封印值",
		Cmd = "/cmd addlunaseal {zoneid} {value}",
		Type = 7,
		Id = 704
	},
	[705] = {
		TypeName = "活动",
		Name = "解锁恶域蚀入商店",
		Cmd = "/cmd additem 4060051 1",
		Type = 7,
		Id = 705
	},
	[706] = {
		TypeName = "活动",
		Name = "进入恶域蚀入光前",
		Cmd = "/cmd evilfight {levelCid} {buffCid}",
		Type = 7,
		Id = 706
	},
	[707] = {
		TypeName = "活动",
		Name = "设置恶域蚀入蕴灵星级",
		Cmd = "/cmd setevilequipstar {level}",
		Type = 7,
		Id = 707
	},
	[708] = {
		TypeName = "活动",
		Name = "开启恶域蚀入",
		Cmd = "/cmd openDailyDup 16 30 30",
		Type = 7,
		Id = 708
	},
	[801] = {
		TypeName = "祈愿",
		Name = "改系统时间",
		Cmd = "/cmd date 2023/3/14 23:02:00",
		Type = 8,
		Id = 801
	},
	[802] = {
		TypeName = "祈愿",
		Name = "清理背包",
		Cmd = "/cmd cleanwarehouse",
		Type = 8,
		Id = 802
	},
	[803] = {
		TypeName = "祈愿",
		Name = "灵魂解锁大礼包",
		Cmd = "/cmd exec 1023",
		Type = 8,
		Id = 803
	},
	[804] = {
		TypeName = "祈愿",
		Name = "获得10000000金币",
		Cmd = "/cmd additem 10005 10000",
		Type = 8,
		Id = 804
	},
	[805] = {
		TypeName = "祈愿",
		Name = "获得10000000钻石",
		Cmd = "/cmd additem 10006 10000",
		Type = 8,
		Id = 805
	},
	[806] = {
		TypeName = "祈愿",
		Name = "蕴灵卡池",
		Cmd = "/cmd lottery 9996 999906 100 2084",
		Type = 8,
		Id = 806
	},
	[807] = {
		TypeName = "祈愿",
		Name = "人偶卡池",
		Cmd = "/cmd lottery 9997 999702 100 1081",
		Type = 8,
		Id = 807
	},
	[808] = {
		TypeName = "祈愿",
		Name = "人偶单Up卡池",
		Cmd = "/cmd lottery 210902101 2109021012 100 0",
		Type = 8,
		Id = 808
	},
	[809] = {
		TypeName = "祈愿",
		Name = "蕴灵自选5",
		Cmd = "/cmd lottery 20003 2000302 100 110001 110002 110003 110004 110005",
		Type = 8,
		Id = 809
	}
}

setmetatable(CfgGmTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGmTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		TypeName = "",
		Cmd = "",
		Type = 0
	}
}

for i, data in pairs(CfgGmTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGmTable
