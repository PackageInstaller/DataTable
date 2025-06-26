-- chunkname: @IQIGame\\Config\\CfgLimitedTurntableGlobalTable.lua

local CfgLimitedTurntableGlobalTable = {
	{
		BackGround = "/UI/_DailyActivityUI/LinkageTable/LinkageTable_221222001.prefab",
		Id = 1,
		MaxTimes = 50,
		RewardsGroup = 1,
		CostItem = 426,
		CostNum = 1,
		Name = getI18NValue(180478304),
		Desc = getI18NValue(180478303),
		TotalTaskID = {
			90107301,
			90107302,
			90107303,
			90107304,
			90107305,
			90107306,
			90107307,
			90107308,
			90107309,
			90107310
		}
	}
}

setmetatable(CfgLimitedTurntableGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLimitedTurntableGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		CostItem = 0,
		MaxTimes = 0,
		BackGround = "",
		CostNum = 0,
		RewardsGroup = 0,
		Desc = "",
		TotalTaskID = {}
	}
}

for i, data in pairs(CfgLimitedTurntableGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLimitedTurntableGlobalTable
