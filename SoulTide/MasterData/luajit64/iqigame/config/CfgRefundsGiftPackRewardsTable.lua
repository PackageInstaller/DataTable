-- chunkname: @IQIGame\\Config\\CfgRefundsGiftPackRewardsTable.lua

local CfgRefundsGiftPackRewardsTable = {
	{
		Id = 1,
		payPoint = 6,
		Rewards = {
			11501,
			100
		}
	},
	{
		Id = 2,
		payPoint = 6,
		Rewards = {
			11501,
			100
		}
	},
	{
		Id = 3,
		payPoint = 6,
		Rewards = {
			11501,
			100
		}
	},
	{
		Id = 4,
		payPoint = 6,
		Rewards = {
			11501,
			100
		}
	},
	{
		Id = 5,
		payPoint = 6,
		Rewards = {
			11501,
			100
		}
	},
	{
		Id = 6,
		payPoint = 6,
		Rewards = {
			11501,
			100
		}
	},
	{
		Id = 7,
		payPoint = 6,
		Rewards = {
			11501,
			100
		}
	},
	{
		Id = 8,
		payPoint = 6,
		Rewards = {
			11501,
			100
		}
	},
	{
		Id = 9,
		payPoint = 6,
		Rewards = {
			11501,
			100
		}
	},
	{
		Id = 10,
		payPoint = 6,
		Rewards = {
			11501,
			100
		}
	},
	{
		Id = 11,
		payPoint = 6,
		Rewards = {
			11501,
			100
		}
	},
	{
		Id = 12,
		payPoint = 6,
		Rewards = {
			11501,
			100
		}
	},
	{
		Id = 13,
		payPoint = 6,
		Rewards = {
			11501,
			100
		}
	},
	{
		Id = 14,
		payPoint = 6,
		Rewards = {
			11501,
			100
		}
	}
}

setmetatable(CfgRefundsGiftPackRewardsTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRefundsGiftPackRewardsTable]")
	end
})

local defaultMetaTable = {
	__index = {
		payPoint = 0,
		Rewards = {}
	}
}

for i, data in pairs(CfgRefundsGiftPackRewardsTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRefundsGiftPackRewardsTable
