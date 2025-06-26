-- chunkname: @IQIGame\\Config\\CfgElementBuffTable.lua

local CfgElementBuffTable = {
	{
		Id = 1,
		BuffStackNum = 1,
		ElementBuff = 123,
		BuffTime = 2
	},
	{
		Id = 2,
		BuffStackNum = 1,
		ElementBuff = 124,
		BuffTime = 2
	},
	{
		Id = 3,
		BuffStackNum = 1,
		ElementBuff = 125,
		BuffTime = 2
	},
	{
		Id = 4,
		BuffStackNum = 1,
		ElementBuff = 126,
		BuffTime = 2
	}
}

setmetatable(CfgElementBuffTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgElementBuffTable]")
	end
})

local defaultMetaTable = {
	__index = {
		BuffTime = 0,
		BuffStackNum = 0,
		ElementBuff = 0,
		BuffProbability = 0
	}
}

for i, data in pairs(CfgElementBuffTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgElementBuffTable
