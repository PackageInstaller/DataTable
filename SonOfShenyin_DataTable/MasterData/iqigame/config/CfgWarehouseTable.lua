-- chunkname: @IQIGame\\Config\\CfgWarehouseTable.lua

local CfgWarehouseTable = {
	{
		Id = 1,
		Text = 1000004
	},
	{
		Text = 1000005,
		Checked = true,
		SuperId = 1,
		Index = 1,
		Id = 2,
		EnglishText = "Item",
		Sort = {
			1,
			3
		},
		SortDict = {
			1000001,
			1000003
		}
	},
	{
		Text = 1000006,
		Index = 2,
		SuperId = 1,
		Id = 3,
		EnglishText = "Equip",
		Sort = {
			1,
			2
		},
		SortDict = {
			1000001,
			1000002
		}
	},
	{
		Text = 1000007,
		Index = 3,
		SuperId = 1,
		Id = 4,
		EnglishText = "Skill",
		Sort = {
			1,
			2
		},
		SortDict = {
			1000001,
			1000002
		}
	},
	{
		Text = 1000008,
		Index = 4,
		SuperId = 1,
		Id = 5,
		EnglishText = "Role",
		Sort = {
			1,
			3
		},
		SortDict = {
			1000001,
			1000003
		}
	},
	{
		Text = 1600004,
		SuperId = 3,
		Checked = true,
		Index = 1,
		Id = 6
	},
	{
		Id = 7,
		Text = 1600005,
		SuperId = 3,
		Index = 2
	},
	{
		Id = 8,
		Text = 1600006,
		SuperId = 3,
		Index = 3
	},
	{
		Id = 9,
		Text = 1600007,
		SuperId = 3,
		Index = 4
	},
	{
		Id = 10,
		Text = 1600008,
		SuperId = 3,
		Index = 5
	},
	[13] = {
		Id = 13,
		Text = 1600022,
		SuperId = 4,
		Index = 1
	},
	[14] = {
		Id = 14,
		Text = 1600014,
		SuperId = 4,
		Index = 2
	},
	[15] = {
		Id = 15,
		Text = 8000001
	},
	[16] = {
		Text = 1000013,
		Index = 5,
		SuperId = 1,
		Id = 16,
		EnglishText = "Consumables",
		Sort = {
			1,
			3
		},
		SortDict = {
			1000001,
			1000003
		}
	}
}

setmetatable(CfgWarehouseTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgWarehouseTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Checked = false,
		SuperId = 0,
		Text = 0,
		Index = 0,
		EnglishText = "",
		SortDict = {},
		Sort = {}
	}
}

for i, data in pairs(CfgWarehouseTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgWarehouseTable
