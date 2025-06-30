-- chunkname: @IQIGame\\Config\\CfgDualTeamExploreEXBossTable.lua

local CfgDualTeamExploreEXBossTable = {
	[1001] = {
		Group = 1,
		Id = 1001,
		ChallengeCD = 1,
		MonsterTeam = 41007011,
		RankHeadIcon = "/Image_Resources/ActivityCYZMRes/ActivityCYZMMonsterHead1/DTEExBoss_Head_01.png",
		BossBg = "/Image_Resources/ActivityCYZMRes/ActivityCYZMMonster1/DTEExBoss_02.png",
		Monster = 41008606,
		Describe = getI18NValue(180294935),
		WeakType = {
			5,
			2,
			1
		}
	},
	[1002] = {
		Group = 1,
		Id = 1002,
		ChallengeCD = 1,
		MonsterTeam = 41008011,
		RankHeadIcon = "/Image_Resources/ActivityCYZMRes/ActivityCYZMMonsterHead1/DTEExBoss_Head_02.png",
		BossBg = "/Image_Resources/ActivityCYZMRes/ActivityCYZMMonster1/DTEExBoss_01.png",
		Monster = 41008607,
		Describe = getI18NValue(180294988),
		WeakType = {
			6,
			2,
			3
		}
	},
	[2001] = {
		Group = 2,
		Id = 2001,
		ChallengeCD = 1,
		MonsterTeam = 41814011,
		RankHeadIcon = "/Image_Resources/ActivityCYZMRes/ActivityCYZMMonsterHead1/ZTKSExBoss_Head_01.png",
		BossBg = "/Image_Resources/ActivityCYZMRes/ActivityCYZMMonster1/ZTKSExBoss_01.png",
		Monster = 41814601,
		Describe = getI18NValue(180505818),
		WeakType = {
			5,
			6,
			2
		}
	},
	[2002] = {
		Group = 2,
		Id = 2002,
		ChallengeCD = 1,
		MonsterTeam = 41815011,
		RankHeadIcon = "/Image_Resources/ActivityCYZMRes/ActivityCYZMMonsterHead1/ZTKSExBoss_Head_02.png",
		BossBg = "/Image_Resources/ActivityCYZMRes/ActivityCYZMMonster1/ZTKSExBoss_02.png",
		Monster = 41815601,
		Describe = getI18NValue(180505819),
		WeakType = {
			5,
			6,
			2
		}
	},
	[3001] = {
		Group = 3,
		Id = 3001,
		ChallengeCD = 1,
		MonsterTeam = 41007011,
		RankHeadIcon = "/Image_Resources/ActivityCYZMRes/ActivityCYZMMonsterHead1/DTEExBoss_Head_01.png",
		BossBg = "/Image_Resources/ActivityCYZMRes/ActivityCYZMMonster1/DTEExBoss_02.png",
		Monster = 41008606,
		Describe = getI18NValue(180905832),
		WeakType = {
			5,
			2,
			1
		}
	},
	[3002] = {
		Group = 3,
		Id = 3002,
		ChallengeCD = 1,
		MonsterTeam = 41008011,
		RankHeadIcon = "/Image_Resources/ActivityCYZMRes/ActivityCYZMMonsterHead1/DTEExBoss_Head_02.png",
		BossBg = "/Image_Resources/ActivityCYZMRes/ActivityCYZMMonster1/DTEExBoss_01.png",
		Monster = 41008607,
		Describe = getI18NValue(180905833),
		WeakType = {
			6,
			2,
			3
		}
	}
}

setmetatable(CfgDualTeamExploreEXBossTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgDualTeamExploreEXBossTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		Describe = "",
		RecommendPower = 0,
		MonsterTeam = 0,
		RankHeadIcon = "",
		BossBg = "",
		ChallengeCD = 0,
		Monster = 0,
		WeakType = {}
	}
}

for i, data in pairs(CfgDualTeamExploreEXBossTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgDualTeamExploreEXBossTable
