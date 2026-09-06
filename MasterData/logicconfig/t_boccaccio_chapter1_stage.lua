-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_chapter1_stage.lua

module("logicconfig.config.t_boccaccio_chapter1_stage", package.seeall)

local title = {
	stageId = 2,
	name = 4,
	pos = 6,
	C4UnlockNeed = 7,
	creepsMasterId = 5,
	starId = 3,
	activityId = 1,
	C4Pos = 8
}
local dataList = {
	{
		580001,
		1,
		1,
		"星球\r\n1",
		1001,
		{
			-385,
			120
		},
		"150000000",
		{
			-121,
			180,
			0.8
		}
	},
	{
		580001,
		2,
		1,
		"星球\r\n2",
		1002,
		{
			-145,
			0
		},
		"300000000",
		{
			30,
			5,
			0.8
		}
	},
	{
		580001,
		3,
		1,
		"星球\r\n3",
		1003,
		{
			-335,
			-120
		},
		"450000000",
		{
			-160,
			-90,
			0.8
		}
	},
	{
		580001,
		4,
		1,
		"星球\r\n4",
		1004,
		{
			375,
			160
		},
		"600000000",
		{
			450,
			150,
			0.8
		}
	},
	{
		580001,
		5,
		1,
		"星球\r\n5",
		1005,
		{
			150,
			55
		},
		"750000000",
		{
			253,
			95,
			0.8
		}
	},
	{
		580001,
		6,
		1,
		"星球\r\n6",
		1006,
		{
			330,
			-100
		},
		"900000000",
		{
			400,
			-90,
			0.8
		}
	},
	{
		580001,
		7,
		2,
		"星球\r\n7",
		1007,
		{
			-125,
			145
		},
		"1050000000",
		{
			-121,
			180,
			0.8
		}
	},
	{
		580001,
		8,
		2,
		"星球\r\n8",
		1008,
		{
			-415,
			35
		},
		"1200000000",
		{
			30,
			5,
			0.8
		}
	},
	{
		580001,
		9,
		2,
		"星球\r\n9",
		1009,
		{
			-120,
			-110
		},
		"1350000000",
		{
			-160,
			-90,
			0.8
		}
	},
	{
		580001,
		10,
		2,
		"星球\r\n10",
		1010,
		{
			265,
			170
		},
		"1500000000",
		{
			450,
			150,
			0.8
		}
	},
	{
		580001,
		11,
		2,
		"星球\r\n11",
		1011,
		{
			435,
			-20
		},
		"1650000000",
		{
			253,
			95,
			0.8
		}
	},
	{
		580001,
		12,
		2,
		"星球\r\n12",
		1012,
		{
			180,
			-50
		},
		"2000000000",
		{
			400,
			-90,
			0.8
		}
	}
}
local t_boccaccio_chapter1_stage = {
	[580001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_boccaccio_chapter1_stage.dataList = dataList

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

return t_boccaccio_chapter1_stage
