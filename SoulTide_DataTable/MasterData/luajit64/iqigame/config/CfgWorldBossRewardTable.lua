-- chunkname: @IQIGame\\Config\\CfgWorldBossRewardTable.lua

local CfgWorldBossRewardTable = {
	[10001] = {
		RankUpperLimit = 1,
		RankLowerLimit = 1,
		RankType = 1,
		Mail = 35020001,
		Id = 10001,
		Reward = {
			106,
			4000,
			2,
			2000
		}
	},
	[10002] = {
		RankUpperLimit = 2,
		RankLowerLimit = 2,
		RankType = 1,
		Mail = 35020001,
		Id = 10002,
		Reward = {
			106,
			3600,
			2,
			1800
		}
	},
	[10003] = {
		RankUpperLimit = 3,
		RankLowerLimit = 3,
		RankType = 1,
		Mail = 35020001,
		Id = 10003,
		Reward = {
			106,
			3200,
			2,
			1600
		}
	},
	[10004] = {
		RankUpperLimit = 10,
		RankLowerLimit = 4,
		RankType = 1,
		Mail = 35020001,
		Id = 10004,
		Reward = {
			106,
			3100,
			2,
			1400
		}
	},
	[10005] = {
		RankUpperLimit = 50,
		RankLowerLimit = 11,
		RankType = 1,
		Mail = 35020001,
		Id = 10005,
		Reward = {
			106,
			2800,
			2,
			1200
		}
	},
	[10006] = {
		RankUpperLimit = 100,
		RankLowerLimit = 51,
		RankType = 1,
		Mail = 35020002,
		Id = 10006,
		Reward = {
			106,
			2500,
			2,
			1000
		}
	},
	[10007] = {
		RankUpperLimit = 500,
		RankLowerLimit = 101,
		RankType = 1,
		Mail = 35020003,
		Id = 10007,
		Reward = {
			106,
			2200,
			2,
			800
		}
	},
	[10008] = {
		RankUpperLimit = 1000,
		RankLowerLimit = 501,
		RankType = 1,
		Mail = 35020004,
		Id = 10008,
		Reward = {
			106,
			1900,
			2,
			600
		}
	},
	[10009] = {
		RankUpperLimit = 10,
		RankLowerLimit = 1,
		RankType = 2,
		Mail = 35020005,
		Id = 10009,
		Reward = {
			106,
			1600,
			2,
			400
		}
	},
	[10010] = {
		RankUpperLimit = 20,
		RankLowerLimit = 11,
		RankType = 2,
		Mail = 35020006,
		Id = 10010,
		Reward = {
			106,
			1400,
			2,
			350
		}
	},
	[10011] = {
		RankUpperLimit = 30,
		RankLowerLimit = 21,
		RankType = 2,
		Mail = 35020007,
		Id = 10011,
		Reward = {
			106,
			1200,
			2,
			300
		}
	},
	[10012] = {
		RankUpperLimit = 40,
		RankLowerLimit = 31,
		RankType = 2,
		Mail = 35020008,
		Id = 10012,
		Reward = {
			106,
			1000,
			2,
			250
		}
	},
	[10013] = {
		RankUpperLimit = 60,
		RankLowerLimit = 41,
		RankType = 2,
		Mail = 35020009,
		Id = 10013,
		Reward = {
			106,
			900,
			2,
			200
		}
	},
	[10014] = {
		RankUpperLimit = 80,
		RankLowerLimit = 61,
		RankType = 2,
		Mail = 35020010,
		Id = 10014,
		Reward = {
			106,
			800,
			2,
			150
		}
	},
	[10015] = {
		RankUpperLimit = 100,
		RankLowerLimit = 81,
		RankType = 2,
		Mail = 35020011,
		Id = 10015,
		Reward = {
			106,
			700,
			2,
			100
		}
	}
}

setmetatable(CfgWorldBossRewardTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgWorldBossRewardTable]")
	end
})

local defaultMetaTable = {
	__index = {
		RankUpperLimit = 0,
		Mail = 0,
		RankType = 0,
		RankLowerLimit = 0,
		Reward = {}
	}
}

for i, data in pairs(CfgWorldBossRewardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgWorldBossRewardTable
