-- chunkname: @IQIGame\\Config\\CfgLimitedTurntableGroupTable.lua

local CfgLimitedTurntableGroupTable = {
	{
		Id = 1,
		TotalLimit = 1,
		Group = 1,
		Odds = 10,
		Sort = 1,
		Reward = {
			150001,
			1
		}
	},
	{
		Id = 2,
		TotalLimit = -1,
		Group = 1,
		Odds = 160,
		Sort = 2,
		Reward = {
			10302,
			2
		}
	},
	{
		Id = 3,
		TotalLimit = -1,
		Group = 1,
		Odds = 80,
		Sort = 3,
		Reward = {
			2,
			50
		}
	},
	{
		Id = 4,
		TotalLimit = -1,
		Group = 1,
		Odds = 50,
		Sort = 4,
		Reward = {
			11402,
			6
		}
	},
	{
		Id = 5,
		TotalLimit = -1,
		Group = 1,
		Odds = 40,
		Sort = 5,
		Reward = {
			1,
			20000
		}
	},
	{
		Id = 6,
		TotalLimit = 1,
		Group = 1,
		Odds = 10,
		Sort = 6,
		Reward = {
			150002,
			1
		}
	},
	{
		Id = 7,
		TotalLimit = -1,
		Group = 1,
		Odds = 150,
		Sort = 7,
		Reward = {
			11402,
			2
		}
	},
	{
		Id = 8,
		TotalLimit = -1,
		Group = 1,
		Odds = 120,
		Sort = 8,
		Reward = {
			1,
			10000
		}
	},
	{
		Id = 9,
		TotalLimit = -1,
		Group = 1,
		Odds = 80,
		Sort = 9,
		Reward = {
			10302,
			6
		}
	},
	{
		Id = 10,
		TotalLimit = 1,
		Group = 1,
		Odds = 10,
		Sort = 10,
		Reward = {
			150003,
			1
		}
	},
	{
		Id = 11,
		TotalLimit = -1,
		Group = 1,
		Odds = 30,
		Sort = 11,
		Reward = {
			2,
			100
		}
	},
	{
		Id = 12,
		TotalLimit = -1,
		Group = 1,
		Odds = 100,
		Sort = 12,
		Reward = {
			11402,
			4
		}
	},
	{
		Id = 13,
		TotalLimit = -1,
		Group = 1,
		Odds = 160,
		Sort = 13,
		Reward = {
			1,
			5000
		}
	},
	{
		Id = 14,
		TotalLimit = -1,
		Group = 1,
		Odds = 40,
		Sort = 14,
		Reward = {
			10302,
			8
		}
	},
	{
		Id = 15,
		TotalLimit = 1,
		Group = 1,
		Odds = 10,
		Sort = 15,
		Reward = {
			150004,
			1
		}
	},
	{
		Id = 16,
		TotalLimit = -1,
		Group = 1,
		Odds = 120,
		Sort = 16,
		Reward = {
			2,
			20
		}
	},
	{
		Id = 17,
		TotalLimit = -1,
		Group = 1,
		Odds = 120,
		Sort = 17,
		Reward = {
			10302,
			4
		}
	},
	{
		Id = 18,
		TotalLimit = -1,
		Group = 1,
		Odds = 80,
		Sort = 18,
		Reward = {
			1,
			15000
		}
	}
}

setmetatable(CfgLimitedTurntableGroupTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLimitedTurntableGroupTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Sort = 0,
		Group = 0,
		TotalLimit = 0,
		Odds = 0,
		Reward = {}
	}
}

for i, data in pairs(CfgLimitedTurntableGroupTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLimitedTurntableGroupTable
