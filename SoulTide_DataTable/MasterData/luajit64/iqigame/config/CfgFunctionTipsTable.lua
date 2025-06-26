-- chunkname: @IQIGame\\Config\\CfgFunctionTipsTable.lua

local CfgFunctionTipsTable = {
	{
		FunctionId = 10603001,
		Id = 1,
		Type = 1,
		Describe = getI18NValue(180078848)
	},
	{
		FunctionId = 10207001,
		Id = 2,
		Type = 3,
		Describe = getI18NValue(180078849)
	},
	{
		FunctionId = 10209001,
		Id = 3,
		Type = 4,
		Describe = getI18NValue(180078850)
	},
	{
		FunctionId = 10209001,
		Id = 4,
		Type = 5,
		Describe = getI18NValue(180078851)
	},
	{
		FunctionId = 10206001,
		Id = 5,
		Type = 6,
		Describe = getI18NValue(180078852)
	},
	{
		FunctionId = 10603001,
		Id = 6,
		Type = 7,
		Describe = getI18NValue(180078853)
	}
}

setmetatable(CfgFunctionTipsTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFunctionTipsTable]")
	end
})

local defaultMetaTable = {
	__index = {
		FunctionId = 0,
		Describe = "",
		Type = 0
	}
}

for i, data in pairs(CfgFunctionTipsTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFunctionTipsTable
