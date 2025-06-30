-- chunkname: @IQIGame\\Config\\CfgFlightChallengeControlTable.lua

local CfgFlightChallengeControlTable = {
	{
		Id = 1,
		MaxDistance = 9999999,
		MaxScore = 99999,
		BossMapID = 40500023,
		BossTeam = 42500101,
		BossBg = "/Image_Resources/MonsterDrawing/Drawing/Jslg_Beka_01.png",
		UIBGM = 446,
		BossAddLimit = 50,
		ExploreHallUIBG = "Activity_FlightChallenge_231109",
		Name = getI18NValue(180776280),
		ButtonName = getI18NValue(180776279),
		Desc = getI18NValue(180776278),
		Cost = {
			104,
			1
		},
		DistanceReward = {
			1500,
			11125001
		},
		DistanceScore = {
			10,
			447
		},
		ClearItem = {
			447,
			125001,
			125002,
			125003,
			125004,
			125005,
			125006,
			125007,
			125008,
			125009,
			125010,
			125011,
			125012
		},
		BossAddType = {
			7,
			9,
			11
		},
		BossAddRatio = {
			200,
			0.1
		},
		WeakType = {
			2,
			5,
			6
		},
		AffixBuff = {
			10309500,
			10309800,
			10309900
		},
		BossName = getI18NValue(180782232)
	}
}

setmetatable(CfgFlightChallengeControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFlightChallengeControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ButtonName = "",
		BossAddLimit = 0,
		BossName = "",
		MaxScore = 0,
		Name = "",
		Monster = 0,
		Desc = "",
		BossMapID = 0,
		BossTeam = 0,
		BossBg = "",
		UIBGM = 0,
		MaxDistance = 0,
		ExploreHallUIBG = "",
		DistanceReward = {},
		ClearItem = {},
		Cost = {},
		BossAddRatio = {},
		BossAddType = {},
		AffixBuff = {},
		DistanceScore = {},
		WeakType = {}
	}
}

for i, data in pairs(CfgFlightChallengeControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFlightChallengeControlTable
