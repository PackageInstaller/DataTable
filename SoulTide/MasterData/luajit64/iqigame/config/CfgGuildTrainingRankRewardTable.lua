-- chunkname: @IQIGame\\Config\\CfgGuildTrainingRankRewardTable.lua

local CfgGuildTrainingRankRewardTable = {
	[101] = {
		RankLowerLimit = 1,
		RankType = 1,
		Mail = 35083001,
		RankUpperLimit = 1,
		Image = "/Common/ComButton/Image_Score_S1.png",
		Id = 101,
		Desc = getI18NValue(180826236),
		Reward = {
			11502,
			300
		},
		RewardShow = {
			11502,
			300
		}
	},
	[102] = {
		RankLowerLimit = 2,
		RankType = 1,
		Mail = 35083001,
		RankUpperLimit = 2,
		Image = "/Common/ComButton/Image_Score_S2.png",
		Id = 102,
		Desc = getI18NValue(180836523),
		Reward = {
			11502,
			280
		},
		RewardShow = {
			11502,
			280
		}
	},
	[103] = {
		RankLowerLimit = 3,
		RankType = 1,
		Mail = 35083001,
		RankUpperLimit = 3,
		Image = "/Common/ComButton/Image_Score_S3.png",
		Id = 103,
		Desc = getI18NValue(180836524),
		Reward = {
			11502,
			260
		},
		RewardShow = {
			11502,
			260
		}
	},
	[104] = {
		RankLowerLimit = 4,
		RankType = 1,
		Mail = 35083001,
		RankUpperLimit = 10,
		Image = "/Common/ComButton/Image_Score_SS.png",
		Id = 104,
		Desc = getI18NValue(180836525),
		Reward = {
			11502,
			240
		},
		RewardShow = {
			11502,
			240
		}
	},
	[105] = {
		RankLowerLimit = 1,
		RankType = 2,
		Mail = 35083002,
		RankUpperLimit = 10,
		Image = "/Common/ComButton/Image_Score_S.png",
		Id = 105,
		Desc = getI18NValue(180836526),
		Reward = {
			11502,
			220
		},
		RewardShow = {
			11502,
			220
		}
	},
	[106] = {
		RankLowerLimit = 11,
		RankType = 2,
		Mail = 35083003,
		RankUpperLimit = 20,
		Image = "/Common/ComButton/Image_Score_A.png",
		Id = 106,
		Desc = getI18NValue(180836527),
		Reward = {
			11502,
			200
		},
		RewardShow = {
			11502,
			200
		}
	},
	[107] = {
		RankLowerLimit = 21,
		RankType = 2,
		Mail = 35083004,
		RankUpperLimit = 30,
		Image = "/Common/ComButton/Image_Score_A0.png",
		Id = 107,
		Desc = getI18NValue(180836528),
		Reward = {
			11502,
			180
		},
		RewardShow = {
			11502,
			180
		}
	},
	[108] = {
		RankLowerLimit = 31,
		RankType = 2,
		Mail = 35083005,
		RankUpperLimit = 40,
		Image = "/Common/ComButton/Image_Score_B.png",
		Id = 108,
		Desc = getI18NValue(180836529),
		Reward = {
			11502,
			160
		},
		RewardShow = {
			11502,
			160
		}
	},
	[109] = {
		RankLowerLimit = 41,
		RankType = 2,
		Mail = 35083006,
		RankUpperLimit = 60,
		Image = "/Common/ComButton/Image_Score_B0.png",
		Id = 109,
		Desc = getI18NValue(180836530),
		Reward = {
			11502,
			140
		},
		RewardShow = {
			11502,
			140
		}
	},
	[110] = {
		RankLowerLimit = 61,
		RankType = 2,
		Mail = 35083007,
		RankUpperLimit = 80,
		Image = "/Common/ComButton/Image_Score_C.png",
		Id = 110,
		Desc = getI18NValue(180826237),
		Reward = {
			11502,
			120
		},
		RewardShow = {
			11502,
			120
		}
	},
	[111] = {
		RankLowerLimit = 81,
		RankType = 2,
		Mail = 35083008,
		RankUpperLimit = 100,
		Image = "/Common/ComButton/Image_Score_C0.png",
		Id = 111,
		Desc = getI18NValue(180826238),
		Reward = {
			11502,
			100
		},
		RewardShow = {
			11502,
			100
		}
	}
}

setmetatable(CfgGuildTrainingRankRewardTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGuildTrainingRankRewardTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Mail = 0,
		RankType = 0,
		IsHide = false,
		RankLowerLimit = 0,
		GuildFond = 0,
		RankUpperLimit = 0,
		Image = "",
		Desc = "",
		RewardShow = {},
		Reward = {}
	}
}

for i, data in pairs(CfgGuildTrainingRankRewardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGuildTrainingRankRewardTable
