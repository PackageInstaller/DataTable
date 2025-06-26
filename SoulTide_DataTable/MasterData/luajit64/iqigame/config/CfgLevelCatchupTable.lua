-- chunkname: @IQIGame\\Config\\CfgLevelCatchupTable.lua

local CfgLevelCatchupTable = {
	{
		FunctionId = 10203001,
		Id = 1,
		Name = getI18NValue(180082228),
		Desc = getI18NValue(180082227)
	},
	{
		FunctionId = 10206029,
		Id = 2,
		Name = getI18NValue(180082230),
		Desc = getI18NValue(180082229)
	},
	{
		Id = 3,
		Name = getI18NValue(180249404),
		Desc = getI18NValue(180249403)
	},
	{
		Id = 4,
		Parameter = 6520070,
		Name = getI18NValue(180249406),
		Desc = getI18NValue(180249405)
	},
	{
		Id = 5,
		Parameter = 1010301038,
		Name = getI18NValue(180249408),
		Desc = getI18NValue(180249407)
	}
}

setmetatable(CfgLevelCatchupTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLevelCatchupTable]")
	end
})

local defaultMetaTable = {
	__index = {
		FunctionId = 0,
		Name = "",
		Parameter = 0,
		Desc = ""
	}
}

for i, data in pairs(CfgLevelCatchupTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLevelCatchupTable
