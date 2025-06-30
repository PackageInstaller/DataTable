-- chunkname: @IQIGame\\Config\\CfgEndlessPlusBossRankTable.lua

local CfgEndlessPlusBossRankTable = {
	[10001] = {
		RankUpperLimit = 1,
		Id = 10001,
		RankType = 1,
		Group = 1,
		RankLowerLimit = 1,
		Mail = 35035001,
		Reward = {
			80017,
			1,
			2,
			3000
		}
	},
	[10002] = {
		RankUpperLimit = 2,
		Id = 10002,
		RankType = 1,
		Group = 1,
		RankLowerLimit = 2,
		Mail = 35035001,
		Reward = {
			80017,
			1,
			2,
			2700
		}
	},
	[10003] = {
		RankUpperLimit = 3,
		Id = 10003,
		RankType = 1,
		Group = 1,
		RankLowerLimit = 3,
		Mail = 35035001,
		Reward = {
			80017,
			1,
			2,
			2500
		}
	},
	[10004] = {
		RankUpperLimit = 10,
		Id = 10004,
		RankType = 1,
		Group = 1,
		RankLowerLimit = 4,
		Mail = 35035001,
		Reward = {
			80017,
			1,
			2,
			2300
		}
	},
	[10005] = {
		RankUpperLimit = 50,
		Id = 10005,
		RankType = 1,
		Group = 1,
		RankLowerLimit = 11,
		Mail = 35035001,
		Reward = {
			80017,
			1,
			2,
			2100
		}
	},
	[10006] = {
		RankUpperLimit = 100,
		Id = 10006,
		RankType = 1,
		Group = 1,
		RankLowerLimit = 51,
		Mail = 35035002,
		Reward = {
			80016,
			1,
			2,
			1900
		}
	},
	[10007] = {
		RankUpperLimit = 500,
		Id = 10007,
		RankType = 1,
		Group = 1,
		RankLowerLimit = 101,
		Mail = 35035003,
		Reward = {
			80015,
			1,
			2,
			1700
		}
	},
	[10008] = {
		RankUpperLimit = 1000,
		Id = 10008,
		RankType = 1,
		Group = 1,
		RankLowerLimit = 501,
		Mail = 35035004,
		Reward = {
			80014,
			1,
			2,
			1500
		}
	},
	[10009] = {
		RankUpperLimit = 10,
		Id = 10009,
		RankType = 2,
		Group = 1,
		RankLowerLimit = 1,
		Mail = 35035005,
		Reward = {
			80013,
			1,
			2,
			1200
		}
	},
	[10010] = {
		RankUpperLimit = 20,
		Id = 10010,
		RankType = 2,
		Group = 1,
		RankLowerLimit = 11,
		Mail = 35035006,
		Reward = {
			80013,
			1,
			2,
			1000
		}
	},
	[10011] = {
		RankUpperLimit = 30,
		Id = 10011,
		RankType = 2,
		Group = 1,
		RankLowerLimit = 21,
		Mail = 35035007,
		Reward = {
			80013,
			1,
			2,
			900
		}
	},
	[10012] = {
		RankUpperLimit = 40,
		Id = 10012,
		RankType = 2,
		Group = 1,
		RankLowerLimit = 31,
		Mail = 35035008,
		Reward = {
			80012,
			1,
			2,
			800
		}
	},
	[10013] = {
		RankUpperLimit = 60,
		Id = 10013,
		RankType = 2,
		Group = 1,
		RankLowerLimit = 41,
		Mail = 35035009,
		Reward = {
			80012,
			1,
			2,
			700
		}
	},
	[10014] = {
		RankUpperLimit = 80,
		Id = 10014,
		RankType = 2,
		Group = 1,
		RankLowerLimit = 61,
		Mail = 35035010,
		Reward = {
			80012,
			1,
			2,
			600
		}
	},
	[10015] = {
		RankUpperLimit = 100,
		Id = 10015,
		RankType = 2,
		Group = 1,
		RankLowerLimit = 81,
		Mail = 35035011,
		Reward = {
			80012,
			1,
			2,
			500
		}
	}
}

setmetatable(CfgEndlessPlusBossRankTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgEndlessPlusBossRankTable]")
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

for i, data in pairs(CfgEndlessPlusBossRankTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgEndlessPlusBossRankTable
