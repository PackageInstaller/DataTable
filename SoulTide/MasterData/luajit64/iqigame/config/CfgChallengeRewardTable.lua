-- chunkname: @IQIGame\\Config\\CfgChallengeRewardTable.lua

local CfgChallengeRewardTable = {
	{
		Id = 1,
		DailyDupId = 1,
		DamageNeed = 1000,
		Gift = {
			1,
			5000
		}
	},
	{
		Id = 2,
		DailyDupId = 1,
		DamageNeed = 2000,
		Gift = {
			1,
			5000
		}
	},
	{
		Id = 3,
		DailyDupId = 1,
		DamageNeed = 4000,
		Gift = {
			1,
			5000
		}
	},
	{
		Id = 4,
		DailyDupId = 1,
		DamageNeed = 6000,
		Gift = {
			1,
			5000
		}
	},
	{
		Id = 5,
		DailyDupId = 1,
		DamageNeed = 8000,
		Gift = {
			1,
			5000
		}
	},
	{
		Id = 6,
		DailyDupId = 1,
		DamageNeed = 10000,
		Gift = {
			1,
			5000
		}
	},
	{
		Id = 7,
		DailyDupId = 1,
		DamageNeed = 20000,
		Gift = {
			1,
			5000
		}
	},
	{
		Id = 8,
		DailyDupId = 1,
		DamageNeed = 40000,
		Gift = {
			1,
			10000
		}
	},
	{
		Id = 9,
		DailyDupId = 1,
		DamageNeed = 60000,
		Gift = {
			1,
			10000
		}
	},
	{
		Id = 10,
		DailyDupId = 1,
		DamageNeed = 80000,
		Gift = {
			1,
			10000
		}
	},
	{
		Id = 11,
		DailyDupId = 1,
		DamageNeed = 100000,
		Gift = {
			1,
			10000
		}
	},
	{
		Id = 12,
		DailyDupId = 1,
		DamageNeed = 200000,
		Gift = {
			1,
			15000
		}
	},
	{
		Id = 13,
		DailyDupId = 1,
		DamageNeed = 400000,
		Gift = {
			1,
			15000
		}
	},
	{
		Id = 14,
		DailyDupId = 1,
		DamageNeed = 600000,
		Gift = {
			1,
			15000
		}
	},
	{
		Id = 15,
		DailyDupId = 1,
		DamageNeed = 800000,
		Gift = {
			1,
			15000
		}
	},
	{
		Id = 16,
		DailyDupId = 1,
		DamageNeed = 1000000,
		Gift = {
			1,
			15000
		}
	},
	{
		Id = 17,
		DailyDupId = 2,
		DamageNeed = 1000,
		Gift = {
			10303,
			2
		}
	},
	{
		Id = 18,
		DailyDupId = 2,
		DamageNeed = 2000,
		Gift = {
			10303,
			2
		}
	},
	{
		Id = 19,
		DailyDupId = 2,
		DamageNeed = 4000,
		Gift = {
			10303,
			2
		}
	},
	{
		Id = 20,
		DailyDupId = 2,
		DamageNeed = 6000,
		Gift = {
			10303,
			2
		}
	},
	{
		Id = 21,
		DailyDupId = 2,
		DamageNeed = 8000,
		Gift = {
			10303,
			2
		}
	},
	{
		Id = 22,
		DailyDupId = 2,
		DamageNeed = 10000,
		Gift = {
			10303,
			3
		}
	},
	{
		Id = 23,
		DailyDupId = 2,
		DamageNeed = 20000,
		Gift = {
			10303,
			3
		}
	},
	{
		Id = 24,
		DailyDupId = 2,
		DamageNeed = 40000,
		Gift = {
			10303,
			3
		}
	},
	{
		Id = 25,
		DailyDupId = 2,
		DamageNeed = 60000,
		Gift = {
			10303,
			3
		}
	},
	{
		Id = 26,
		DailyDupId = 2,
		DamageNeed = 80000,
		Gift = {
			10303,
			4
		}
	},
	{
		Id = 27,
		DailyDupId = 2,
		DamageNeed = 100000,
		Gift = {
			10303,
			4
		}
	},
	{
		Id = 28,
		DailyDupId = 2,
		DamageNeed = 200000,
		Gift = {
			10303,
			4
		}
	},
	{
		Id = 29,
		DailyDupId = 2,
		DamageNeed = 400000,
		Gift = {
			10303,
			4
		}
	},
	{
		Id = 30,
		DailyDupId = 2,
		DamageNeed = 600000,
		Gift = {
			10303,
			4
		}
	},
	{
		Id = 31,
		DailyDupId = 2,
		DamageNeed = 800000,
		Gift = {
			10303,
			4
		}
	},
	{
		Id = 32,
		DailyDupId = 2,
		DamageNeed = 1000000,
		Gift = {
			10303,
			4
		}
	}
}

setmetatable(CfgChallengeRewardTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgChallengeRewardTable]")
	end
})

local defaultMetaTable = {
	__index = {
		DailyDupId = 0,
		DamageNeed = 0,
		Gift = {}
	}
}

for i, data in pairs(CfgChallengeRewardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgChallengeRewardTable
