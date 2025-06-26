-- chunkname: @IQIGame\\Config\\CfgChallengeDamageRewardTable.lua

local CfgChallengeDamageRewardTable = {
	{
		Id = 1,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			0,
			1000
		},
		ChallengeGift = {
			1,
			100000
		}
	},
	{
		Id = 2,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			1000,
			2000
		},
		ChallengeGift = {
			1,
			110000
		}
	},
	{
		Id = 3,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			2000,
			3000
		},
		ChallengeGift = {
			1,
			120000
		}
	},
	{
		Id = 4,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			3000,
			4000
		},
		ChallengeGift = {
			1,
			130000
		}
	},
	{
		Id = 5,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			4000,
			5000
		},
		ChallengeGift = {
			1,
			145000
		}
	},
	{
		Id = 6,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			5000,
			8000
		},
		ChallengeGift = {
			1,
			160000
		}
	},
	{
		Id = 7,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			8000,
			11000
		},
		ChallengeGift = {
			1,
			180000
		}
	},
	{
		Id = 8,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			11000,
			14000
		},
		ChallengeGift = {
			1,
			200000
		}
	},
	{
		Id = 9,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			14000,
			17000
		}
	},
	{
		Id = 10,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			17000,
			20000
		}
	},
	{
		Id = 11,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			20000,
			23000
		}
	},
	{
		Id = 12,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			23000,
			26000
		}
	},
	{
		Id = 13,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			26000,
			29000
		}
	},
	{
		Id = 14,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			29000,
			32000
		}
	},
	{
		Id = 15,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			32000,
			35000
		}
	},
	{
		Id = 16,
		DailyDupId = 1,
		ChallengeDamageNeed = {
			35000,
			9999999
		}
	},
	{
		Id = 17,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			0,
			1000
		},
		ChallengeGift = {
			10302,
			5
		}
	},
	{
		Id = 18,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			1000,
			2000
		},
		ChallengeGift = {
			10302,
			10
		}
	},
	{
		Id = 19,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			2000,
			3000
		},
		ChallengeGift = {
			10302,
			15
		}
	},
	{
		Id = 20,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			3000,
			4000
		},
		ChallengeGift = {
			10302,
			20
		}
	},
	{
		Id = 21,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			4000,
			5000
		},
		ChallengeGift = {
			10302,
			25
		}
	},
	{
		Id = 22,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			5000,
			8000
		},
		ChallengeGift = {
			10302,
			30
		}
	},
	{
		Id = 23,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			8000,
			11000
		},
		ChallengeGift = {
			10302,
			35
		}
	},
	{
		Id = 24,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			11000,
			14000
		},
		ChallengeGift = {
			10302,
			40
		}
	},
	{
		Id = 25,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			14000,
			17000
		}
	},
	{
		Id = 26,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			17000,
			20000
		}
	},
	{
		Id = 27,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			20000,
			23000
		}
	},
	{
		Id = 28,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			23000,
			26000
		}
	},
	{
		Id = 29,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			26000,
			29000
		}
	},
	{
		Id = 30,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			29000,
			32000
		}
	},
	{
		Id = 31,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			32000,
			35000
		}
	},
	{
		Id = 32,
		DailyDupId = 2,
		ChallengeDamageNeed = {
			35000,
			9999999
		}
	}
}

setmetatable(CfgChallengeDamageRewardTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgChallengeDamageRewardTable]")
	end
})

local defaultMetaTable = {
	__index = {
		DailyDupId = 0,
		ChallengeDamageNeed = {},
		ChallengeGift = {}
	}
}

for i, data in pairs(CfgChallengeDamageRewardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgChallengeDamageRewardTable
