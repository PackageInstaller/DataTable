-- chunkname: @IQIGame\\Config\\CfgTreasureQuestRewardsTable.lua

local CfgTreasureQuestRewardsTable = {
	{
		Id = 1,
		Name = getI18NValue(180498877),
		Reward = {
			30302,
			1
		},
		QuestList = {
			20340001,
			20340002,
			20340003,
			20340004,
			20340005,
			20340006,
			20340007,
			20340008,
			20340009,
			20340010,
			20340011,
			20340012,
			20340013,
			20340014
		},
		NumRequired = {
			430,
			100
		}
	}
}

setmetatable(CfgTreasureQuestRewardsTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTreasureQuestRewardsTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		FunctionId = 0,
		NumRequired = {},
		QuestList = {},
		Reward = {}
	}
}

for i, data in pairs(CfgTreasureQuestRewardsTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTreasureQuestRewardsTable
