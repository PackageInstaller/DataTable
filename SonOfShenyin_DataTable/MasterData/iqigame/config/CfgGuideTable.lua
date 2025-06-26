-- chunkname: @IQIGame\\Config\\CfgGuideTable.lua

local CfgGuideTable = {
	[101] = {
		Content = "测试新手引导1",
		TriggerValues = "StartStory",
		GuideType = 1,
		KeyID = 101,
		HideL2D = true,
		Order = 101,
		RelinkRevert = true,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,101",
		Id = 101,
		Record = true,
		Enable = true,
		SubIDList = {
			101
		}
	},
	[201] = {
		Content = "序章-编队引导",
		TriggerValues = "FormationUI",
		GuideType = 1,
		KeyID = 4005,
		HideL2D = true,
		Order = 201,
		RelinkRevert = true,
		TriggerType = 1,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,201|CheckChapterNoFinished,20010101",
		Id = 201,
		Record = true,
		Enable = true,
		SubIDList = {
			4001,
			4002,
			4003,
			4004,
			4005
		}
	},
	[301] = {
		Record = true,
		Content = "序章-第一场战斗",
		GuideType = 1,
		TriggerValues = "BattleStart",
		KeyID = 1013,
		Order = 301,
		HideL2D = true,
		RelinkRevert = true,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,301|CheckMonsterTeamID,14100030",
		Id = 301,
		Unlimited = true,
		Enable = true,
		SubIDList = {
			1001,
			1002,
			1003,
			1004,
			1005,
			1006,
			1007,
			1008,
			1009,
			1010,
			1011,
			1012,
			1013
		}
	},
	[401] = {
		Content = "关卡1-进入引导",
		TriggerValues = "MainUI",
		GuideType = 1,
		KeyID = 30201,
		HideL2D = true,
		Order = 401,
		RelinkRevert = true,
		TriggerType = 1,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,401|CheckChapterNoFinished,20010101|CheckTaskState,1010001,==,3",
		Id = 401,
		Record = true,
		Enable = true,
		SubIDList = {
			30201,
			30203
		}
	},
	[501] = {
		Content = "关卡2-进入引导",
		TriggerValues = "Settlement_ActionUI",
		GuideType = 1,
		KeyID = 30401,
		HideL2D = true,
		Order = 501,
		RelinkRevert = true,
		TriggerType = 5,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,501|CheckChapterNoFinished,20010102|CheckTaskState,1010100,==,3",
		Id = 501,
		Record = true,
		Enable = true,
		SubIDList = {
			30401,
			30403
		}
	},
	[601] = {
		Record = true,
		Content = "1-2-第2场战斗-1",
		GuideType = 1,
		TriggerValues = "BattleStart",
		KeyID = 2113,
		Order = 601,
		HideL2D = true,
		RelinkRevert = true,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,601|CheckMonsterTeamID,14101020",
		Id = 601,
		Unlimited = true,
		Enable = true,
		SubIDList = {
			2101,
			2102,
			2103,
			2104,
			2105,
			2106,
			2107,
			2108,
			2109,
			2110,
			2111,
			2112,
			2113
		}
	},
	[701] = {
		Content = "新手十连",
		TriggerValues = "Settlement_ActionUI",
		GuideType = 1,
		KeyID = 30106,
		HideL2D = true,
		Order = 701,
		RelinkRevert = true,
		TriggerType = 5,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,701|CheckTaskState,1010200,==,3",
		Id = 701,
		Record = true,
		Enable = true,
		SubIDList = {
			30101,
			30102,
			30103,
			30104,
			30105,
			30106
		}
	},
	[801] = {
		Content = "等级强化",
		TriggerValues = "LotteryUI",
		GuideType = 1,
		KeyID = 30301,
		HideL2D = true,
		Order = 801,
		RelinkRevert = true,
		TriggerType = 5,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,801|CheckChapterFinished,20010102|CheckTaskState,1010200,==,3|CheckGuideFinished,701",
		Id = 801,
		Record = true,
		Enable = true,
		SubIDList = {
			30301,
			30303,
			30304,
			30305,
			30306,
			30307,
			30308,
			30309,
			30310
		}
	},
	[901] = {
		Content = "编队引导2",
		TriggerValues = "FormationUI",
		GuideType = 1,
		KeyID = 4104,
		HideL2D = true,
		Order = 901,
		RelinkRevert = true,
		TriggerType = 1,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,901|CheckChapterFinished,20010102|CheckTaskState,1010200,==,3",
		Id = 901,
		Record = true,
		Enable = true,
		SubIDList = {
			4101,
			4102,
			4103,
			4104
		}
	},
	[1001] = {
		GuideType = 1,
		Content = "1-3-第3场战斗-待定",
		TriggerValues = "BattleStart",
		KeyID = 2301,
		HideL2D = true,
		Order = 1001,
		RelinkRevert = true,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,1001|CheckMonsterTeamID,14101030",
		Id = 1001,
		Unlimited = true,
		SubIDList = {
			2301,
			2302
		}
	},
	[1101] = {
		Content = "英雄副本引导",
		TriggerValues = "Settlement_ActionUI",
		GuideType = 1,
		KeyID = 30601,
		HideL2D = true,
		Order = 1101,
		RelinkRevert = true,
		TriggerType = 5,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,1101|CheckTaskState,1010500,==,3",
		Id = 1101,
		Record = true,
		Enable = true,
		SubIDList = {
			30601,
			30602,
			30603,
			30604,
			30605,
			30606
		}
	},
	[1201] = {
		Content = "鬼武强化",
		TriggerValues = "Settlement_ActionUI",
		GuideType = 1,
		KeyID = 301209,
		HideL2D = true,
		Order = 1201,
		RelinkRevert = true,
		TriggerType = 5,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,1201|CheckChapterFinished,20010106|CheckTaskState,1010600,==,3",
		Id = 1201,
		Record = true,
		Enable = true,
		SubIDList = {
			301201,
			301202,
			301203,
			301204,
			301205,
			301206,
			301207,
			301208,
			301209
		}
	},
	[1301] = {
		Content = "宝箱-逛街-支线-软引导",
		TriggerValues = "Settlement_ActionUI",
		GuideType = 1,
		KeyID = 30501,
		HideL2D = true,
		Order = 1301,
		RelinkRevert = true,
		TriggerType = 5,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,1301|CheckTaskState,1010700,==,3",
		Id = 1301,
		Record = true,
		Enable = true,
		SubIDList = {
			30501,
			30502,
			30503,
			30504,
			30505,
			30506,
			30507,
			30508,
			30509,
			30510,
			30511,
			30512,
			30513
		}
	},
	[1401] = {
		Content = "技能强化",
		TriggerValues = "Settlement_ActionUI",
		GuideType = 1,
		KeyID = 301407,
		HideL2D = true,
		Order = 1401,
		RelinkRevert = true,
		TriggerType = 5,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,1401|CheckChapterFinished,20010202|CheckTaskState,1020200,==,3",
		Id = 1401,
		Record = true,
		Enable = true,
		SubIDList = {
			301401,
			301402,
			301403,
			301404,
			301405,
			301406,
			301407
		}
	},
	[1501] = {
		Content = "日常周常任务",
		TriggerValues = "Settlement_ActionUI",
		GuideType = 1,
		KeyID = 301505,
		HideL2D = true,
		Order = 1501,
		RelinkRevert = true,
		TriggerType = 5,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,1501|CheckChapterFinished,20010113|CheckTaskState,1011100,==,3",
		Id = 1501,
		Record = true,
		Enable = true,
		SubIDList = {
			301501,
			301502,
			301503,
			301504,
			301505
		}
	},
	[1601] = {
		GuideType = 1,
		Content = "潜能强化",
		TriggerValues = "Settlement_ActionUI",
		KeyID = 301607,
		HideL2D = true,
		Order = 1601,
		RelinkRevert = true,
		TriggerType = 5,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,1601|CheckChapterFinished,20010114|CheckTaskState,1011400,==,3",
		Id = 1601,
		Record = true,
		SubIDList = {
			301601,
			301602,
			301603,
			301604,
			301605,
			301606,
			301607
		}
	},
	[1701] = {
		Content = "爬塔引导",
		TriggerValues = "Settlement_ActionUI",
		GuideType = 1,
		KeyID = 301705,
		HideL2D = true,
		Order = 1701,
		RelinkRevert = true,
		TriggerType = 5,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,1701|CheckChapterFinished,20010108|CheckTaskState,1010800,==,3",
		Id = 1701,
		Record = true,
		Enable = true,
		SubIDList = {
			301701,
			301702,
			301703,
			301704,
			301705
		}
	},
	[1711] = {
		Content = "短信引导",
		TriggerValues = "WarlockChoosePanel",
		GuideType = 1,
		KeyID = 301901,
		HideL2D = true,
		Order = 1711,
		RelinkRevert = true,
		TriggerType = 1,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,1711|CheckChapterFinished,20010118|CheckTaskState,1011700,==,3|CheckGuideFinished,1701|CheckChapterNoFinished,20010211",
		Id = 1711,
		Record = true,
		Enable = true,
		SubIDList = {
			301901,
			301902,
			301903,
			301904,
			301905
		}
	},
	[1721] = {
		Content = "互动引导",
		TriggerValues = "AffinityChatUI",
		GuideType = 1,
		KeyID = 302001,
		HideL2D = true,
		Order = 1721,
		RelinkRevert = true,
		TriggerType = 5,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,1721|CheckChapterFinished,20010118|CheckTaskState,1011700,==,3|CheckGuideFinished,1711|CheckChapterNoFinished,20010211",
		Id = 1721,
		Record = true,
		Enable = true,
		SubIDList = {
			302001,
			302002,
			302003,
			302004
		}
	},
	[1751] = {
		Content = "迷宫入口引导",
		TriggerValues = "Settlement_ActionUI",
		GuideType = 1,
		KeyID = 301751,
		HideL2D = true,
		Order = 1751,
		RelinkRevert = true,
		TriggerType = 5,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,1751|CheckChapterFinished,20010118|CheckTaskState,1011700,==,3|CheckGuideFinished,1701",
		Id = 1751,
		Record = true,
		Enable = true,
		SubIDList = {
			301751,
			301752,
			301753,
			301754
		}
	},
	[1801] = {
		Content = "BOSS引导",
		TriggerValues = "Settlement_ActionUI",
		GuideType = 1,
		KeyID = 301801,
		HideL2D = true,
		Order = 1801,
		RelinkRevert = true,
		TriggerType = 5,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,1801|CheckChapterFinished,20010211|CheckTaskState,1021100,==,3|CheckGuideFinished,1701",
		Id = 1801,
		Record = true,
		Enable = true,
		SubIDList = {
			301801,
			301802,
			301803,
			301804,
			301805
		}
	},
	[1901] = {
		Content = "家园引导",
		TriggerValues = "Settlement_ActionUI",
		GuideType = 1,
		KeyID = 302101,
		HideL2D = true,
		Order = 1702,
		RelinkRevert = true,
		TriggerType = 5,
		Conditions = "CheckPlayerLv,>=,1|CheckGuideNoFinished,1901|CheckChapterFinished,20010108|CheckTaskState,1010900,==,3",
		Id = 1901,
		Record = true,
		Enable = true,
		SubIDList = {
			302101,
			302102,
			302103,
			302104,
			302105,
			302106
		}
	}
}

setmetatable(CfgGuideTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGuideTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Enable = false,
		GuideType = 0,
		RelinkRevert = false,
		IsSkip = false,
		Order = 0,
		TriggerType = 0,
		KeyID = 0,
		Record = false,
		Content = "",
		Conditions = "",
		ReturnScene = 0,
		Unlimited = false,
		TriggerValues = "",
		ReturnUI = "",
		GuideGroupId = 0,
		HideL2D = false,
		NextGuide = 0,
		SubIDList = {},
		Items = {}
	}
}

for i, data in pairs(CfgGuideTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGuideTable
