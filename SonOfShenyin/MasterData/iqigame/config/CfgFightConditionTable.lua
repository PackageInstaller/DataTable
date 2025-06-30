-- chunkname: @IQIGame\\Config\\CfgFightConditionTable.lua

local CfgFightConditionTable = {
	{
		Id = 1,
		ComparisonOP = "<",
		Name = getI18NValue(180001680)
	},
	{
		Id = 2,
		ComparisonOP = "<",
		Name = getI18NValue(180001681)
	},
	{
		Id = 3,
		ComparisonOP = ">=",
		Name = getI18NValue(180001682)
	},
	{
		Id = 4,
		ComparisonOP = "=",
		Name = getI18NValue(180001683)
	},
	{
		Id = 5,
		ComparisonOP = "=",
		Name = getI18NValue(180001684)
	}
}

setmetatable(CfgFightConditionTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFightConditionTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		ComparisonOP = ""
	}
}

for i, data in pairs(CfgFightConditionTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFightConditionTable
