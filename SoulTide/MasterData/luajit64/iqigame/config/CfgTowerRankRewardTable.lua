-- chunkname: @IQIGame\\Config\\CfgTowerRankRewardTable.lua

local CfgTowerRankRewardTable = {
	[10001] = {
		RankUpperLimit = 1,
		Id = 10001,
		RankLowerLimit = 1,
		Mail = 35020001,
		Reward = {
			1,
			1000
		}
	},
	[10002] = {
		RankUpperLimit = 2,
		Id = 10002,
		RankLowerLimit = 2,
		Mail = 35020001,
		Reward = {
			1,
			1000
		}
	},
	[10003] = {
		RankUpperLimit = 3,
		Id = 10003,
		RankLowerLimit = 3,
		Mail = 35020001,
		Reward = {
			1,
			1000
		}
	},
	[10004] = {
		RankUpperLimit = 10,
		Id = 10004,
		RankLowerLimit = 4,
		Mail = 35020001,
		Reward = {
			1,
			1000
		}
	},
	[10005] = {
		RankUpperLimit = 20,
		Id = 10005,
		RankLowerLimit = 11,
		Mail = 35020001,
		Reward = {
			1,
			1000
		}
	},
	[10006] = {
		RankUpperLimit = 50,
		Id = 10006,
		RankLowerLimit = 21,
		Mail = 35020001,
		Reward = {
			1,
			1000
		}
	},
	[10007] = {
		RankUpperLimit = 100,
		Id = 10007,
		RankLowerLimit = 51,
		Mail = 35020001,
		Reward = {
			1,
			1000
		}
	},
	[10008] = {
		RankUpperLimit = 200,
		Id = 10008,
		RankLowerLimit = 101,
		Mail = 35020001,
		Reward = {
			1,
			1000
		}
	},
	[10009] = {
		RankUpperLimit = 500,
		Id = 10009,
		RankLowerLimit = 201,
		Mail = 35020001,
		Reward = {
			1,
			1000
		}
	},
	[10010] = {
		RankLowerLimit = 500,
		Id = 10010,
		Mail = 35020001,
		Reward = {
			1,
			1000
		}
	}
}

setmetatable(CfgTowerRankRewardTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTowerRankRewardTable]")
	end
})

local defaultMetaTable = {
	__index = {
		RankUpperLimit = 0,
		Mail = 0,
		RankLowerLimit = 0,
		Reward = {}
	}
}

for i, data in pairs(CfgTowerRankRewardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTowerRankRewardTable
