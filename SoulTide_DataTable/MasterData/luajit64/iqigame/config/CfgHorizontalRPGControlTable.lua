-- chunkname: @IQIGame\\Config\\CfgHorizontalRPGControlTable.lua

local CfgHorizontalRPGControlTable = {
	{
		EXBossMapID = 41100003,
		ScoreItem = 468,
		MazeBossChallengeEntryUI = "/_DailyActivityUI/HorizontalRPGMaze/Chapter1/MazeBossChallengeEntryUIView",
		MazeExBossDetailUI = "/_DailyActivityUI/HorizontalRPGMaze/Chapter1/HorizontalRPGMazeBossChallengeDetailUIView",
		Service = 90120,
		MoneyId = 1700000,
		OpenCount = 1,
		HorizontalRPGMissionUI = "/_DailyActivityUI/HorizontalRPGMaze/Chapter1/RPGMissionUIView",
		EXBossTeam = 43206011,
		MazeBossDetailUI = "/_DailyActivityUI/HorizontalRPGMaze/Chapter1/MazeBossDetailUIView",
		ModeType = 1,
		BGM = 411,
		BossFreeChallengeCount = 1,
		EXBossBg = "/Image_Resources/MonsterDrawing/Drawing/AXLM_shidirongyan_01.png",
		HorizontalRPGMazeTeamUI = "/_DailyActivityUI/HorizontalRPGMaze/Chapter1/RpgMazeTeamUIView",
		Id = 1,
		MallMoneyId = 468,
		ExploreHallUIBG = "Activity_HorizontalPRG_250102",
		Desc = getI18NValue(180921017),
		DollDatas = {
			30
		},
		QuestIds = {
			90501001,
			90501006,
			90501011,
			90501021,
			90501026,
			90501027,
			90501028,
			90501029
		},
		BossList = {
			1001,
			1002,
			1003,
			1004,
			1005
		},
		WeakType = {
			6,
			2,
			3
		},
		EXBossName = getI18NValue(180921179),
		MazeInstances = {
			26070001,
			26070002,
			26070003,
			26070004,
			26070005,
			26070006,
			26070007,
			26070008,
			26070009,
			26070010
		},
		EventGroup = {
			1001,
			1002,
			1003
		}
	},
	{
		EXBossMapID = 41000001,
		ScoreItem = 473,
		MazeBossChallengeEntryUI = "/_DailyActivityUI/HorizontalRPGMaze/Chapter1/MazeBossChallengeEntryUIView",
		MazeExBossDetailUI = "/_DailyActivityUI/HorizontalRPGMaze/Chapter1/HorizontalRPGMazeBossChallengeDetailUIView",
		Service = 14,
		MoneyId = 473,
		OpenCount = 2,
		HorizontalRPGMissionUI = "/_DailyActivityUI/HorizontalRPGMaze/Chapter1/RPGMissionUIView",
		EXBossTeam = 41509271,
		MazeBossDetailUI = "/_DailyActivityUI/HorizontalRPGMaze/Chapter1/MazeBossDetailUIView",
		ModeType = 2,
		BGM = 108,
		BossFreeChallengeCount = 1,
		EXBossBg = "/Image_Resources/MonsterDrawing/Drawing/LHTX_wujinxiuluo_01.png",
		HorizontalRPGMazeTeamUI = "/_DailyActivityUI/HorizontalRPGMaze/Chapter1/RpgMazeTeamUIView",
		Id = 2,
		MallMoneyId = 473,
		ExploreHallUIBG = "Activity_HorizontalPRG_250327",
		Desc = getI18NValue(180935520),
		DollDatas = {
			30
		},
		QuestIds = {
			90501001,
			90501006,
			90501011,
			90501021,
			90501026,
			90501027,
			90501028,
			90501029
		},
		BossList = {
			1001,
			1002,
			1003,
			1004,
			1005
		},
		WeakType = {
			5,
			6,
			2
		},
		EXBossName = getI18NValue(180935521),
		MazeInstances = {
			25020705
		},
		EventGroup = {
			1001,
			1002,
			1003,
			1004,
			1005,
			1006,
			1007,
			1008,
			1009,
			1010,
			1011,
			1012,
			1013,
			1014,
			1015,
			1016,
			1017,
			1018,
			1019,
			1020,
			1021,
			1022,
			1023,
			1024,
			1025,
			1026,
			1027,
			1028,
			1029,
			1030,
			1201,
			1202,
			1203,
			1204,
			1205,
			1206,
			1207,
			1208,
			1209,
			1210,
			1211,
			1212,
			1213
		}
	}
}

setmetatable(CfgHorizontalRPGControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHorizontalRPGControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		EXBossMapID = 0,
		ScoreItem = 0,
		EXBossName = "",
		MazeBossChallengeEntryUI = "",
		Service = 0,
		BGM = 0,
		MoneyId = 0,
		OpenCount = 0,
		HorizontalRPGMissionUI = "",
		EXBossTeam = 0,
		Desc = "",
		MazeBossDetailUI = "",
		ModeType = 0,
		BossFreeChallengeCount = 0,
		EXBossBg = "",
		HorizontalRPGMazeTeamUI = "",
		MazeExBossDetailUI = "",
		MallMoneyId = 0,
		ExploreHallUIBG = "",
		MazeInstances = {},
		QuestIds = {},
		EventGroup = {},
		BossList = {},
		WeakType = {},
		DollDatas = {}
	}
}

for i, data in pairs(CfgHorizontalRPGControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHorizontalRPGControlTable
