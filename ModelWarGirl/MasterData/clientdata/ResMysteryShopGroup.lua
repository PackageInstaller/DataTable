-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResMysteryShopGroup.lua

local RT = {}

RT[1] = {
	1
}
RT[2] = {
	50,
	20,
	10,
	10,
	6,
	2,
	2
}
RT[3] = {
	91025,
	91026,
	91027
}
RT[4] = {
	5,
	5,
	5
}
RT[5] = {
	109400,
	109401,
	109402,
	109403,
	109404,
	109405,
	109406,
	109407,
	109408,
	109409,
	109410,
	109411,
	109412,
	109413,
	109414,
	109415,
	109416,
	109417
}
RT[6] = {
	8,
	10,
	10,
	10,
	7,
	10,
	10,
	10,
	5,
	5,
	7,
	10,
	10,
	10,
	7,
	10,
	10,
	10
}
RT[7] = {
	900004,
	900004,
	900004,
	900004,
	900005,
	900005,
	900005,
	900005,
	0,
	0,
	900006,
	900006,
	900006,
	900006,
	900007,
	900007,
	900007,
	900007
}
RT[8] = {
	0,
	1,
	1,
	1,
	0,
	2,
	2,
	2,
	0,
	0,
	0,
	3,
	3,
	3,
	0,
	4,
	4,
	4
}
RT[9] = {
	0,
	80,
	80,
	80,
	0,
	80,
	80,
	80,
	0,
	0,
	0,
	80,
	80,
	80,
	0,
	80,
	80,
	80
}
RT[10] = {
	91000,
	91001,
	91003,
	91004
}
RT[11] = {
	91000,
	91001,
	91002,
	91003,
	91004,
	91005
}
RT[12] = {
	91006,
	91007,
	91022,
	91023,
	91024,
	91009,
	91010,
	91012,
	91013
}

local Data = {
	{
		group_type = 1,
		goods_type = 1,
		group_id = 1,
		goods_id = {
			90001,
			90002,
			90003,
			90004,
			90005
		},
		goods_weight = {
			15,
			25,
			20,
			20,
			20
		}
	},
	{
		group_type = 2,
		goods_type = 1,
		group_id = 2,
		goods_id = {
			90006,
			90007,
			90008,
			90009,
			90010,
			90011,
			90012,
			90013,
			90014,
			90015
		},
		goods_weight = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10
		}
	},
	{
		group_type = 1,
		goods_type = 2,
		group_id = 3,
		goods_id = {
			102466
		},
		goods_weight = RT[1]
	},
	{
		group_type = 1,
		goods_type = 2,
		group_id = 4,
		goods_id = {
			102467
		},
		goods_weight = RT[1]
	},
	{
		group_type = 1,
		goods_type = 2,
		group_id = 5,
		goods_id = {
			102468
		},
		goods_weight = RT[1]
	},
	{
		group_type = 1,
		goods_type = 2,
		group_id = 6,
		goods_id = {
			102469
		},
		goods_weight = RT[1]
	},
	{
		group_type = 1,
		goods_type = 2,
		group_id = 7,
		goods_id = {
			102470
		},
		goods_weight = RT[1]
	},
	{
		group_type = 1,
		goods_type = 2,
		group_id = 8,
		goods_id = {
			102471
		},
		goods_weight = RT[1]
	},
	[101] = {
		group_type = 1,
		goods_type = 1,
		group_id = 101,
		goods_id = {
			91000,
			91003
		},
		goods_weight = {
			3,
			1
		}
	},
	[102] = {
		group_type = 1,
		goods_type = 1,
		check_item = 500022,
		group_id = 102,
		goods_id = {
			91006,
			91008,
			91009,
			91010,
			91011,
			91012,
			91013
		},
		goods_weight = RT[2],
		replace_goods_weight = RT[2]
	},
	[103] = {
		group_type = 1,
		goods_type = 1,
		group_id = 103,
		goods_id = RT[3],
		goods_weight = RT[4]
	},
	[104] = {
		goods_type = 2,
		group_type = 1,
		group_id = 104,
		goods_id = RT[5],
		goods_limit = RT[7],
		goods_weight = RT[6],
		group_rate = RT[9],
		rechage_group = RT[8]
	},
	[111] = {
		group_type = 1,
		goods_type = 1,
		group_id = 111,
		goods_id = RT[10],
		goods_weight = {
			50,
			25,
			17,
			8
		}
	},
	[112] = {
		group_type = 1,
		goods_type = 1,
		check_item = 500022,
		group_id = 112,
		goods_id = {
			91006,
			91007,
			91008,
			91009,
			91010,
			91011,
			91012,
			91013
		},
		goods_weight = {
			40,
			20,
			10,
			10,
			10,
			4,
			3,
			3
		},
		replace_goods_weight = {
			60,
			20,
			10,
			10,
			10,
			4,
			3,
			3
		}
	},
	[113] = {
		group_type = 1,
		goods_type = 1,
		group_id = 113,
		goods_id = RT[3],
		goods_weight = RT[4]
	},
	[114] = {
		goods_type = 2,
		group_type = 1,
		group_id = 114,
		goods_id = RT[5],
		goods_limit = RT[7],
		goods_weight = RT[6],
		group_rate = RT[9],
		rechage_group = RT[8]
	},
	[121] = {
		group_type = 1,
		goods_type = 1,
		group_id = 121,
		goods_id = RT[10],
		goods_weight = {
			40,
			25,
			15,
			10
		}
	},
	[122] = {
		group_type = 1,
		goods_type = 1,
		check_item = 500022,
		group_id = 122,
		goods_id = {
			91006,
			91007,
			91023,
			91024,
			91008,
			91009,
			91010,
			91011,
			91012,
			91013
		},
		goods_weight = {
			30,
			20,
			15,
			6,
			5,
			8,
			8,
			2,
			3,
			3
		},
		replace_goods_weight = {
			70,
			20,
			15,
			6,
			5,
			8,
			8,
			2,
			3,
			3
		}
	},
	[123] = {
		group_type = 1,
		goods_type = 1,
		group_id = 123,
		goods_id = RT[3],
		goods_weight = RT[4]
	},
	[124] = {
		goods_type = 2,
		group_type = 1,
		group_id = 124,
		goods_id = RT[5],
		goods_limit = RT[7],
		goods_weight = RT[6],
		group_rate = RT[9],
		rechage_group = RT[8]
	},
	[131] = {
		group_type = 1,
		goods_type = 1,
		group_id = 131,
		goods_id = RT[11],
		goods_weight = {
			30,
			25,
			20,
			12,
			10,
			3
		}
	},
	[132] = {
		group_type = 1,
		goods_type = 1,
		check_item = 500022,
		group_id = 132,
		goods_id = RT[12],
		goods_weight = {
			20,
			20,
			20,
			15,
			7,
			6,
			6,
			3,
			3
		},
		replace_goods_weight = {
			80,
			20,
			20,
			15,
			7,
			6,
			6,
			3,
			3
		}
	},
	[133] = {
		group_type = 1,
		goods_type = 1,
		group_id = 133,
		goods_id = RT[3],
		goods_weight = RT[4]
	},
	[134] = {
		goods_type = 2,
		group_type = 1,
		group_id = 134,
		goods_id = RT[5],
		goods_limit = RT[7],
		goods_weight = RT[6],
		group_rate = RT[9],
		rechage_group = RT[8]
	},
	[141] = {
		group_type = 1,
		goods_type = 1,
		group_id = 141,
		goods_id = RT[11],
		goods_weight = {
			20,
			25,
			30,
			11,
			10,
			4
		}
	},
	[142] = {
		group_type = 1,
		goods_type = 1,
		check_item = 500022,
		group_id = 142,
		goods_id = RT[12],
		goods_weight = {
			15,
			20,
			20,
			17,
			10,
			6,
			6,
			3,
			3
		},
		replace_goods_weight = {
			85,
			20,
			20,
			17,
			10,
			6,
			6,
			3,
			3
		}
	},
	[143] = {
		group_type = 1,
		goods_type = 1,
		group_id = 143,
		goods_id = RT[3],
		goods_weight = RT[4]
	},
	[144] = {
		goods_type = 2,
		group_type = 1,
		group_id = 144,
		goods_id = RT[5],
		goods_limit = RT[7],
		goods_weight = RT[6],
		group_rate = RT[9],
		rechage_group = RT[8]
	},
	[151] = {
		group_type = 1,
		goods_type = 1,
		group_id = 151,
		goods_id = RT[11],
		goods_weight = {
			10,
			30,
			35,
			10,
			10,
			5
		}
	},
	[152] = {
		group_type = 1,
		goods_type = 1,
		check_item = 500022,
		group_id = 152,
		goods_id = RT[12],
		goods_weight = {
			10,
			20,
			20,
			20,
			12,
			6,
			6,
			3,
			3
		},
		replace_goods_weight = {
			90,
			20,
			20,
			20,
			12,
			6,
			6,
			3,
			3
		}
	},
	[153] = {
		group_type = 1,
		goods_type = 1,
		group_id = 153,
		goods_id = RT[3],
		goods_weight = RT[4]
	},
	[154] = {
		goods_type = 2,
		group_type = 1,
		group_id = 154,
		goods_id = RT[5],
		goods_limit = RT[7],
		goods_weight = RT[6],
		group_rate = RT[9],
		rechage_group = RT[8]
	},
	[161] = {
		group_type = 1,
		goods_type = 1,
		group_id = 161,
		goods_id = RT[11],
		goods_weight = {
			5,
			30,
			40,
			10,
			10,
			5
		}
	},
	[162] = {
		group_type = 1,
		goods_type = 1,
		check_item = 500022,
		group_id = 162,
		goods_id = RT[12],
		goods_weight = {
			10,
			20,
			17,
			20,
			15,
			6,
			6,
			3,
			3
		},
		replace_goods_weight = {
			90,
			20,
			17,
			20,
			15,
			6,
			6,
			3,
			3
		}
	},
	[163] = {
		group_type = 1,
		goods_type = 1,
		group_id = 163,
		goods_id = RT[3],
		goods_weight = RT[4]
	},
	[164] = {
		goods_type = 2,
		group_type = 1,
		group_id = 164,
		goods_id = RT[5],
		goods_limit = RT[7],
		goods_weight = RT[6],
		group_rate = RT[9],
		rechage_group = RT[8]
	}
}

return Data
