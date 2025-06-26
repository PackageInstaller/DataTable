-- chunkname: @IQIGame\\Config\\CfgPushMessageTable.lua

local CfgPushMessageTable = {
	{
		Id = 1,
		Title = getI18NValue(180105505),
		Word = getI18NValue(180105504)
	},
	{
		Id = 2,
		Title = getI18NValue(180105507),
		Word = getI18NValue(180105506)
	},
	{
		Id = 3,
		Title = getI18NValue(180105509),
		Word = getI18NValue(180105508)
	},
	{
		Id = 4,
		Title = getI18NValue(180105511),
		Word = getI18NValue(180105510)
	}
}

setmetatable(CfgPushMessageTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPushMessageTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Title = "",
		Condition = "",
		Word = ""
	}
}

for i, data in pairs(CfgPushMessageTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPushMessageTable
