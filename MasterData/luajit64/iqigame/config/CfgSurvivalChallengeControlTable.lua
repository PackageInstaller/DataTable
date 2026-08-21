-- chunkname: @IQIGame\\Config\\CfgSurvivalChallengeControlTable.lua

local CfgSurvivalChallengeControlTable = {
	{
		ItemId = 125013,
		ExploreHallUIBG = "Activity_Survival",
		PlayerId = 1001,
		SurvivalFlyGameBG = "/Scene/Survival/SurvivalFlyGameBG.prefab",
		MaxLevel = 22,
		SurvivalChallengeLevel = "/_DailyActivityUI/SurvivalChallenge/SurvivalChallengeLevelUIView",
		UIBGM = 432,
		Id = 1,
		Name = getI18NValue(180918106),
		ButtonName = getI18NValue(180918105),
		Desc = getI18NValue(180918104),
		Cost = {
			104,
			1
		},
		ClearItem = {
			464,
			125013
		}
	},
	{
		ItemId = 125014,
		ExploreHallUIBG = "Activity_Survival_1",
		PlayerId = 2001,
		SurvivalFlyGameBG = "/Scene/Survival/SurvivalFlyGameBG_01.prefab",
		MaxLevel = 22,
		SurvivalChallengeLevel = "/_DailyActivityUI/SurvivalChallenge/SurvivalChallengeLevelUIView_1",
		UIBGM = 418,
		Id = 2,
		Name = getI18NValue(180946751),
		ButtonName = getI18NValue(180946750),
		Desc = getI18NValue(180946749),
		Cost = {
			104,
			1
		},
		ClearItem = {
			474,
			125014
		}
	}
}

setmetatable(CfgSurvivalChallengeControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSurvivalChallengeControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ItemId = 0,
		PlayerId = 0,
		ButtonName = "",
		ExploreHallUIBG = "",
		SurvivalFlyGameBG = "",
		Name = "",
		MaxLevel = 0,
		SurvivalChallengeLevel = "",
		UIBGM = 0,
		Desc = "",
		ClearItem = {},
		Cost = {}
	}
}

for i, data in pairs(CfgSurvivalChallengeControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSurvivalChallengeControlTable
