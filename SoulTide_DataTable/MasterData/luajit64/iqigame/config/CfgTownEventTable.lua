-- chunkname: @IQIGame\\Config\\CfgTownEventTable.lua

local CfgTownEventTable = {
	[100] = {
		IsEnd = 1,
		AreaId = 10010,
		TownSpine = 1013,
		DialogId = 10101110,
		Reward = 12000001,
		Id = 100,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132119),
		Weight = {
			15
		},
		PriorWeight = {
			1500
		}
	},
	[101101] = {
		IsEnd = 1,
		AreaId = 10010,
		Redirect = 101102,
		DialogId = 10101110,
		Id = 101101,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000010
		},
		Name = getI18NValue(180132120),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[101102] = {
		IsEnd = 1,
		AreaId = 10010,
		Redirect = 101103,
		DialogId = 10101110,
		Id = 101102,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000020
		},
		Name = getI18NValue(180132121),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[101103] = {
		IsEnd = 1,
		AreaId = 10010,
		TownSpine = 1013,
		DialogId = 10101110,
		Reward = 12000001,
		Id = 101103,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			0
		},
		Name = getI18NValue(180132122),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[102101] = {
		TotalTimeLimit = 10,
		AreaId = 10010,
		Id = 102101,
		DialogId = 10101110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 102102,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132123),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[102102] = {
		TotalTimeLimit = 20,
		AreaId = 10010,
		Id = 102102,
		DialogId = 10101110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 102103,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132124),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[102103] = {
		IsEnd = 1,
		AreaId = 10010,
		TownSpine = 1013,
		DialogId = 10101110,
		Reward = 12000001,
		Id = 102103,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132125),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[102201] = {
		TotalTimeLimit = 10,
		AreaId = 10010,
		Id = 102201,
		DialogId = 10101110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 102202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132126),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[102202] = {
		TotalTimeLimit = 20,
		AreaId = 10010,
		Id = 102202,
		DialogId = 10101110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 102203,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132127),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[102203] = {
		IsEnd = 1,
		AreaId = 10010,
		TownSpine = 1013,
		DialogId = 10101110,
		Reward = 12000001,
		Id = 102203,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132128),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[102301] = {
		TotalTimeLimit = 10,
		AreaId = 10010,
		Id = 102301,
		DialogId = 10101110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 102302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132129),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[102302] = {
		TotalTimeLimit = 20,
		AreaId = 10010,
		Id = 102302,
		DialogId = 10101110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 102303,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132130),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[102303] = {
		IsEnd = 1,
		AreaId = 10010,
		TownSpine = 1013,
		DialogId = 10101110,
		Reward = 12000001,
		Id = 102303,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132131),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[103101] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101110,
		Condition = 26042000,
		Reward = 12000001,
		Join = 1,
		Id = 103101,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132132),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103102] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101140,
		Id = 103102,
		Condition = 26042000,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950270,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132133),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103103] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101170,
		Condition = 26042000,
		Reward = 12000001,
		Join = 1,
		Id = 103103,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132134),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103104] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101200,
		Condition = 26042000,
		Reward = 12000001,
		Join = 1,
		Id = 103104,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132135),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103105] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101230,
		Id = 103105,
		Condition = 26042000,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132136),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103151] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101590,
		Id = 103151,
		Condition = 26042000,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950040,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132137),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103152] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101710,
		Id = 103152,
		Condition = 26042000,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950240,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132138),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103153] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101830,
		Condition = 26042000,
		Reward = 12000001,
		Join = 1,
		Id = 103153,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132139),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103154] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101950,
		Id = 103154,
		Condition = 26042000,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132140),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103155] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10102070,
		Id = 103155,
		Condition = 26042000,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950230,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132141),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103201] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101260,
		Condition = 26042001,
		Reward = 12000001,
		Join = 1,
		Id = 103201,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132142),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103202] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101290,
		Condition = 26042001,
		Reward = 12000001,
		Join = 1,
		Id = 103202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132143),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103203] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101320,
		Condition = 26042001,
		Reward = 12000001,
		Join = 1,
		Id = 103203,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132144),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103251] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101620,
		Id = 103251,
		Condition = 26042001,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950040,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132145),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103252] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101740,
		Id = 103252,
		Condition = 26042001,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950240,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132146),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103253] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101860,
		Condition = 26042001,
		Reward = 12000001,
		Join = 1,
		Id = 103253,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132147),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103254] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101980,
		Id = 103254,
		Condition = 26042001,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132148),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103255] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10102100,
		Id = 103255,
		Condition = 26042001,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950230,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132149),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103301] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101350,
		Id = 103301,
		Condition = 26042002,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950150,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132150),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103302] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101380,
		Condition = 26042002,
		Reward = 12000001,
		Join = 1,
		Id = 103302,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132151),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103303] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101410,
		Id = 103303,
		Condition = 26042002,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950030,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132152),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103304] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101440,
		Condition = 26042002,
		Reward = 12000001,
		Join = 1,
		Id = 103304,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132153),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103305] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101470,
		Condition = 26042002,
		Reward = 12000001,
		Join = 1,
		Id = 103305,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132154),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103351] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101650,
		Id = 103351,
		Condition = 26042002,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950040,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132155),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103352] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101770,
		Id = 103352,
		Condition = 26042002,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950240,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132156),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103353] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101890,
		Condition = 26042002,
		Reward = 12000001,
		Join = 1,
		Id = 103353,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132157),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103354] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10102010,
		Id = 103354,
		Condition = 26042002,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132158),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103355] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10102130,
		Id = 103355,
		Condition = 26042002,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950230,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132159),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103401] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101500,
		Condition = 26042003,
		Reward = 12000001,
		Join = 1,
		Id = 103401,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132160),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103402] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101530,
		Id = 103402,
		Condition = 26042003,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950030,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132161),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103403] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101560,
		Id = 103403,
		Condition = 26042003,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950230,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132162),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[103451] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101680,
		Id = 103451,
		Condition = 26042003,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950040,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132163),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103452] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101800,
		Id = 103452,
		Condition = 26042003,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950240,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132164),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103453] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101920,
		Condition = 26042003,
		Reward = 12000001,
		Join = 1,
		Id = 103453,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132165),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103454] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10102040,
		Id = 103454,
		Condition = 26042003,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132166),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103455] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10102160,
		Id = 103455,
		Condition = 26042003,
		Reward = 12000001,
		Join = 1,
		TownSpine = 950230,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132167),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[103501] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106000,
		Id = 103501,
		Condition = 26042020,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 2013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132168),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103502] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106030,
		Id = 103502,
		Condition = 26042030,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 3013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132169),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103503] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106060,
		Id = 103503,
		Condition = 26042040,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 4013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132170),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103504] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106090,
		Id = 103504,
		Condition = 26042050,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 5013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132171),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103505] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106120,
		Id = 103505,
		Condition = 26042060,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 6013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132172),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103506] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106150,
		Id = 103506,
		Condition = 26042082,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 8013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132173),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103507] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106180,
		Id = 103507,
		Condition = 26042122,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 12013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132174),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103508] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 108021190,
		Id = 103508,
		Condition = 26042201,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 20013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132175),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103509] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 108021270,
		Id = 103509,
		Condition = 26042170,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 17013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132176),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103510] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 108021560,
		Id = 103510,
		Condition = 26042182,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 18013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132177),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103511] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 108021720,
		Id = 103511,
		Condition = 26042220,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 22013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132178),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103512] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106240,
		Id = 103512,
		Condition = 26042150,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 15013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132179),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103513] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106210,
		Id = 103513,
		Condition = 26042140,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 14013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132180),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103514] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106265,
		Id = 103514,
		Condition = 26042242,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 24013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180245214),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103515] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106300,
		Id = 103515,
		Condition = 26042272,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 27013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180274260),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103516] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106320,
		Id = 103516,
		Condition = 26042271,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 27013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180274261),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103517] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106340,
		Id = 103517,
		Condition = 26042280,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 28013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180299671),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103518] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106400,
		Id = 103518,
		Condition = 26042332,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 33013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180533709),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103519] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106440,
		Id = 103519,
		Condition = 26042340,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 34013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180545087),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103520] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106480,
		Id = 103520,
		Condition = 26042350,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 35013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180773002),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103521] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106550,
		Id = 103521,
		Condition = 26042360,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 36013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180773003),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103522] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106600,
		Id = 103522,
		Condition = 26042381,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 38013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180823401),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103523] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106640,
		Id = 103523,
		Condition = 26042410,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 41013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180844877),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103524] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106690,
		Id = 103524,
		Condition = 26042423,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 42013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180875441),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103525] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106740,
		Id = 103525,
		Condition = 26042430,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 43013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180881403),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103526] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106800,
		Id = 103526,
		Condition = 26042440,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 44013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180901582),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103527] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106850,
		Id = 103527,
		Condition = 26042450,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 45013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180912728),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103528] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106900,
		Id = 103528,
		Condition = 26042470,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 46013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180918413),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103529] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10106950,
		Id = 103529,
		Condition = 26042480,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 48013,
		RecordsInArchives = true,
		Type = {
			2,
			1
		},
		Name = getI18NValue(180950078),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[103601] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10104000,
		Id = 103601,
		Condition = 26042456,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950310,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132181),
		Weight = {
			210
		},
		PriorWeight = {
			21000
		}
	},
	[103602] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10104030,
		Id = 103602,
		Condition = 26042458,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 900010,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132182),
		Weight = {
			210
		},
		PriorWeight = {
			21000
		}
	},
	[103603] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10104060,
		Id = 103603,
		Condition = 26042458,
		Reward = 12000001,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 900020,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132183),
		Weight = {
			210
		},
		PriorWeight = {
			21000
		}
	},
	[103604] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10104090,
		Condition = 26042000,
		Join = 1,
		DayTimeLimit = 1,
		Reward = 12000001,
		Id = 103604,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132184),
		TownAreaPros = {
			150,
			150
		},
		PreEvent = {
			20000604
		},
		Weight = {
			210
		},
		PriorWeight = {
			21000
		}
	},
	[104101] = {
		TotalTimeLimit = 50,
		AreaId = 10010,
		Id = 104101,
		DialogId = 10101110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 104102,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132185),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[104102] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		Id = 104102,
		DialogId = 10101110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 104101,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132186),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[104201] = {
		TotalTimeLimit = 17,
		AreaId = 10010,
		Id = 104201,
		DialogId = 10101110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 104202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132187),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[104202] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		Id = 104202,
		DialogId = 10101110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 104201,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132188),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[104301] = {
		TotalTimeLimit = 20,
		AreaId = 10010,
		Id = 104301,
		DialogId = 10101110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 104302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132189),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[104302] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		Id = 104302,
		DialogId = 10101110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 104301,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132190),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[105101] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 105101,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132191),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[105102] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 105102,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132192),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[105103] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 105103,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132193),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[105201] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 105201,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132194),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[105202] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 105202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132195),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[105203] = {
		IsEnd = 1,
		AreaId = 10010,
		DialogId = 10101110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 105203,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132196),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[201101] = {
		IsEnd = 1,
		AreaId = 10020,
		Redirect = 201102,
		DialogId = 10201110,
		Id = 201101,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000010
		},
		Name = getI18NValue(180132197),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[201102] = {
		IsEnd = 1,
		AreaId = 10020,
		Redirect = 201103,
		DialogId = 10201110,
		Id = 201102,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000020
		},
		Name = getI18NValue(180132198),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[201103] = {
		IsEnd = 1,
		AreaId = 10020,
		TownSpine = 1013,
		DialogId = 10201110,
		Reward = 12000001,
		Id = 201103,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			0
		},
		Name = getI18NValue(180132199),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[202101] = {
		TotalTimeLimit = 10,
		AreaId = 10020,
		Id = 202101,
		DialogId = 10201110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 202102,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132200),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[202102] = {
		TotalTimeLimit = 20,
		AreaId = 10020,
		Id = 202102,
		DialogId = 10201110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 202103,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132201),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[202103] = {
		IsEnd = 1,
		AreaId = 10020,
		TownSpine = 1013,
		DialogId = 10201110,
		Reward = 12000001,
		Id = 202103,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132202),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[202201] = {
		TotalTimeLimit = 10,
		AreaId = 10020,
		Id = 202201,
		DialogId = 10201110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 202202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132203),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[202202] = {
		TotalTimeLimit = 20,
		AreaId = 10020,
		Id = 202202,
		DialogId = 10201110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 202203,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132204),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[202203] = {
		IsEnd = 1,
		AreaId = 10020,
		TownSpine = 1013,
		DialogId = 10201110,
		Reward = 12000001,
		Id = 202203,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132205),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[202301] = {
		TotalTimeLimit = 10,
		AreaId = 10020,
		Id = 202301,
		DialogId = 10201110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 202302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132206),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[202302] = {
		TotalTimeLimit = 20,
		AreaId = 10020,
		Id = 202302,
		DialogId = 10201110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 202303,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132207),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[202303] = {
		IsEnd = 1,
		AreaId = 10020,
		TownSpine = 1013,
		DialogId = 10201110,
		Reward = 12000001,
		Id = 202303,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132208),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[203101] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201110,
		Condition = 26042000,
		Reward = 12000002,
		Join = 1,
		Id = 203101,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132209),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203102] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201140,
		Condition = 26042000,
		Reward = 12000002,
		Join = 1,
		Id = 203102,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132210),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203103] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201170,
		Condition = 26042000,
		Reward = 12000002,
		Join = 1,
		Id = 203103,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132211),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203104] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201200,
		Condition = 26042000,
		Reward = 12000002,
		Join = 1,
		Id = 203104,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132212),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203105] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201230,
		Id = 203105,
		Condition = 26042000,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950130,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132213),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203151] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201590,
		Id = 203151,
		Condition = 26042000,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132214),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203152] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201710,
		Id = 203152,
		Condition = 26042000,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950010,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132215),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203153] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201830,
		Condition = 26042000,
		Reward = 12000002,
		Join = 1,
		Id = 203153,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132216),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[203154] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201950,
		Id = 203154,
		Condition = 26042000,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132217),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203155] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10202070,
		Condition = 26042000,
		Reward = 12000002,
		Join = 1,
		Id = 203155,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132218),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203201] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201260,
		Condition = 26042001,
		Reward = 12000002,
		Join = 1,
		Id = 203201,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132219),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203202] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201290,
		Id = 203202,
		Condition = 26042001,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950190,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132220),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203203] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201320,
		Condition = 26042001,
		Reward = 12000002,
		Join = 1,
		Id = 203203,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132221),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203251] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201620,
		Id = 203251,
		Condition = 26042001,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132222),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203252] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201740,
		Id = 203252,
		Condition = 26042001,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950010,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132223),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203253] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201860,
		Condition = 26042001,
		Reward = 12000002,
		Join = 1,
		Id = 203253,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132224),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[203254] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201980,
		Id = 203254,
		Condition = 26042001,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132225),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203255] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10202100,
		Condition = 26042001,
		Reward = 12000002,
		Join = 1,
		Id = 203255,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132226),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203301] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201350,
		Id = 203301,
		Condition = 26042002,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950020,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132227),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203302] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201380,
		Condition = 26042002,
		Reward = 12000002,
		Join = 1,
		Id = 203302,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132228),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203303] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201410,
		Id = 203303,
		Condition = 26042002,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950050,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132229),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203304] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201440,
		Condition = 26042002,
		Reward = 12000002,
		Join = 1,
		Id = 203304,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132230),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203305] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201470,
		Id = 203305,
		Condition = 26042002,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950190,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132231),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203351] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201650,
		Id = 203351,
		Condition = 26042002,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132232),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203352] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201770,
		Id = 203352,
		Condition = 26042002,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950010,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132233),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203353] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201890,
		Condition = 26042002,
		Reward = 12000002,
		Join = 1,
		Id = 203353,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132234),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[203354] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10202010,
		Id = 203354,
		Condition = 26042002,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132235),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203355] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10202130,
		Condition = 26042002,
		Reward = 12000002,
		Join = 1,
		Id = 203355,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132236),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203401] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201500,
		Id = 203401,
		Condition = 26042003,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950170,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132237),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203402] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201530,
		Condition = 26042003,
		Reward = 12000002,
		Join = 1,
		Id = 203402,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132238),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203403] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201560,
		Condition = 26042003,
		Reward = 12000002,
		Join = 1,
		Id = 203403,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132239),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[203451] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201680,
		Id = 203451,
		Condition = 26042003,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132240),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203452] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201800,
		Id = 203452,
		Condition = 26042003,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950010,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132241),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203453] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201920,
		Condition = 26042003,
		Reward = 12000002,
		Join = 1,
		Id = 203453,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132242),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[203454] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10202040,
		Id = 203454,
		Condition = 26042003,
		Reward = 12000002,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132243),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203455] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10202160,
		Condition = 26042003,
		Reward = 12000002,
		Join = 1,
		Id = 203455,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132244),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[203501] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206000,
		Id = 203501,
		Condition = 26042021,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 2013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132245),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203502] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206030,
		Condition = 26042030,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		Id = 203502,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132246),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203503] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206060,
		Id = 203503,
		Condition = 26042051,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 5013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132247),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203504] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206090,
		Id = 203504,
		Condition = 26042062,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 6013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132248),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203505] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206120,
		Id = 203505,
		Condition = 26042120,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 12013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132249),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203506] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 108021170,
		Id = 203506,
		Condition = 26042200,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 20013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132250),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203507] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 108021440,
		Id = 203507,
		Condition = 26042191,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 19013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132251),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203508] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 108021650,
		Id = 203508,
		Condition = 26042220,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 22013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132252),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203509] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206180,
		Id = 203509,
		Condition = 26042150,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 15013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132253),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203510] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10202190,
		Id = 203510,
		Condition = 26042110,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 11013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132254),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203511] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 102021120,
		Id = 203511,
		Condition = 26042213,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 21013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132255),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203512] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206150,
		Id = 203512,
		Condition = 26042130,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 13013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132256),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203513] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206380,
		Id = 203513,
		Condition = 26042252,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 25013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180146014),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203514] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206400,
		Id = 203514,
		Condition = 26042283,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 28013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180299672),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203515] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206420,
		Id = 203515,
		Condition = 26042290,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 29013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180443794),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203516] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206460,
		Id = 203516,
		Condition = 26042320,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 32013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180508946),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203517] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206500,
		Id = 203517,
		Condition = 26042332,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 33013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180533710),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203518] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206550,
		Id = 203518,
		Condition = 26042330,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 33013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180533711),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203519] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206590,
		Id = 203519,
		Condition = 26042340,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 34013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180545088),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203520] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206650,
		Id = 203520,
		Condition = 26042360,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 36013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180773004),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203521] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206700,
		Id = 203521,
		Condition = 26042382,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 38013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180823402),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203522] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206740,
		Id = 203522,
		Condition = 26042390,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 39013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180829026),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203523] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206800,
		Id = 203523,
		Condition = 26042410,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 41013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180844878),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203524] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206850,
		Id = 203524,
		Condition = 26042420,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 42013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180875450),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203525] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10206900,
		Id = 203525,
		Condition = 26042433,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 43013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180881404),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203526] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10207000,
		Id = 203526,
		Condition = 26042441,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 44013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180901583),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203527] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10207050,
		Id = 203527,
		Condition = 26042402,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 40013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180911420),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203528] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10207100,
		Id = 203528,
		Condition = 26042451,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 45013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180912729),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203529] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10207150,
		Id = 203529,
		Condition = 26042470,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 46013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180918414),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203530] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10207200,
		Id = 203530,
		Condition = 26042474,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 47013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180946232),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203601] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10204000,
		Id = 203601,
		Condition = 26042454,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950320,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132257),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203602] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10204030,
		Id = 203602,
		Condition = 26042000,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950300,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132258),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203603] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10204060,
		Id = 203603,
		Condition = 26042462,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 900010,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132259),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203604] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10204090,
		Id = 203604,
		Condition = 26042458,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 900020,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132260),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[203605] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10204120,
		Id = 203605,
		Condition = 26042002,
		Reward = 12000002,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950090,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132261),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[204101] = {
		TotalTimeLimit = 50,
		AreaId = 10020,
		Id = 204101,
		DialogId = 10201110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 204102,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132262),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[204102] = {
		TotalTimeLimit = 1,
		AreaId = 10020,
		Id = 204102,
		DialogId = 10201110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 204101,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132263),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[204201] = {
		TotalTimeLimit = 17,
		AreaId = 10020,
		Id = 204201,
		DialogId = 10201110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 204202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132264),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[204202] = {
		TotalTimeLimit = 1,
		AreaId = 10020,
		Id = 204202,
		DialogId = 10201110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 204201,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132265),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[204301] = {
		TotalTimeLimit = 20,
		AreaId = 10020,
		Id = 204301,
		DialogId = 10201110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 204302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132266),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[204302] = {
		TotalTimeLimit = 1,
		AreaId = 10020,
		Id = 204302,
		DialogId = 10201110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 204301,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132267),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[205101] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 205101,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132268),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[205102] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 205102,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132269),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[205103] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 205103,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132270),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[205201] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 205201,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132271),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[205202] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 205202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132272),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[205203] = {
		IsEnd = 1,
		AreaId = 10020,
		DialogId = 10201110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 205203,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132273),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[301101] = {
		IsEnd = 1,
		AreaId = 10030,
		Redirect = 301102,
		DialogId = 10301110,
		Id = 301101,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000010
		},
		Name = getI18NValue(180132274),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[301102] = {
		IsEnd = 1,
		AreaId = 10030,
		Redirect = 301103,
		DialogId = 10301110,
		Id = 301102,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000020
		},
		Name = getI18NValue(180132275),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[301103] = {
		IsEnd = 1,
		AreaId = 10030,
		TownSpine = 1013,
		DialogId = 10301110,
		Reward = 12000001,
		Id = 301103,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			0
		},
		Name = getI18NValue(180132276),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[302101] = {
		TotalTimeLimit = 10,
		AreaId = 10030,
		Id = 302101,
		DialogId = 10301110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 302102,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132277),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[302102] = {
		TotalTimeLimit = 20,
		AreaId = 10030,
		Id = 302102,
		DialogId = 10301110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 302103,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132278),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[302103] = {
		IsEnd = 1,
		AreaId = 10030,
		TownSpine = 1013,
		DialogId = 10301110,
		Reward = 12000001,
		Id = 302103,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132279),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[302201] = {
		TotalTimeLimit = 10,
		AreaId = 10030,
		Id = 302201,
		DialogId = 10301110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 302202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132280),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[302202] = {
		TotalTimeLimit = 20,
		AreaId = 10030,
		Id = 302202,
		DialogId = 10301110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 302203,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132281),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[302203] = {
		IsEnd = 1,
		AreaId = 10030,
		TownSpine = 1013,
		DialogId = 10301110,
		Reward = 12000001,
		Id = 302203,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132282),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[302301] = {
		TotalTimeLimit = 10,
		AreaId = 10030,
		Id = 302301,
		DialogId = 10301110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 302302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132283),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[302302] = {
		TotalTimeLimit = 20,
		AreaId = 10030,
		Id = 302302,
		DialogId = 10301110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 302303,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132284),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[302303] = {
		IsEnd = 1,
		AreaId = 10030,
		TownSpine = 1013,
		DialogId = 10301110,
		Reward = 12000001,
		Id = 302303,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132285),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[303101] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301110,
		Id = 303101,
		Condition = 26042000,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950290,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132286),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303102] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301140,
		Id = 303102,
		Condition = 26042000,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950280,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132287),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303103] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301170,
		Id = 303103,
		Condition = 26042000,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950280,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132288),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303104] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301200,
		Id = 303104,
		Condition = 26042000,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950190,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132289),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303105] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301230,
		Id = 303105,
		Condition = 26042000,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950070,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132290),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303151] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301590,
		Id = 303151,
		Condition = 26042000,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950070,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132291),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303152] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301710,
		Condition = 26042000,
		Reward = 12000003,
		Join = 1,
		Id = 303152,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132292),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303153] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301830,
		Id = 303153,
		Condition = 26042000,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950280,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132293),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303154] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301950,
		Id = 303154,
		Condition = 26042000,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950070,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132294),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303155] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10302070,
		Id = 303155,
		Condition = 26042000,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950280,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132295),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303201] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301260,
		Condition = 26042001,
		Reward = 12000003,
		Join = 1,
		Id = 303201,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132296),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303202] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301290,
		Condition = 26042001,
		Reward = 12000003,
		Join = 1,
		Id = 303202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132297),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303203] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301320,
		Condition = 26042001,
		Reward = 12000003,
		Join = 1,
		Id = 303203,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132298),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303251] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301620,
		Id = 303251,
		Condition = 26042001,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950070,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132299),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303252] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301740,
		Condition = 26042001,
		Reward = 12000003,
		Join = 1,
		Id = 303252,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132300),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303253] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301860,
		Id = 303253,
		Condition = 26042001,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950280,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132301),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303254] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301980,
		Id = 303254,
		Condition = 26042001,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950070,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132302),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303255] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10302100,
		Id = 303255,
		Condition = 26042001,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950280,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132303),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303301] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301350,
		Id = 303301,
		Condition = 26042002,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950030,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132304),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303302] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301380,
		Condition = 26042002,
		Reward = 12000003,
		Join = 1,
		Id = 303302,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132305),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303303] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301410,
		Condition = 26042002,
		Reward = 12000003,
		Join = 1,
		Id = 303303,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132306),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303304] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301440,
		Condition = 26042002,
		Reward = 12000003,
		Join = 1,
		Id = 303304,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132307),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303305] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301470,
		Condition = 26042002,
		Reward = 12000003,
		Join = 1,
		Id = 303305,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132308),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303351] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301650,
		Id = 303351,
		Condition = 26042002,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950070,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132309),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303352] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301770,
		Condition = 26042002,
		Reward = 12000003,
		Join = 1,
		Id = 303352,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132310),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303353] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301890,
		Id = 303353,
		Condition = 26042002,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950280,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132311),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303354] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10302010,
		Id = 303354,
		Condition = 26042002,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950070,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132312),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303355] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10302130,
		Id = 303355,
		Condition = 26042002,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950280,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132313),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303401] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301500,
		Condition = 26042003,
		Reward = 12000003,
		Join = 1,
		Id = 303401,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132314),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303402] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301530,
		Condition = 26042003,
		Reward = 12000003,
		Join = 1,
		Id = 303402,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132315),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303403] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301560,
		Condition = 26042003,
		Reward = 12000003,
		Join = 1,
		Id = 303403,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132316),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[303451] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301680,
		Id = 303451,
		Condition = 26042003,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950070,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132317),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303452] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301800,
		Condition = 26042003,
		Reward = 12000003,
		Join = 1,
		Id = 303452,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132318),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303453] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301920,
		Id = 303453,
		Condition = 26042003,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950280,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132319),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303454] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10302040,
		Id = 303454,
		Condition = 26042003,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950070,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132320),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303455] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10302160,
		Id = 303455,
		Condition = 26042003,
		Reward = 12000003,
		Join = 1,
		TownSpine = 950280,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132321),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[303501] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306000,
		Id = 303501,
		Condition = 26042010,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 1013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132322),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303502] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306030,
		Id = 303502,
		Condition = 26042022,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 2013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132323),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303503] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306060,
		Id = 303503,
		Condition = 26042072,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 7013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132324),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303504] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306090,
		Id = 303504,
		Condition = 26042082,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 8013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132325),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303505] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306120,
		Id = 303505,
		Condition = 26042090,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 9013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132326),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303506] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306150,
		Id = 303506,
		Condition = 26042092,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 9013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132327),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303507] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306180,
		Id = 303507,
		Condition = 26042121,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 12013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132328),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303508] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 108021250,
		Id = 303508,
		Condition = 26042203,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 20013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132329),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303509] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 108021510,
		Id = 303509,
		Condition = 26042193,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 19013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132330),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303510] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 108021600,
		Id = 303510,
		Condition = 26042181,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 18013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132331),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303511] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 108021700,
		Id = 303511,
		Condition = 26042220,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 22013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132332),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303512] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10302190,
		Id = 303512,
		Condition = 26042111,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 11013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132333),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303513] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 103021120,
		Id = 303513,
		Condition = 26042102,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 10013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132334),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303514] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 103021150,
		Id = 303514,
		Condition = 26042210,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 21013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132335),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303515] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306210,
		Id = 303515,
		Condition = 26042140,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 14013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132336),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303516] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306240,
		Id = 303516,
		Condition = 26042250,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 25013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180146015),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303517] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306280,
		Id = 303517,
		Condition = 26042161,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 16013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180146016),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303518] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306310,
		Id = 303518,
		Condition = 26042271,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 27013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180274262),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303519] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306330,
		Id = 303519,
		Condition = 26042282,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 28013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180299673),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303520] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306350,
		Id = 303520,
		Condition = 26042293,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 29013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180443795),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303521] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306380,
		Id = 303521,
		Condition = 26042303,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 30013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180467346),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303522] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306400,
		Id = 303522,
		Condition = 26042330,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 33013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180533712),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303523] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306440,
		Id = 303523,
		Condition = 26042343,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 34013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180545089),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303524] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306500,
		Id = 303524,
		Condition = 26042352,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 35013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180773005),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303525] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306560,
		Id = 303525,
		Condition = 26042372,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 37013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180781650),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303526] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306600,
		Id = 303526,
		Condition = 26042393,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 39013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180829027),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303527] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306660,
		Id = 303527,
		Condition = 26042431,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 43013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180881405),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303528] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306700,
		Id = 303528,
		Condition = 26042450,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 45013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180912730),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303529] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306750,
		Id = 303529,
		Condition = 26042470,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 46013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180918415),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303530] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306800,
		Id = 303530,
		Condition = 26042474,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 47013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180946233),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303531] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10306850,
		Id = 303531,
		Condition = 26042474,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 47013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180946234),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[303601] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10304000,
		Id = 303601,
		Condition = 26042454,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950320,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132337),
		Weight = {
			210
		},
		PriorWeight = {
			21000
		}
	},
	[303602] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10304030,
		Id = 303602,
		Condition = 26042456,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950310,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132338),
		Weight = {
			210
		},
		PriorWeight = {
			21000
		}
	},
	[303603] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10304060,
		Id = 303603,
		Condition = 26042461,
		Reward = 12000003,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 900010,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132339),
		Weight = {
			210
		},
		PriorWeight = {
			21000
		}
	},
	[303604] = {
		IsEnd = 1,
		AreaId = 10030,
		Join = 1,
		Redirect = 304102,
		DialogId = 10304090,
		Condition = 26042003,
		Id = 303604,
		DayTimeLimit = 1,
		Reward = 12000003,
		TownSpine = 950100,
		RecordsInArchives = true,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132340),
		Weight = {
			210
		},
		PriorWeight = {
			21000
		}
	},
	[304101] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		Id = 304101,
		DialogId = 10301110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 304101,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132341),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[304102] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		Id = 304102,
		DialogId = 10301110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 304101,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132342),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[304201] = {
		TotalTimeLimit = 17,
		AreaId = 10030,
		Id = 304201,
		DialogId = 10301110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 304202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132343),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[304202] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		Id = 304202,
		DialogId = 10301110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 304201,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132344),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[304301] = {
		TotalTimeLimit = 20,
		AreaId = 10030,
		Id = 304301,
		DialogId = 10301110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 304302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132345),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[304302] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		Id = 304302,
		DialogId = 10301110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 304301,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132346),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[305101] = {
		IsEnd = 1,
		AreaId = 10030,
		TownSpine = 1013,
		DialogId = 10301110,
		Reward = 12000001,
		Id = 305101,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132347),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[305102] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 305102,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132348),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[305103] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 305103,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132349),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[305201] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 305201,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132350),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[305202] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 305202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132351),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[305203] = {
		IsEnd = 1,
		AreaId = 10030,
		DialogId = 10301110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 305203,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132352),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[401101] = {
		IsEnd = 1,
		AreaId = 10040,
		Join = 1,
		Redirect = 401102,
		Condition = 26042005,
		DialogId = 10401110,
		Id = 401101,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000010
		},
		Name = getI18NValue(180132353),
		PreEvent = {
			403001
		},
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[401102] = {
		IsEnd = 1,
		AreaId = 10040,
		Redirect = 401103,
		DialogId = 10401110,
		Id = 401102,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000020
		},
		Name = getI18NValue(180132354),
		PreEvent = {
			403001
		},
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[401103] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401110,
		TownSpine = 1013,
		Reward = 12000001,
		Id = 401103,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			0
		},
		Name = getI18NValue(180132355),
		PreEvent = {
			403001
		},
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[402101] = {
		TotalTimeLimit = 10,
		AreaId = 10040,
		Join = 1,
		Redirect = 402102,
		Id = 402101,
		DialogId = 10401110,
		IsEnd = 1,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132356),
		PreEvent = {
			403001
		},
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[402102] = {
		TotalTimeLimit = 20,
		AreaId = 10040,
		Id = 402102,
		DialogId = 10401110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 402103,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132357),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[402103] = {
		IsEnd = 1,
		AreaId = 10040,
		TownSpine = 1013,
		DialogId = 10401110,
		Reward = 12000001,
		Id = 402103,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132358),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[402201] = {
		TotalTimeLimit = 10,
		AreaId = 10040,
		Join = 1,
		Redirect = 402202,
		Id = 402201,
		DialogId = 10401110,
		IsEnd = 1,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132359),
		PreEvent = {
			403001
		},
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[402202] = {
		TotalTimeLimit = 20,
		AreaId = 10040,
		Id = 402202,
		DialogId = 10401110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 402203,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132360),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[402203] = {
		IsEnd = 1,
		AreaId = 10040,
		TownSpine = 1013,
		DialogId = 10401110,
		Reward = 12000001,
		Id = 402203,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132361),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[402301] = {
		TotalTimeLimit = 10,
		AreaId = 10040,
		Join = 1,
		Redirect = 402302,
		Id = 402301,
		DialogId = 10401110,
		IsEnd = 1,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132362),
		PreEvent = {
			403001
		},
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[402302] = {
		TotalTimeLimit = 20,
		AreaId = 10040,
		Id = 402302,
		DialogId = 10401110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 402303,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132363),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[402303] = {
		IsEnd = 1,
		AreaId = 10040,
		TownSpine = 1013,
		DialogId = 10401110,
		Reward = 12000001,
		Id = 402303,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132364),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[403001] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		TownSpine = 1013,
		DialogId = 10401110,
		IsEnd = 1,
		Reward = 12000001,
		Id = 403001,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132365),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[403002] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		TownSpine = 1013,
		DialogId = 10401110,
		IsEnd = 1,
		Reward = 12000001,
		Id = 403002,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132366),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[403101] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401110,
		Id = 403101,
		Condition = 26042000,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950180,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132367),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403102] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401140,
		Condition = 26042000,
		Reward = 12000004,
		Join = 1,
		Id = 403102,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132368),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403103] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401170,
		Id = 403103,
		Condition = 26042000,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950150,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132369),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403104] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401200,
		Condition = 26042000,
		Reward = 12000004,
		Join = 1,
		Id = 403104,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132370),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403105] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401230,
		Id = 403105,
		Condition = 26042000,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950150,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132371),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403151] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401590,
		Id = 403151,
		Condition = 26042000,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950060,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132372),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403152] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401710,
		Condition = 26042000,
		Reward = 12000004,
		Join = 1,
		Id = 403152,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132373),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403153] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401830,
		Condition = 26042000,
		Reward = 12000004,
		Join = 1,
		Id = 403153,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132374),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403154] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401950,
		Id = 403154,
		Condition = 26042000,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132375),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403155] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10402070,
		Condition = 26042000,
		Reward = 12000004,
		Join = 1,
		Id = 403155,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132376),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403201] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401260,
		Id = 403201,
		Condition = 26042001,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950180,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132377),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403202] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401290,
		Condition = 26042001,
		Reward = 12000004,
		Join = 1,
		Id = 403202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132378),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403203] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401320,
		Condition = 26042001,
		Reward = 12000004,
		Join = 1,
		Id = 403203,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132379),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403251] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401620,
		Id = 403251,
		Condition = 26042001,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950060,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132380),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403252] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401740,
		Condition = 26042001,
		Reward = 12000004,
		Join = 1,
		Id = 403252,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132381),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403253] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401860,
		Condition = 26042001,
		Reward = 12000004,
		Join = 1,
		Id = 403253,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132382),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403254] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401980,
		Id = 403254,
		Condition = 26042001,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132383),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403255] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10402100,
		Condition = 26042001,
		Reward = 12000004,
		Join = 1,
		Id = 403255,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132384),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403301] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401350,
		Id = 403301,
		Condition = 26042002,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950180,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132385),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403302] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401380,
		Condition = 26042002,
		Reward = 12000004,
		Join = 1,
		Id = 403302,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132386),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403303] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401410,
		Id = 403303,
		Condition = 26042002,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950020,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132387),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403304] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401440,
		Condition = 26042002,
		Reward = 12000004,
		Join = 1,
		Id = 403304,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132388),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403305] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401470,
		Id = 403305,
		Condition = 26042002,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950010,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132389),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403351] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401650,
		Id = 403351,
		Condition = 26042002,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950060,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132390),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403352] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401770,
		Condition = 26042002,
		Reward = 12000004,
		Join = 1,
		Id = 403352,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132391),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403353] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401890,
		Condition = 26042002,
		Reward = 12000004,
		Join = 1,
		Id = 403353,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132392),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403354] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10402010,
		Id = 403354,
		Condition = 26042002,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132393),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403355] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10402130,
		Condition = 26042002,
		Reward = 12000004,
		Join = 1,
		Id = 403355,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132394),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403401] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401500,
		Id = 403401,
		Condition = 26042003,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950180,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132395),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403402] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401530,
		Condition = 26042003,
		Reward = 12000004,
		Join = 1,
		Id = 403402,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132396),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403403] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401560,
		Condition = 26042003,
		Reward = 12000004,
		Join = 1,
		Id = 403403,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132397),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[403451] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401680,
		Id = 403451,
		Condition = 26042003,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950060,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132398),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403452] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401800,
		Condition = 26042003,
		Reward = 12000004,
		Join = 1,
		Id = 403452,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132399),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403453] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401920,
		Condition = 26042003,
		Reward = 12000004,
		Join = 1,
		Id = 403453,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132400),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403454] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10402040,
		Id = 403454,
		Condition = 26042003,
		Reward = 12000004,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132401),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403455] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10402160,
		Condition = 26042003,
		Reward = 12000004,
		Join = 1,
		Id = 403455,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132402),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[403501] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406000,
		Id = 403501,
		Condition = 26042010,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 1013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132403),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403502] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406030,
		Id = 403502,
		Condition = 26042022,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 2013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132404),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403503] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406060,
		Condition = 26042030,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		Id = 403503,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132405),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403504] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406090,
		Id = 403504,
		Condition = 26042040,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 4013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132406),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403505] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406120,
		Id = 403505,
		Condition = 26042060,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 6013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132407),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403506] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406150,
		Id = 403506,
		Condition = 26042070,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 7013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132408),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403507] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406180,
		Id = 403507,
		Condition = 26042080,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 8013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132409),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403508] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406210,
		Id = 403508,
		Condition = 26042092,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 9013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132410),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403509] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 108021390,
		Id = 403509,
		Condition = 26042172,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 17013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132411),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403510] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 108021540,
		Id = 403510,
		Condition = 26042180,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 18013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132412),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403511] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406240,
		Id = 403511,
		Condition = 26042151,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 15013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132413),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403512] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406270,
		Id = 403512,
		Condition = 26042251,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 25013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180146017),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403513] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406300,
		Id = 403513,
		Condition = 26042160,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 16013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180146018),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403514] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406320,
		Id = 403514,
		Condition = 26042243,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 24013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180245215),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403515] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406350,
		Id = 403515,
		Condition = 26042280,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 28013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180299674),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403516] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406385,
		Id = 403516,
		Condition = 26042290,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 29013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180443796),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403517] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406410,
		Id = 403517,
		Condition = 26042311,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 31013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180498282),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403518] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406440,
		Id = 403518,
		Condition = 26042311,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 31013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180498283),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403519] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406470,
		Id = 403519,
		Condition = 26042310,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 31013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180498284),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403520] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406550,
		Id = 403520,
		Condition = 26042331,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 33013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180533713),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403521] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406590,
		Id = 403521,
		Condition = 26042340,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 34013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180545090),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403522] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406650,
		Id = 403522,
		Condition = 26042350,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 35013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180773006),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403523] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406700,
		Id = 403523,
		Condition = 26042360,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 36013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180773007),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403524] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406750,
		Id = 403524,
		Condition = 26042370,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 37013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180783073),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403525] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406800,
		Id = 403525,
		Condition = 26042382,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 38013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180823403),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403526] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406850,
		Id = 403526,
		Condition = 26042432,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 43013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180881406),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403527] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10406900,
		Id = 403527,
		Condition = 26042440,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 44013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180901584),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403528] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10407000,
		Id = 403528,
		Condition = 26042442,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 44013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180901585),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403529] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10407050,
		Id = 403529,
		Condition = 26042450,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 45013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180912731),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403530] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10407110,
		Id = 403530,
		Condition = 26042470,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 46013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180918416),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403531] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10407150,
		Id = 403531,
		Condition = 26042481,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 48013,
		RecordsInArchives = true,
		Type = {
			2,
			1
		},
		Name = getI18NValue(180950079),
		Weight = {
			45
		},
		PriorWeight = {
			4500
		}
	},
	[403601] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10404000,
		Id = 403601,
		Condition = 26042454,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950320,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132414),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[403602] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10404030,
		Id = 403602,
		Condition = 26042002,
		Reward = 12000004,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950300,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132415),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[403603] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10404060,
		Condition = 26042000,
		Join = 1,
		DayTimeLimit = 1,
		Reward = 12000004,
		Id = 403603,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132416),
		TownAreaPros = {
			150,
			150
		},
		PreEvent = {
			20000604
		},
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[404101] = {
		TotalTimeLimit = 50,
		AreaId = 10040,
		Redirect = 404102,
		Id = 404101,
		DialogId = 10401110,
		IsEnd = 1,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132417),
		PreEvent = {
			403001
		},
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[404102] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		Id = 404102,
		DialogId = 10401110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 404101,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132418),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[404201] = {
		TotalTimeLimit = 17,
		AreaId = 10040,
		Redirect = 404202,
		Id = 404201,
		DialogId = 10401110,
		IsEnd = 1,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132419),
		PreEvent = {
			403001
		},
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[404202] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		Id = 404202,
		DialogId = 10401110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 404201,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132420),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[404301] = {
		TotalTimeLimit = 20,
		AreaId = 10040,
		Redirect = 404302,
		Id = 404301,
		DialogId = 10401110,
		IsEnd = 1,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132421),
		PreEvent = {
			403001
		},
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[404302] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		Id = 404302,
		DialogId = 10401110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 404301,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132422),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[405101] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 405101,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132423),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[405102] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 405102,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132424),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[405103] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 405103,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132425),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[405201] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 405201,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132426),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[405202] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 405202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132427),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[405203] = {
		IsEnd = 1,
		AreaId = 10040,
		DialogId = 10401110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 405203,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132428),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[501101] = {
		IsEnd = 1,
		AreaId = 10050,
		Redirect = 501102,
		DialogId = 10601110,
		Id = 501101,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000010
		},
		Name = getI18NValue(180132429),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[501102] = {
		IsEnd = 1,
		AreaId = 10050,
		Redirect = 501103,
		DialogId = 10601110,
		Id = 501102,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000020
		},
		Name = getI18NValue(180132430),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[501103] = {
		IsEnd = 1,
		AreaId = 10050,
		TownSpine = 1013,
		DialogId = 10601110,
		Reward = 12000001,
		Id = 501103,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			0
		},
		Name = getI18NValue(180132431),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[502101] = {
		TotalTimeLimit = 10,
		AreaId = 10050,
		Id = 502101,
		DialogId = 10601110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 502102,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132432),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[502102] = {
		TotalTimeLimit = 20,
		AreaId = 10050,
		Id = 502102,
		DialogId = 10601110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 502103,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132433),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[502103] = {
		IsEnd = 1,
		AreaId = 10050,
		TownSpine = 1013,
		DialogId = 10601110,
		Reward = 12000001,
		Id = 502103,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132434),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[502201] = {
		TotalTimeLimit = 10,
		AreaId = 10050,
		Id = 502201,
		DialogId = 10601110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 502202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132435),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[502202] = {
		TotalTimeLimit = 20,
		AreaId = 10050,
		Id = 502202,
		DialogId = 10601110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 502203,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132436),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[502203] = {
		IsEnd = 1,
		AreaId = 10050,
		TownSpine = 1013,
		DialogId = 10601110,
		Reward = 12000001,
		Id = 502203,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132437),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[502301] = {
		TotalTimeLimit = 10,
		AreaId = 10050,
		Id = 502301,
		DialogId = 10601110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 502302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132438),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[502302] = {
		TotalTimeLimit = 20,
		AreaId = 10050,
		Id = 502302,
		DialogId = 10601110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 502303,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132439),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[502303] = {
		IsEnd = 1,
		AreaId = 10050,
		TownSpine = 1013,
		DialogId = 10601110,
		Reward = 12000001,
		Id = 502303,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132440),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[503101] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601110,
		Condition = 26042000,
		Reward = 12000005,
		Join = 1,
		Id = 503101,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132441),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503102] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601140,
		Id = 503102,
		Condition = 26042000,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950190,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132442),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503103] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601170,
		Id = 503103,
		Condition = 26042000,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950190,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132443),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503104] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601200,
		Id = 503104,
		Condition = 26042000,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950040,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132444),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503105] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601230,
		Id = 503105,
		Condition = 26042000,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950040,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132445),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503151] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601590,
		Condition = 26042000,
		Reward = 12000005,
		Join = 1,
		Id = 503151,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132446),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503152] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601710,
		Condition = 26042000,
		Reward = 12000005,
		Join = 1,
		Id = 503152,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132447),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503153] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601830,
		Condition = 26042000,
		Reward = 12000005,
		Join = 1,
		Id = 503153,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132448),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503154] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601950,
		Id = 503154,
		Condition = 26042000,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132449),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503155] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10602070,
		Id = 503155,
		Condition = 26042000,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950050,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132450),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503201] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601260,
		Id = 503201,
		Condition = 26042001,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950010,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132451),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503202] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601290,
		Condition = 26042001,
		Reward = 12000005,
		Join = 1,
		Id = 503202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132452),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503203] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601320,
		Id = 503203,
		Condition = 26042001,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950170,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132453),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503251] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601620,
		Condition = 26042001,
		Reward = 12000005,
		Join = 1,
		Id = 503251,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132454),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503252] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601740,
		Condition = 26042001,
		Reward = 12000005,
		Join = 1,
		Id = 503252,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132455),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503253] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601860,
		Condition = 26042001,
		Reward = 12000005,
		Join = 1,
		Id = 503253,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132456),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503254] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601980,
		Id = 503254,
		Condition = 26042001,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132457),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503255] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10602100,
		Id = 503255,
		Condition = 26042001,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950050,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132458),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503301] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601350,
		Condition = 26042002,
		Reward = 12000005,
		Join = 1,
		Id = 503301,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132459),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503302] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601380,
		Id = 503302,
		Condition = 26042002,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950070,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132460),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503303] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601410,
		Id = 503303,
		Condition = 26042002,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950030,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132461),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503304] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601440,
		Condition = 26042002,
		Reward = 12000005,
		Join = 1,
		Id = 503304,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132462),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503305] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601470,
		Id = 503305,
		Condition = 26042002,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950190,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132463),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503351] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601650,
		Condition = 26042002,
		Reward = 12000005,
		Join = 1,
		Id = 503351,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132464),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503352] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601770,
		Condition = 26042002,
		Reward = 12000005,
		Join = 1,
		Id = 503352,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132465),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503353] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601890,
		Condition = 26042002,
		Reward = 12000005,
		Join = 1,
		Id = 503353,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132466),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503354] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10602010,
		Id = 503354,
		Condition = 26042002,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132467),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503355] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10602130,
		Id = 503355,
		Condition = 26042002,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950050,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132468),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503401] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601500,
		Id = 503401,
		Condition = 26042003,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950030,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132469),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503402] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601530,
		Condition = 26042003,
		Reward = 12000005,
		Join = 1,
		Id = 503402,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132470),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503403] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601560,
		Condition = 26042003,
		Reward = 12000005,
		Join = 1,
		Id = 503403,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132471),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[503451] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601680,
		Condition = 26042003,
		Reward = 12000005,
		Join = 1,
		Id = 503451,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132472),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503452] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601800,
		Condition = 26042003,
		Reward = 12000005,
		Join = 1,
		Id = 503452,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132473),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503453] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601920,
		Condition = 26042003,
		Reward = 12000005,
		Join = 1,
		Id = 503453,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132474),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503454] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10602040,
		Id = 503454,
		Condition = 26042003,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132475),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503455] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10602160,
		Id = 503455,
		Condition = 26042003,
		Reward = 12000005,
		Join = 1,
		TownSpine = 950050,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132476),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[503501] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10606000,
		Id = 503501,
		Condition = 26042020,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 2013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132477),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503502] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10606030,
		Id = 503502,
		Condition = 26042052,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 5013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132478),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503503] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10606060,
		Id = 503503,
		Condition = 26042060,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 6013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132479),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503504] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10606090,
		Id = 503504,
		Condition = 26042070,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 7013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132480),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503505] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10606120,
		Id = 503505,
		Condition = 26042080,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 8013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132481),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503506] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 108021230,
		Id = 503506,
		Condition = 26042200,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 20013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132482),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503507] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 108021330,
		Id = 503507,
		Condition = 26042172,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 17013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132483),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503508] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 108021470,
		Id = 503508,
		Condition = 26042192,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 19013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132484),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503509] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 108021740,
		Id = 503509,
		Condition = 26042222,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 22013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132485),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503510] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10602190,
		Id = 503510,
		Condition = 26042113,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 11013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132486),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503511] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 106021120,
		Id = 503511,
		Condition = 26042100,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 10013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132487),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503512] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10606150,
		Id = 503512,
		Condition = 26042140,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 14013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132488),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503513] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10606190,
		Id = 503513,
		Condition = 26042250,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 25013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180146019),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503514] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10606210,
		Id = 503514,
		Condition = 26042240,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 24013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180245216),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503515] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10606240,
		Id = 503515,
		Condition = 26042232,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 23013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180266528),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503516] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10606270,
		Id = 503516,
		Condition = 26042292,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 29013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180443797),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503517] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10606300,
		Id = 503517,
		Condition = 26042350,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 35013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180773008),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503518] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10606350,
		Id = 503518,
		Condition = 26042360,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 36013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180773009),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503519] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10606400,
		Id = 503519,
		Condition = 26042373,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 37013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180781651),
		Weight = {
			72
		},
		PriorWeight = {
			7200
		}
	},
	[503601] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10604000,
		Id = 503601,
		Condition = 26042456,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950310,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132489),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[503602] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10604030,
		Id = 503602,
		Condition = 26042000,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950300,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132490),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[503603] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10604060,
		Id = 503603,
		Condition = 26042002,
		Reward = 12000005,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950090,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132491),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[504101] = {
		TotalTimeLimit = 50,
		AreaId = 10050,
		Id = 504101,
		DialogId = 10601110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 504102,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132492),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[504102] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		Id = 504102,
		DialogId = 10601110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 504101,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132493),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[504201] = {
		TotalTimeLimit = 17,
		AreaId = 10050,
		Id = 504201,
		DialogId = 10601110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 504202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132494),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[504202] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		Id = 504202,
		DialogId = 10601110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 504201,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132495),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[504301] = {
		TotalTimeLimit = 20,
		AreaId = 10050,
		Id = 504301,
		DialogId = 10601110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 504302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132496),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[504302] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		Id = 504302,
		DialogId = 10601110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 504301,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132497),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[505101] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 505101,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132498),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[505102] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 505102,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132499),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[505103] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 505103,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132500),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[505201] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 505201,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132501),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[505202] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 505202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132502),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[505203] = {
		IsEnd = 1,
		AreaId = 10050,
		DialogId = 10601110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 505203,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132503),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[601101] = {
		IsEnd = 1,
		AreaId = 10060,
		Redirect = 601102,
		DialogId = 10501110,
		Id = 601101,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000010
		},
		Name = getI18NValue(180132504),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[601102] = {
		IsEnd = 1,
		AreaId = 10060,
		Redirect = 601103,
		DialogId = 10501110,
		Id = 601102,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000020
		},
		Name = getI18NValue(180132505),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[601103] = {
		IsEnd = 1,
		AreaId = 10060,
		TownSpine = 1013,
		DialogId = 10501110,
		Reward = 12000001,
		Id = 601103,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			0
		},
		Name = getI18NValue(180132506),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[602101] = {
		TotalTimeLimit = 10,
		AreaId = 10060,
		Id = 602101,
		DialogId = 10501110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 602102,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132507),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[602102] = {
		TotalTimeLimit = 20,
		AreaId = 10060,
		Id = 602102,
		DialogId = 10501110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 602103,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132508),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[602103] = {
		IsEnd = 1,
		AreaId = 10060,
		TownSpine = 1013,
		DialogId = 10501110,
		Reward = 12000001,
		Id = 602103,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132509),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[602201] = {
		TotalTimeLimit = 10,
		AreaId = 10060,
		Id = 602201,
		DialogId = 10501110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 602202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132510),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[602202] = {
		TotalTimeLimit = 20,
		AreaId = 10060,
		Id = 602202,
		DialogId = 10501110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 602203,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132511),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[602203] = {
		IsEnd = 1,
		AreaId = 10060,
		TownSpine = 1013,
		DialogId = 10501110,
		Reward = 12000001,
		Id = 602203,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132512),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[602301] = {
		TotalTimeLimit = 10,
		AreaId = 10060,
		Id = 602301,
		DialogId = 10501110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 602302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132513),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[602302] = {
		TotalTimeLimit = 20,
		AreaId = 10060,
		Id = 602302,
		DialogId = 10501110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 602303,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132514),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[602303] = {
		IsEnd = 1,
		AreaId = 10060,
		TownSpine = 1013,
		DialogId = 10501110,
		Reward = 12000001,
		Id = 602303,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132515),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[603101] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501110,
		Id = 603101,
		Condition = 26042000,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132516),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603102] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501140,
		Id = 603102,
		Condition = 26042000,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950080,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132517),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603103] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501170,
		Id = 603103,
		Condition = 26042000,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950180,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132518),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603104] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501200,
		Id = 603104,
		Condition = 26042000,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950080,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132519),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603105] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501230,
		Condition = 26042000,
		Reward = 12000006,
		Join = 1,
		Id = 603105,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132520),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603151] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501590,
		Id = 603151,
		Condition = 26042000,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950180,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132521),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603152] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501710,
		Id = 603152,
		Condition = 26042000,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132522),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603153] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501830,
		Condition = 26042000,
		Reward = 12000006,
		Join = 1,
		Id = 603153,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132523),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603154] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501950,
		Condition = 26042000,
		Reward = 12000006,
		Join = 1,
		Id = 603154,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132524),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603155] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10502070,
		Condition = 26042000,
		Reward = 12000006,
		Join = 1,
		Id = 603155,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132525),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603201] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501260,
		Id = 603201,
		Condition = 26042001,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950080,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132526),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603202] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501290,
		Condition = 26042001,
		Reward = 12000006,
		Join = 1,
		Id = 603202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132527),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603203] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501320,
		Id = 603203,
		Condition = 26042001,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132528),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603251] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501620,
		Id = 603251,
		Condition = 26042001,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950180,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132529),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603252] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501740,
		Id = 603252,
		Condition = 26042001,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132530),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603253] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501860,
		Condition = 26042001,
		Reward = 12000006,
		Join = 1,
		Id = 603253,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132531),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603254] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501980,
		Condition = 26042001,
		Reward = 12000006,
		Join = 1,
		Id = 603254,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132532),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603255] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10502100,
		Condition = 26042001,
		Reward = 12000006,
		Join = 1,
		Id = 603255,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132533),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603301] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501350,
		Condition = 26042002,
		Reward = 12000006,
		Join = 1,
		Id = 603301,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132534),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603302] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501380,
		Id = 603302,
		Condition = 26042002,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950080,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132535),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603303] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501410,
		Id = 603303,
		Condition = 26042002,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132536),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603304] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501440,
		Condition = 26042002,
		Reward = 12000006,
		Join = 1,
		Id = 603304,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132537),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603305] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501470,
		Id = 603305,
		Condition = 26042002,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950110,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132538),
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603351] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501650,
		Id = 603351,
		Condition = 26042002,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950180,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132539),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603352] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501770,
		Id = 603352,
		Condition = 26042002,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132540),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603353] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501890,
		Condition = 26042002,
		Reward = 12000006,
		Join = 1,
		Id = 603353,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132541),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603354] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10502010,
		Condition = 26042002,
		Reward = 12000006,
		Join = 1,
		Id = 603354,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132542),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603355] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10502130,
		Condition = 26042002,
		Reward = 12000006,
		Join = 1,
		Id = 603355,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132543),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603401] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501500,
		Condition = 26042003,
		Reward = 12000006,
		Join = 1,
		Id = 603401,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132544),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603402] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501530,
		Condition = 26042003,
		Reward = 12000006,
		Join = 1,
		Id = 603402,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132545),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603403] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501560,
		Condition = 26042003,
		Reward = 12000006,
		Join = 1,
		Id = 603403,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132546),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			60
		},
		PriorWeight = {
			6000
		}
	},
	[603451] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501680,
		Id = 603451,
		Condition = 26042003,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950180,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132547),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603452] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501800,
		Id = 603452,
		Condition = 26042003,
		Reward = 12000006,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132548),
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603453] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501920,
		Condition = 26042003,
		Reward = 12000006,
		Join = 1,
		Id = 603453,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132549),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603454] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10502040,
		Condition = 26042003,
		Reward = 12000006,
		Join = 1,
		Id = 603454,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132550),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603455] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10502160,
		Condition = 26042003,
		Reward = 12000006,
		Join = 1,
		Id = 603455,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132551),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			36
		},
		PriorWeight = {
			3600
		}
	},
	[603501] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10506000,
		Id = 603501,
		Condition = 26042010,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 1013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132552),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603502] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10506030,
		Condition = 26042032,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		Id = 603502,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132553),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603503] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10506060,
		Id = 603503,
		Condition = 26042040,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 4013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132554),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603504] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 108021630,
		Id = 603504,
		Condition = 26042180,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 18013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132555),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603505] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10506150,
		Id = 603505,
		Condition = 26042150,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 15013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132556),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603506] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10502190,
		Id = 603506,
		Condition = 26042110,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 11013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132557),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603507] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 105021120,
		Id = 603507,
		Condition = 26042103,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 10013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132558),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603508] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 105021150,
		Id = 603508,
		Condition = 26042210,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 21013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132559),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603509] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10506120,
		Id = 603509,
		Condition = 26042130,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 13013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132560),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603510] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10506090,
		Id = 603510,
		Condition = 26042140,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 14013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132561),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603511] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10506190,
		Id = 603511,
		Condition = 26042160,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 16013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180146020),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603512] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10506220,
		Id = 603512,
		Condition = 26042231,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 23013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180266529),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603513] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10506250,
		Id = 603513,
		Condition = 26042272,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 27013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180274263),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603514] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10506270,
		Id = 603514,
		Condition = 26042290,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 29013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180443798),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603515] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10506300,
		Id = 603515,
		Condition = 26042300,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 30013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180467347),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603516] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10506340,
		Id = 603516,
		Condition = 26042380,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 38013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180823404),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603517] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10506380,
		Id = 603517,
		Condition = 26042411,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 41013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180844879),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603518] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10506450,
		Id = 603518,
		Condition = 26042474,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 47013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180946235),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[603601] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10504000,
		Id = 603601,
		Condition = 26042457,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950310,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132562),
		Weight = {
			90
		},
		PriorWeight = {
			9000
		}
	},
	[603602] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10504030,
		Id = 603602,
		Condition = 26042464,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950300,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132563),
		Weight = {
			90
		},
		PriorWeight = {
			9000
		}
	},
	[603603] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10504060,
		Id = 603603,
		Condition = 26042463,
		Reward = 12000006,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 900020,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132564),
		Weight = {
			90
		},
		PriorWeight = {
			9000
		}
	},
	[603604] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10504090,
		Condition = 26042002,
		Join = 1,
		DayTimeLimit = 1,
		Reward = 12000006,
		Id = 603604,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132565),
		TownAreaPros = {
			150,
			150
		},
		PreEvent = {
			20000604
		},
		Weight = {
			90
		},
		PriorWeight = {
			9000
		}
	},
	[604101] = {
		TotalTimeLimit = 50,
		AreaId = 10060,
		Id = 604101,
		DialogId = 10501110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 604102,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132566),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[604102] = {
		TotalTimeLimit = 1,
		AreaId = 10060,
		Id = 604102,
		DialogId = 10501110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 604101,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132567),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[604201] = {
		TotalTimeLimit = 17,
		AreaId = 10060,
		Id = 604201,
		DialogId = 10501110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 604202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132568),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[604202] = {
		TotalTimeLimit = 1,
		AreaId = 10060,
		Id = 604202,
		DialogId = 10501110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 604201,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132569),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[604301] = {
		TotalTimeLimit = 20,
		AreaId = 10060,
		Id = 604301,
		DialogId = 10501110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 604302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132570),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[604302] = {
		TotalTimeLimit = 1,
		AreaId = 10060,
		Id = 604302,
		DialogId = 10501110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 604301,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132571),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[605101] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 605101,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132572),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[605102] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 605102,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132573),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[605103] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 605103,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132574),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[605201] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 605201,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132575),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[605202] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 605202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132576),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[605203] = {
		IsEnd = 1,
		AreaId = 10060,
		DialogId = 10501110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 605203,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132577),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[701101] = {
		IsEnd = 1,
		AreaId = 10070,
		Redirect = 701102,
		DialogId = 10701110,
		Id = 701101,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000010
		},
		Name = getI18NValue(180132578),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[701102] = {
		IsEnd = 1,
		AreaId = 10070,
		Redirect = 701103,
		DialogId = 10701110,
		Id = 701102,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000020
		},
		Name = getI18NValue(180132579),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[701103] = {
		IsEnd = 1,
		AreaId = 10070,
		TownSpine = 1013,
		DialogId = 10701110,
		Reward = 12000001,
		Id = 701103,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			0
		},
		Name = getI18NValue(180132580),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[702101] = {
		TotalTimeLimit = 10,
		AreaId = 10070,
		Id = 702101,
		DialogId = 10701110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 702102,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132581),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[702102] = {
		TotalTimeLimit = 20,
		AreaId = 10070,
		Id = 702102,
		DialogId = 10701110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 702103,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132582),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[702103] = {
		IsEnd = 1,
		AreaId = 10070,
		TownSpine = 1013,
		DialogId = 10701110,
		Reward = 12000001,
		Id = 702103,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132583),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[702201] = {
		TotalTimeLimit = 10,
		AreaId = 10070,
		Id = 702201,
		DialogId = 10701110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 702202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132584),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[702202] = {
		TotalTimeLimit = 20,
		AreaId = 10070,
		Id = 702202,
		DialogId = 10701110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 702203,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132585),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[702203] = {
		IsEnd = 1,
		AreaId = 10070,
		TownSpine = 1013,
		DialogId = 10701110,
		Reward = 12000001,
		Id = 702203,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132586),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[702301] = {
		TotalTimeLimit = 10,
		AreaId = 10070,
		Id = 702301,
		DialogId = 10701110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 702302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132587),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[702302] = {
		TotalTimeLimit = 20,
		AreaId = 10070,
		Id = 702302,
		DialogId = 10701110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 702303,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132588),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[702303] = {
		IsEnd = 1,
		AreaId = 10070,
		TownSpine = 1013,
		DialogId = 10701110,
		Reward = 12000001,
		Id = 702303,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132589),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[703101] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701110,
		Condition = 26042000,
		Reward = 12000007,
		Join = 1,
		Id = 703101,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132590),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703102] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701140,
		Condition = 26042000,
		Reward = 12000007,
		Join = 1,
		Id = 703102,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132591),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703103] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701170,
		Condition = 26042000,
		Reward = 12000007,
		Join = 1,
		Id = 703103,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132592),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703104] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701200,
		Id = 703104,
		Condition = 26042000,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950130,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132593),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703105] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701230,
		Id = 703105,
		Condition = 26042000,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950040,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132594),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703151] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701590,
		Condition = 26042000,
		Reward = 12000007,
		Join = 1,
		Id = 703151,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132595),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703152] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701710,
		Condition = 26042000,
		Reward = 12000007,
		Join = 1,
		Id = 703152,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132596),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703153] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701830,
		Id = 703153,
		Condition = 26042000,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132597),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703154] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701950,
		Condition = 26042000,
		Reward = 12000007,
		Join = 1,
		Id = 703154,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132598),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703155] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10702070,
		Id = 703155,
		Condition = 26042000,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132599),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703201] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701260,
		Id = 703201,
		Condition = 26042001,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950110,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132600),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703202] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701290,
		Condition = 26042001,
		Reward = 12000007,
		Join = 1,
		Id = 703202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132601),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703203] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701320,
		Id = 703203,
		Condition = 26042001,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950140,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132602),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703251] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701620,
		Condition = 26042001,
		Reward = 12000007,
		Join = 1,
		Id = 703251,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132603),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703252] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701740,
		Condition = 26042001,
		Reward = 12000007,
		Join = 1,
		Id = 703252,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132604),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703253] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701860,
		Id = 703253,
		Condition = 26042001,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132605),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703254] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701980,
		Condition = 26042001,
		Reward = 12000007,
		Join = 1,
		Id = 703254,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132606),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703255] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10702100,
		Id = 703255,
		Condition = 26042001,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132607),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703301] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701350,
		Id = 703301,
		Condition = 26042002,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950170,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132608),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703302] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701380,
		Id = 703302,
		Condition = 26042002,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950140,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132609),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703303] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701410,
		Id = 703303,
		Condition = 26042002,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950130,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132610),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703304] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701440,
		Condition = 26042002,
		Reward = 12000007,
		Join = 1,
		Id = 703304,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132611),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703305] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701470,
		Id = 703305,
		Condition = 26042002,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950110,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132612),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703351] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701650,
		Condition = 26042002,
		Reward = 12000007,
		Join = 1,
		Id = 703351,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132613),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703352] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701770,
		Condition = 26042002,
		Reward = 12000007,
		Join = 1,
		Id = 703352,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132614),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703353] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701890,
		Id = 703353,
		Condition = 26042002,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132615),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703354] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10702010,
		Condition = 26042002,
		Reward = 12000007,
		Join = 1,
		Id = 703354,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132616),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703355] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10702130,
		Id = 703355,
		Condition = 26042002,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132617),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703401] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701500,
		Id = 703401,
		Condition = 26042003,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950140,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132618),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703402] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701530,
		Id = 703402,
		Condition = 26042003,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950140,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132619),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703403] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701560,
		Condition = 26042003,
		Reward = 12000007,
		Join = 1,
		Id = 703403,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132620),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[703451] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701680,
		Condition = 26042003,
		Reward = 12000007,
		Join = 1,
		Id = 703451,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132621),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703452] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701800,
		Condition = 26042003,
		Reward = 12000007,
		Join = 1,
		Id = 703452,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132622),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703453] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701920,
		Id = 703453,
		Condition = 26042003,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132623),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703454] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10702040,
		Condition = 26042003,
		Reward = 12000007,
		Join = 1,
		Id = 703454,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132624),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703455] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10702160,
		Id = 703455,
		Condition = 26042003,
		Reward = 12000007,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132625),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[703501] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10706000,
		Id = 703501,
		Condition = 26042040,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 4013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132626),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703502] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10706030,
		Id = 703502,
		Condition = 26042050,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 5013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132627),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703503] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10706060,
		Id = 703503,
		Condition = 26042090,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 9013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132628),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703504] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10706090,
		Id = 703504,
		Condition = 26042120,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 12013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132629),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703505] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 108021300,
		Id = 703505,
		Condition = 26042171,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 17013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132630),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703506] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 108021490,
		Id = 703506,
		Condition = 26042190,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 19013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132631),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703507] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 108021680,
		Id = 703507,
		Condition = 26042221,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 22013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132632),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703508] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10702190,
		Id = 703508,
		Condition = 26042101,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 10013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132633),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703509] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 107021120,
		Id = 703509,
		Condition = 26042210,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 21013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132634),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703510] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10706120,
		Id = 703510,
		Condition = 26042131,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 13013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132635),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703511] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10706150,
		Id = 703511,
		Condition = 26042252,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 25013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180146021),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703512] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10706175,
		Id = 703512,
		Condition = 26042243,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 24013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180245217),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703513] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10706210,
		Id = 703513,
		Condition = 26042231,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 23013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180266530),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703514] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10706230,
		Id = 703514,
		Condition = 26042300,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 30013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180467348),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703515] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10706250,
		Id = 703515,
		Condition = 26042300,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 30013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180467349),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703516] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10706290,
		Id = 703516,
		Condition = 26042342,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 34013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180545091),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703517] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10706340,
		Id = 703517,
		Condition = 26042370,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 37013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180781652),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703518] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10706370,
		Id = 703518,
		Condition = 26042391,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 39013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180829028),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703519] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10706420,
		Id = 703519,
		Condition = 26042422,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 42013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180875442),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703520] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10706450,
		Id = 703520,
		Condition = 26042482,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 48013,
		RecordsInArchives = true,
		Type = {
			2,
			1
		},
		Name = getI18NValue(180950080),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[703601] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10704000,
		Id = 703601,
		Condition = 26042455,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950310,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132636),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[703602] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10704030,
		Id = 703602,
		Condition = 26042001,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950200,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132637),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[703603] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10704060,
		Id = 703603,
		Condition = 26042460,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 900020,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132638),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[703604] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10704090,
		Id = 703604,
		Condition = 26042000,
		Reward = 12000007,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950090,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132639),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[703605] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10704120,
		Condition = 26042002,
		Join = 1,
		DayTimeLimit = 1,
		Reward = 12000007,
		Id = 703605,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132640),
		TownAreaPros = {
			150,
			150
		},
		PreEvent = {
			20000604
		},
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[704101] = {
		TotalTimeLimit = 50,
		AreaId = 10070,
		Id = 704101,
		DialogId = 10701110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 704102,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132641),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[704102] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		Id = 704102,
		DialogId = 10701110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 704101,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132642),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[704201] = {
		TotalTimeLimit = 17,
		AreaId = 10070,
		Id = 704201,
		DialogId = 10701110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 704202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132643),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[704202] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		Id = 704202,
		DialogId = 10701110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 704201,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132644),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[704301] = {
		TotalTimeLimit = 20,
		AreaId = 10070,
		Id = 704301,
		DialogId = 10701110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 704302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132645),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[704302] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		Id = 704302,
		DialogId = 10701110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 704301,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132646),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[705101] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 705101,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132647),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[705102] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 705102,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132648),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[705103] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 705103,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132649),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[705201] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 705201,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132650),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[705202] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 705202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132651),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[705203] = {
		IsEnd = 1,
		AreaId = 10070,
		DialogId = 10701110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 705203,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132652),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[801101] = {
		IsEnd = 1,
		AreaId = 10090,
		Redirect = 801102,
		DialogId = 10801110,
		Id = 801101,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000010
		},
		Name = getI18NValue(180132653),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[801102] = {
		IsEnd = 1,
		AreaId = 10090,
		Redirect = 801103,
		DialogId = 10801110,
		Id = 801102,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000020
		},
		Name = getI18NValue(180132654),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[801103] = {
		IsEnd = 1,
		AreaId = 10090,
		TownSpine = 1013,
		DialogId = 10801110,
		Reward = 12000001,
		Id = 801103,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			0
		},
		Name = getI18NValue(180132655),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[802101] = {
		TotalTimeLimit = 10,
		AreaId = 10090,
		Id = 802101,
		DialogId = 10801110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 802102,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132656),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[802102] = {
		TotalTimeLimit = 20,
		AreaId = 10090,
		Id = 802102,
		DialogId = 10801110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 802103,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132657),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[802103] = {
		IsEnd = 1,
		AreaId = 10090,
		TownSpine = 1013,
		DialogId = 10801110,
		Reward = 12000001,
		Id = 802103,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132658),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[802201] = {
		TotalTimeLimit = 10,
		AreaId = 10090,
		Id = 802201,
		DialogId = 10801110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 802202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132659),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[802202] = {
		TotalTimeLimit = 20,
		AreaId = 10090,
		Id = 802202,
		DialogId = 10801110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 802203,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132660),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[802203] = {
		IsEnd = 1,
		AreaId = 10090,
		TownSpine = 1013,
		DialogId = 10801110,
		Reward = 12000001,
		Id = 802203,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132661),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[802301] = {
		TotalTimeLimit = 10,
		AreaId = 10090,
		Id = 802301,
		DialogId = 10801110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 802302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132662),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[802302] = {
		TotalTimeLimit = 20,
		AreaId = 10090,
		Id = 802302,
		DialogId = 10801110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 802303,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132663),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[802303] = {
		IsEnd = 1,
		AreaId = 10090,
		TownSpine = 1013,
		DialogId = 10801110,
		Reward = 12000001,
		Id = 802303,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132664),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[803101] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801110,
		Condition = 26042000,
		Reward = 12000008,
		Join = 1,
		Id = 803101,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132665),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803102] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801140,
		Id = 803102,
		Condition = 26042000,
		Reward = 12000008,
		Join = 1,
		TownSpine = 950170,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132666),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803103] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801170,
		Condition = 26042000,
		Reward = 12000008,
		Join = 1,
		Id = 803103,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132667),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803104] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801200,
		Condition = 26042000,
		Reward = 12000008,
		Join = 1,
		Id = 803104,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132668),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803105] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801230,
		Id = 803105,
		Condition = 26042000,
		Reward = 12000008,
		Join = 1,
		TownSpine = 950240,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132669),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803151] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801590,
		Id = 803151,
		Condition = 26042000,
		Reward = 12000008,
		Join = 1,
		TownSpine = 950020,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132670),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803152] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801710,
		Condition = 26042000,
		Reward = 12000008,
		Join = 1,
		Id = 803152,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132671),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803153] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801830,
		Condition = 26042000,
		Reward = 12000008,
		Join = 1,
		Id = 803153,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132672),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803154] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801950,
		Id = 803154,
		Condition = 26042000,
		Reward = 12000008,
		Join = 1,
		TownSpine = 950240,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132673),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803155] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10802070,
		Condition = 26042000,
		Reward = 12000008,
		Join = 1,
		Id = 803155,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132674),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803201] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801260,
		Condition = 26042001,
		Reward = 12000008,
		Join = 1,
		Id = 803201,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132675),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803202] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801290,
		Condition = 26042001,
		Reward = 12000008,
		Join = 1,
		Id = 803202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132676),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803203] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801320,
		Condition = 26042001,
		Reward = 12000008,
		Join = 1,
		Id = 803203,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132677),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803251] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801620,
		Id = 803251,
		Condition = 26042001,
		Reward = 12000008,
		Join = 1,
		TownSpine = 950020,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132678),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803252] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801740,
		Condition = 26042001,
		Reward = 12000008,
		Join = 1,
		Id = 803252,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132679),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803253] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801860,
		Condition = 26042001,
		Reward = 12000008,
		Join = 1,
		Id = 803253,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132680),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803254] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801980,
		Id = 803254,
		Condition = 26042001,
		Reward = 12000008,
		Join = 1,
		TownSpine = 950240,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132681),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803255] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10802107,
		Condition = 26042001,
		Reward = 12000008,
		Join = 1,
		Id = 803255,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132682),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803301] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801350,
		Condition = 26042002,
		Reward = 12000008,
		Join = 1,
		Id = 803301,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132683),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803302] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801380,
		Condition = 26042002,
		Reward = 12000008,
		Join = 1,
		Id = 803302,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132684),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803303] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801410,
		Id = 803303,
		Condition = 26042002,
		Reward = 12000008,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132685),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803304] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801440,
		Condition = 26042002,
		Reward = 12000008,
		Join = 1,
		Id = 803304,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132686),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803305] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801470,
		Condition = 26042002,
		Reward = 12000008,
		Join = 1,
		Id = 803305,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132687),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803351] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801650,
		Id = 803351,
		Condition = 26042002,
		Reward = 12000008,
		Join = 1,
		TownSpine = 950020,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132688),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803352] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801770,
		Condition = 26042002,
		Reward = 12000008,
		Join = 1,
		Id = 803352,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132689),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803353] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801890,
		Condition = 26042002,
		Reward = 12000008,
		Join = 1,
		Id = 803353,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132690),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803354] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10802010,
		Id = 803354,
		Condition = 26042002,
		Reward = 12000008,
		Join = 1,
		TownSpine = 950240,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132691),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803355] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10802137,
		Condition = 26042002,
		Reward = 12000008,
		Join = 1,
		Id = 803355,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132692),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803401] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801500,
		Condition = 26042003,
		Reward = 12000008,
		Join = 1,
		Id = 803401,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132693),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803402] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801530,
		Condition = 26042003,
		Reward = 12000008,
		Join = 1,
		Id = 803402,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132694),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803403] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801560,
		Id = 803403,
		Condition = 26042003,
		Reward = 12000008,
		Join = 1,
		TownSpine = 950010,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132695),
		Weight = {
			20
		},
		PriorWeight = {
			2000
		}
	},
	[803451] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801680,
		Id = 803451,
		Condition = 26042003,
		Reward = 12000008,
		Join = 1,
		TownSpine = 950020,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132696),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803452] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801800,
		Condition = 26042003,
		Reward = 12000008,
		Join = 1,
		Id = 803452,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132697),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803453] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801920,
		Condition = 26042003,
		Reward = 12000008,
		Join = 1,
		Id = 803453,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132698),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803454] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10802040,
		Id = 803454,
		Condition = 26042003,
		Reward = 12000008,
		Join = 1,
		TownSpine = 950240,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132699),
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803455] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10802167,
		Condition = 26042003,
		Reward = 12000008,
		Join = 1,
		Id = 803455,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132700),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			12
		},
		PriorWeight = {
			1200
		}
	},
	[803501] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806000,
		Id = 803501,
		Condition = 26042010,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 1013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132701),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803502] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806030,
		Id = 803502,
		Condition = 26042040,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 4013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132702),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803503] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806060,
		Id = 803503,
		Condition = 26042072,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 7013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132703),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803504] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806090,
		Id = 803504,
		Condition = 26042080,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 8013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132704),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803505] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 108021210,
		Id = 803505,
		Condition = 26042202,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 20013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132705),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803506] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 108021360,
		Id = 803506,
		Condition = 26042170,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 17013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132706),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803507] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 108021420,
		Id = 803507,
		Condition = 26042190,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 19013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132707),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803508] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 108021580,
		Id = 803508,
		Condition = 26042180,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 18013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132708),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803509] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10802190,
		Id = 803509,
		Condition = 26042110,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 11013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132709),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803510] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 108021120,
		Id = 803510,
		Condition = 26042100,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 10013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132710),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803511] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 108021150,
		Id = 803511,
		Condition = 26042210,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 21013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132711),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803512] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806120,
		Id = 803512,
		Condition = 26042132,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 13013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132712),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803513] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806150,
		Id = 803513,
		Condition = 26042162,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 16013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180146022),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803514] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806180,
		Id = 803514,
		Condition = 26042240,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 24013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180245218),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803515] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806210,
		Id = 803515,
		Condition = 26042230,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 23013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180266531),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803516] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806240,
		Id = 803516,
		Condition = 26042271,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 27013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180274384),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803517] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806260,
		Id = 803517,
		Condition = 26042280,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 28013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180299675),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803518] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806290,
		Id = 803518,
		Condition = 26042300,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 30013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180467350),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803519] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806320,
		Id = 803519,
		Condition = 26042311,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 31013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180498285),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803520] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806360,
		Id = 803520,
		Condition = 26042320,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 32013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180508947),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803521] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806410,
		Id = 803521,
		Condition = 26042321,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 32013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180508948),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803522] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806460,
		Id = 803522,
		Condition = 26042322,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 32013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180508949),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803523] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806510,
		Id = 803523,
		Condition = 26042323,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 32013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180508950),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803524] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806550,
		Id = 803524,
		Condition = 26042351,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 35013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180773010),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803525] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806600,
		Id = 803525,
		Condition = 26042362,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 36013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180773011),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803526] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806650,
		Id = 803526,
		Condition = 26042380,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 38013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180823405),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803527] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806690,
		Id = 803527,
		Condition = 26042390,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 39013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180829029),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803528] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806730,
		Id = 803528,
		Condition = 26042410,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 41013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180844880),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803529] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806770,
		Id = 803529,
		Condition = 26042410,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 41013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180844881),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803530] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806830,
		Id = 803530,
		Condition = 26042421,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 42013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180875443),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803531] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10806880,
		Id = 803531,
		Condition = 26042430,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 43013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180881407),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803532] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10807000,
		Id = 803532,
		Condition = 26042443,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 44013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180901586),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803533] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10807100,
		Id = 803533,
		Condition = 26042402,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 40013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180911421),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803534] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10807160,
		Id = 803534,
		Condition = 26042400,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 40013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180911422),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803535] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10807210,
		Id = 803535,
		Condition = 26042401,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 40013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180911423),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803536] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10807250,
		Id = 803536,
		Condition = 26042450,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 45013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180912732),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803537] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10807300,
		Id = 803537,
		Condition = 26042470,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 46013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180918417),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803538] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10807350,
		Id = 803538,
		Condition = 26042474,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 47013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180946236),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803539] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10807400,
		Id = 803539,
		Condition = 26042482,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 48013,
		RecordsInArchives = true,
		Type = {
			2,
			1
		},
		Name = getI18NValue(180950081),
		Weight = {
			30
		},
		PriorWeight = {
			3000
		}
	},
	[803601] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10804000,
		Id = 803601,
		Condition = 26042457,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950320,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132713),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[803602] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10804030,
		Id = 803602,
		Condition = 26042458,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 900010,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132714),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[803603] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10804060,
		Id = 803603,
		Condition = 26042458,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 900020,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132715),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[803604] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10804090,
		Id = 803604,
		Condition = 26042000,
		Reward = 12000008,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950100,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132716),
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[803605] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10804120,
		Condition = 26042002,
		Join = 1,
		DayTimeLimit = 1,
		Reward = 12000008,
		Id = 803605,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132717),
		TownAreaPros = {
			150,
			150
		},
		PreEvent = {
			20000604
		},
		Weight = {
			24
		},
		PriorWeight = {
			2400
		}
	},
	[804101] = {
		TotalTimeLimit = 50,
		AreaId = 10090,
		Id = 804101,
		DialogId = 10801110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 804102,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132718),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[804102] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		Id = 804102,
		DialogId = 10801110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 804101,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132719),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[804201] = {
		TotalTimeLimit = 17,
		AreaId = 10090,
		Id = 804201,
		DialogId = 10801110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 804202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132720),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[804202] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		Id = 804202,
		DialogId = 10801110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 804201,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132721),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[804301] = {
		TotalTimeLimit = 20,
		AreaId = 10090,
		Id = 804301,
		DialogId = 10801110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 804302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132722),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[804302] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		Id = 804302,
		DialogId = 10801110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 804301,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132723),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[805101] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 805101,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132724),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[805102] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 805102,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132725),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[805103] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 805103,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132726),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[805201] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 805201,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132727),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[805202] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 805202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132728),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[805203] = {
		IsEnd = 1,
		AreaId = 10090,
		DialogId = 10801110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 805203,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132729),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[901101] = {
		IsEnd = 1,
		AreaId = 10100,
		Redirect = 901102,
		DialogId = 10901110,
		Id = 901101,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000010
		},
		Name = getI18NValue(180132730),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[901102] = {
		IsEnd = 1,
		AreaId = 10100,
		Redirect = 901103,
		DialogId = 10901110,
		Id = 901102,
		Reward = 12000001,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			10000020
		},
		Name = getI18NValue(180132731),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[901103] = {
		IsEnd = 1,
		AreaId = 10100,
		TownSpine = 1013,
		DialogId = 10901110,
		Reward = 12000001,
		Id = 901103,
		RecordsInArchives = false,
		Type = {
			2,
			1,
			0
		},
		Name = getI18NValue(180132732),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[902101] = {
		TotalTimeLimit = 10,
		AreaId = 10100,
		Id = 902101,
		DialogId = 10901110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 902102,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132733),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[902102] = {
		TotalTimeLimit = 20,
		AreaId = 10100,
		Id = 902102,
		DialogId = 10901110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 902103,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132734),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[902103] = {
		IsEnd = 1,
		AreaId = 10100,
		TownSpine = 1013,
		DialogId = 10901110,
		Reward = 12000001,
		Id = 902103,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132735),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[902201] = {
		TotalTimeLimit = 10,
		AreaId = 10100,
		Id = 902201,
		DialogId = 10901110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 902202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132736),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[902202] = {
		TotalTimeLimit = 20,
		AreaId = 10100,
		Id = 902202,
		DialogId = 10901110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 902203,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132737),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[902203] = {
		IsEnd = 1,
		AreaId = 10100,
		TownSpine = 1013,
		DialogId = 10901110,
		Reward = 12000001,
		Id = 902203,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132738),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[902301] = {
		TotalTimeLimit = 10,
		AreaId = 10100,
		Id = 902301,
		DialogId = 10901110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 902302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132739),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[902302] = {
		TotalTimeLimit = 20,
		AreaId = 10100,
		Id = 902302,
		DialogId = 10901110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 902303,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132740),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[902303] = {
		IsEnd = 1,
		AreaId = 10100,
		TownSpine = 1013,
		DialogId = 10901110,
		Reward = 12000001,
		Id = 902303,
		RecordsInArchives = false,
		Type = {
			2,
			2
		},
		Name = getI18NValue(180132741),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[903101] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901110,
		Condition = 26042000,
		Reward = 12000009,
		Join = 1,
		Id = 903101,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132742),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903102] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901140,
		Id = 903102,
		Condition = 26042000,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950030,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132743),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903103] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901170,
		Id = 903103,
		Condition = 26042000,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950160,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132744),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903104] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901200,
		Condition = 26042000,
		Reward = 12000009,
		Join = 1,
		Id = 903104,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132745),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903105] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901230,
		Id = 903105,
		Condition = 26042000,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950110,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132746),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903151] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901590,
		Id = 903151,
		Condition = 26042000,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950110,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132747),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903152] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901710,
		Condition = 26042000,
		Reward = 12000009,
		Join = 1,
		Id = 903152,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132748),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903153] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901830,
		Id = 903153,
		Condition = 26042000,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950070,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132749),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903154] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901950,
		Id = 903154,
		Condition = 26042000,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950150,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132750),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903155] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10902070,
		Condition = 26042000,
		Reward = 12000009,
		Join = 1,
		Id = 903155,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132751),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903201] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901260,
		Condition = 26042001,
		Reward = 12000009,
		Join = 1,
		Id = 903201,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132752),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903202] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901290,
		Id = 903202,
		Condition = 26042001,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950170,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132753),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903203] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901320,
		Id = 903203,
		Condition = 26042001,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950120,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132754),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903251] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901620,
		Id = 903251,
		Condition = 26042001,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950110,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132755),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903252] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901740,
		Condition = 26042001,
		Reward = 12000009,
		Join = 1,
		Id = 903252,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132756),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903253] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901860,
		Id = 903253,
		Condition = 26042001,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950070,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132757),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903254] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901980,
		Id = 903254,
		Condition = 26042001,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950150,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132758),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903255] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10902100,
		Condition = 26042001,
		Reward = 12000009,
		Join = 1,
		Id = 903255,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132759),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903301] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901350,
		Condition = 26042002,
		Reward = 12000009,
		Join = 1,
		Id = 903301,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132760),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903302] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901380,
		Id = 903302,
		Condition = 26042002,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950030,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132761),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903303] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901410,
		Id = 903303,
		Condition = 26042002,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950190,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132762),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903304] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901440,
		Id = 903304,
		Condition = 26042002,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950040,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132763),
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903305] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901470,
		Condition = 26042002,
		Reward = 12000009,
		Join = 1,
		Id = 903305,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132764),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903351] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901650,
		Id = 903351,
		Condition = 26042002,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950110,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132765),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903352] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901770,
		Condition = 26042002,
		Reward = 12000009,
		Join = 1,
		Id = 903352,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132766),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903353] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901890,
		Id = 903353,
		Condition = 26042002,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950070,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132767),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903354] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10902010,
		Id = 903354,
		Condition = 26042002,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950150,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132768),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903355] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10902130,
		Condition = 26042002,
		Reward = 12000009,
		Join = 1,
		Id = 903355,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132769),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903401] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901500,
		Condition = 26042003,
		Reward = 12000009,
		Join = 1,
		Id = 903401,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132770),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903402] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901530,
		Condition = 26042003,
		Reward = 12000009,
		Join = 1,
		Id = 903402,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132771),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903403] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901560,
		Condition = 26042003,
		Reward = 12000009,
		Join = 1,
		Id = 903403,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132772),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			140
		},
		PriorWeight = {
			14000
		}
	},
	[903451] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901680,
		Id = 903451,
		Condition = 26042003,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950110,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132773),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903452] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901800,
		Condition = 26042003,
		Reward = 12000009,
		Join = 1,
		Id = 903452,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132774),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903453] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901920,
		Id = 903453,
		Condition = 26042003,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950070,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132775),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903454] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10902040,
		Id = 903454,
		Condition = 26042003,
		Reward = 12000009,
		Join = 1,
		TownSpine = 950150,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132776),
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903455] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10902160,
		Condition = 26042003,
		Reward = 12000009,
		Join = 1,
		Id = 903455,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132777),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			84
		},
		PriorWeight = {
			8400
		}
	},
	[903501] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906000,
		Id = 903501,
		Condition = 26042011,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 1013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132778),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903502] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906030,
		Condition = 26042030,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		Id = 903502,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132779),
		TownAreaPros = {
			150,
			150
		},
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903503] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906060,
		Id = 903503,
		Condition = 26042050,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 5013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132780),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903504] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906090,
		Id = 903504,
		Condition = 26042060,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 6013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132781),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903505] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906120,
		Id = 903505,
		Condition = 26042072,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 7013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132782),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903506] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906150,
		Id = 903506,
		Condition = 26042090,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 9013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132783),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903507] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906180,
		Id = 903507,
		Condition = 26042122,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 12013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132784),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903508] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906270,
		Id = 903508,
		Condition = 26042150,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 15013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132785),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903509] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906240,
		Id = 903509,
		Condition = 26042130,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 13013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132786),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903510] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906210,
		Id = 903510,
		Condition = 26042142,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 14013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132787),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903511] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906300,
		Id = 903511,
		Condition = 26042162,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 16013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180146023),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903512] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906320,
		Id = 903512,
		Condition = 26042231,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 23013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180266532),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903513] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906360,
		Id = 903513,
		Condition = 26042311,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 31013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180498286),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903514] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906390,
		Id = 903514,
		Condition = 26042370,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 37013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180781653),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903515] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906430,
		Id = 903515,
		Condition = 26042390,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 39013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180829030),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903516] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906480,
		Id = 903516,
		Condition = 26042420,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 42013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180875444),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903517] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906550,
		Id = 903517,
		Condition = 26042402,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 40013,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180911424),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903518] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10906600,
		Id = 903518,
		Condition = 26042480,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 48013,
		RecordsInArchives = true,
		Type = {
			2,
			1
		},
		Name = getI18NValue(180950082),
		Weight = {
			120
		},
		PriorWeight = {
			12000
		}
	},
	[903601] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10904000,
		Id = 903601,
		Condition = 26042456,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 950320,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132788),
		Weight = {
			420
		},
		PriorWeight = {
			42000
		}
	},
	[903602] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10904030,
		Id = 903602,
		Condition = 26042459,
		Reward = 12000009,
		DayTimeLimit = 1,
		Join = 1,
		TownSpine = 900010,
		RecordsInArchives = true,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132789),
		Weight = {
			420
		},
		PriorWeight = {
			42000
		}
	},
	[904101] = {
		TotalTimeLimit = 50,
		AreaId = 10100,
		Id = 904101,
		DialogId = 10901110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 904102,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132790),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[904102] = {
		TotalTimeLimit = 1,
		AreaId = 10100,
		Id = 904102,
		DialogId = 10901110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 904101,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132791),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[904201] = {
		TotalTimeLimit = 17,
		AreaId = 10100,
		Id = 904201,
		DialogId = 10901110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 904202,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132792),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[904202] = {
		TotalTimeLimit = 1,
		AreaId = 10100,
		Id = 904202,
		DialogId = 10901110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 904201,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132793),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[904301] = {
		TotalTimeLimit = 20,
		AreaId = 10100,
		Id = 904301,
		DialogId = 10901110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 904302,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132794),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[904302] = {
		TotalTimeLimit = 1,
		AreaId = 10100,
		Id = 904302,
		DialogId = 10901110,
		IsEnd = 1,
		Reward = 12000001,
		Redirect = 904301,
		TownSpine = 1013,
		RecordsInArchives = false,
		Type = {
			2,
			3
		},
		Name = getI18NValue(180132795),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[905101] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 905101,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132796),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[905102] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 905102,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132797),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[905103] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042004,
		Id = 905103,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132798),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[905201] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 905201,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132799),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[905202] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 905202,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132800),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[905203] = {
		IsEnd = 1,
		AreaId = 10100,
		DialogId = 10901110,
		TownSpine = 1013,
		Reward = 12000001,
		Condition = 26042005,
		Id = 905203,
		RecordsInArchives = false,
		Type = {
			2,
			0
		},
		Name = getI18NValue(180132801),
		Weight = {
			0
		},
		PriorWeight = {
			0
		}
	},
	[10000101] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011010000,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10201001,
		Condition = 26043001,
		EventType = 1,
		Id = 10000101,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132802),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020101
		}
	},
	[10000102] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		DialogId = 2011010330,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10201002,
		Condition = 26043002,
		EventType = 1,
		Id = 10000102,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132803),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000101
		}
	},
	[10000103] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		DialogId = 2011011000,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10201003,
		Condition = 26043003,
		EventType = 1,
		Id = 10000103,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132804),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000102
		}
	},
	[10000104] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		DialogId = 2011011400,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10201004,
		Condition = 26043004,
		EventType = 1,
		Id = 10000104,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132805),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000103
		}
	},
	[10000105] = {
		TotalTimeLimit = 1,
		AreaId = 10020,
		DialogId = 2011011500,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10201005,
		Condition = 26043005,
		EventType = 1,
		Id = 10000105,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132806),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000104
		}
	},
	[10000106] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011011900,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Condition = 26043006,
		EventType = 1,
		Reward = 10201006,
		Id = 10000106,
		RoomId = 4,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132807),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000105
		}
	},
	[10000107] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011012100,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10201007,
		Condition = 26043007,
		EventType = 1,
		Id = 10000107,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132808),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000106,
			10020109
		}
	},
	[10000108] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		DialogId = 2011012302,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10201008,
		Condition = 26043008,
		EventType = 1,
		Id = 10000108,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132809),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000107
		}
	},
	[10000109] = {
		TotalTimeLimit = 1,
		AreaId = 10100,
		DialogId = 2011012400,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10201009,
		Condition = 26043009,
		EventType = 1,
		Id = 10000109,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132810),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000108
		}
	},
	[10000110] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		DialogId = 38010603,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10201010,
		Condition = 26043010,
		EventType = 1,
		Id = 10000110,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132811),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000109
		}
	},
	[10000111] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		DialogId = 2011012700,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10201011,
		Condition = 26043011,
		EventType = 1,
		Id = 10000111,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132812),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000110
		}
	},
	[10000112] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		DialogId = 2011012850,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10201012,
		Condition = 26043012,
		EventType = 1,
		Id = 10000112,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132813),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000111
		}
	},
	[10000113] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		DialogId = 2011013901,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10201013,
		Condition = 26043013,
		EventType = 1,
		Id = 10000113,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132814),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000112
		}
	},
	[10000114] = {
		TotalTimeLimit = 1,
		AreaId = 10020,
		DialogId = 38019173,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10201014,
		Condition = 26043014,
		EventType = 1,
		Id = 10000114,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132815),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000113
		}
	},
	[10000201] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011020000,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10202001,
		Condition = 26043015,
		EventType = 1,
		Id = 10000201,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132816),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000114
		}
	},
	[10000202] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		DialogId = 2011020250,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10202002,
		Condition = 26043016,
		EventType = 1,
		Id = 10000202,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132817),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000201
		}
	},
	[10000203] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011020450,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10202003,
		Condition = 26043017,
		EventType = 1,
		Id = 10000203,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132818),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000202
		}
	},
	[10000204] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		DialogId = 2011020550,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10202004,
		Condition = 26043018,
		EventType = 1,
		Id = 10000204,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132819),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000203
		}
	},
	[10000205] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		DialogId = 2011020900,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10202005,
		Condition = 26043019,
		EventType = 1,
		Id = 10000205,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132820),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000204
		}
	},
	[10000206] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011021050,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10202006,
		Condition = 26043020,
		EventType = 1,
		Id = 10000206,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132821),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000205
		}
	},
	[10000207] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		DialogId = 2011021350,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10202007,
		Condition = 26043021,
		EventType = 1,
		Id = 10000207,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132822),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000206
		}
	},
	[10000208] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		DialogId = 2011021500,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10202008,
		Condition = 26043022,
		EventType = 1,
		Id = 10000208,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132823),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000207
		}
	},
	[10000209] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		DialogId = 2011021800,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10202009,
		Condition = 26043023,
		EventType = 1,
		Id = 10000209,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132824),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000208
		}
	},
	[10000210] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		DialogId = 2011022050,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10202010,
		Condition = 26043024,
		EventType = 1,
		Id = 10000210,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132825),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000209
		}
	},
	[10000211] = {
		TotalTimeLimit = 1,
		AreaId = 10060,
		DialogId = 2011022350,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10202011,
		Condition = 26043025,
		EventType = 1,
		Id = 10000211,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132826),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000210
		}
	},
	[10000212] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011022650,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10202012,
		Condition = 26043026,
		EventType = 1,
		Id = 10000212,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132827),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000211
		}
	},
	[10000301] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011030000,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10203001,
		Condition = 26043027,
		EventType = 1,
		Id = 10000301,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132828),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000212
		}
	},
	[10000302] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		DialogId = 2011030160,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10203002,
		Condition = 26043028,
		EventType = 1,
		Id = 10000302,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132829),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000301
		}
	},
	[10000303] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011030300,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10203003,
		Condition = 26043029,
		EventType = 1,
		Id = 10000303,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132830),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000302
		}
	},
	[10000304] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011030630,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10203004,
		Condition = 26043030,
		EventType = 1,
		Id = 10000304,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132831),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000303
		}
	},
	[10000305] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011030820,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10203005,
		Condition = 26043031,
		EventType = 1,
		Id = 10000305,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132832),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000304
		}
	},
	[10000306] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011031050,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10203006,
		Condition = 26043032,
		EventType = 1,
		Id = 10000306,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132833),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000305
		}
	},
	[10000307] = {
		TotalTimeLimit = 1,
		AreaId = 10020,
		DialogId = 2011031350,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10203007,
		Condition = 26043033,
		EventType = 1,
		Id = 10000307,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132834),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000306
		}
	},
	[10000308] = {
		TotalTimeLimit = 1,
		AreaId = 15001,
		DialogId = 2011031601,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10203008,
		Condition = 26043034,
		EventType = 1,
		Id = 10000308,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132835),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000307
		}
	},
	[10000309] = {
		TotalTimeLimit = 1,
		AreaId = 15001,
		DialogId = 2011031901,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10203009,
		Condition = 26043035,
		EventType = 1,
		Id = 10000309,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132836),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000308
		}
	},
	[10000310] = {
		TotalTimeLimit = 1,
		AreaId = 15001,
		DialogId = 2011032201,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10203010,
		Condition = 26043036,
		EventType = 1,
		Id = 10000310,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132837),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000309
		}
	},
	[10000311] = {
		TotalTimeLimit = 1,
		AreaId = 15001,
		DialogId = 2011032501,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10203011,
		Condition = 26043037,
		EventType = 1,
		Id = 10000311,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132838),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000310
		}
	},
	[10000312] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011032901,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10203012,
		Condition = 26043038,
		EventType = 1,
		Id = 10000312,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132839),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000311
		}
	},
	[10000401] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011033200,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10204001,
		Condition = 26045101,
		EventType = 1,
		Id = 10000401,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180268445),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000312
		}
	},
	[10000402] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011033400,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10204002,
		Condition = 26045102,
		EventType = 1,
		Id = 10000402,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180268446),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000401
		}
	},
	[10000403] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		DialogId = 2011033650,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10204003,
		Condition = 26045103,
		EventType = 1,
		Id = 10000403,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180268447),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000402
		}
	},
	[10000404] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		DialogId = 2011033900,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10204004,
		Condition = 26045104,
		EventType = 1,
		Id = 10000404,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180268448),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000403
		}
	},
	[10000405] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		DialogId = 2011034100,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10204005,
		Condition = 26045105,
		EventType = 1,
		Id = 10000405,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180268449),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000404
		}
	},
	[10000406] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		DialogId = 2011034300,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10204006,
		Condition = 26045106,
		EventType = 1,
		Id = 10000406,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180289110),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000405
		}
	},
	[10000407] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		DialogId = 2011034550,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10204007,
		Condition = 26045107,
		EventType = 1,
		Id = 10000407,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180289111),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000406
		}
	},
	[10000408] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		DialogId = 2011034850,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10204008,
		Condition = 26045108,
		EventType = 1,
		Id = 10000408,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180289112),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000407
		}
	},
	[10000409] = {
		TotalTimeLimit = 1,
		AreaId = 10060,
		DialogId = 2011035100,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10204009,
		Condition = 26045109,
		EventType = 1,
		Id = 10000409,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180289113),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000408
		}
	},
	[10000410] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		DialogId = 2011035350,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10204010,
		Condition = 26045110,
		EventType = 1,
		Id = 10000410,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180306797),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000409
		}
	},
	[10000411] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		DialogId = 2011035550,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10204011,
		Condition = 26045111,
		EventType = 1,
		Id = 10000411,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180306798),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000410
		}
	},
	[10000412] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		DialogId = 2011035700,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10204012,
		Condition = 26045112,
		EventType = 1,
		Id = 10000412,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180306799),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000411
		}
	},
	[10000413] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		DialogId = 2011035900,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10204013,
		Condition = 26045113,
		EventType = 1,
		Id = 10000413,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180306800),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000412
		}
	},
	[10000414] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		DialogId = 2011036200,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10204014,
		Condition = 26045114,
		EventType = 1,
		Id = 10000414,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180306801),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000413
		}
	},
	[10000415] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011036450,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10204015,
		Condition = 26045115,
		EventType = 1,
		Id = 10000415,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180306802),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000414
		}
	},
	[10000501] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011271350,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10205001,
		Condition = 26045301,
		EventType = 1,
		Id = 10000501,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180477823),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000415
		}
	},
	[10000502] = {
		TotalTimeLimit = 1,
		AreaId = 15002,
		DialogId = 2011271550,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10205002,
		Condition = 26045302,
		EventType = 1,
		Id = 10000502,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180477824),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000501
		}
	},
	[10000503] = {
		TotalTimeLimit = 1,
		AreaId = 15002,
		DialogId = 2011271800,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10205003,
		Condition = 26045303,
		EventType = 1,
		Id = 10000503,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180477825),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000502
		}
	},
	[10000504] = {
		TotalTimeLimit = 1,
		AreaId = 15002,
		DialogId = 2011272050,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10205004,
		Condition = 26045304,
		EventType = 1,
		Id = 10000504,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180477826),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000503
		}
	},
	[10000505] = {
		TotalTimeLimit = 1,
		AreaId = 15002,
		DialogId = 2011272300,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10205005,
		Condition = 26045305,
		EventType = 1,
		Id = 10000505,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180477827),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000504
		}
	},
	[10000506] = {
		TotalTimeLimit = 1,
		AreaId = 15002,
		DialogId = 2011272500,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10205006,
		Condition = 26011124,
		EventType = 1,
		Id = 10000506,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180532369),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000505
		}
	},
	[10000507] = {
		TotalTimeLimit = 1,
		AreaId = 15002,
		DialogId = 2011272800,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10205007,
		Condition = 26011124,
		EventType = 1,
		Id = 10000507,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180532370),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000506
		}
	},
	[10000508] = {
		TotalTimeLimit = 1,
		AreaId = 15002,
		DialogId = 2011273150,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10205008,
		Condition = 26011124,
		EventType = 1,
		Id = 10000508,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180532371),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000507
		}
	},
	[10000509] = {
		TotalTimeLimit = 1,
		AreaId = 15002,
		DialogId = 2011274000,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10205009,
		Condition = 26011124,
		EventType = 1,
		Id = 10000509,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180532372),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000508
		}
	},
	[10000510] = {
		TotalTimeLimit = 1,
		AreaId = 15002,
		DialogId = 2011274400,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10205010,
		Condition = 26045310,
		EventType = 1,
		Id = 10000510,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180549461),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000509
		}
	},
	[10000511] = {
		TotalTimeLimit = 1,
		AreaId = 15002,
		DialogId = 2011274800,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10205011,
		Condition = 26045311,
		EventType = 1,
		Id = 10000511,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180549462),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000510
		}
	},
	[10000512] = {
		TotalTimeLimit = 1,
		AreaId = 15002,
		DialogId = 2011275200,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10205012,
		Condition = 26045312,
		EventType = 1,
		Id = 10000512,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180549463),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000511
		}
	},
	[10000513] = {
		TotalTimeLimit = 1,
		AreaId = 15002,
		DialogId = 2011275550,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10205013,
		Condition = 26045313,
		EventType = 1,
		Id = 10000513,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180549464),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000512
		}
	},
	[10000601] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011277550,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206001,
		Condition = 26045601,
		EventType = 1,
		Id = 10000601,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180818488),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000513
		}
	},
	[10000602] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011277750,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206002,
		Condition = 26045602,
		EventType = 1,
		Id = 10000602,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180818489),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000601
		}
	},
	[10000603] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		DialogId = 2011277950,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206003,
		Condition = 26045603,
		EventType = 1,
		Id = 10000603,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180818490),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000602
		}
	},
	[10000604] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		DialogId = 2011278100,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206004,
		Condition = 26045604,
		EventType = 1,
		Id = 10000604,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180818491),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000603
		}
	},
	[10000605] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		DialogId = 2011278400,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206005,
		Condition = 26045605,
		EventType = 1,
		Id = 10000605,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180818492),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000604
		}
	},
	[10000606] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		DialogId = 2011278700,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206006,
		Condition = 26045606,
		EventType = 1,
		Id = 10000606,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180843549),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000605
		}
	},
	[10000607] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		DialogId = 2011279000,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206007,
		Condition = 26045607,
		EventType = 1,
		Id = 10000607,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180843550),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000606
		}
	},
	[10000608] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011279300,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206008,
		Condition = 26045608,
		EventType = 1,
		Id = 10000608,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180843551),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000607
		}
	},
	[10000609] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		DialogId = 2011279600,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206009,
		Condition = 26045609,
		EventType = 1,
		Id = 10000609,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180843552),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000608
		}
	},
	[10000610] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011279900,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206010,
		Condition = 26045610,
		EventType = 1,
		Id = 10000610,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180843553),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000609
		}
	},
	[10000611] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		DialogId = 2011280950,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206011,
		Condition = 26045611,
		EventType = 1,
		Id = 10000611,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180843554),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000610
		}
	},
	[10000612] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		DialogId = 2011281800,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206012,
		Condition = 26045612,
		EventType = 1,
		Id = 10000612,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180908176),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000611
		}
	},
	[10000613] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		DialogId = 2011282250,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206013,
		Condition = 26045613,
		EventType = 1,
		Id = 10000613,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180908177),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000612
		}
	},
	[10000614] = {
		TotalTimeLimit = 1,
		AreaId = 15001,
		DialogId = 2011282650,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206014,
		Condition = 26045614,
		EventType = 1,
		Id = 10000614,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180908178),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000613
		}
	},
	[10000615] = {
		TotalTimeLimit = 1,
		AreaId = 15001,
		DialogId = 2011283100,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206015,
		Condition = 26045615,
		EventType = 1,
		Id = 10000615,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180908179),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000614
		}
	},
	[10000616] = {
		TotalTimeLimit = 1,
		AreaId = 15001,
		DialogId = 2011283450,
		IconImge = "/Common/ComImage/TownUI_Image_03.png",
		Reward = 10206016,
		Condition = 26045616,
		EventType = 1,
		Id = 10000616,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180908180),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000615
		}
	},
	[10020001] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011273400,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300038,
		Condition = 28010008,
		EventType = 2,
		Id = 10020001,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180498297),
		TownAreaPros = {
			300,
			300
		}
	},
	[10020002] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011273700,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10301001,
		Condition = 28010009,
		EventType = 2,
		Id = 10020002,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180500536),
		TownAreaPros = {
			300,
			300
		}
	},
	[10020003] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011280250,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 28010010,
		EventType = 2,
		Id = 10020003,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180836533),
		TownAreaPros = {
			300,
			300
		}
	},
	[10020004] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011280600,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 28010011,
		EventType = 2,
		Id = 10020004,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180836534),
		TownAreaPros = {
			300,
			300
		}
	},
	[10020005] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011281350,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 28010012,
		EventType = 2,
		Id = 10020005,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180843561),
		TownAreaPros = {
			300,
			300
		}
	},
	[10020006] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2112043000,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10301002,
		Condition = 28010015,
		EventType = 2,
		Id = 10020006,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180934780),
		TownAreaPros = {
			300,
			300
		}
	},
	[10020007] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2112043500,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 28010016,
		EventType = 2,
		Id = 10020007,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180935731),
		TownAreaPros = {
			300,
			300
		}
	},
	[10020008] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2112043800,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 28010017,
		EventType = 2,
		Id = 10020008,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180939084),
		TownAreaPros = {
			300,
			300
		}
	},
	[10020101] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		DialogId = 2111120600,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300001,
		Condition = 26045001,
		EventType = 2,
		Id = 10020101,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132840),
		TownAreaPros = {
			300,
			300
		}
	},
	[10020155] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		DialogId = 10206300,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300002,
		Condition = 26011008,
		EventType = 2,
		Id = 10020155,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132841),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020101
		}
	},
	[10020102] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2111090000,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300003,
		Condition = 26045002,
		EventType = 2,
		Id = 10020102,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132842),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000114,
			10020111
		}
	},
	[10020103] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		DialogId = 2112041000,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300004,
		Condition = 26045003,
		EventType = 2,
		Id = 10020103,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132843),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000101,
			10020155
		}
	},
	[10020104] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		DialogId = 2111060400,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300005,
		Condition = 26045004,
		EventType = 2,
		Id = 10020104,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132844),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020103
		}
	},
	[10020105] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		DialogId = 2011270000,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300006,
		Condition = 26045005,
		EventType = 2,
		Id = 10020105,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132845),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020104
		}
	},
	[10020106] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		DialogId = 2111080000,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300007,
		Condition = 26045006,
		EventType = 2,
		Id = 10020106,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132846),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020105
		}
	},
	[10020107] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2111120400,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Condition = 26045007,
		EventType = 2,
		Reward = 10300008,
		Id = 10020107,
		RoomId = 9,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132847),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020106
		}
	},
	[10020158] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		DialogId = 1800010510,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300009,
		Condition = 26043005,
		EventType = 2,
		Id = 10020158,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132848),
		TownAreaPros = {
			300,
			300
		}
	},
	[10020108] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		DialogId = 2111010600,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300010,
		Condition = 26045008,
		EventType = 2,
		Id = 10020108,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132849),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020107
		}
	},
	[10020156] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		DialogId = 2111010000,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300011,
		Condition = 26045008,
		EventType = 2,
		Id = 10020156,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132850),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020108
		}
	},
	[10020109] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		DialogId = 2111120000,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300012,
		Condition = 26045009,
		EventType = 2,
		Id = 10020109,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132851),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000106,
			10020108
		}
	},
	[10020110] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2111020500,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300013,
		Condition = 26045010,
		EventType = 2,
		Id = 10020110,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132852),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000108,
			10020109
		}
	},
	[10020111] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2111030400,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300014,
		Condition = 26045011,
		EventType = 2,
		Id = 10020111,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132853),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020110
		}
	},
	[10020112] = {
		TotalTimeLimit = 1,
		AreaId = 10020,
		DialogId = 2111000400,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300015,
		Condition = 26045012,
		EventType = 2,
		Id = 10020112,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132854),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020102
		}
	},
	[10020113] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		DialogId = 2111100000,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300016,
		Condition = 26045013,
		EventType = 2,
		Id = 10020113,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132855),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020112
		}
	},
	[10020114] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		DialogId = 2111030600,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300017,
		Condition = 26045014,
		EventType = 2,
		Id = 10020114,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132856),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020113
		}
	},
	[10020115] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2111110000,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300018,
		Condition = 26045015,
		EventType = 2,
		Id = 10020115,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132857),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020114
		}
	},
	[10020157] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2111020000,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300019,
		Condition = 26045015,
		EventType = 2,
		Id = 10020157,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132858),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020115
		}
	},
	[10020116] = {
		TotalTimeLimit = 1,
		AreaId = 10020,
		DialogId = 2111130000,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300020,
		Condition = 26045016,
		EventType = 2,
		Id = 10020116,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132859),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020115
		}
	},
	[10020117] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		DialogId = 2111140000,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300021,
		Condition = 26045017,
		EventType = 2,
		Id = 10020117,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132860),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020116
		}
	},
	[10020118] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		DialogId = 2111080100,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300022,
		Condition = 26045018,
		EventType = 2,
		Id = 10020118,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132861),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020117
		}
	},
	[10020119] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		DialogId = 2111080300,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300023,
		Condition = 26045019,
		EventType = 2,
		Id = 10020119,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132862),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020118
		}
	},
	[10020120] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		DialogId = 2111030700,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300024,
		Condition = 26045020,
		EventType = 2,
		Id = 10020120,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132863),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020119
		}
	},
	[10020121] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		DialogId = 2111100100,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300025,
		Condition = 26045021,
		EventType = 2,
		Id = 10020121,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132864),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020120
		}
	},
	[10020122] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		DialogId = 2111120200,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300026,
		Condition = 26045022,
		EventType = 2,
		Id = 10020122,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132865),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020121
		}
	},
	[10020123] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		DialogId = 2111010700,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300027,
		Condition = 26045023,
		EventType = 2,
		Id = 10020123,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132866),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020122
		}
	},
	[10020124] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2111090200,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300028,
		Condition = 26045024,
		EventType = 2,
		Id = 10020124,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132867),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020123
		}
	},
	[10020125] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2111110100,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300029,
		Condition = 26045025,
		EventType = 2,
		Id = 10020125,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132868),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10020124
		}
	},
	[10021001] = {
		TotalTimeLimit = 1,
		AreaId = 10060,
		DialogId = 2112041100,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300030,
		Condition = 26045026,
		EventType = 2,
		Id = 10021001,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132869),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000301
		}
	},
	[10021002] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		DialogId = 2112041300,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300031,
		Condition = 26045027,
		EventType = 2,
		Id = 10021002,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132870),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000302
		}
	},
	[10021003] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		DialogId = 2112041900,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300032,
		Condition = 26045028,
		EventType = 2,
		Id = 10021003,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132871),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021002
		}
	},
	[10021004] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		DialogId = 2112042000,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300033,
		Condition = 26045028,
		EventType = 2,
		Id = 10021004,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132872),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021003
		}
	},
	[10021005] = {
		TotalTimeLimit = 1,
		AreaId = 10060,
		DialogId = 2112042100,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300034,
		Condition = 26045030,
		EventType = 2,
		Id = 10021005,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132873),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021004
		}
	},
	[10021006] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		DialogId = 2112041500,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300035,
		Condition = 26045031,
		EventType = 2,
		Id = 10021006,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132874),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021005
		}
	},
	[10021007] = {
		TotalTimeLimit = 1,
		AreaId = 10060,
		DialogId = 2112041700,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300036,
		Condition = 26045032,
		EventType = 2,
		Id = 10021007,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132875),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021006
		}
	},
	[10021008] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2112042300,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300037,
		Condition = 26045033,
		EventType = 2,
		Id = 10021008,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132876),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021007
		}
	},
	[10021009] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2112042500,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300038,
		Condition = 26045034,
		EventType = 2,
		Id = 10021009,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132877),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021008
		}
	},
	[10021010] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 1110190100,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300039,
		Condition = 26045035,
		EventType = 2,
		Id = 10021010,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132878),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021009
		}
	},
	[10021101] = {
		TotalTimeLimit = 1,
		AreaId = 10020,
		DialogId = 1110190301,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300040,
		Condition = 26045151,
		EventType = 2,
		Id = 10021101,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180268450),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000405
		}
	},
	[10021102] = {
		TotalTimeLimit = 1,
		AreaId = 10020,
		DialogId = 2011270100,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300041,
		Condition = 26045152,
		EventType = 2,
		Id = 10021102,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180268451),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021101
		}
	},
	[10021103] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011270350,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300042,
		Condition = 26045153,
		EventType = 2,
		Id = 10021103,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180451184),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021102
		}
	},
	[10021104] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		DialogId = 2011270550,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300043,
		Condition = 26045154,
		EventType = 2,
		Id = 10021104,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180451185),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000408,
			10021103
		}
	},
	[10021105] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		DialogId = 2011270250,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300044,
		Condition = 26045155,
		EventType = 2,
		Id = 10021105,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180451186),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021104
		}
	},
	[10021106] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011270750,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300045,
		Condition = 26045156,
		EventType = 2,
		Id = 10021106,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180451187),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021105
		}
	},
	[10021107] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		DialogId = 2011270900,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300046,
		Condition = 26045157,
		EventType = 2,
		Id = 10021107,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180456001),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021106
		}
	},
	[10021108] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011271150,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 26045158,
		EventType = 2,
		Id = 10021108,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180456002),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021107
		}
	},
	[10021109] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		DialogId = 2011276000,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300046,
		Condition = 26045301,
		EventType = 2,
		Id = 10021109,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180560866),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021108
		}
	},
	[10021110] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		DialogId = 2011276150,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 26045302,
		EventType = 2,
		Id = 10021110,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180560867),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021109
		}
	},
	[10021111] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		DialogId = 2011276350,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300046,
		Condition = 26045403,
		EventType = 2,
		Id = 10021111,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180765036),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021110
		}
	},
	[10021112] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		DialogId = 2011276450,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 26045404,
		EventType = 2,
		Id = 10021112,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180765037),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021111
		}
	},
	[10021113] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		DialogId = 2011276700,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300046,
		Condition = 26045405,
		EventType = 2,
		Id = 10021113,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180767951),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021112
		}
	},
	[10021114] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		DialogId = 2011276850,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 26045406,
		EventType = 2,
		Id = 10021114,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180767952),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021113
		}
	},
	[10021115] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		DialogId = 2011277050,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300046,
		Condition = 26045407,
		EventType = 2,
		Id = 10021115,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180767953),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10021114
		}
	},
	[10021116] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		DialogId = 2011277250,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 26045313,
		EventType = 2,
		Id = 10021116,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180767954),
		TownAreaPros = {
			300,
			300
		},
		PreEvent = {
			10000513
		}
	},
	[10021117] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 26011056,
		EventType = 2,
		Id = 10021117,
		DialogId = 2011281580,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180895967),
		PreEvent = {
			10020117,
			10000601
		}
	},
	[10021118] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 26011056,
		EventType = 2,
		Id = 10021118,
		DialogId = 2011281680,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180895968),
		PreEvent = {
			10021117
		}
	},
	[10021119] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 26011056,
		EventType = 2,
		Id = 10021119,
		DialogId = 2011283900,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180901279),
		PreEvent = {
			10021118
		}
	},
	[10021120] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 26011056,
		EventType = 2,
		Id = 10021120,
		DialogId = 2011284100,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180901280),
		PreEvent = {
			10021119
		}
	},
	[10021121] = {
		TotalTimeLimit = 1,
		AreaId = 10060,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 26011056,
		EventType = 2,
		Id = 10021121,
		DialogId = 2011284250,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180912305),
		PreEvent = {
			10021120
		}
	},
	[10021122] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 26011056,
		EventType = 2,
		Id = 10021122,
		DialogId = 2011284400,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180912306),
		PreEvent = {
			10021121
		}
	},
	[10021123] = {
		TotalTimeLimit = 1,
		AreaId = 10040,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 26045408,
		EventType = 2,
		Id = 10021123,
		DialogId = 2011284500,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180919099),
		PreEvent = {
			10021122
		}
	},
	[10021124] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10300047,
		Condition = 26045409,
		EventType = 2,
		Id = 10021124,
		DialogId = 2011284750,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180919100),
		PreEvent = {
			10021123
		}
	},
	[20000201] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310001,
		Condition = 26011926,
		EventType = 2,
		Id = 20000201,
		DialogId = 2111030000,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132879),
		PreEvent = {
			10000107
		}
	},
	[20000202] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310002,
		Condition = 26011926,
		EventType = 2,
		Id = 20000202,
		DialogId = 2111030100,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132880),
		PreEvent = {
			20000201
		}
	},
	[20000203] = {
		TotalTimeLimit = 1,
		AreaId = 10080,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310003,
		Condition = 26011926,
		EventType = 2,
		Id = 20000203,
		DialogId = 2111030200,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132881),
		PreEvent = {
			20000202
		}
	},
	[20000204] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310004,
		Condition = 26011926,
		EventType = 2,
		Id = 20000204,
		DialogId = 2111030300,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132882),
		PreEvent = {
			20000203
		}
	},
	[20000301] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310005,
		Condition = 26011926,
		EventType = 2,
		Id = 20000301,
		DialogId = 2111040000,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132883)
	},
	[20000302] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310006,
		Condition = 26011926,
		EventType = 2,
		Id = 20000302,
		DialogId = 2111040100,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132884),
		PreEvent = {
			20000301
		}
	},
	[20000303] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310007,
		Condition = 26011926,
		EventType = 2,
		Id = 20000303,
		DialogId = 2111040200,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132885),
		PreEvent = {
			20000302
		}
	},
	[20000304] = {
		TotalTimeLimit = 1,
		AreaId = 10090,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310008,
		Condition = 26011926,
		EventType = 2,
		Id = 20000304,
		DialogId = 2111040300,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132886),
		PreEvent = {
			20000303
		}
	},
	[20000401] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310009,
		Condition = 26011926,
		EventType = 2,
		Id = 20000401,
		DialogId = 2111050000,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132887)
	},
	[20000402] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310010,
		Condition = 26011926,
		EventType = 2,
		Id = 20000402,
		DialogId = 2111050100,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132888),
		PreEvent = {
			20000401
		}
	},
	[20000403] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310011,
		Condition = 26011926,
		EventType = 2,
		Id = 20000403,
		DialogId = 2111050200,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132889),
		PreEvent = {
			20000402
		}
	},
	[20000404] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310012,
		Condition = 26011926,
		EventType = 2,
		Id = 20000404,
		DialogId = 2111050300,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132890),
		PreEvent = {
			20000403
		}
	},
	[20000501] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310013,
		Condition = 26011926,
		EventType = 2,
		Id = 20000501,
		DialogId = 2111010000,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132891)
	},
	[20000502] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310014,
		Condition = 26011926,
		EventType = 2,
		Id = 20000502,
		DialogId = 2111010100,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132892),
		PreEvent = {
			20000501
		}
	},
	[20000503] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310015,
		Condition = 26011926,
		EventType = 2,
		Id = 20000503,
		DialogId = 2111010200,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132893),
		PreEvent = {
			20000502
		}
	},
	[20000504] = {
		TotalTimeLimit = 1,
		AreaId = 10070,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310016,
		Condition = 26011926,
		EventType = 2,
		Id = 20000504,
		DialogId = 2111010300,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132894),
		PreEvent = {
			20000503
		}
	},
	[20000601] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310017,
		Condition = 26011926,
		EventType = 2,
		Id = 20000601,
		DialogId = 2111000000,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132895),
		PreEvent = {
			10000107
		}
	},
	[20000602] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310018,
		Condition = 26011926,
		EventType = 2,
		Id = 20000602,
		DialogId = 2111000100,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132896),
		PreEvent = {
			20000601
		}
	},
	[20000603] = {
		TotalTimeLimit = 1,
		AreaId = 10010,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310019,
		Condition = 26011926,
		EventType = 2,
		Id = 20000603,
		DialogId = 2111000200,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132897),
		PreEvent = {
			20000602
		}
	},
	[20000604] = {
		TotalTimeLimit = 1,
		AreaId = 10050,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310020,
		Condition = 26011926,
		EventType = 2,
		Id = 20000604,
		DialogId = 2111000300,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132898),
		PreEvent = {
			20000603
		}
	},
	[20000701] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310021,
		Condition = 26011926,
		EventType = 2,
		Id = 20000701,
		DialogId = 2111060000,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132899)
	},
	[20000702] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310022,
		Condition = 26011926,
		EventType = 2,
		Id = 20000702,
		DialogId = 2111060100,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132900),
		PreEvent = {
			20000701
		}
	},
	[20000703] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310023,
		Condition = 26011926,
		EventType = 2,
		Id = 20000703,
		DialogId = 2111060200,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132901),
		PreEvent = {
			20000702
		}
	},
	[20000704] = {
		TotalTimeLimit = 1,
		AreaId = 10030,
		IconImge = "/Common/ComImage/TownUI_Image_04.png",
		Reward = 10310024,
		Condition = 26011926,
		EventType = 2,
		Id = 20000704,
		DialogId = 2111060300,
		RecordsInArchives = true,
		Type = {
			1,
			0
		},
		Name = getI18NValue(180132902),
		PreEvent = {
			20000703
		}
	}
}

setmetatable(CfgTownEventTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTownEventTable]")
	end
})

local defaultMetaTable = {
	__index = {
		IsEnd = 0,
		Join = 0,
		RoomId = 0,
		TownSpine = 0,
		TotalTimeLimit = 0,
		EventType = 0,
		Name = "",
		IconImge = "",
		Reward = 0,
		AreaId = 0,
		Condition = 0,
		DayTimeLimit = 0,
		Redirect = 0,
		DialogId = 0,
		RecordsInArchives = false,
		TownAreaPros = {},
		Weight = {},
		Type = {},
		PreEvent = {},
		PriorWeight = {}
	}
}

for i, data in pairs(CfgTownEventTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTownEventTable
