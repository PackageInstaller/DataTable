-- chunkname: @IQIGame\\Config\\CfgPandaActivityGlobalTable.lua

local CfgPandaActivityGlobalTable = {
	{
		FeedingFavor = 20,
		Id = 1,
		PlayFavor = 50,
		ScenePrefabs = "/Scene/ActivityBG/ActivityBG_Panda.prefab",
		BathingFavor = 50,
		BGM = 416,
		BackGround = "/UI/_DailyActivityUI/Panda_220107001.prefab",
		PandaSpine = 900030,
		Name = getI18NValue(180245858),
		FeedingNeeds = {
			403,
			1
		},
		BathingNeeds = {
			2,
			20
		},
		PlayNeeds = {
			404,
			1
		},
		ExtraRewardNeeds = {
			10000,
			100
		},
		ExtraReward = {
			401,
			200
		}
	}
}

setmetatable(CfgPandaActivityGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPandaActivityGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		FeedingFavor = 0,
		PlayFavor = 0,
		Desc = "",
		BathingFavor = 0,
		ScenePrefabs = "",
		Name = "",
		BackGround = "",
		PandaSpine = 0,
		BGM = 0,
		BathingNeeds = {},
		ExtraRewardNeeds = {},
		FeedingNeeds = {},
		ExtraReward = {},
		PlayNeeds = {}
	}
}

for i, data in pairs(CfgPandaActivityGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPandaActivityGlobalTable
