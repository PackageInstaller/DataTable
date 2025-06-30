-- chunkname: @IQIGame\\Config\\CfgAmusementParkIncomeTable.lua

local CfgAmusementParkIncomeTable = {
	{
		Group = 1,
		Id = 1,
		Type = 10,
		Attribute = {
			4
		}
	},
	{
		Group = 1,
		Id = 2,
		Type = 11,
		Attribute = {
			5
		}
	},
	[4] = {
		Group = 1,
		IncomeItem = 351,
		Type = 13,
		Id = 4,
		Attribute = {
			5,
			7,
			10,
			11
		}
	},
	[5] = {
		Group = 1,
		IncomeItem = 353,
		Ratio = 0.001,
		Type = 14,
		Id = 5,
		Attribute = {
			13
		}
	}
}

setmetatable(CfgAmusementParkIncomeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgAmusementParkIncomeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		IncomeItem = 0,
		Ratio = 0,
		Type = 0,
		Group = 0,
		Attribute = {}
	}
}

for i, data in pairs(CfgAmusementParkIncomeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgAmusementParkIncomeTable
