-- chunkname: @IQIGame\\Config\\CfgActiveTurntableTable.lua

local CfgActiveTurntableTable = {
	{
		Id = 1,
		Rare = 4,
		Reward = {
			1008,
			1
		}
	},
	{
		Id = 2,
		Rare = 3,
		Reward = {
			2,
			100
		}
	},
	{
		Id = 3,
		Rare = 2,
		Reward = {
			1,
			10000
		}
	},
	{
		Id = 4,
		Rare = 4,
		Reward = {
			1001,
			1
		}
	},
	{
		Id = 5,
		Rare = 3,
		Reward = {
			11402,
			6
		}
	},
	{
		Id = 6,
		Rare = 1,
		Reward = {
			1,
			5000
		}
	},
	{
		Id = 7,
		Rare = 4,
		Reward = {
			1009,
			1
		}
	},
	{
		Id = 8,
		Rare = 2,
		Reward = {
			2,
			50
		}
	},
	{
		Id = 9,
		Rare = 4,
		Reward = {
			1002,
			1
		}
	},
	{
		Id = 10,
		Rare = 1,
		Reward = {
			2,
			20
		}
	},
	{
		Id = 11,
		Rare = 4,
		Reward = {
			1010,
			1
		}
	},
	{
		Id = 12,
		Rare = 3,
		Reward = {
			1,
			20000
		}
	},
	{
		Id = 13,
		Rare = 4,
		Reward = {
			1012,
			1
		}
	},
	{
		Id = 14,
		Rare = 2,
		Reward = {
			11402,
			4
		}
	},
	{
		Id = 15,
		Rare = 4,
		Reward = {
			1011,
			1
		}
	},
	{
		Id = 16,
		Rare = 1,
		Reward = {
			11402,
			2
		}
	}
}

setmetatable(CfgActiveTurntableTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgActiveTurntableTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Rare = 0,
		Reward = {}
	}
}

for i, data in pairs(CfgActiveTurntableTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgActiveTurntableTable
