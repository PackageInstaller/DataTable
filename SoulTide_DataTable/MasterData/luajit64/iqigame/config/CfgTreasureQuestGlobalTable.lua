-- chunkname: @IQIGame\\Config\\CfgTreasureQuestGlobalTable.lua

local CfgTreasureQuestGlobalTable = {
	[230119] = {
		Id = 230119,
		BackGround = "/UI/_DailyActivityUI/TreasureQuest/TreasureQuest_230119001.prefab",
		Name = getI18NValue(180498840),
		Desc = getI18NValue(180498839),
		Rewards = {
			1
		}
	}
}

setmetatable(CfgTreasureQuestGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTreasureQuestGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		BackGround = "",
		Name = "",
		Desc = "",
		Rewards = {}
	}
}

for i, data in pairs(CfgTreasureQuestGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTreasureQuestGlobalTable
