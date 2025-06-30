-- chunkname: @IQIGame\\Config\\CfgGuildActiveRewardTable.lua

local CfgGuildActiveRewardTable = {
	[10001] = {
		LevelNeed = 1,
		Image = "/Common/ComButton/RewardBox_13.png",
		Mail = 35082001,
		Id = 10001,
		Level = 1,
		GuildFond = 3000,
		MemberReward = {
			122,
			160
		}
	},
	[10002] = {
		LevelNeed = 2,
		Image = "/Common/ComButton/RewardBox_13.png",
		Mail = 35082001,
		Id = 10002,
		Level = 2,
		GuildFond = 3500,
		MemberReward = {
			122,
			220
		}
	},
	[10003] = {
		LevelNeed = 3,
		Image = "/Common/ComButton/RewardBox_13.png",
		Mail = 35082001,
		Id = 10003,
		Level = 3,
		GuildFond = 4000,
		MemberReward = {
			122,
			280
		}
	},
	[10004] = {
		LevelNeed = 4,
		Image = "/Common/ComButton/RewardBox_13.png",
		Mail = 35082001,
		Id = 10004,
		Level = 4,
		GuildFond = 4500,
		MemberReward = {
			122,
			340
		}
	},
	[10005] = {
		LevelNeed = 5,
		Image = "/Common/ComButton/RewardBox_14.png",
		Mail = 35082001,
		Id = 10005,
		Level = 5,
		GuildFond = 5000,
		MemberReward = {
			122,
			400
		}
	},
	[10006] = {
		LevelNeed = 6,
		Image = "/Common/ComButton/RewardBox_14.png",
		Mail = 35082001,
		Id = 10006,
		Level = 6,
		GuildFond = 5500,
		MemberReward = {
			122,
			460
		}
	},
	[10007] = {
		LevelNeed = 7,
		Image = "/Common/ComButton/RewardBox_14.png",
		Mail = 35082001,
		Id = 10007,
		Level = 7,
		GuildFond = 6000,
		MemberReward = {
			122,
			520
		}
	},
	[10008] = {
		LevelNeed = 8,
		Image = "/Common/ComButton/RewardBox_14.png",
		Mail = 35082001,
		Id = 10008,
		Level = 8,
		GuildFond = 6500,
		MemberReward = {
			122,
			580
		}
	},
	[10009] = {
		LevelNeed = 9,
		Image = "/Common/ComButton/RewardBox_14.png",
		Mail = 35082001,
		Id = 10009,
		Level = 9,
		GuildFond = 7000,
		MemberReward = {
			122,
			640
		}
	},
	[10010] = {
		LevelNeed = 10,
		Image = "/Common/ComButton/RewardBox_14.png",
		Mail = 35082001,
		Id = 10010,
		Level = 10,
		GuildFond = 7500,
		MemberReward = {
			122,
			700
		}
	},
	[10011] = {
		LevelNeed = 11,
		Image = "/Common/ComButton/RewardBox_14.png",
		Mail = 35082001,
		Id = 10011,
		Level = 11,
		GuildFond = 8000,
		MemberReward = {
			122,
			760
		}
	},
	[10012] = {
		LevelNeed = 12,
		Image = "/Common/ComButton/RewardBox_14.png",
		Mail = 35082001,
		Id = 10012,
		Level = 12,
		GuildFond = 8500,
		MemberReward = {
			122,
			820
		}
	},
	[10013] = {
		LevelNeed = 13,
		Image = "/Common/ComButton/RewardBox_16.png",
		Mail = 35082001,
		Id = 10013,
		Level = 13,
		GuildFond = 9000,
		MemberReward = {
			122,
			880
		}
	},
	[10014] = {
		LevelNeed = 14,
		Image = "/Common/ComButton/RewardBox_16.png",
		Mail = 35082001,
		Id = 10014,
		Level = 14,
		GuildFond = 9500,
		MemberReward = {
			122,
			940
		}
	},
	[10015] = {
		LevelNeed = 15,
		Image = "/Common/ComButton/RewardBox_16.png",
		Mail = 35082001,
		Id = 10015,
		Level = 15,
		GuildFond = 10000,
		MemberReward = {
			122,
			1000
		}
	}
}

setmetatable(CfgGuildActiveRewardTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGuildActiveRewardTable]")
	end
})

local defaultMetaTable = {
	__index = {
		LevelNeed = 0,
		Image = "",
		Mail = 0,
		Level = 0,
		GuildFond = 0,
		MemberReward = {}
	}
}

for i, data in pairs(CfgGuildActiveRewardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGuildActiveRewardTable
