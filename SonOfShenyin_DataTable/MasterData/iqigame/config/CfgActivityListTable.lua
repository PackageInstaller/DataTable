-- chunkname: @IQIGame\\Config\\CfgActivityListTable.lua

local CfgActivityListTable = {
	[60101001] = {
		ActivityType = 102,
		ActivityPrefab = "/_Activity/LevelPassActivity",
		ActivityTeam = 1,
		Sort = 103,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Id = 60101001,
		Name = getI18NValue(180129345),
		ActivityID = {
			60002020
		},
		ShowConditionID = {
			30070201,
			30070301
		}
	},
	[60101002] = {
		ActivityType = 102,
		ActivityPrefab = "/_Activity/LevelPassActivity",
		ActivityTeam = 1,
		Sort = 103,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Id = 60101002,
		Name = getI18NValue(180129346),
		ActivityID = {
			60002021
		},
		ShowConditionID = {
			30070202,
			30070302
		}
	},
	[60101003] = {
		ActivityType = 101,
		ActivityPrefab = "/_Activity/MainLinePassActivity",
		ActivityTeam = 1,
		Sort = 104,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Id = 60101003,
		Name = getI18NValue(180129347),
		ActivityID = {
			60002030
		},
		ShowConditionID = {
			30070118,
			30070303
		}
	},
	[60101004] = {
		ActivityType = 103,
		ActivityPrefab = "/_Activity/StrengthActivity",
		ActivityTeam = 1,
		Sort = 102,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_6.png",
		Id = 60101004,
		Name = getI18NValue(180129348),
		ActivityID = {
			60001001
		},
		ShowConditionID = {
			30070115
		}
	},
	[60101006] = {
		ActivityType = 105,
		ActivityPrefab = "/_Activity/BattleActivity",
		ActivityTeam = 2,
		Sort = 202,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_5.png",
		Id = 60101006,
		Name = getI18NValue(180131858),
		ActivityID = {
			60006001
		},
		ShowConditionID = {
			30070113
		},
		Reward = {
			12012,
			3,
			50033,
			50003
		},
		Desc = getI18NValue(180164842)
	},
	[60101007] = {
		ActivityType = 888,
		ActivityPrefab = "/_Activity/AccRechargeActivity",
		ActivityTeam = 2,
		Sort = 200,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_5.png",
		Id = 60101007,
		Name = getI18NValue(180267276),
		ActivityID = {
			60001101
		},
		ShowConditionID = {
			30070217
		},
		Desc = getI18NValue(180267275)
	},
	[60101005] = {
		ActivityType = 888,
		ActivityPrefab = "/_Activity/AccRechargeActivity",
		ActivityTeam = 2,
		Sort = 200,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_5.png",
		Id = 60101005,
		Name = getI18NValue(180267537),
		ActivityID = {
			60001102
		},
		ShowConditionID = {
			30070218
		},
		Desc = getI18NValue(180267536)
	},
	[60101009] = {
		ActivityType = 888,
		ActivityPrefab = "/_Activity/AccRechargeActivity",
		ActivityTeam = 2,
		Sort = 200,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_5.png",
		Id = 60101009,
		Name = getI18NValue(180267539),
		ActivityID = {
			60001103
		},
		ShowConditionID = {
			30070219
		},
		Desc = getI18NValue(180267538)
	},
	[60101010] = {
		ActivityType = 104,
		ChapterNameImg = "/UI/ActivityPart/ActivityListUI/DupMultipleActivity/DupMultipleActivity_imge01.png",
		ActivityPrefab = "/_Activity/DupMultipleActivity",
		ActivityTeam = 2,
		Sort = 201,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_7.png",
		Id = 60101010,
		Name = getI18NValue(180139119),
		ActivityID = {
			60005001
		},
		ShowConditionID = {
			30070203
		},
		Desc = getI18NValue(180139118)
	},
	[60101011] = {
		ActivityType = 104,
		ChapterNameImg = "/UI/ActivityPart/ActivityListUI/DupMultipleActivity/DupMultipleActivity_imge02.png",
		ActivityPrefab = "/_Activity/DupMultipleActivity",
		ActivityTeam = 2,
		Sort = 201,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_7.png",
		Id = 60101011,
		Name = getI18NValue(180139121),
		ActivityID = {
			60005011
		},
		ShowConditionID = {
			30070204
		},
		Desc = getI18NValue(180139120)
	},
	[60101012] = {
		ActivityType = 104,
		ChapterNameImg = "/UI/ActivityPart/ActivityListUI/DupMultipleActivity/DupMultipleActivity_imge03.png",
		ActivityPrefab = "/_Activity/DupMultipleActivity",
		ActivityTeam = 2,
		Sort = 201,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_7.png",
		Id = 60101012,
		Name = getI18NValue(180139123),
		ActivityID = {
			60005081
		},
		ShowConditionID = {
			30070205
		},
		Desc = getI18NValue(180139122)
	},
	[60101013] = {
		ActivityType = 104,
		ChapterNameImg = "/UI/ActivityPart/ActivityListUI/DupMultipleActivity/DupMultipleActivity_imge04.png",
		ActivityPrefab = "/_Activity/DupMultipleActivity",
		ActivityTeam = 2,
		Sort = 201,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_7.png",
		Id = 60101013,
		Name = getI18NValue(180142895),
		ActivityID = {
			60005021
		},
		ShowConditionID = {
			30070205
		},
		Desc = getI18NValue(180260975)
	},
	[60101014] = {
		ActivityType = 108,
		ActivityPrefab = "/_Activity/NoviceSignActivity",
		ActivityTeam = 1,
		Sort = 101,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_2.png",
		Id = 60101014,
		Name = getI18NValue(180153746),
		ActivityID = {
			60001002
		},
		ShowConditionID = {
			30070103
		}
	},
	[60101015] = {
		ActivityType = 666,
		ActivityPrefab = "/_Activity/GlobalChannelActivity",
		ActivityTeam = 1,
		Sort = 101,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_2.png",
		Id = 60101015,
		Name = getI18NValue(180266478),
		ActivityID = {
			60001005
		},
		ShowConditionID = {
			30070216
		}
	},
	[60101016] = {
		ActivityType = 666,
		ActivityPrefab = "/_Activity/SignActivityMayDay",
		ActivityTeam = 1,
		Sort = 101,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_2.png",
		Id = 60101016,
		Name = getI18NValue(180267544),
		ActivityID = {
			60001008
		},
		ShowConditionID = {
			30070220
		}
	},
	[60101017] = {
		ActivityType = 110,
		ActivityPrefab = "/_Activity/SummerSignActivity",
		ActivityTeam = 1,
		Sort = 101,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Id = 60101017,
		Name = getI18NValue(180169843),
		ActivityID = {
			60008001
		},
		ShowConditionID = {
			30070210
		}
	},
	[60101018] = {
		ActivityType = 110,
		ActivityPrefab = "/_Activity/XiaNaiSignActivity",
		ActivityTeam = 1,
		Sort = 101,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Id = 60101018,
		Name = getI18NValue(180261287),
		ActivityID = {
			60008014
		},
		ShowConditionID = {
			30070214
		}
	},
	[60101019] = {
		ActivityType = 110,
		ActivityPrefab = "/_Activity/StarryWishesSignActivity",
		ActivityTeam = 1,
		Sort = 101,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Id = 60101019,
		Name = getI18NValue(180267596),
		ActivityID = {
			60008005
		},
		ShowConditionID = {
			30070213
		}
	},
	[60101021] = {
		ActivityType = 109,
		ChapterNameImg = "/UI/ActivityPart/ActivityListUI/FreeDrawActivity/FreeDrawActivity_imge01.png",
		ActivityPrefab = "/_Activity/LotteryActivity",
		ActivityTeam = 1,
		Sort = 105,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Jump = 50000003,
		Id = 60101021,
		Name = getI18NValue(180260976),
		ActivityID = {
			60003101
		},
		ShowConditionID = {
			30070206
		}
	},
	[60101022] = {
		ActivityType = 109,
		ChapterNameImg = "/UI/ActivityPart/ActivityListUI/FreeDrawActivity/FreeDrawActivity_imge02.png",
		ActivityPrefab = "/_Activity/LotteryActivity_1",
		ActivityTeam = 1,
		Sort = 105,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Jump = 50000005,
		Id = 60101022,
		Name = getI18NValue(180260977),
		ActivityID = {
			60003102
		},
		ShowConditionID = {
			30070207
		}
	},
	[60101023] = {
		ActivityType = 109,
		ChapterNameImg = "/UI/ActivityPart/ActivityListUI/FreeDrawActivity/FreeDrawActivity_imge03.png",
		ActivityPrefab = "/_Activity/LotteryActivity_2",
		ActivityTeam = 1,
		Sort = 105,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Jump = 50000007,
		Id = 60101023,
		Name = getI18NValue(180260978),
		ActivityID = {
			60003103
		},
		ShowConditionID = {
			30070208
		}
	},
	[60101024] = {
		ActivityType = 109,
		ChapterNameImg = "/UI/ActivityPart/ActivityListUI/FreeDrawActivity/FreeDrawActivity_imge04.png",
		ActivityPrefab = "/_Activity/LotteryActivity_3",
		ActivityTeam = 1,
		Sort = 105,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Jump = 50000009,
		Id = 60101024,
		Name = getI18NValue(180260979),
		ActivityID = {
			60003104
		},
		ShowConditionID = {
			30070211
		}
	},
	[60102000] = {
		ActivityType = 302,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Sort = 301,
		Id = 60102000,
		ActivityTeam = 3,
		Name = getI18NValue(180184053),
		ShowConditionID = {
			30070212,
			30000010
		}
	},
	[60102001] = {
		ActivityType = 302,
		Branch = 1,
		ActivityPrefab = "/_ActiveActivity/GhostMainActivity",
		ActivityTeam = 3,
		Sort = 302,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Id = 60102001,
		Name = getI18NValue(180184054),
		ActivityID = {
			60008010
		},
		ShowConditionID = {
			30070212,
			30000010
		},
		Desc = getI18NValue(180195235)
	},
	[60102002] = {
		ActivityType = 302,
		Branch = 2,
		ActivityPrefab = "/_ActiveActivity/GhostBossActivity",
		ActivityTeam = 3,
		Sort = 303,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Id = 60102002,
		Name = getI18NValue(180184055),
		ActivityID = {
			60008011
		},
		ShowConditionID = {
			30070212,
			30000010
		},
		Desc = getI18NValue(180195236)
	},
	[60102003] = {
		ActivityType = 302,
		Branch = 3,
		ActivityPrefab = "/_ActiveActivity/GhostGameActivity",
		ActivityTeam = 3,
		Sort = 304,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Id = 60102003,
		Name = getI18NValue(180184056),
		ActivityID = {
			60008012
		},
		ShowConditionID = {
			30070212,
			30000010
		},
		Desc = getI18NValue(180195237)
	},
	[60301001] = {
		ActivityType = 301,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Sort = 301,
		Id = 60301001,
		ActivityTeam = 3,
		Name = getI18NValue(180171606),
		ShowConditionID = {
			30070210,
			30000010
		}
	},
	[60301002] = {
		ActivityType = 301,
		Branch = 1,
		ActivityPrefab = "/_ActiveActivity/SummerMainActivity",
		ActivityTeam = 3,
		Sort = 1,
		Background = "/UI/ActivityPart/SummerActivity/SummerActivityMain/SummerActivity_bg_01.png",
		Id = 60301002,
		Name = getI18NValue(180171607),
		ActivityID = {
			60008000
		},
		ShowConditionID = {
			30070210,
			30000010
		}
	},
	[60301003] = {
		ActivityType = 301,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_1.png",
		Sort = 301,
		Id = 60301003,
		ActivityTeam = 3,
		Name = getI18NValue(180261288),
		ShowConditionID = {
			30070215,
			30000005
		}
	},
	[60301004] = {
		ActivityType = 301,
		Branch = 1,
		ActivityPrefab = "/_ActiveActivity/XiaNaiMainActivity",
		ActivityTeam = 3,
		Sort = 1,
		Background = "/UI/ActivityPart/XiaNaiActivity/XiaNaiActivityMain/XiaNaiActivity_bg_01.png",
		Id = 60301004,
		Name = getI18NValue(180261289),
		ActivityID = {
			60008013
		},
		ShowConditionID = {
			30070215,
			30000005
		}
	},
	[60301101] = {
		ActivityType = 107,
		ActivityPrefab = "/_Activity/DiceGameActivity",
		ActivityTeam = 2,
		Sort = 203,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_4.png",
		Id = 60301101,
		Name = getI18NValue(180267597),
		ActivityID = {
			60007001
		},
		ShowConditionID = {
			30070119
		}
	},
	[60301102] = {
		ActivityType = 999,
		ActivityPrefab = "/_Activity/TreasureHuntActivity",
		ActivityTeam = 2,
		Sort = 301,
		Background = "/UI/ActivityPart/ActivityListUI/ActivityListUI_Bg/ActivityList_Bg_4.png",
		Id = 60301102,
		Name = getI18NValue(180267598),
		ActivityID = {
			60007002
		},
		ShowConditionID = {
			30070221
		}
	}
}

setmetatable(CfgActivityListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgActivityListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Branch = 0,
		Sort = 0,
		ActivityPrefab = "",
		ActivityTeam = 0,
		ChapterNameImg = "",
		ActivityType = 0,
		Name = "",
		Background = "",
		Jump = 0,
		Desc = "",
		ActivityID = {},
		ShowConditionID = {},
		Reward = {}
	}
}

for i, data in pairs(CfgActivityListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgActivityListTable
