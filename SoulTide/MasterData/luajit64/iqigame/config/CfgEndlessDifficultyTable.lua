-- chunkname: @IQIGame\\Config\\CfgEndlessDifficultyTable.lua

local CfgEndlessDifficultyTable = {
	{
		PowerValue4 = 1,
		Id = 1,
		PowerValue3 = 1,
		PowerValue2 = 1,
		PowerValue1 = 1
	},
	{
		PowerValue4 = 5.6144,
		Id = 2,
		PowerValue3 = 5.6144,
		PowerValue2 = 5.6144,
		PowerValue1 = 5.6144
	},
	{
		PowerValue4 = 14.7213,
		Id = 3,
		PowerValue3 = 14.7213,
		PowerValue2 = 14.7213,
		PowerValue1 = 14.7213
	}
}

setmetatable(CfgEndlessDifficultyTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgEndlessDifficultyTable]")
	end
})

local defaultMetaTable = {
	__index = {
		PowerValue2 = 0,
		PowerValue1 = 0,
		PowerValue3 = 0,
		PowerValue4 = 0
	}
}

for i, data in pairs(CfgEndlessDifficultyTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgEndlessDifficultyTable
