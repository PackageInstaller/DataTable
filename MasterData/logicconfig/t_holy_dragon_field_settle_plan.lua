-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dragon_field_settle_plan.lua

module("logicconfig.config.t_holy_dragon_field_settle_plan", package.seeall)

local title = {
	score = 5,
	settlePlan = 2,
	settleType = 4,
	num = 3,
	activityId = 1
}
local dataList = {
	{
		611001,
		1,
		{
			6,
			6
		},
		1,
		200
	},
	{
		611001,
		1,
		{
			5,
			5
		},
		1,
		180
	},
	{
		611001,
		1,
		{
			4,
			4
		},
		1,
		150
	},
	{
		611001,
		1,
		{
			3,
			3
		},
		1,
		100
	},
	{
		611001,
		1,
		{
			2,
			2
		},
		1,
		80
	},
	{
		611001,
		1,
		{
			1,
			1
		},
		1,
		50
	},
	{
		611001,
		2,
		{
			1,
			2
		},
		3,
		50
	},
	{
		611001,
		2,
		{
			3,
			5
		},
		3,
		100
	},
	{
		611001,
		2,
		{
			6,
			8
		},
		3,
		120
	},
	{
		611001,
		2,
		{
			9,
			12
		},
		3,
		150
	},
	{
		611001,
		2,
		{
			13,
			15
		},
		3,
		200
	},
	{
		611001,
		2,
		{
			16,
			17
		},
		3,
		250
	},
	{
		611001,
		2,
		{
			18,
			999
		},
		3,
		400
	},
	{
		611001,
		3,
		{
			1,
			2
		},
		4,
		100
	},
	{
		611001,
		3,
		{
			3,
			4
		},
		4,
		200
	},
	{
		611001,
		3,
		{
			5,
			5
		},
		4,
		300
	},
	{
		611001,
		3,
		{
			6,
			999
		},
		4,
		400
	},
	{
		611001,
		4,
		{
			1,
			1
		},
		2,
		200
	},
	{
		611001,
		4,
		{
			2,
			2
		},
		2,
		150
	},
	{
		611001,
		4,
		{
			3,
			4
		},
		2,
		100
	},
	{
		611001,
		4,
		{
			5,
			6
		},
		2,
		50
	},
	{
		611001,
		4,
		{
			7,
			999
		},
		2,
		10
	},
	{
		611001,
		5,
		{
			1,
			1
		},
		5,
		300
	},
	{
		611001,
		6,
		{
			1,
			1
		},
		7,
		300
	}
}
local t_holy_dragon_field_settle_plan = {
	[611001] = {
		{
			[{
				6,
				6
			}] = dataList[1],
			[{
				5,
				5
			}] = dataList[2],
			[{
				4,
				4
			}] = dataList[3],
			[{
				3,
				3
			}] = dataList[4],
			[{
				2,
				2
			}] = dataList[5],
			[{
				1,
				1
			}] = dataList[6]
		},
		{
			[{
				1,
				2
			}] = dataList[7],
			[{
				3,
				5
			}] = dataList[8],
			[{
				6,
				8
			}] = dataList[9],
			[{
				9,
				12
			}] = dataList[10],
			[{
				13,
				15
			}] = dataList[11],
			[{
				16,
				17
			}] = dataList[12],
			[{
				18,
				999
			}] = dataList[13]
		},
		{
			[{
				1,
				2
			}] = dataList[14],
			[{
				3,
				4
			}] = dataList[15],
			[{
				5,
				5
			}] = dataList[16],
			[{
				6,
				999
			}] = dataList[17]
		},
		{
			[{
				1,
				1
			}] = dataList[18],
			[{
				2,
				2
			}] = dataList[19],
			[{
				3,
				4
			}] = dataList[20],
			[{
				5,
				6
			}] = dataList[21],
			[{
				7,
				999
			}] = dataList[22]
		},
		{
			[{
				1,
				1
			}] = dataList[23]
		},
		{
			[{
				1,
				1
			}] = dataList[24]
		}
	}
}

t_holy_dragon_field_settle_plan.dataList = dataList

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

return t_holy_dragon_field_settle_plan
