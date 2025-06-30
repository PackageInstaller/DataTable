-- chunkname: @IQIGame\\Config\\CfgRPGMazeExBossTable.lua

local CfgRPGMazeExBossTable = {
	[1001] = {
		MonsterTeam = 40208601,
		BossBg = "/Image_Resources/MonsterDrawing2/Drawing/Small_Aomanwitch_01.png",
		Id = 1001,
		ChallengeCD = 120,
		Monster = 40208601,
		RecommendPower = 150000,
		Describe = getI18NValue(180106938),
		WeakType = {
			5,
			6,
			3
		}
	},
	[1002] = {
		MonsterTeam = 40209601,
		BossBg = "/Image_Resources/MonsterDrawing2/Drawing/Small_Aomanwitch_01.png",
		Id = 1002,
		ChallengeCD = 1,
		Monster = 40209601,
		RecommendPower = 150000,
		Describe = getI18NValue(180286844),
		WeakType = {
			5,
			6,
			3
		}
	},
	[1003] = {
		MonsterTeam = 41307601,
		BossBg = "/Image_Resources/MonsterDrawing/Drawing/LHTX_fennulifu_01.png",
		Id = 1003,
		ChallengeCD = 1,
		Monster = 41307601,
		RecommendPower = 550000,
		Describe = getI18NValue(180441084),
		WeakType = {
			1,
			6,
			3
		}
	},
	[1004] = {
		MonsterTeam = 42106011,
		BossBg = "/Image_Resources/MonsterDrawing/Drawing/SXQT_pingzhongxian_01.png",
		Id = 1004,
		ChallengeCD = 1,
		Monster = 42106011,
		RecommendPower = 550000,
		Describe = getI18NValue(180563303),
		WeakType = {
			1,
			2,
			6
		}
	},
	[1005] = {
		MonsterTeam = 41307601,
		BossBg = "/Image_Resources/MonsterDrawing/Drawing/LHTX_fennulifu_01.png",
		Id = 1005,
		ChallengeCD = 1,
		Monster = 41307601,
		RecommendPower = 550000,
		Describe = getI18NValue(180918193),
		WeakType = {
			1,
			6,
			3
		}
	}
}

setmetatable(CfgRPGMazeExBossTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgRPGMazeExBossTable]")
	end
})

local defaultMetaTable = {
	__index = {
		MonsterTeam = 0,
		Describe = "",
		BossBg = "",
		ChallengeCD = 0,
		Monster = 0,
		RecommendPower = 0,
		WeakType = {}
	}
}

for i, data in pairs(CfgRPGMazeExBossTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgRPGMazeExBossTable
