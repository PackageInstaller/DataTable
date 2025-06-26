-- chunkname: @IQIGame\\Config\\CfgGuideTable.lua

local CfgGuideTable = {
	[1000] = {
		Content = "迎新+进入迷宫指引",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = 1007,
		IsSkip = false,
		Order = 1000,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CheckPlayerLv,>=,1|CheckInactivatedGuide,1000|CheckIsEnterMaze,25020100",
		Id = 1000,
		Record = true,
		Enable = true,
		SubIDList = {
			1001,
			1002,
			1003,
			1004,
			1005,
			1006,
			1007,
			1008,
			1009
		}
	},
	[1100] = {
		Content = "第2次进魔女境界",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = 1102,
		IsSkip = false,
		Order = 1100,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020100|CheckInactivatedGuide,1200|CheckIsEnterMaze,25020101",
		Id = 1100,
		Record = true,
		Enable = true,
		SubIDList = {
			1101,
			1102
		}
	},
	[1200] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10001100_1_10101601",
		KeyID = -1,
		Content = "战斗引导1-1",
		Order = 1200,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1|CheckInactivatedGuide,2000|CheckIsEnterMaze,25020102",
		Id = 1200,
		Record = true,
		Enable = true,
		SubIDList = {
			1201,
			1202,
			1203,
			1204,
			1205,
			1206,
			1207
		}
	},
	[1250] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10001100_2_10101601",
		KeyID = -1,
		Content = "战斗引导1-2",
		Order = 1250,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1|CheckInactivatedGuide,2000|CheckIsEnterMaze,25020102",
		Id = 1250,
		Record = true,
		Enable = true,
		SubIDList = {
			1251,
			1252
		}
	},
	[1300] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_1200021_1_10102601",
		KeyID = -1,
		Content = "战斗引导2-1",
		Order = 1300,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1|CheckInactivatedGuide,2000|CheckIsEnterMaze,25020102",
		Id = 1300,
		Record = true,
		Enable = true,
		SubIDList = {
			1301,
			1302
		}
	},
	[1350] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_1200021_2_10102601",
		KeyID = -1,
		Content = "战斗引导2-2",
		Order = 1350,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1|CheckInactivatedGuide,2000|CheckIsEnterMaze,25020102",
		Id = 1350,
		Record = true,
		Enable = true,
		SubIDList = {
			1351,
			1352
		}
	},
	[1380] = {
		Content = "未满探索时提示",
		ReturnScene = 2,
		TriggerValues = "MazeArriveExit_25020101",
		KeyID = 25000,
		IsSkip = false,
		Order = 1380,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020100|CheckInactivatedGuide,1400",
		Id = 1380,
		Record = true,
		Enable = true,
		SubIDList = {
			25000
		}
	},
	[1400] = {
		Content = "星见和芙丽希亚进编队",
		ReturnScene = 2,
		TriggerValues = "2",
		NextGuide = 1480,
		KeyID = 1403,
		Order = 1400,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020101|CheckInactivatedGuide,1500|CheckIsEnterMaze,25020102",
		Id = 1400,
		Record = true,
		Enable = true,
		SubIDList = {
			1400,
			1401,
			1402,
			1403
		}
	},
	[1480] = {
		Content = "星见和芙丽希亚进编队",
		ReturnScene = 2,
		TriggerValues = "-1",
		ReturnUI = "FormationUI",
		IsSkip = false,
		Order = 1480,
		HideL2D = false,
		KeyID = 1405,
		Conditions = "CustomsClearance,25020101|CheckInactivatedGuide,1500|CheckIsEnterMaze,25020102",
		Id = 1480,
		Record = true,
		Enable = true,
		SubIDList = {
			1404,
			1405,
			1406,
			1407,
			1408,
			1409
		}
	},
	[1450] = {
		Content = "星见和芙丽希亚进编队",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = 1405,
		IsSkip = false,
		Order = 1,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020101|CheckInactivatedGuide,1480|CheckGuideID,1400|CheckIsEnterMaze,25020102",
		Id = 1450,
		Record = true,
		Enable = true,
		SubIDList = {
			1401,
			1404,
			1405,
			1406,
			1407,
			1408
		}
	},
	[1500] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10001100_2_10103601",
		KeyID = -1,
		Content = "战斗引导3-1",
		Order = 1500,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1|CheckInactivatedGuide,1600|CheckIsEnterMaze,25020103|CheckGuideID,1480|CheckGuideID,1400",
		Id = 1500,
		Record = true,
		Enable = true,
		SubIDList = {
			1501,
			1502,
			1503,
			1504,
			1505
		}
	},
	[1550] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10000300_3_10103601",
		KeyID = -1,
		Content = "战斗引导3-2",
		Order = 1550,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1|CheckInactivatedGuide,1600|CheckIsEnterMaze,25020103|CheckGuideID,1480|CheckGuideID,1400",
		Id = 1550,
		Record = true,
		Enable = true,
		SubIDList = {
			1551,
			1552,
			1553,
			1554
		}
	},
	[1580] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10000300_4_10103601",
		KeyID = -1,
		Content = "战斗引导3-3",
		Order = 1580,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1|CheckInactivatedGuide,1600|CheckIsEnterMaze,25020103|CheckGuideID,1480|CheckGuideID,1400",
		Id = 1580,
		Record = true,
		Enable = true,
		SubIDList = {
			1581,
			1582
		}
	},
	[1600] = {
		Content = "主线剧情引导1（进入小镇）",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = -1,
		IsSkip = false,
		Order = 1600,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020102|CheckInactivatedGuide,1700|CheckIsEnterMaze,25020103|CheckTownPlotEvent,10020101",
		Id = 1600,
		Record = true,
		Enable = true,
		SubIDList = {
			1601,
			1602,
			1603
		}
	},
	[1700] = {
		Content = "完成小镇支线剧情后进入家园",
		ReturnScene = 2,
		TriggerValues = "CloseDialogUI",
		KeyID = -1,
		IsSkip = false,
		Order = 1700,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020102|CheckInactivatedGuide,1900|CheckIsEnterMaze,25020103",
		Id = 1700,
		Record = true,
		Enable = true,
		SubIDList = {
			1701,
			1702
		}
	},
	[1790] = {
		Content = "炼金室解锁-领取收益",
		ReturnScene = 5,
		TriggerValues = "5",
		KeyID = -1,
		IsSkip = false,
		Order = 1790,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020102|CheckInactivatedGuide,1800|CheckIsEnterMaze,25020103",
		Id = 1790,
		Record = true,
		Enable = true,
		SubIDList = {
			2450,
			2451,
			2452,
			2453
		}
	},
	[1795] = {
		Content = "0-3回到主城后再次引导点迷宫探索",
		ReturnScene = 5,
		TriggerValues = "2",
		KeyID = -1,
		IsSkip = false,
		Order = 1795,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020102|CheckInactivatedGuide,1800|CheckIsEnterMaze,25020103|CheckGuideID,1790",
		Id = 1795,
		Record = true,
		Enable = true,
		SubIDList = {
			1409
		}
	},
	[1800] = {
		Content = "自动战斗1",
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10000500_1_10104103",
		KeyID = -1,
		IsSkip = false,
		Order = 1800,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020102|CheckInactivatedGuide,1850|CheckIsEnterMaze,25020104",
		Id = 1800,
		Record = true,
		Enable = true,
		SubIDList = {
			1801,
			1802
		}
	},
	[1850] = {
		Content = "自动战斗2",
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10000500_1_10104105",
		KeyID = -1,
		IsSkip = false,
		Order = 1850,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020102|CheckInactivatedGuide,1800|CheckIsEnterMaze,25020104",
		Id = 1850,
		Record = true,
		Enable = true,
		SubIDList = {
			1851,
			1852
		}
	},
	[1900] = {
		Content = "人偶祈愿",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = 1904,
		IsSkip = false,
		Order = 1900,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020103|CheckInactivatedGuide,2000|CheckIsEnterMaze,25020104",
		Id = 1900,
		Record = true,
		Enable = true,
		SubIDList = {
			1901,
			1902,
			1903,
			1904,
			1905
		}
	},
	[1940] = {
		Content = "上阵南宫凛",
		TriggerValues = "CloseLotteryUI",
		KeyID = -1,
		ReturnScene = 2,
		Order = 1940,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020103|CheckGuideID,1900|CheckInactivatedGuide,2000|CheckIsEnterMaze,25020104|CheckHaveSoul,20010014",
		Id = 1940,
		Record = true,
		Enable = true,
		SubIDList = {
			1941,
			1942,
			1943,
			1944,
			1945,
			1946,
			1947
		},
		Items = {
			42001,
			1
		}
	},
	[2000] = {
		Content = "获得莉莉艾洛剧情",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = -1,
		IsSkip = false,
		Order = 2000,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020104|CheckInactivatedGuide,2020|CheckIsEnterMaze,25020105|CheckTownPlotEvent,10020155",
		Id = 2000,
		Record = true,
		Enable = true,
		SubIDList = {
			2001,
			2002
		}
	},
	[2020] = {
		Content = "任务奖励领取",
		ReturnScene = 2,
		TriggerValues = "CloseSoulUnlockUI",
		KeyID = -1,
		IsSkip = false,
		Order = 2020,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020104|CheckInactivatedGuide,2040|CheckIsEnterMaze,25020105",
		Id = 2020,
		Record = true,
		Enable = true,
		SubIDList = {
			2020,
			2021,
			2022,
			2023
		}
	},
	[2040] = {
		Content = "升级莉莉艾洛",
		ReturnScene = 2,
		TriggerValues = "CloseMissionUI",
		KeyID = -1,
		IsSkip = false,
		Order = 2040,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020104|CheckInactivatedGuide,2100|CheckIsEnterMaze,25020105|CheckHaveSoul,20010003",
		Id = 2040,
		Record = true,
		Enable = true,
		SubIDList = {
			2041,
			2042,
			2043,
			2044,
			2045,
			2046
		}
	},
	[2060] = {
		Content = "上阵莉莉艾洛",
		ReturnScene = 2,
		TriggerValues = "CloseSoulListUI",
		KeyID = -1,
		IsSkip = false,
		Order = 2060,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020104|CheckInactivatedGuide,2100|CheckIsEnterMaze,25020105|CheckGuideID,2040",
		Id = 2060,
		Record = true,
		Enable = true,
		SubIDList = {
			2061,
			2062
		}
	},
	[2100] = {
		Content = "相伴引导1",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = -1,
		IsSkip = false,
		Order = 2100,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020105|CheckInactivatedGuide,2200|CheckIsEnterMaze,25020106",
		Id = 2100,
		Record = true,
		Enable = true,
		SubIDList = {
			2101
		}
	},
	[2150] = {
		Content = "相伴引导2",
		TriggerValues = "7",
		NextGuide = 2180,
		KeyID = -1,
		Order = 2150,
		ReturnScene = 7,
		IsSkip = false,
		TriggerType = 4,
		HideL2D = false,
		Conditions = "CustomsClearance,25020105|CheckInactivatedGuide,2200|CheckIsEnterMaze,25020106",
		Id = 2150,
		Record = true,
		Enable = true,
		SubIDList = {
			2152,
			2153,
			2154,
			2155
		},
		Items = {
			11105,
			1
		}
	},
	[2180] = {
		Content = "相伴引导3",
		ReturnScene = 7,
		IsSkip = false,
		HideL2D = false,
		Order = 2180,
		KeyID = -1,
		Conditions = "CustomsClearance,25020105|CheckInactivatedGuide,2200|CheckIsEnterMaze,25020106",
		Id = 2180,
		Record = true,
		Enable = true,
		SubIDList = {
			2181,
			2182,
			2183
		}
	},
	[2200] = {
		Content = "蕴灵强化引导1",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = -1,
		IsSkip = false,
		Order = 2200,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020106|CheckInactivatedGuide,2300|CheckItemNum,42001,1|CheckIsEnterMaze,25020107",
		Id = 2200,
		Record = true,
		Enable = true,
		SubIDList = {
			2201,
			2202,
			2203,
			2204,
			2205,
			2206
		}
	},
	[2300] = {
		Content = "魂印强化引导",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = -1,
		IsSkip = false,
		Order = 2300,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020107|CheckInactivatedGuide,2400|CheckIsEnterMaze,25020108|CheckTalentUnlock,20010004,1040101",
		Id = 2300,
		Record = true,
		Enable = true,
		SubIDList = {
			2301,
			2302,
			2303,
			2304
		}
	},
	[2400] = {
		Content = "蕴灵升星引导",
		TriggerValues = "2",
		KeyID = -1,
		ReturnScene = 2,
		Order = 2400,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020108|CheckInactivatedGuide,2500|CheckItemNum,42001,1|CheckIsEnterMaze,25020110",
		Id = 2400,
		Record = true,
		Enable = true,
		SubIDList = {
			2401,
			2402,
			2403,
			2404
		},
		Items = {
			42001,
			1
		}
	},
	[2500] = {
		Content = "试炼引导",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = -1,
		IsSkip = false,
		Order = 2500,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020110|CheckInactivatedGuide,2600|CheckIsEnterMaze,25020111",
		Id = 2500,
		Record = true,
		Enable = true,
		SubIDList = {
			2501,
			2502,
			2503,
			2504
		}
	},
	[2600] = {
		Content = "日常领取",
		ReturnScene = 2,
		TriggerValues = "CloseExploreHallUI",
		KeyID = -1,
		IsSkip = false,
		Order = 2600,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020110|CheckInactivatedGuide,2700|CheckGuideID,2500|CheckIsEnterMaze,25020111",
		Id = 2600,
		Record = true,
		Enable = true,
		SubIDList = {
			2601,
			2602
		}
	},
	[2700] = {
		Content = "巡查引导",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = -1,
		IsSkip = false,
		Order = 2700,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020111|CheckInactivatedGuide,2800|CheckIsEnterMaze,25020112",
		Id = 2700,
		Record = true,
		Enable = true,
		SubIDList = {
			2701,
			2702
		}
	},
	[2800] = {
		Content = "无尽之塔",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = -1,
		IsSkip = false,
		Order = 2800,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020112|CheckInactivatedGuide,2800|CheckIsEnterMaze,25020113",
		Id = 2800,
		Record = true,
		Enable = true,
		SubIDList = {
			2801,
			2802,
			2803,
			2804
		}
	},
	[2900] = {
		Content = "回忆引导1",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = -1,
		IsSkip = false,
		Order = 2900,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020113|CheckInactivatedGuide,2950|CheckIsEnterMaze,25020114",
		Id = 2900,
		Record = true,
		Enable = true,
		SubIDList = {
			2901
		}
	},
	[2950] = {
		Content = "回忆引导2",
		ReturnScene = 7,
		TriggerValues = "7",
		KeyID = -1,
		IsSkip = false,
		Order = 2950,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020113|CheckInactivatedGuide,3000|CheckIsEnterMaze,25020114",
		Id = 2950,
		Record = true,
		Enable = true,
		SubIDList = {
			2950,
			2951,
			2952
		}
	},
	[3000] = {
		Content = "幻境遗迹",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = -1,
		IsSkip = false,
		Order = 3000,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020113|CheckInactivatedGuide,3100|CheckGuideID,2950|CheckIsEnterMaze,25020114",
		Id = 3000,
		Record = true,
		Enable = true,
		SubIDList = {
			3001,
			3002,
			3003,
			3004
		}
	},
	[3100] = {
		Content = "次元深渊引导",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = -1,
		IsSkip = false,
		Order = 3100,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020115|CheckInactivatedGuide,3200|CheckIsEnterMaze,25020200",
		Id = 3100,
		Record = true,
		Enable = true,
		SubIDList = {
			3101,
			3102,
			3103
		}
	},
	[3200] = {
		Content = "世界BOSS引导",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = -1,
		IsSkip = false,
		Order = 3200,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020205|CheckIsEnterMaze,25020210",
		Id = 3200,
		Record = true,
		Enable = true,
		SubIDList = {
			3201,
			3202,
			3203,
			3204
		}
	},
	[4000] = {
		Content = "钟摆引导",
		ReturnScene = 2,
		TriggerValues = "MazeClockUI",
		KeyID = -1,
		IsSkip = false,
		Order = 4000,
		HideL2D = false,
		TriggerType = 1,
		Conditions = "CustomsClearance,25020400",
		Id = 4000,
		Record = true,
		Enable = true,
		SubIDList = {
			4001,
			4002,
			4003,
			4004,
			4005,
			4006,
			4007,
			4008,
			4009,
			4010,
			4011,
			4012
		}
	},
	[4100] = {
		Content = "卢纳战线引导1",
		ReturnScene = 2,
		TriggerValues = "2",
		KeyID = -1,
		IsSkip = false,
		Order = 4100,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020200|CheckDailyDupOpen,10",
		Id = 4100,
		Record = true,
		Enable = false,
		SubIDList = {
			4101,
			4102,
			4103,
			4104,
			4105
		}
	},
	[4200] = {
		Content = "卢纳战线引导2",
		ReturnScene = 2,
		TriggerValues = "LunaBattleLineDetailUI",
		KeyID = -1,
		IsSkip = false,
		Order = 4200,
		HideL2D = false,
		TriggerType = 1,
		Conditions = "CustomsClearance,26030301|CheckDailyDupOpen,10",
		Id = 4200,
		Record = true,
		Enable = false,
		SubIDList = {
			4201,
			4202
		}
	},
	[4300] = {
		Content = "卢纳战线引导3",
		ReturnScene = 2,
		TriggerValues = "LunaBattleLineDetailUI",
		KeyID = -1,
		IsSkip = false,
		Order = 4300,
		HideL2D = false,
		TriggerType = 1,
		Conditions = "CustomsClearance,25020200|CheckGuideID,4200|CheckLunaBattleAnyZoneSeal,1|CheckDailyDupOpen,10",
		Id = 4300,
		Record = true,
		Enable = false,
		SubIDList = {
			4301
		}
	},
	[4400] = {
		Content = "梦见活动引导1",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUIDreamlandTab",
		KeyID = -1,
		IsSkip = false,
		Order = 4400,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 4400,
		Record = true,
		Enable = false,
		SubIDList = {
			4401
		}
	},
	[4500] = {
		Content = "梦见活动引导2",
		ReturnScene = 2,
		TriggerValues = "8",
		NextGuide = 4600,
		KeyID = -1,
		Order = 4500,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020115",
		Id = 4500,
		Record = true,
		Enable = false,
		SubIDList = {
			4501
		}
	},
	[4600] = {
		Content = "梦见活动引导3",
		ReturnScene = 2,
		IsSkip = false,
		HideL2D = false,
		Order = 4600,
		KeyID = -1,
		Conditions = "CustomsClearance,25020115|CheckGuideID,4500",
		Id = 4600,
		Record = true,
		Enable = false,
		SubIDList = {
			4601
		}
	},
	[44100] = {
		Content = "梦见2.0引导1",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUIDreamlandTab",
		KeyID = -1,
		IsSkip = false,
		Order = 44100,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 44100,
		Record = true,
		Enable = false,
		SubIDList = {
			44101
		}
	},
	[45100] = {
		Content = "梦见2.0引导2",
		ReturnScene = 2,
		TriggerValues = "8",
		NextGuide = 46100,
		KeyID = -1,
		Order = 45100,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020115",
		Id = 45100,
		Record = true,
		Enable = false,
		SubIDList = {
			45101
		}
	},
	[46100] = {
		Content = "梦见2.0引导3",
		ReturnScene = 2,
		IsSkip = false,
		HideL2D = false,
		Order = 46100,
		KeyID = -1,
		Conditions = "CustomsClearance,25020115|CheckGuideID,4500",
		Id = 46100,
		Record = true,
		Enable = false,
		SubIDList = {
			46101
		}
	},
	[44200] = {
		Content = "梦见3.0引导1",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUIDreamlandTab",
		KeyID = -1,
		IsSkip = false,
		Order = 44200,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 44200,
		Record = true,
		Enable = false,
		SubIDList = {
			44201
		}
	},
	[45200] = {
		Content = "梦见3.0引导2",
		ReturnScene = 2,
		TriggerValues = "8",
		NextGuide = 46200,
		KeyID = -1,
		Order = 45200,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020115",
		Id = 45200,
		Record = true,
		Enable = false,
		SubIDList = {
			45201
		}
	},
	[46200] = {
		Content = "梦见3.0引导3",
		ReturnScene = 2,
		IsSkip = false,
		HideL2D = false,
		Order = 46200,
		KeyID = -1,
		Conditions = "CustomsClearance,25020115|CheckGuideID,4500",
		Id = 46200,
		Record = true,
		Enable = false,
		SubIDList = {
			46201
		}
	},
	[47100] = {
		Content = "梦见4.0引导1",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUIDreamlandTab",
		KeyID = -1,
		IsSkip = false,
		Order = 47100,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 47100,
		Record = true,
		Enable = false,
		SubIDList = {
			47101
		}
	},
	[47200] = {
		Content = "梦见4.0引导2",
		ReturnScene = 2,
		TriggerValues = "8",
		NextGuide = 47300,
		KeyID = -1,
		Order = 47200,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020115",
		Id = 47200,
		Record = true,
		Enable = false,
		SubIDList = {
			47201
		}
	},
	[47300] = {
		Content = "梦见4.0引导3",
		ReturnScene = 2,
		IsSkip = false,
		HideL2D = false,
		Order = 47300,
		KeyID = -1,
		Conditions = "CustomsClearance,25020115|CheckGuideID,4500",
		Id = 47300,
		Record = true,
		Enable = false,
		SubIDList = {
			47301
		}
	},
	[48100] = {
		Content = "梦见5.0引导1",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUIDreamlandTab",
		KeyID = -1,
		IsSkip = false,
		Order = 48100,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 48100,
		Record = true,
		Enable = false,
		SubIDList = {
			48101
		}
	},
	[48200] = {
		Content = "梦见6.0引导1",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUIDreamlandTab",
		KeyID = -1,
		IsSkip = false,
		Order = 48200,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 48200,
		Record = true,
		Enable = false,
		SubIDList = {
			48201
		}
	},
	[48300] = {
		Content = "梦见7.0引导1",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUIDreamlandTab",
		KeyID = -1,
		IsSkip = false,
		Order = 48300,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 48300,
		Record = true,
		Enable = true,
		SubIDList = {
			48301
		}
	},
	[48400] = {
		Content = "梦见7.0引导1",
		ReturnScene = 2,
		TriggerValues = "8",
		NextGuide = 48400,
		KeyID = -1,
		Order = 48400,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020115",
		Id = 48400,
		Record = true,
		Enable = true,
		SubIDList = {
			48401
		}
	},
	[4700] = {
		Content = "钓鱼引导",
		ReturnScene = 2,
		TriggerValues = "5",
		KeyID = -1,
		IsSkip = false,
		Order = 4700,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020325",
		Id = 4700,
		Record = true,
		Enable = true,
		SubIDList = {
			4701,
			4702,
			4703
		}
	},
	[4800] = {
		Content = "弛豫之末引导",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUIDualTeamExploreTab",
		KeyID = -1,
		IsSkip = false,
		Order = 4800,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 4800,
		Record = true,
		Enable = false,
		SubIDList = {
			4801,
			4802,
			4803
		}
	},
	[4900] = {
		Content = "弛豫之末分队引导",
		ReturnScene = 2,
		TriggerValues = "DualTeamExploreSeparateConfirmUI",
		KeyID = -1,
		IsSkip = false,
		Order = 4900,
		HideL2D = false,
		TriggerType = 1,
		Conditions = "CustomsClearance,25020115",
		Id = 4900,
		Record = true,
		Enable = false,
		SubIDList = {
			4901,
			4902,
			4903,
			4904
		}
	},
	[5000] = {
		Content = "弥心rpg引导",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUI_Toggle_3",
		KeyID = -1,
		IsSkip = false,
		Order = 5000,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 5000,
		Record = true,
		Enable = true,
		SubIDList = {
			5001
		}
	},
	[5005] = {
		Content = "2周年RPG引导",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUI_Toggle_3",
		KeyID = -1,
		IsSkip = false,
		Order = 5005,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 5005,
		Record = true,
		Enable = false,
		SubIDList = {
			5005
		}
	},
	[5050] = {
		Content = "怪物学园主界面引导",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUI_Toggle_8",
		KeyID = -1,
		IsSkip = false,
		Order = 5050,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 5050,
		Record = true,
		Enable = false,
		SubIDList = {
			5051,
			5052
		}
	},
	[5100] = {
		Content = "怪物学园引导",
		ReturnScene = 2,
		TriggerValues = "CloseDialogUI",
		KeyID = -1,
		IsSkip = false,
		Order = 5100,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 5100,
		Record = true,
		Enable = false,
		SubIDList = {
			5101,
			5102,
			5103,
			5104,
			5105,
			5106,
			5107,
			5108,
			5109,
			5110,
			5111,
			5112,
			5113,
			5114
		}
	},
	[5200] = {
		Content = "种田开始引导1",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUI_Toggle_6",
		KeyID = -1,
		IsSkip = false,
		Order = 5200,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 5200,
		Record = true,
		Enable = false,
		SubIDList = {
			5201
		}
	},
	[5300] = {
		Content = "种田开始引导2",
		ReturnScene = 2,
		TriggerValues = "DualTeamExploreLevelEntryConfirmUI",
		KeyID = -1,
		IsSkip = false,
		Order = 5300,
		HideL2D = false,
		TriggerType = 1,
		Conditions = "CustomsClearance,25020115",
		Id = 5300,
		Record = true,
		Enable = false,
		SubIDList = {
			5301
		}
	},
	[5400] = {
		Content = "种田开始引导3",
		ReturnScene = 2,
		TriggerValues = "DualTeamExploreSeparateConfirmUI",
		KeyID = -1,
		IsSkip = false,
		Order = 5400,
		HideL2D = false,
		TriggerType = 1,
		Conditions = "CustomsClearance,25020115",
		Id = 5400,
		Record = true,
		Enable = false,
		SubIDList = {
			5401,
			5402,
			5403,
			5404
		}
	},
	[5500] = {
		Content = "怪物学园2主界面引导",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUI_Toggle_8",
		KeyID = -1,
		IsSkip = false,
		Order = 5500,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 5500,
		Record = true,
		Enable = false,
		SubIDList = {
			5501,
			5502
		}
	},
	[5600] = {
		Content = "怪物学园2引导",
		ReturnScene = 2,
		TriggerValues = "CloseDialogUI",
		KeyID = -1,
		IsSkip = false,
		Order = 5600,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 5600,
		Record = true,
		Enable = false,
		SubIDList = {
			5601,
			5602,
			5603,
			5604,
			5605,
			5606,
			5607,
			5608,
			5609,
			5610,
			5611,
			5612,
			5613,
			5614
		}
	},
	[5700] = {
		Content = "挖矿引导",
		TriggerValues = "2",
		KeyID = -1,
		ReturnScene = 2,
		Order = 5700,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 4,
		Conditions = "CustomsClearance,25020325",
		Id = 5700,
		Record = true,
		Enable = true,
		SubIDList = {
			5701
		},
		Items = {
			311,
			200
		}
	},
	[5800] = {
		Content = "弹幕飞行",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUI_Toggle_10",
		KeyID = -1,
		IsSkip = false,
		Order = 5800,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 5800,
		Record = true,
		Enable = true,
		SubIDList = {
			5801
		}
	},
	[5900] = {
		Content = "客栈经营",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUI_Toggle_11",
		KeyID = -1,
		IsSkip = false,
		Order = 5900,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 5900,
		Record = true,
		Enable = true,
		SubIDList = {
			5901
		}
	},
	[5910] = {
		Content = "客栈内引导",
		ReturnScene = 2,
		TriggerValues = "RestaurantOperationMainUI",
		KeyID = -1,
		IsSkip = false,
		Order = 5910,
		HideL2D = false,
		TriggerType = 1,
		Conditions = "CustomsClearance,25020115",
		Id = 5910,
		Record = true,
		Enable = true,
		SubIDList = {
			5911
		}
	},
	[5920] = {
		Content = "办证引导",
		ReturnScene = 2,
		TriggerValues = "RestaurantOperationUnlockPlayerUI",
		KeyID = -1,
		IsSkip = false,
		Order = 5920,
		HideL2D = false,
		TriggerType = 1,
		Conditions = "CustomsClearance,25020115",
		Id = 5920,
		Record = true,
		Enable = true,
		SubIDList = {
			5921
		}
	},
	[5930] = {
		Content = "进修引导",
		ReturnScene = 2,
		TriggerValues = "RestaurantOperationUpdateUI",
		KeyID = -1,
		IsSkip = false,
		Order = 5930,
		HideL2D = false,
		TriggerType = 1,
		Conditions = "CustomsClearance,25020115",
		Id = 5930,
		Record = true,
		Enable = true,
		SubIDList = {
			5931
		}
	},
	[6000] = {
		Content = "放置挑战",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUI_Toggle_12",
		KeyID = -1,
		IsSkip = false,
		Order = 6000,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 6000,
		Record = true,
		Enable = true,
		SubIDList = {
			6001
		}
	},
	[6100] = {
		Content = "怪物嘉年华",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUI_Toggle_13",
		KeyID = -1,
		IsSkip = false,
		Order = 6100,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 6100,
		Record = true,
		Enable = true,
		SubIDList = {
			6101
		}
	},
	[6200] = {
		Content = "飞机2.0",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUI_Toggle_14",
		KeyID = -1,
		IsSkip = false,
		Order = 6200,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 6200,
		Record = true,
		Enable = false,
		SubIDList = {
			6201
		}
	},
	[6300] = {
		Content = "可安歇的黎明引导",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUI_Toggle_15",
		KeyID = -1,
		IsSkip = false,
		Order = 6300,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 6300,
		Record = true,
		Enable = true,
		SubIDList = {
			6301
		}
	},
	[6400] = {
		Content = "拯救世界要在约会后",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUI_Toggle_5",
		KeyID = -1,
		IsSkip = false,
		Order = 6400,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 6400,
		Record = true,
		Enable = true,
		SubIDList = {
			6401
		}
	},
	[6500] = {
		Content = "飞机3.0",
		ReturnScene = 2,
		TriggerValues = "ExploreHallUI_Toggle_14",
		KeyID = -1,
		IsSkip = false,
		Order = 6500,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CustomsClearance,25020115",
		Id = 6500,
		Record = true,
		Enable = true,
		SubIDList = {
			6501
		}
	},
	[51100] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10001100_1_42410101",
		KeyID = -1,
		Content = "指挥讲堂引导1",
		Order = 51100,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51100,
		Record = true,
		Enable = true,
		SubIDList = {
			51101,
			51103,
			51104,
			51105,
			51107,
			51108,
			51109,
			51110,
			51111,
			51112,
			51113,
			51114,
			51115,
			51116
		}
	},
	[51150] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10001100_3_42410101",
		KeyID = -1,
		Content = "指挥讲堂引导1第二段",
		Order = 51150,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51150,
		Record = true,
		Enable = true,
		SubIDList = {
			51151,
			51152,
			51153
		}
	},
	[51200] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10000200_1_42420101",
		KeyID = -1,
		Content = "指挥讲堂引导2",
		Order = 51200,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51200,
		Record = true,
		Enable = true,
		SubIDList = {
			51201,
			51202,
			51203,
			51204,
			51205,
			51206
		}
	},
	[51250] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10000200_2_42420101",
		KeyID = -1,
		Content = "指挥讲堂引导2第二段",
		Order = 51250,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51250,
		Record = true,
		Enable = true,
		SubIDList = {
			51251,
			51252,
			51253,
			51254,
			51255,
			51256,
			51257
		}
	},
	[51300] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10001100_1_42430101",
		KeyID = -1,
		Content = "指挥讲堂引导3",
		Order = 51300,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51300,
		Record = true,
		Enable = true,
		SubIDList = {
			51301,
			51302,
			51303,
			51304,
			51305,
			51306,
			51307,
			51308,
			51309
		}
	},
	[51310] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10001100_2_42430101",
		KeyID = -1,
		Content = "指挥讲堂引导3第二段",
		Order = 51310,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51310,
		Record = true,
		Enable = true,
		SubIDList = {
			51311,
			51312,
			51313,
			51314,
			51315
		}
	},
	[51320] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10001100_3_42430101",
		KeyID = -1,
		Content = "指挥讲堂引导3第三段",
		Order = 51320,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51320,
		Record = true,
		Enable = true,
		SubIDList = {
			51321,
			51322,
			51323,
			51324,
			51325
		}
	},
	[51400] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10001100_1_42440101",
		KeyID = -1,
		Content = "指挥讲堂引导4",
		Order = 51400,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51400,
		Record = true,
		Enable = true,
		SubIDList = {
			51401,
			51402,
			51403,
			51404
		}
	},
	[51410] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10001100_2_42440101",
		KeyID = -1,
		Content = "指挥讲堂引导4第二段",
		Order = 51400,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51410,
		Record = true,
		Enable = true,
		SubIDList = {
			51411,
			51412,
			51413
		}
	},
	[51420] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10001100_3_42440101",
		KeyID = -1,
		Content = "指挥讲堂引导4第三段",
		Order = 51400,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51420,
		Record = true,
		Enable = true,
		SubIDList = {
			51421,
			51422,
			51423
		}
	},
	[51500] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10002600_1_42450101",
		KeyID = -1,
		Content = "指挥讲堂引导5",
		Order = 51500,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51500,
		Record = true,
		Enable = true,
		SubIDList = {
			51501,
			51502,
			51503,
			51504,
			51505,
			51506,
			51507,
			51508,
			51509,
			51510
		}
	},
	[51510] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10002600_2_42450101",
		KeyID = -1,
		Content = "指挥讲堂引导5第二段",
		Order = 51510,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51510,
		Record = true,
		Enable = true,
		SubIDList = {
			51511,
			51512,
			51513,
			51514,
			51515,
			51516
		}
	},
	[51600] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10000200_1_42460101",
		KeyID = -1,
		Content = "指挥讲堂引导6",
		Order = 51600,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51600,
		Record = true,
		Enable = true,
		SubIDList = {
			51601,
			51602,
			51603,
			51604,
			51605
		}
	},
	[51610] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10000200_2_42460101",
		KeyID = -1,
		Content = "指挥讲堂引导6第二段",
		Order = 51610,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51610,
		Record = true,
		Enable = true,
		SubIDList = {
			51611,
			51612,
			51613
		}
	},
	[51620] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10000200_3_42460101",
		KeyID = -1,
		Content = "指挥讲堂引导6第三段",
		Order = 51620,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51620,
		Record = true,
		Enable = true,
		SubIDList = {
			51621,
			51622,
			51623,
			51624,
			51625
		}
	},
	[51630] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10000200_4_42460101",
		KeyID = -1,
		Content = "指挥讲堂引导6第四段",
		Order = 51630,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51630,
		Record = true,
		Enable = true,
		SubIDList = {
			51631,
			51632,
			51633
		}
	},
	[51700] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10002400_1_42470101",
		KeyID = -1,
		Content = "指挥讲堂引导7",
		Order = 51700,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51700,
		Record = true,
		Enable = true,
		SubIDList = {
			51701,
			51702,
			51703,
			51704
		}
	},
	[51710] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10001100_1_42470101",
		KeyID = -1,
		Content = "指挥讲堂引导7第2段",
		Order = 51710,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51710,
		Record = true,
		Enable = true,
		SubIDList = {
			51711,
			51712,
			51713,
			51714,
			51715
		}
	},
	[51720] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10000200_1_42470101",
		KeyID = -1,
		Content = "指挥讲堂引导7第3段",
		Order = 51720,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51720,
		Record = true,
		Enable = true,
		SubIDList = {
			51721,
			51722
		}
	},
	[51730] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10000200_2_42470101",
		KeyID = -1,
		Content = "指挥讲堂引导7第4段",
		Order = 51730,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51730,
		Record = true,
		Enable = true,
		SubIDList = {
			51731,
			51732
		}
	},
	[51740] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10001100_2_42470101",
		KeyID = -1,
		Content = "指挥讲堂引导7第5段",
		Order = 51740,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51740,
		Record = true,
		Enable = true,
		SubIDList = {
			51741
		}
	},
	[51750] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10002400_2_42470101",
		KeyID = -1,
		Content = "指挥讲堂引导7第6段",
		Order = 51750,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51750,
		Record = true,
		Enable = true,
		SubIDList = {
			51751
		}
	},
	[51760] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10002400_3_42470101",
		KeyID = -1,
		Content = "指挥讲堂引导7第7段",
		Order = 51760,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51760,
		Record = true,
		Enable = true,
		SubIDList = {
			51761,
			51762,
			51763
		}
	},
	[51800] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10000300_1_42480101",
		KeyID = -1,
		Content = "指挥讲堂引导8",
		Order = 51800,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51800,
		Record = true,
		Enable = true,
		SubIDList = {
			51801,
			51802,
			51803,
			51804,
			51805,
			51806,
			51807,
			51808
		}
	},
	[51810] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10000300_2_42480101",
		KeyID = -1,
		Content = "指挥讲堂引导8第二段",
		Order = 51810,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51810,
		Record = true,
		Enable = true,
		SubIDList = {
			51811,
			51812,
			51813,
			51814
		}
	},
	[51820] = {
		Unlimited = true,
		ReturnScene = 2,
		TriggerValues = "BattleSoulSelectSkill_10000300_3_42480101",
		KeyID = -1,
		Content = "指挥讲堂引导8第三段",
		Order = 51820,
		IsSkip = false,
		HideL2D = false,
		TriggerType = 3,
		Conditions = "CheckPlayerLv,>=,1",
		Id = 51820,
		Record = true,
		Enable = true,
		SubIDList = {
			51821,
			51822,
			51823
		}
	}
}

setmetatable(CfgGuideTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGuideTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ReturnUI = "",
		IsSkip = false,
		Content = "",
		Unlimited = false,
		Order = 0,
		Enable = false,
		KeyID = 0,
		ReturnScene = 0,
		Conditions = "",
		Record = false,
		TriggerValues = "",
		TriggerType = 0,
		GuideGroupId = 0,
		HideL2D = false,
		NextGuide = 0,
		SubIDList = {},
		Items = {}
	}
}

for i, data in pairs(CfgGuideTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGuideTable
