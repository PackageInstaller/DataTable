-- chunkname: @IQIGame\\Config\\CfgGlobalBuffTable.lua

local CfgGlobalBuffTable = {
	{
		Group = 1,
		EffectType = 1,
		Id = 1,
		BuffTime = 2592000,
		Name = getI18NValue(180499171)
	},
	{
		Group = 2,
		EffectType = 2,
		Id = 2,
		BuffTime = 2592000,
		Name = getI18NValue(180499172),
		EffectParams = {
			"0.5"
		}
	},
	{
		Group = 3,
		EffectType = 3,
		Id = 3,
		BuffTime = 2592000,
		Name = getI18NValue(180499173),
		EffectParams = {
			"5"
		}
	}
}

setmetatable(CfgGlobalBuffTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGlobalBuffTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		EffectType = 0,
		Name = "",
		Icon = "",
		BuffTime = 0,
		EffectParams = {}
	}
}

for i, data in pairs(CfgGlobalBuffTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGlobalBuffTable
