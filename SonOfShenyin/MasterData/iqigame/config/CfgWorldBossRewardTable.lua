-- chunkname: @IQIGame\\Config\\CfgWorldBossRewardTable.lua

local CfgWorldBossRewardTable = {
	[10001] = {
		RankUpperLimit = 1,
		RankLowerLimit = 1,
		RankType = 1,
		Id = 10001,
		Mail = 35020001,
		Reward = {
			3,
			3000,
			115,
			3000
		},
		Desc = getI18NValue(180235961),
		RankRating = getI18NValue(180241112)
	},
	[10002] = {
		RankUpperLimit = 2,
		RankLowerLimit = 2,
		RankType = 1,
		Id = 10002,
		Mail = 35020001,
		Reward = {
			3,
			2500,
			115,
			2500
		},
		Desc = getI18NValue(180235962),
		RankRating = getI18NValue(180241113)
	},
	[10003] = {
		RankUpperLimit = 3,
		RankLowerLimit = 3,
		RankType = 1,
		Id = 10003,
		Mail = 35020001,
		Reward = {
			3,
			2000,
			115,
			2000
		},
		Desc = getI18NValue(180235963),
		RankRating = getI18NValue(180241114)
	},
	[10004] = {
		RankUpperLimit = 10,
		RankLowerLimit = 4,
		RankType = 1,
		Id = 10004,
		Mail = 35020001,
		Reward = {
			3,
			1500,
			115,
			1800
		},
		Desc = getI18NValue(180235964),
		RankRating = getI18NValue(180241115)
	},
	[10005] = {
		RankUpperLimit = 50,
		RankLowerLimit = 11,
		RankType = 1,
		Id = 10005,
		Mail = 35020002,
		Reward = {
			3,
			1000,
			115,
			1500
		},
		Desc = getI18NValue(180235965),
		RankRating = getI18NValue(180241116)
	},
	[10006] = {
		RankUpperLimit = 100,
		RankLowerLimit = 51,
		RankType = 1,
		Id = 10006,
		Mail = 35020002,
		Reward = {
			3,
			800,
			115,
			1200
		},
		Desc = getI18NValue(180235966),
		RankRating = getI18NValue(180241117)
	},
	[10007] = {
		RankUpperLimit = 500,
		RankLowerLimit = 101,
		RankType = 1,
		Id = 10007,
		Mail = 35020003,
		Reward = {
			3,
			750,
			115,
			1100
		},
		Desc = getI18NValue(180235967),
		RankRating = getI18NValue(180241118)
	},
	[10008] = {
		RankUpperLimit = 1000,
		RankLowerLimit = 501,
		RankType = 1,
		Id = 10008,
		Mail = 35020004,
		Reward = {
			3,
			700,
			115,
			1000
		},
		Desc = getI18NValue(180235968),
		RankRating = getI18NValue(180241119)
	},
	[10009] = {
		RankUpperLimit = 10,
		RankLowerLimit = 1,
		RankType = 2,
		Id = 10009,
		Mail = 35020005,
		Reward = {
			3,
			600,
			115,
			900
		},
		Desc = getI18NValue(180235969),
		RankRating = getI18NValue(180241120)
	},
	[10010] = {
		RankUpperLimit = 20,
		RankLowerLimit = 11,
		RankType = 2,
		Id = 10010,
		Mail = 35020006,
		Reward = {
			3,
			550,
			115,
			800
		},
		Desc = getI18NValue(180235970),
		RankRating = getI18NValue(180241121)
	},
	[10011] = {
		RankUpperLimit = 30,
		RankLowerLimit = 21,
		RankType = 2,
		Id = 10011,
		Mail = 35020007,
		Reward = {
			3,
			500,
			115,
			750
		},
		Desc = getI18NValue(180235971),
		RankRating = getI18NValue(180241122)
	},
	[10012] = {
		RankUpperLimit = 40,
		RankLowerLimit = 31,
		RankType = 2,
		Id = 10012,
		Mail = 35020008,
		Reward = {
			3,
			450,
			115,
			700
		},
		Desc = getI18NValue(180235972),
		RankRating = getI18NValue(180241123)
	},
	[10013] = {
		RankUpperLimit = 60,
		RankLowerLimit = 41,
		RankType = 2,
		Id = 10013,
		Mail = 35020009,
		Reward = {
			3,
			400,
			115,
			650
		},
		Desc = getI18NValue(180235973),
		RankRating = getI18NValue(180241124)
	},
	[10014] = {
		RankUpperLimit = 80,
		RankLowerLimit = 61,
		RankType = 2,
		Id = 10014,
		Mail = 35020010,
		Reward = {
			3,
			350,
			115,
			600
		},
		Desc = getI18NValue(180235974),
		RankRating = getI18NValue(180241125)
	},
	[10015] = {
		RankUpperLimit = 100,
		RankLowerLimit = 81,
		RankType = 2,
		Id = 10015,
		Mail = 35020011,
		Reward = {
			3,
			300,
			115,
			500
		},
		Desc = getI18NValue(180235975),
		RankRating = getI18NValue(180241126)
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
		Image = "",
		RankType = 0,
		RankRating = "",
		Mail = 0,
		RankLowerLimit = 0,
		Desc = "",
		Reward = {}
	}
}

for i, data in pairs(CfgWorldBossRewardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgWorldBossRewardTable
