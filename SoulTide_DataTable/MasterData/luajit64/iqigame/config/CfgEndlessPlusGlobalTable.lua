-- chunkname: @IQIGame\\Config\\CfgEndlessPlusGlobalTable.lua

local CfgEndlessPlusGlobalTable = {
	{
		BossImage = "/Challenge_Background/DramaChallenge/DramaChallenge_Bg/ActivityDrama_Challenge_Bg_01.png",
		ScoreItem = 214,
		MonsterSpine = 40600001,
		BossTeam = 41710011,
		ShowUiSize = 1,
		UIBGM = 434,
		Id = 1,
		ExploreHallUIBG = "EndlessPlus/Activity_EndlessPlus_230119",
		SubTitle = getI18NValue(180496934),
		ButtonWord = getI18NValue(180496935),
		MallName = getI18NValue(180478302),
		Desc = getI18NValue(180478301),
		Level = {
			10001,
			10002,
			10003
		},
		MallGoods = {
			1130101001,
			1130101002,
			1130101003,
			1130101004,
			1130101005,
			1130101006,
			1130101007,
			1130101008,
			1130101009,
			1130101010,
			1130101011,
			1130101012,
			1130101013
		},
		BossName = getI18NValue(180478300),
		ShowUiPosition = {
			0,
			0,
			0
		}
	}
}

setmetatable(CfgEndlessPlusGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgEndlessPlusGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		BossImage = "",
		ScoreItem = 0,
		SubTitle = "",
		ExploreHallUIBG = "",
		MallName = "",
		MonsterSpine = 0,
		BossTeam = 0,
		ButtonWord = "",
		BossBg = "",
		UIBGM = 0,
		ShowUiSize = 0,
		BossName = "",
		Desc = "",
		ShowUiPosition = {},
		MallGoods = {},
		Level = {
			0,
			0,
			0
		}
	}
}

for i, data in pairs(CfgEndlessPlusGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgEndlessPlusGlobalTable
