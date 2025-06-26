-- chunkname: @IQIGame\\Config\\CfgActivityTable.lua

local CfgActivityTable = {
	[60000001] = {
		ActivityType = 1,
		OpenTime = "0:00:00",
		OneOnly = false,
		Id = 60000001,
		OpenTimeType = 1,
		OpenTimeParam = {
			1,
			2,
			3,
			4,
			5,
			6,
			7
		},
		Duration = {
			86400
		},
		Desc = getI18NValue(180129553)
	},
	[60000002] = {
		ActivityType = 1,
		OpenTime = "0:00:00",
		OneOnly = false,
		Id = 60000002,
		OpenTimeType = 1,
		OpenTimeParam = {
			1,
			3,
			5
		},
		Duration = {
			86400
		},
		Desc = getI18NValue(180129554)
	},
	[60000003] = {
		ActivityType = 1,
		OpenTime = "0:00:00",
		OneOnly = false,
		Id = 60000003,
		OpenTimeType = 1,
		OpenTimeParam = {
			2,
			4,
			6
		},
		Duration = {
			86400
		},
		Desc = getI18NValue(180129555)
	},
	[60000004] = {
		ActivityType = 1,
		OpenTime = "0:00:00",
		OneOnly = false,
		Id = 60000004,
		OpenTimeType = 1,
		OpenTimeParam = {
			7
		},
		Duration = {
			86400
		},
		Desc = getI18NValue(180129556)
	},
	[60000005] = {
		ActivityType = 1,
		OpenTime = "0:00:00",
		OneOnly = false,
		Id = 60000005,
		OpenTimeType = 1,
		OpenTimeParam = {
			1,
			3,
			5,
			7
		},
		Duration = {
			86400
		},
		Desc = getI18NValue(180129557)
	},
	[60000006] = {
		ActivityType = 1,
		OpenTime = "0:00:00",
		OneOnly = false,
		Id = 60000006,
		OpenTimeType = 1,
		OpenTimeParam = {
			2,
			4,
			6,
			7
		},
		Duration = {
			86400
		},
		Desc = getI18NValue(180129558)
	},
	[60000007] = {
		ActivityType = 1,
		OpenTime = "11:30:00",
		OneOnly = false,
		Id = 60000007,
		OpenTimeType = 1,
		OpenTimeParam = {
			2,
			4,
			6
		},
		Duration = {
			18000
		},
		Desc = getI18NValue(180129559)
	},
	[60000008] = {
		ActivityType = 1,
		OpenTime = "12:00:00",
		OneOnly = false,
		Id = 60000008,
		OpenTimeType = 1,
		OpenTimeParam = {
			3,
			5
		},
		Duration = {
			18000
		},
		Desc = getI18NValue(180129560)
	},
	[60000009] = {
		ActivityType = 1,
		OpenTime = "0:00:00",
		OneOnly = false,
		Id = 60000009,
		OpenTimeType = 1,
		OpenTimeParam = {
			1,
			6
		},
		Duration = {
			18000
		},
		Desc = getI18NValue(180129561)
	},
	[60000010] = {
		ActivityType = 1,
		OpenTime = "14:30:00",
		OneOnly = false,
		Id = 60000010,
		OpenTimeType = 1,
		OpenTimeParam = {
			1,
			2,
			3
		},
		Duration = {
			36000
		},
		Desc = getI18NValue(180129562)
	},
	[60000011] = {
		ActivityType = 1,
		OpenTime = "8:00:00",
		OneOnly = false,
		Id = 60000011,
		OpenTimeType = 1,
		OpenTimeParam = {
			4,
			5,
			6
		},
		Duration = {
			14400
		},
		Desc = getI18NValue(180129563)
	},
	[60001001] = {
		ActivityType = 16,
		OneOnly = false,
		Id = 60001001,
		OpenTimeType = 3,
		Duration = {
			-1
		},
		ExtraParam = {
			36000,
			86400,
			60008,
			61200,
			86400,
			60008
		},
		Desc = getI18NValue(180129564)
	},
	[60001002] = {
		Id = 60001002,
		OpenAction = 9,
		ActivityType = 3,
		CloseAction = 27,
		OneOnly = false,
		OpenTimeType = 3,
		Duration = {
			-1
		},
		Desc = getI18NValue(180129565),
		OpenActionParams = {
			6
		},
		CloseActionParams = {
			6
		}
	},
	[60001004] = {
		Id = 60001004,
		OpenAction = 9,
		ActivityType = 7,
		CloseAction = 27,
		OneOnly = false,
		OpenTimeType = 3,
		Duration = {
			-1
		},
		Desc = getI18NValue(180129567),
		OpenActionParams = {
			8,
			0
		},
		CloseActionParams = {
			8
		}
	},
	[60001005] = {
		Id = 60001005,
		OpenTime = "2025/4/9 4:00",
		OpenTimeType = 2,
		ActivityType = 3,
		OpenAction = 9,
		CloseAction = 27,
		OneOnly = false,
		version = 1,
		Duration = {
			1886400
		},
		ExtraParam = {
			11,
			7
		},
		Desc = getI18NValue(180266477),
		OpenActionParams = {
			11,
			7
		},
		CloseActionParams = {
			11,
			7
		}
	},
	[60001006] = {
		Id = 60001006,
		OpenAction = 15,
		ActivityType = 4,
		CloseAction = 16,
		OneOnly = false,
		OpenTimeType = 3,
		Duration = {
			2592000
		},
		Desc = getI18NValue(180267136),
		OpenActionParams = {
			60001006,
			50300101
		},
		CloseActionParams = {
			60001006,
			50300101
		}
	},
	[60001007] = {
		OneOnly = false,
		OpenTime = "2025/4/30 12:00",
		ActivityType = 4,
		CloseAction = 16,
		OpenAction = 15,
		Id = 60001007,
		OpenTimeType = 2,
		Duration = {
			1785600
		},
		Desc = getI18NValue(180267274),
		OpenActionParams = {
			60001007,
			50300201
		},
		CloseActionParams = {
			60001007,
			50300201
		}
	},
	[60001008] = {
		Id = 60001008,
		OpenTime = "2025/5/1 4:00",
		OpenTimeType = 2,
		ActivityType = 3,
		OpenAction = 9,
		CloseAction = 27,
		OneOnly = false,
		version = 1,
		Duration = {
			1209600
		},
		ExtraParam = {
			11,
			8
		},
		Desc = getI18NValue(180267543),
		OpenActionParams = {
			11,
			8
		},
		CloseActionParams = {
			11,
			8
		}
	},
	[60001101] = {
		ActivityType = 28,
		OpenTime = "2025/4/16 14:30",
		OneOnly = false,
		Id = 60001101,
		OpenTimeType = 2,
		Duration = {
			1243800
		},
		ExtraParam = {
			0
		},
		Desc = getI18NValue(180267222)
	},
	[60001102] = {
		ActivityType = 28,
		OpenTime = "2025/5/1 4:00",
		OneOnly = false,
		Id = 60001102,
		OpenTimeType = 2,
		Duration = {
			2664000
		},
		ExtraParam = {
			1746028800
		},
		Desc = getI18NValue(180267238)
	},
	[60001103] = {
		ActivityType = 28,
		OpenTime = "2025/6/1 4:00",
		OneOnly = false,
		Id = 60001103,
		OpenTimeType = 2,
		Duration = {
			2577600
		},
		ExtraParam = {
			1748707200
		},
		Desc = getI18NValue(180267239)
	},
	[60002001] = {
		ActivityType = 17,
		OpenAction = 9,
		OneOnly = false,
		Id = 60002001,
		OpenTimeType = 3,
		Duration = {
			-1
		},
		Desc = getI18NValue(180129568),
		OpenActionParams = {
			11,
			1
		}
	},
	[60002010] = {
		ActivityType = 2,
		OpenTime = "2025/2/1 16:35",
		OneOnly = true,
		Id = 60002010,
		OpenTimeType = 2,
		Duration = {
			4219200
		},
		ExtraParam = {
			80215
		},
		Desc = getI18NValue(180153901)
	},
	[60002011] = {
		Id = 60002011,
		OpenTime = "2025/3/26 4:00",
		OpenTimeType = 2,
		ActivityType = 2,
		OneOnly = true,
		version = 1,
		Duration = {
			3628800
		},
		ExtraParam = {
			80211
		},
		Desc = getI18NValue(180153902)
	},
	[60002012] = {
		Id = 60002012,
		OpenTime = "2025/5/28 4:00",
		OpenTimeType = 2,
		ActivityType = 2,
		OneOnly = true,
		version = 1,
		Duration = {
			3628800
		},
		ExtraParam = {
			80228
		},
		Desc = getI18NValue(180268857)
	},
	[60002020] = {
		OneOnly = false,
		ActivityType = 18,
		OpenAction = 9,
		Id = 60002020,
		OpenTimeType = 3,
		Duration = {
			-1
		},
		ExtraParam = {
			11,
			2,
			1,
			11,
			2,
			2
		},
		Desc = getI18NValue(180153903),
		OpenActionParams = {
			11,
			2,
			1
		}
	},
	[60002021] = {
		OneOnly = false,
		ActivityType = 18,
		OpenAction = 9,
		Id = 60002021,
		OpenTimeType = 3,
		Duration = {
			-1
		},
		ExtraParam = {
			11,
			4,
			1,
			11,
			4,
			2
		},
		Desc = getI18NValue(180153904),
		OpenActionParams = {
			11,
			4,
			1
		},
		ConditionIds = {
			30000030
		}
	},
	[60002030] = {
		OpenAction = 9,
		OneOnly = false,
		Id = 60002030,
		ActivityType = 19,
		ExtraParam = {
			11,
			3,
			1,
			11,
			3,
			2
		},
		Desc = getI18NValue(180153905),
		OpenActionParams = {
			11,
			3,
			1
		}
	},
	[60003001] = {
		Id = 60003001,
		OpenTime = "2025/2/20 0:00",
		OpenTimeType = 2,
		OpenAction = 15,
		ActivityType = 4,
		CloseAction = 16,
		OneOnly = false,
		version = 1,
		Duration = {
			1900800
		},
		Desc = getI18NValue(180129572),
		OpenActionParams = {
			60003001,
			50300301
		},
		CloseActionParams = {
			60003001,
			50300301
		}
	},
	[60003002] = {
		Id = 60003002,
		OpenTime = "2025/2/20 0:00",
		OpenTimeType = 2,
		OpenAction = 15,
		ActivityType = 4,
		CloseAction = 16,
		OneOnly = false,
		version = 1,
		Duration = {
			1900800
		},
		Desc = getI18NValue(180129573),
		OpenActionParams = {
			60003002,
			50300302
		},
		CloseActionParams = {
			60003002,
			50300302
		}
	},
	[60003003] = {
		Id = 60003003,
		OpenTime = "2025/3/14 4:00",
		OpenTimeType = 2,
		OpenAction = 15,
		ActivityType = 4,
		CloseAction = 16,
		OneOnly = false,
		version = 1,
		Duration = {
			1814400
		},
		Desc = getI18NValue(180129574),
		OpenActionParams = {
			60003003,
			50300303
		},
		CloseActionParams = {
			60003003,
			50300303
		}
	},
	[60003004] = {
		Id = 60003004,
		OpenTime = "2025/3/14 4:00",
		OpenTimeType = 2,
		OpenAction = 15,
		ActivityType = 4,
		CloseAction = 16,
		OneOnly = false,
		version = 1,
		Duration = {
			1814400
		},
		Desc = getI18NValue(180129575),
		OpenActionParams = {
			60003004,
			50300304
		},
		CloseActionParams = {
			60003004,
			50300304
		}
	},
	[60003005] = {
		Id = 60003005,
		OpenTime = "2025/3/14 4:00",
		OpenTimeType = 2,
		OpenAction = 15,
		ActivityType = 4,
		CloseAction = 16,
		OneOnly = false,
		version = 1,
		Duration = {
			1814400
		},
		Desc = getI18NValue(180146179),
		OpenActionParams = {
			60003005,
			50300305
		},
		CloseActionParams = {
			60003005,
			50300305
		}
	},
	[60003006] = {
		Id = 60003006,
		OpenTime = "2025/4/9 4:00",
		OpenTimeType = 2,
		OpenAction = 15,
		ActivityType = 4,
		CloseAction = 16,
		OneOnly = false,
		version = 1,
		Duration = {
			1814400
		},
		Desc = getI18NValue(180264382),
		OpenActionParams = {
			60003006,
			50300306
		},
		CloseActionParams = {
			60003006,
			50300306
		}
	},
	[60003007] = {
		Id = 60003007,
		OpenTime = "2025/4/9 4:00",
		OpenTimeType = 2,
		OpenAction = 15,
		ActivityType = 4,
		CloseAction = 16,
		OneOnly = false,
		version = 1,
		Duration = {
			1814400
		},
		Desc = getI18NValue(180264383),
		OpenActionParams = {
			60003007,
			50300307
		},
		CloseActionParams = {
			60003007,
			50300307
		}
	},
	[60003011] = {
		Id = 60003011,
		OpenTime = "2025/2/20 0:00",
		OpenTimeType = 2,
		OpenAction = 15,
		ActivityType = 4,
		CloseAction = 16,
		OneOnly = false,
		version = 1,
		Duration = {
			1900800
		},
		Desc = getI18NValue(180146181),
		OpenActionParams = {
			60003011,
			50300101
		},
		CloseActionParams = {
			60003011,
			50300101
		}
	},
	[60003012] = {
		Id = 60003012,
		OpenTime = "2025/2/20 0:00",
		OpenTimeType = 2,
		OpenAction = 15,
		ActivityType = 4,
		CloseAction = 16,
		OneOnly = false,
		version = 1,
		Duration = {
			1900800
		},
		Desc = getI18NValue(180146182),
		OpenActionParams = {
			60003012,
			50300102
		},
		CloseActionParams = {
			60003012,
			50300102
		}
	},
	[60003013] = {
		OneOnly = false,
		OpenTime = "2025/3/14 4:00",
		ActivityType = 4,
		CloseAction = 16,
		OpenAction = 15,
		Id = 60003013,
		OpenTimeType = 2,
		Duration = {
			1814400
		},
		Desc = getI18NValue(180146183),
		OpenActionParams = {
			60003013,
			50300103
		},
		CloseActionParams = {
			60003013,
			50300103
		}
	},
	[60003014] = {
		OneOnly = false,
		OpenTime = "2025/3/14 4:00",
		ActivityType = 4,
		CloseAction = 16,
		OpenAction = 15,
		Id = 60003014,
		OpenTimeType = 2,
		Duration = {
			1814400
		},
		Desc = getI18NValue(180146184),
		OpenActionParams = {
			60003014,
			50300104
		},
		CloseActionParams = {
			60003014,
			50300104
		}
	},
	[60003015] = {
		OneOnly = false,
		OpenTime = "2025/4/9 4:00",
		ActivityType = 4,
		CloseAction = 16,
		OpenAction = 15,
		Id = 60003015,
		OpenTimeType = 2,
		Duration = {
			1814400
		},
		Desc = getI18NValue(180169213),
		OpenActionParams = {
			60003015,
			50300105
		},
		CloseActionParams = {
			60003015,
			50300105
		}
	},
	[60003016] = {
		OneOnly = false,
		OpenTime = "2025/4/9 4:00",
		ActivityType = 4,
		CloseAction = 16,
		OpenAction = 15,
		Id = 60003016,
		OpenTimeType = 2,
		Duration = {
			1814400
		},
		Desc = getI18NValue(180169214),
		OpenActionParams = {
			60003016,
			50300106
		},
		CloseActionParams = {
			60003016,
			50300106
		}
	},
	[60003017] = {
		OneOnly = false,
		OpenTime = "2025/5/7 12:00",
		ActivityType = 4,
		CloseAction = 16,
		OpenAction = 15,
		Id = 60003017,
		OpenTimeType = 2,
		Duration = {
			1785600
		},
		Desc = getI18NValue(180183837),
		OpenActionParams = {
			60003017,
			50300107
		},
		CloseActionParams = {
			60003017,
			50300107
		}
	},
	[60003018] = {
		OneOnly = false,
		OpenTime = "2025/5/7 12:00",
		ActivityType = 4,
		CloseAction = 16,
		OpenAction = 15,
		Id = 60003018,
		OpenTimeType = 2,
		Duration = {
			1785600
		},
		Desc = getI18NValue(180183838),
		OpenActionParams = {
			60003018,
			50300108
		},
		CloseActionParams = {
			60003018,
			50300108
		}
	},
	[60003019] = {
		OneOnly = false,
		OpenTime = "2025/5/28 12:00",
		ActivityType = 4,
		CloseAction = 16,
		OpenAction = 15,
		Id = 60003019,
		OpenTimeType = 2,
		Duration = {
			1785600
		},
		Desc = getI18NValue(180268638),
		OpenActionParams = {
			60003019,
			50300109
		},
		CloseActionParams = {
			60003019,
			50300109
		}
	},
	[60003020] = {
		OneOnly = false,
		OpenTime = "2025/5/28 12:00",
		ActivityType = 4,
		CloseAction = 16,
		OpenAction = 15,
		Id = 60003020,
		OpenTimeType = 2,
		Duration = {
			1785600
		},
		Desc = getI18NValue(180268639),
		OpenActionParams = {
			60003020,
			50300110
		},
		CloseActionParams = {
			60003020,
			50300110
		}
	},
	[60003101] = {
		ActivityType = 21,
		OpenTime = "2024/6/18 4:00",
		OneOnly = false,
		Id = 60003101,
		OpenTimeType = 2,
		Duration = {
			604800
		},
		ExtraParam = {
			0,
			1,
			0,
			60003012
		},
		Desc = getI18NValue(180153906)
	},
	[60003102] = {
		ActivityType = 21,
		OpenTime = "2024/6/27 4:00",
		OneOnly = false,
		Id = 60003102,
		OpenTimeType = 2,
		Duration = {
			604800
		},
		ExtraParam = {
			0,
			1,
			0,
			60003014
		},
		Desc = getI18NValue(180154220)
	},
	[60003103] = {
		ActivityType = 21,
		OpenTime = "2024/7/18 4:00",
		OneOnly = false,
		Id = 60003103,
		OpenTimeType = 2,
		Duration = {
			604800
		},
		ExtraParam = {
			0,
			1,
			0,
			60003016
		},
		Desc = getI18NValue(180169215)
	},
	[60003104] = {
		ActivityType = 21,
		OpenTime = "2024/8/8 4:00",
		OneOnly = false,
		Id = 60003104,
		OpenTimeType = 2,
		Duration = {
			604800
		},
		ExtraParam = {
			0,
			1,
			0,
			60003018
		},
		Desc = getI18NValue(180183839)
	},
	[60004012] = {
		Id = 60004012,
		OpenTime = "2025/1/12 10:00",
		OpenTimeType = 2,
		OpenAction = 18,
		ActivityType = 15,
		OneOnly = false,
		version = 3,
		Duration = {
			604800
		},
		Desc = getI18NValue(180220894),
		OpenActionParams = {
			31120001
		}
	},
	[60005001] = {
		OpenTime = "2025/3/5 4:00",
		ActivityType = 12,
		OneOnly = false,
		Id = 60005001,
		OpenTimeType = 2,
		Duration = {
			172800
		},
		ExtraParam = {
			6,
			3,
			2,
			1
		},
		Desc = getI18NValue(180129581),
		Source = {
			11202100
		}
	},
	[60005011] = {
		OpenTime = "2025/3/7 4:00",
		ActivityType = 12,
		OneOnly = false,
		Id = 60005011,
		OpenTimeType = 2,
		Duration = {
			172800
		},
		ExtraParam = {
			6,
			3,
			2,
			2
		},
		Desc = getI18NValue(180146537),
		Source = {
			11202200
		}
	},
	[60005021] = {
		OpenTime = "2025/3/10 4:00",
		ActivityType = 12,
		OneOnly = false,
		Id = 60005021,
		OpenTimeType = 2,
		Duration = {
			259200
		},
		ExtraParam = {
			9,
			3,
			2,
			7
		},
		Desc = getI18NValue(180260974),
		Source = {
			11202200
		}
	},
	[60005081] = {
		OpenTime = "2024/1/7 4:00",
		ActivityType = 11,
		OneOnly = false,
		Id = 60005081,
		OpenTimeType = 2,
		Duration = {
			604800
		},
		ExtraParam = {
			18,
			3,
			2,
			9
		},
		Desc = getI18NValue(180146538),
		Source = {
			11203000
		}
	},
	[60005082] = {
		OpenTime = "2024/1/7 4:00",
		ActivityType = 11,
		OneOnly = false,
		Id = 60005082,
		OpenTimeType = 2,
		Duration = {
			604800
		},
		ExtraParam = {
			15,
			3,
			2,
			9
		},
		Desc = getI18NValue(180184058),
		Source = {
			11203000
		}
	},
	[60006001] = {
		ActivityType = 14,
		OpenTime = "2025/4/2 4:00",
		OneOnly = false,
		Id = 60006001,
		OpenTimeType = 2,
		Duration = {
			1209600
		},
		Desc = getI18NValue(180264323)
	},
	[60007001] = {
		OpenTime = "2024/6/24 4:00",
		ActivityType = 20,
		OpenAction = 9,
		OneOnly = false,
		Id = 60007001,
		OpenTimeType = 2,
		Duration = {
			1209600
		},
		ExtraParam = {
			6,
			31200101,
			12,
			31200102,
			18,
			31200103,
			24,
			31200104,
			30,
			31200105
		},
		Desc = getI18NValue(180146539),
		OpenActionParams = {
			11,
			5
		}
	},
	[60007002] = {
		ActivityType = 29,
		OpenTime = "2025/4/30 4:00",
		OneOnly = false,
		Id = 60007002,
		OpenTimeType = 2,
		Duration = {
			604800
		},
		ExtraParam = {
			203,
			1
		},
		Desc = getI18NValue(180267594)
	},
	[60008000] = {
		OpenTime = "2025/5/28 4:00",
		ActivityType = 22,
		OpenAction = 9,
		CloseAction = 27,
		OneOnly = false,
		Id = 60008000,
		OpenTimeType = 2,
		Duration = {
			0,
			0,
			691200,
			1814400,
			259200
		},
		ExtraParam = {
			12,
			0,
			13
		},
		Desc = getI18NValue(180167459),
		OpenActionParams = {
			11,
			6,
			4
		},
		CloseActionParams = {
			11,
			6,
			4
		}
	},
	[60008001] = {
		OpenTime = "2025/5/28 4:00",
		ActivityType = 23,
		OpenAction = 9,
		CloseAction = 27,
		OneOnly = false,
		Id = 60008001,
		OpenTimeType = 2,
		Duration = {
			2678400
		},
		ExtraParam = {
			11,
			6,
			1
		},
		Desc = getI18NValue(180169784),
		OpenActionParams = {
			11,
			6,
			1
		},
		CloseActionParams = {
			11,
			6,
			1
		}
	},
	[60008005] = {
		OpenTime = "2024/8/8 4:00",
		ActivityType = 23,
		OpenAction = 9,
		CloseAction = 27,
		OneOnly = false,
		Id = 60008005,
		OpenTimeType = 2,
		Duration = {
			1209600
		},
		ExtraParam = {
			11,
			5,
			1
		},
		Desc = getI18NValue(180184059),
		OpenActionParams = {
			11,
			5,
			1
		},
		CloseActionParams = {
			11,
			5,
			1
		}
	},
	[60008010] = {
		Id = 60008010,
		OpenTime = "2025/5/8 4:00",
		OpenTimeType = 2,
		ActivityType = 24,
		OneOnly = false,
		version = 1,
		Duration = {
			0,
			1209600
		},
		ExtraParam = {
			0,
			0,
			14
		},
		Desc = getI18NValue(180184016)
	},
	[60008011] = {
		Id = 60008011,
		OpenTime = "2025/5/8 4:00",
		OpenTimeType = 2,
		ActivityType = 25,
		OpenAction = 9,
		CloseAction = 27,
		OneOnly = false,
		version = 1,
		Duration = {
			0,
			604800,
			604800
		},
		ExtraParam = {
			13,
			101,
			16
		},
		Desc = getI18NValue(180186465),
		OpenActionParams = {
			101
		},
		CloseActionParams = {
			101
		}
	},
	[60008012] = {
		Id = 60008012,
		OpenTime = "2025/5/8 4:00",
		OpenTimeType = 2,
		ActivityType = 26,
		OpenAction = 9,
		CloseAction = 27,
		OneOnly = false,
		version = 1,
		Duration = {
			1209600
		},
		ExtraParam = {
			3,
			102
		},
		Desc = getI18NValue(180193741),
		OpenActionParams = {
			102
		},
		CloseActionParams = {
			102
		}
	},
	[60008013] = {
		Id = 60008013,
		OpenTime = "2025/3/14 4:00",
		OpenTimeType = 2,
		ActivityType = 22,
		OpenAction = 9,
		CloseAction = 27,
		OneOnly = false,
		version = 3,
		Duration = {
			0,
			604800,
			604800,
			1209600,
			345600
		},
		ExtraParam = {
			12,
			0,
			403
		},
		Desc = getI18NValue(180261285),
		OpenActionParams = {
			11,
			6,
			2
		},
		CloseActionParams = {
			11,
			6,
			2
		}
	},
	[60008014] = {
		OpenTime = "2025/3/14 4:00",
		ActivityType = 23,
		OpenAction = 9,
		CloseAction = 27,
		OneOnly = false,
		Id = 60008014,
		OpenTimeType = 2,
		Duration = {
			2419200
		},
		ExtraParam = {
			11,
			6,
			3
		},
		Desc = getI18NValue(180261286),
		OpenActionParams = {
			11,
			6,
			3
		},
		CloseActionParams = {
			11,
			6,
			3
		}
	},
	[60009001] = {
		Id = 60009001,
		OpenTime = "2025/2/21 4:00",
		OpenTimeType = 2,
		ActivityType = 13,
		OpenAction = 30,
		CloseAction = 31,
		OneOnly = true,
		version = 4,
		Duration = {
			5184000,
			604800
		},
		ExtraParam = {
			21,
			3,
			1301,
			1302,
			1303
		},
		Desc = getI18NValue(180195918),
		OpenActionParams = {
			1,
			1,
			2,
			3
		},
		CloseActionParams = {
			1
		},
		ConditionIds = {
			30000208,
			30300303
		}
	},
	[60009002] = {
		Id = 60009002,
		OpenTime = "2025/4/30 4:00",
		OpenTimeType = 2,
		ActivityType = 13,
		OpenAction = 30,
		CloseAction = 31,
		OneOnly = true,
		version = 1,
		Duration = {
			20736000,
			2419200
		},
		ExtraParam = {
			21,
			3,
			1301,
			1302,
			1303
		},
		Desc = getI18NValue(180267595),
		OpenActionParams = {
			2,
			1,
			2,
			3
		},
		CloseActionParams = {
			1
		},
		ConditionIds = {
			30000208,
			30300303
		}
	},
	[60010001] = {
		OpenTime = "22:00:00",
		Id = 60010001,
		Remote = true,
		ActivityType = 27,
		OneOnly = true,
		OpenTimeType = 1,
		OpenTimeParam = {
			7
		},
		Duration = {
			604740,
			60
		},
		Desc = getI18NValue(180231763)
	}
}

setmetatable(CfgActivityTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgActivityTable]")
	end
})

local defaultMetaTable = {
	__index = {
		OpenAction = 0,
		OpenTime = "",
		CloseAction = 0,
		OneOnly = false,
		OpenTimeType = 0,
		Desc = "",
		ResetType = 0,
		Remote = false,
		ActivityType = 0,
		version = 0,
		OpenTimeParam = {},
		ConditionIds = {},
		Duration = {},
		CloseActionParams = {},
		Source = {},
		OpenActionParams = {},
		ExtraParam = {}
	}
}

for i, data in pairs(CfgActivityTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgActivityTable
