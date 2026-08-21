-- chunkname: @IQIGame\\Config\\CfgRPGMazeExBossRewardTable.lua

local CfgRPGMazeExBossRewardTable = {
	[10001] = {
		RankUpperLimit = 1,
		Id = 10001,
		RankType = 1,
		Group = 5,
		RankLowerLimit = 1,
		Mail = 35030201,
		Reward = {
			2,
			3000
		}
	},
	[10002] = {
		RankUpperLimit = 2,
		Id = 10002,
		RankType = 1,
		Group = 5,
		RankLowerLimit = 2,
		Mail = 35030201,
		Reward = {
			2,
			2700
		}
	},
	[10003] = {
		RankUpperLimit = 3,
		Id = 10003,
		RankType = 1,
		Group = 5,
		RankLowerLimit = 3,
		Mail = 35030201,
		Reward = {
			2,
			2500
		}
	},
	[10004] = {
		RankUpperLimit = 10,
		Id = 10004,
		RankType = 1,
		Group = 5,
		RankLowerLimit = 4,
		Mail = 35030201,
		Reward = {
			2,
			2300
		}
	},
	[10005] = {
		RankUpperLimit = 50,
		Id = 10005,
		RankType = 1,
		Group = 5,
		RankLowerLimit = 11,
		Mail = 35030201,
		Reward = {
			2,
			2100
		}
	},
	[10006] = {
		RankUpperLimit = 100,
		Id = 10006,
		RankType = 1,
		Group = 5,
		RankLowerLimit = 51,
		Mail = 35030202,
		Reward = {
			2,
			1900
		}
	},
	[10007] = {
		RankUpperLimit = 500,
		Id = 10007,
		RankType = 1,
		Group = 5,
		RankLowerLimit = 101,
		Mail = 35030203,
		Reward = {
			2,
			1700
		}
	},
	[10008] = {
		RankUpperLimit = 1000,
		Id = 10008,
		RankType = 1,
		Group = 5,
		RankLowerLimit = 501,
		Mail = 35030204,
		Reward = {
			2,
			1500
		}
	},
	[10009] = {
		RankUpperLimit = 10,
		Id = 10009,
		RankType = 2,
		Group = 5,
		RankLowerLimit = 1,
		Mail = 35030205,
		Reward = {
			2,
			1200
		}
	},
	[10010] = {
		RankUpperLimit = 20,
		Id = 10010,
		RankType = 2,
		Group = 5,
		RankLowerLimit = 11,
		Mail = 35030206,
		Reward = {
			2,
			1000
		}
	},
	[10011] = {
		RankUpperLimit = 30,
		Id = 10011,
		RankType = 2,
		Group = 5,
		RankLowerLimit = 21,
		Mail = 35030207,
		Reward = {
			2,
			900
		}
	},
	[10012] = {
		RankUpperLimit = 40,
		Id = 10012,
		RankType = 2,
		Group = 5,
		RankLowerLimit = 31,
		Mail = 35030208,
		Reward = {
			2,
			800
		}
	},
	[10013] = {
		RankUpperLimit = 60,
		Id = 10013,
		RankType = 2,
		Group = 5,
		RankLowerLimit = 41,
		Mail = 35030209,
		Reward = {
			2,
			700
		}
	},
	[10014] = {
		RankUpperLimit = 80,
		Id = 10014,
		RankType = 2,
		Group = 5,
		RankLowerLimit = 61,
		Mail = 35030210,
		Reward = {
			2,
			600
		}
	},
	[10015] = {
		RankUpperLimit = 100,
		Id = 10015,
		RankType = 2,
		Group = 5,
		RankLowerLimit = 81,
		Mail = 35030211,
		Reward = {
			2,
			500
		}
	}
}

setmetatable(CfgRPGMazeExBossRewardTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRPGMazeExBossRewardTable]")
	end
})

local defaultMetaTable = {
	__index = {
		RankUpperLimit = 0,
		Group = 0,
		RankType = 0,
		Mail = 0,
		RankLowerLimit = 0,
		Reward = {}
	}
}

for i, data in pairs(CfgRPGMazeExBossRewardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRPGMazeExBossRewardTable
