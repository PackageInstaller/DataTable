-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResSeasonRelicOp.lua

local RT = {}

RT[1] = {
	{
		id = 510019,
		num = 1250
	},
	{
		id = 510020,
		num = 2500
	}
}
RT[2] = {
	{
		id = 510019,
		num = 5000
	},
	{
		id = 510020,
		num = 10000
	}
}

local Data = {
	[730000] = {
		{
			{
				param = 1,
				limit_id = 39,
				optype = 1,
				id = 730000,
				use = RT[1]
			}
		},
		{
			{
				id = 730000,
				param = 1,
				optype = 2,
				use = RT[1]
			},
			{
				id = 730000,
				param = 2,
				optype = 2,
				use = RT[2]
			}
		}
	},
	[730001] = {
		{
			{
				param = 1,
				limit_id = 40,
				optype = 1,
				id = 730001,
				use = RT[1]
			}
		},
		{
			{
				id = 730001,
				param = 1,
				optype = 2,
				use = RT[1]
			},
			{
				id = 730001,
				param = 2,
				optype = 2,
				use = RT[2]
			}
		}
	},
	[730002] = {
		{
			{
				param = 1,
				limit_id = 52,
				optype = 1,
				id = 730002,
				use = RT[1]
			}
		},
		{
			{
				id = 730002,
				param = 1,
				optype = 2,
				use = RT[1]
			},
			{
				id = 730002,
				param = 2,
				optype = 2,
				use = RT[2]
			}
		}
	},
	[730003] = {
		{
			{
				param = 1,
				limit_id = 51,
				optype = 1,
				id = 730003,
				use = RT[1]
			}
		},
		{
			{
				id = 730003,
				param = 1,
				optype = 2,
				use = RT[1]
			},
			{
				id = 730003,
				param = 2,
				optype = 2,
				use = RT[2]
			}
		}
	},
	[730004] = {
		{
			{
				param = 1,
				limit_id = 65,
				optype = 1,
				id = 730004,
				use = RT[1]
			}
		},
		{
			{
				id = 730004,
				param = 1,
				optype = 2,
				use = RT[1]
			},
			{
				id = 730004,
				param = 2,
				optype = 2,
				use = RT[2]
			}
		}
	},
	[730005] = {
		{
			{
				param = 1,
				limit_id = 66,
				optype = 1,
				id = 730005,
				use = RT[1]
			}
		},
		{
			{
				id = 730005,
				param = 1,
				optype = 2,
				use = RT[1]
			},
			{
				id = 730005,
				param = 2,
				optype = 2,
				use = RT[2]
			}
		}
	}
}

return Data
