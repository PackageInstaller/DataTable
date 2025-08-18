-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResHeroProficientLevel.lua

local RT = {}

RT[1] = {
	12,
	14
}
RT[2] = {
	300,
	300
}
RT[3] = {
	600,
	600
}
RT[4] = {
	900,
	900
}
RT[5] = {
	1200,
	1200
}
RT[6] = {
	1500,
	1500
}

local Data = {
	{
		group_score = 4,
		total_score = 0,
		level = 1,
		attrs = {
			14
		},
		value = {
			300
		}
	},
	{
		group_score = 8,
		total_score = 0,
		level = 2,
		attrs = RT[1],
		value = RT[2]
	},
	{
		group_score = 12,
		state_id = 830001,
		total_score = 50,
		level = 3,
		attrs = RT[1],
		state_desc = Lang.get(4514),
		value = RT[2]
	},
	{
		group_score = 16,
		total_score = 50,
		level = 4,
		attrs = RT[1],
		value = {
			300,
			600
		}
	},
	{
		group_score = 20,
		total_score = 50,
		level = 5,
		attrs = RT[1],
		value = RT[3]
	},
	{
		group_score = 25,
		state_id = 830002,
		total_score = 120,
		level = 6,
		attrs = RT[1],
		state_desc = Lang.get(4515),
		value = RT[3]
	},
	{
		group_score = 30,
		total_score = 120,
		level = 7,
		attrs = RT[1],
		value = {
			600,
			900
		}
	},
	{
		group_score = 35,
		total_score = 120,
		level = 8,
		attrs = RT[1],
		value = RT[4]
	},
	{
		group_score = 40,
		state_id = 830003,
		total_score = 200,
		level = 9,
		attrs = RT[1],
		state_desc = Lang.get(4516),
		value = RT[4]
	},
	{
		group_score = 50,
		total_score = 240,
		level = 10,
		attrs = RT[1],
		value = {
			900,
			1200
		}
	},
	{
		group_score = 60,
		total_score = 320,
		level = 11,
		attrs = RT[1],
		value = RT[5]
	},
	{
		group_score = 70,
		state_id = 830004,
		total_score = 380,
		level = 12,
		attrs = RT[1],
		state_desc = Lang.get(4517),
		value = RT[5]
	},
	{
		group_score = 80,
		total_score = 440,
		level = 13,
		attrs = RT[1],
		value = {
			1200,
			1500
		}
	},
	{
		group_score = 90,
		total_score = 500,
		level = 14,
		attrs = RT[1],
		value = RT[6]
	},
	{
		group_score = 100,
		state_id = 830005,
		total_score = 560,
		level = 15,
		attrs = RT[1],
		state_desc = Lang.get(4518),
		value = RT[6]
	},
	{
		group_score = 110,
		total_score = 640,
		level = 16,
		attrs = RT[1],
		value = {
			1500,
			1800
		}
	},
	{
		group_score = 120,
		total_score = 720,
		level = 17,
		attrs = RT[1],
		value = {
			1800,
			1800
		}
	},
	{
		group_score = 150,
		total_score = 900,
		level = 18,
		attrs = RT[1],
		value = {
			1800,
			2000
		}
	},
	{
		group_score = 180,
		total_score = 1080,
		level = 19,
		attrs = RT[1],
		value = {
			2000,
			2000
		}
	},
	{
		group_score = 210,
		total_score = 1260,
		level = 20,
		attrs = RT[1],
		value = {
			2000,
			2200
		}
	},
	{
		group_score = 240,
		total_score = 1440,
		level = 21,
		attrs = RT[1],
		value = {
			2200,
			2200
		}
	},
	{
		group_score = 270,
		total_score = 1620,
		level = 22,
		attrs = RT[1],
		value = {
			2200,
			2400
		}
	},
	{
		group_score = 300,
		total_score = 1800,
		level = 23,
		attrs = RT[1],
		value = {
			2400,
			2400
		}
	},
	{
		group_score = 330,
		total_score = 1980,
		level = 24,
		attrs = RT[1],
		value = {
			2400,
			2600
		}
	},
	{
		group_score = 360,
		total_score = 2160,
		level = 25,
		attrs = RT[1],
		value = {
			2600,
			2600
		}
	},
	{
		group_score = 400,
		total_score = 2400,
		level = 26,
		attrs = RT[1],
		value = {
			2600,
			2800
		}
	}
}

return Data
