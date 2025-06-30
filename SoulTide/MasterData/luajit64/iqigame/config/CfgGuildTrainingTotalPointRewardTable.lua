-- chunkname: @IQIGame\\Config\\CfgGuildTrainingTotalPointRewardTable.lua

local CfgGuildTrainingTotalPointRewardTable = {
	[1101] = {
		Sort = 1,
		Id = 1101,
		PointsUpperLimit = 150,
		PointsLowerLimit = 100,
		Mail = 35082002,
		GuildFond = 500,
		RewardShow = {
			121,
			500
		}
	},
	[1102] = {
		Sort = 2,
		Id = 1102,
		PointsUpperLimit = 200,
		PointsLowerLimit = 150,
		Mail = 35082002,
		GuildFond = 1000,
		RewardShow = {
			121,
			1000
		}
	},
	[1103] = {
		Sort = 3,
		Id = 1103,
		PointsUpperLimit = 300,
		PointsLowerLimit = 200,
		Mail = 35082002,
		GuildFond = 1500,
		RewardShow = {
			121,
			1500
		}
	},
	[1104] = {
		Sort = 4,
		Id = 1104,
		PointsUpperLimit = 500,
		PointsLowerLimit = 300,
		Mail = 35082002,
		GuildFond = 2000,
		RewardShow = {
			121,
			2000
		}
	},
	[1105] = {
		Sort = 5,
		Id = 1105,
		PointsUpperLimit = 800,
		PointsLowerLimit = 500,
		Mail = 35082002,
		GuildFond = 2500,
		RewardShow = {
			121,
			2500
		}
	},
	[1106] = {
		Sort = 6,
		Id = 1106,
		PointsUpperLimit = 1300,
		PointsLowerLimit = 800,
		Mail = 35082002,
		GuildFond = 3000,
		RewardShow = {
			121,
			3000
		}
	},
	[1107] = {
		Sort = 7,
		Id = 1107,
		PointsUpperLimit = 1800,
		PointsLowerLimit = 1300,
		Mail = 35082002,
		GuildFond = 3500,
		RewardShow = {
			121,
			3500
		}
	},
	[1108] = {
		Sort = 8,
		Id = 1108,
		PointsUpperLimit = 2900,
		PointsLowerLimit = 1800,
		Mail = 35082002,
		GuildFond = 4000,
		RewardShow = {
			121,
			4000
		}
	},
	[1109] = {
		Sort = 9,
		Id = 1109,
		PointsUpperLimit = 4000,
		PointsLowerLimit = 2900,
		Mail = 35082002,
		GuildFond = 4500,
		RewardShow = {
			121,
			4500
		}
	},
	[1110] = {
		Sort = 10,
		Id = 1110,
		PointsUpperLimit = 7500,
		PointsLowerLimit = 4000,
		Mail = 35082002,
		GuildFond = 5000,
		RewardShow = {
			121,
			5000
		}
	},
	[1111] = {
		Sort = 11,
		Id = 1111,
		PointsUpperLimit = 11000,
		PointsLowerLimit = 7500,
		Mail = 35082002,
		GuildFond = 5500,
		RewardShow = {
			121,
			5500
		}
	},
	[1112] = {
		Sort = 12,
		Id = 1112,
		PointsUpperLimit = 18000,
		PointsLowerLimit = 11000,
		Mail = 35082002,
		GuildFond = 6000,
		RewardShow = {
			121,
			6000
		}
	},
	[1113] = {
		Sort = 13,
		Id = 1113,
		PointsUpperLimit = 24000,
		PointsLowerLimit = 18000,
		Mail = 35082002,
		GuildFond = 6500,
		RewardShow = {
			121,
			6500
		}
	},
	[1114] = {
		Sort = 14,
		Id = 1114,
		PointsUpperLimit = 33000,
		PointsLowerLimit = 24000,
		Mail = 35082002,
		GuildFond = 7000,
		RewardShow = {
			121,
			7000
		}
	},
	[1115] = {
		Sort = 15,
		Id = 1115,
		PointsUpperLimit = 42000,
		PointsLowerLimit = 33000,
		Mail = 35082002,
		GuildFond = 7500,
		RewardShow = {
			121,
			7500
		}
	},
	[1116] = {
		Sort = 16,
		Id = 1116,
		PointsUpperLimit = 53000,
		PointsLowerLimit = 42000,
		Mail = 35082002,
		GuildFond = 8000,
		RewardShow = {
			121,
			8000
		}
	},
	[1117] = {
		Sort = 17,
		Id = 1117,
		PointsUpperLimit = 64000,
		PointsLowerLimit = 53000,
		Mail = 35082002,
		GuildFond = 8500,
		RewardShow = {
			121,
			8500
		}
	},
	[1118] = {
		Sort = 18,
		Id = 1118,
		PointsUpperLimit = 77000,
		PointsLowerLimit = 64000,
		Mail = 35082002,
		GuildFond = 9000,
		RewardShow = {
			121,
			9000
		}
	},
	[1119] = {
		Sort = 19,
		Id = 1119,
		PointsUpperLimit = 90000,
		PointsLowerLimit = 77000,
		Mail = 35082002,
		GuildFond = 9500,
		RewardShow = {
			121,
			9500
		}
	},
	[1120] = {
		Sort = 20,
		Id = 1120,
		Mail = 35082002,
		PointsLowerLimit = 90000,
		GuildFond = 10000,
		RewardShow = {
			121,
			10000
		}
	}
}

setmetatable(CfgGuildTrainingTotalPointRewardTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGuildTrainingTotalPointRewardTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Sort = 0,
		PointsLowerLimit = 0,
		PointsUpperLimit = 0,
		Mail = 0,
		GuildFond = 0,
		RewardShow = {},
		Reward = {}
	}
}

for i, data in pairs(CfgGuildTrainingTotalPointRewardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGuildTrainingTotalPointRewardTable
