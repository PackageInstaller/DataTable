-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResBattleSuppress.lua

local RT = {}

RT[1] = {
	{
		threshold = 50,
		param = {
			0.4,
			0.25,
			0.15,
			0.1,
			0.1,
			0
		}
	}
}
RT[2] = {
	{
		threshold = 30,
		param = {
			0.25,
			0.25,
			0.2,
			0.15,
			0.15,
			0
		}
	}
}
RT[3] = {
	0.25,
	0.25,
	0.2,
	0.15,
	0.15,
	0
}
RT[4] = {
	{
		threshold = 1000,
		param = {
			0.25,
			0.25,
			0.2,
			0.15,
			0.15,
			0
		}
	}
}
RT[5] = {
	{
		threshold = 1000,
		param = {
			0.22,
			0.22,
			0.17,
			0.13,
			0.13,
			0.13
		}
	}
}
RT[6] = {
	{
		threshold = 200,
		param = {
			0.2,
			0.2,
			0.2,
			0.2,
			0.2,
			0
		}
	}
}

local Data = {
	[102] = {
		suppress_type = 1,
		suppress_id = 102,
		dynamic_level = RT[1]
	},
	[103] = {
		suppress_type = 1,
		suppress_id = 103,
		dynamic_level = RT[1]
	},
	[105] = {
		suppress_type = 1,
		suppress_id = 105,
		dynamic_level = RT[2]
	},
	[201] = {
		suppress_type = 1,
		suppress_id = 201,
		dynamic_level = RT[4]
	},
	[202] = {
		suppress_type = 1,
		suppress_id = 202,
		dynamic_level = RT[4]
	},
	[210] = {
		suppress_type = 3,
		suppress_id = 210,
		dynamic_level = RT[2]
	},
	[211] = {
		suppress_type = 1,
		suppress_id = 211,
		dynamic_level = RT[2]
	},
	[212] = {
		suppress_type = 3,
		suppress_id = 212,
		dynamic_level = RT[2]
	},
	[401] = {
		suppress_type = 4,
		suppress_id = 401,
		dynamic_level = RT[5]
	},
	[402] = {
		suppress_type = 4,
		suppress_id = 402,
		dynamic_level = RT[5]
	},
	[501] = {
		suppress_type = 2,
		suppress_id = 501,
		dynamic_level = RT[6]
	},
	[502] = {
		suppress_type = 2,
		suppress_id = 502,
		dynamic_level = RT[6]
	},
	[503] = {
		suppress_type = 2,
		suppress_id = 503,
		dynamic_level = RT[6]
	},
	[504] = {
		suppress_type = 2,
		suppress_id = 504,
		dynamic_level = RT[6]
	},
	[505] = {
		suppress_type = 2,
		suppress_id = 505,
		dynamic_level = RT[6]
	}
}

return Data
