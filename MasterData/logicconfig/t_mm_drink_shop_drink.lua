-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mm_drink_shop_drink.lua

module("logicconfig.config.t_mm_drink_shop_drink", package.seeall)

local title = {
	drinkId = 2,
	makeSeconds = 3,
	stepTypeCountArr = 6,
	stepToppingsPlanIdArr = 5,
	activityId = 1,
	gainScore = 4
}
local dataList = {
	{
		596001,
		1001,
		60,
		20,
		{
			1,
			2,
			3
		},
		{
			2,
			1,
			1
		}
	},
	{
		596001,
		1002,
		60,
		20,
		{
			4,
			5,
			6
		},
		{
			1,
			1,
			1
		}
	},
	{
		596001,
		1003,
		60,
		20,
		{
			7,
			8,
			9
		},
		{
			2,
			1,
			1
		}
	},
	{
		596001,
		1004,
		60,
		20,
		{
			10,
			11,
			12
		},
		{
			2,
			1,
			1
		}
	},
	{
		596001,
		1005,
		60,
		20,
		{
			13,
			14,
			15
		},
		{
			2,
			1,
			1
		}
	},
	{
		596001,
		1006,
		60,
		20,
		{
			16,
			17,
			18
		},
		{
			2,
			1,
			1
		}
	},
	{
		596001,
		1007,
		60,
		20,
		{
			19,
			20,
			21
		},
		{
			2,
			1,
			1
		}
	},
	{
		596001,
		1008,
		60,
		20,
		{
			22,
			23,
			24
		},
		{
			2,
			1,
			1
		}
	},
	{
		596001,
		1009,
		60,
		20,
		{
			25,
			26,
			27
		},
		{
			1,
			1,
			1
		}
	},
	{
		596001,
		1010,
		60,
		20,
		{
			28,
			29,
			30
		},
		{
			1,
			1,
			1
		}
	},
	{
		596001,
		1011,
		60,
		20,
		{
			31,
			32,
			33
		},
		{
			2,
			1,
			1
		}
	},
	{
		596001,
		1012,
		60,
		20,
		{
			34,
			35,
			36
		},
		{
			2,
			1,
			1
		}
	},
	{
		596001,
		1013,
		60,
		20,
		{
			37,
			38,
			39
		},
		{
			2,
			1,
			1
		}
	},
	{
		596001,
		1014,
		60,
		20,
		{
			40,
			41,
			42
		},
		{
			1,
			1,
			1
		}
	},
	{
		596001,
		1015,
		60,
		20,
		{
			43,
			44,
			45
		},
		{
			2,
			1,
			1
		}
	},
	{
		596001,
		1016,
		60,
		20,
		{
			46,
			47,
			48
		},
		{
			2,
			1,
			1
		}
	},
	{
		596001,
		1017,
		60,
		20,
		{
			49,
			50,
			51
		},
		{
			2,
			1,
			1
		}
	},
	{
		596001,
		1018,
		60,
		20,
		{
			52,
			53,
			54
		},
		{
			2,
			1,
			1
		}
	},
	{
		596001,
		1019,
		60,
		20,
		{
			55,
			56,
			57
		},
		{
			2,
			1,
			1
		}
	},
	{
		596001,
		1020,
		60,
		20,
		{
			58,
			59,
			60
		},
		{
			1,
			1,
			1
		}
	},
	{
		596001,
		1021,
		60,
		20,
		{
			61,
			62,
			63
		},
		{
			1,
			1,
			1
		}
	}
}
local t_mm_drink_shop_drink = {
	[596001] = {
		[1001] = dataList[1],
		[1002] = dataList[2],
		[1003] = dataList[3],
		[1004] = dataList[4],
		[1005] = dataList[5],
		[1006] = dataList[6],
		[1007] = dataList[7],
		[1008] = dataList[8],
		[1009] = dataList[9],
		[1010] = dataList[10],
		[1011] = dataList[11],
		[1012] = dataList[12],
		[1013] = dataList[13],
		[1014] = dataList[14],
		[1015] = dataList[15],
		[1016] = dataList[16],
		[1017] = dataList[17],
		[1018] = dataList[18],
		[1019] = dataList[19],
		[1020] = dataList[20],
		[1021] = dataList[21]
	}
}

t_mm_drink_shop_drink.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_mm_drink_shop_drink
