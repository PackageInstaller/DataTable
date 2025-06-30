-- chunkname: @IQIGame\\Config\\CfgLuckyTurntableTable.lua

local CfgLuckyTurntableTable = {
	{
		Probability = 1.5,
		Id = 1,
		Reward = {
			10006,
			1
		}
	},
	{
		Probability = 20,
		Id = 2,
		Reward = {
			10302,
			1
		}
	},
	{
		Probability = 9,
		Id = 3,
		Reward = {
			2,
			10
		}
	},
	{
		Probability = 20,
		Id = 4,
		Reward = {
			11402,
			1
		}
	},
	{
		Probability = 1.5,
		Id = 5,
		Reward = {
			10005,
			1
		}
	},
	{
		Probability = 9,
		Id = 6,
		Reward = {
			10501,
			1
		}
	},
	{
		Probability = 18,
		Id = 7,
		Reward = {
			20201,
			1
		}
	},
	{
		Probability = 21,
		Id = 8,
		Reward = {
			1,
			2000
		}
	}
}

setmetatable(CfgLuckyTurntableTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLuckyTurntableTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Probability = 0,
		Reward = {}
	}
}

for i, data in pairs(CfgLuckyTurntableTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLuckyTurntableTable
