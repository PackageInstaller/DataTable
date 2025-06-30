-- chunkname: @IQIGame\\Config\\CfgHorizontalRPGBossTable.lua

local CfgHorizontalRPGBossTable = {
	[1001] = {
		BgPosition = "/Common/ArtFont/CN/MazeBossChallengeEntryUI_Name_Baoshi.png",
		Id = 1001,
		UnLockSweepNeed = "1001",
		ChallengeBossCostTickets = 100,
		RecommendPower = 55000,
		MonsterTeam = 43201011,
		BossBg = "/Activity/HorizontalRPG/HorizontalRPGMonster/HorizontalRPGMonster_01.png",
		Monster = 43201011,
		Describe = getI18NValue(180920849),
		ChallengeAward = {
			468,
			500
		},
		WeakType = {
			5,
			2,
			3
		}
	},
	[1002] = {
		BgPosition = "/Common/ArtFont/CN/MazeBossChallengeEntryUI_Name_Seyu.png",
		Id = 1002,
		UnLockSweepNeed = "1002",
		ChallengeBossCostTickets = 100,
		RecommendPower = 110000,
		MonsterTeam = 43202011,
		BossBg = "/Activity/HorizontalRPG/HorizontalRPGMonster/HorizontalRPGMonster_02.png",
		Monster = 43202011,
		Describe = getI18NValue(180920850),
		ChallengeAward = {
			468,
			600
		},
		WeakType = {
			5,
			2,
			3,
			1
		}
	},
	[1003] = {
		BgPosition = "/Common/ArtFont/CN/MazeBossChallengeEntryUI_Name_Fennu.png",
		Id = 1003,
		UnLockSweepNeed = "1003",
		ChallengeBossCostTickets = 100,
		RecommendPower = 220000,
		MonsterTeam = 43203011,
		BossBg = "/Activity/HorizontalRPG/HorizontalRPGMonster/HorizontalRPGMonster_03.png",
		Monster = 43203011,
		Describe = getI18NValue(180920851),
		ChallengeAward = {
			468,
			700
		},
		WeakType = {
			5,
			2,
			3,
			1
		}
	},
	[1004] = {
		BgPosition = "/Common/ArtFont/CN/MazeBossChallengeEntryUI_Name_Jidu.png",
		Id = 1004,
		UnLockSweepNeed = "1004",
		ChallengeBossCostTickets = 100,
		RecommendPower = 390000,
		MonsterTeam = 43204011,
		BossBg = "/Activity/HorizontalRPG/HorizontalRPGMonster/HorizontalRPGMonster_04.png",
		Monster = 43204011,
		Describe = getI18NValue(180920852),
		ChallengeAward = {
			468,
			800
		},
		WeakType = {
			5,
			2,
			1
		}
	},
	[1005] = {
		BgPosition = "/Common/ArtFont/CN/MazeBossChallengeEntryUI_Name_Tanlan.png",
		OpenExBoss = true,
		Id = 1005,
		UnLockSweepNeed = "1005",
		ChallengeBossCostTickets = 100,
		RecommendPower = 600000,
		MonsterTeam = 43205011,
		BossBg = "/Activity/HorizontalRPG/HorizontalRPGMonster/HorizontalRPGMonster_05.png",
		Monster = 43205011,
		Describe = getI18NValue(180920853),
		ChallengeAward = {
			468,
			900
		},
		WeakType = {
			5,
			2,
			1
		}
	}
}

setmetatable(CfgHorizontalRPGBossTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHorizontalRPGBossTable]")
	end
})

local defaultMetaTable = {
	__index = {
		BgPosition = "",
		Describe = "",
		OpenExBoss = false,
		UnLockSweepNeed = "",
		ChallengeBossCostTickets = 0,
		RecommendPower = 0,
		MonsterTeam = 0,
		BossBg = "",
		Monster = 0,
		FirstKilledAward = {},
		ChallengeAward = {},
		WeakType = {}
	}
}

for i, data in pairs(CfgHorizontalRPGBossTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHorizontalRPGBossTable
