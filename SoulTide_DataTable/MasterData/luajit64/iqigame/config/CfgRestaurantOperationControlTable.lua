-- chunkname: @IQIGame\\Config\\CfgRestaurantOperationControlTable.lua

local CfgRestaurantOperationControlTable = {
	{
		NPCAction = 220,
		MoneyId = 331,
		AttMax = 5,
		TimeInterval = 60,
		CompletedEventMax = 50,
		UnlockEvent = 1014,
		MainUiGetButton = 360,
		MaxTimes = 720,
		BossMapID = 41100003,
		UnfinishedEventMax = 24,
		EventTimeInterval = 1800,
		BossTeam = 42770101,
		BossBg = "/Image_Resources/MonsterDrawing/Drawing/ZTKS_liangshuqishi_01.png",
		UIBGM = 448,
		Id = 1,
		ScoreId = 333,
		ExploreHallUIBG = "Activity_RestaurantOperation_240201",
		Name = getI18NValue(180828157),
		ButtonName = getI18NValue(180828156),
		Desc = getI18NValue(180828155),
		ClearItem = {
			331,
			332,
			333,
			334,
			335
		},
		WeakType = {
			1,
			2,
			6
		},
		AffixBuff = {
			30400003,
			30400004,
			30400005
		},
		BossName = getI18NValue(180828154),
		FirstTaskId = {
			90301001,
			90301010,
			90301018,
			90301024,
			90301030,
			90301036,
			90301046,
			90301056,
			90301066
		},
		AchievementsID = {
			90301001,
			90301002,
			90301003,
			90301004,
			90301005,
			90301006,
			90301007,
			90301008,
			90301009,
			90301010,
			90301011,
			90301012,
			90301013,
			90301014,
			90301015,
			90301016,
			90301017,
			90301018,
			90301019,
			90301020,
			90301021,
			90301022,
			90301023,
			90301024,
			90301025,
			90301026,
			90301027,
			90301028,
			90301029,
			90301030,
			90301031,
			90301032,
			90301033,
			90301034,
			90301035,
			90301036,
			90301037,
			90301038,
			90301039,
			90301040,
			90301041,
			90301042,
			90301043,
			90301044,
			90301045,
			90301046,
			90301047,
			90301048,
			90301049,
			90301050,
			90301051,
			90301052,
			90301053,
			90301054,
			90301055,
			90301056,
			90301057,
			90301058,
			90301059,
			90301060,
			90301061,
			90301062,
			90301063,
			90301064,
			90301065,
			90301066,
			90301067,
			90301068,
			90301069,
			90301070,
			90301071,
			90301072,
			90301073,
			90301074,
			90301075
		},
		InitialProps = {
			331,
			500
		},
		CreateCost = {
			331,
			100
		},
		InitialAtt = {
			1,
			3
		}
	}
}

setmetatable(CfgRestaurantOperationControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRestaurantOperationControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		UIBGM = 0,
		ButtonName = "",
		AttMax = 0,
		BossName = "",
		TimeInterval = 0,
		Name = "",
		NPCAction = 0,
		BossMapID = 0,
		UnfinishedEventMax = 0,
		Desc = "",
		MainUiGetButton = 0,
		UnlockEvent = 0,
		EventTimeInterval = 0,
		MaxTimes = 0,
		MoneyId = 0,
		CompletedEventMax = 0,
		BossTeam = 0,
		BossBg = "",
		ScoreId = 0,
		ExploreHallUIBG = "",
		ClearItem = {},
		FirstTaskId = {},
		AffixBuff = {},
		WeakType = {},
		InitialAtt = {},
		InitialProps = {},
		AchievementsID = {},
		CreateCost = {}
	}
}

for i, data in pairs(CfgRestaurantOperationControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRestaurantOperationControlTable
