-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_war_defence_line.lua

module("logicconfig.config.t_ultimate_war_defence_line", package.seeall)

local title = {
	activityId = 1,
	name = 4,
	petPos = 11,
	attributes = 3,
	pointPos = 10,
	itemLimit = 6,
	scoreRatio = 8,
	specialScoreRatio = 7,
	specialRaceIds = 5,
	pointId = 2,
	normalPetCountLimit = 9
}
local dataList = {
	{
		434001,
		1,
		{
			"水"
		},
		"水之神柱",
		{
			11021,
			11014,
			11011
		},
		500,
		24,
		4,
		5,
		{
			-435,
			220
		},
		{
			{
				-190,
				33
			},
			{
				27,
				-24
			},
			{
				100,
				85
			}
		}
	},
	{
		434001,
		2,
		{
			"火"
		},
		"火之神柱",
		{
			12018,
			12014,
			12021
		},
		500,
		24,
		4,
		5,
		{
			-163,
			-185
		},
		{
			{
				-123,
				-20
			},
			{
				-13,
				-55
			},
			{
				95,
				15
			}
		}
	},
	{
		434001,
		3,
		{
			"草"
		},
		"草之神柱",
		{
			13009,
			13013,
			13008
		},
		500,
		24,
		4,
		5,
		{
			-515,
			-40
		},
		{
			{
				-94,
				-30
			},
			{
				41,
				-56
			},
			{
				103,
				48
			}
		}
	},
	{
		434001,
		4,
		{
			"光"
		},
		"光之神柱",
		{
			14018,
			14017,
			14023
		},
		500,
		24,
		4,
		5,
		{
			367,
			280
		},
		{
			{
				-115,
				-22
			},
			{
				-7,
				-116
			},
			{
				75,
				-25
			}
		}
	},
	{
		434001,
		5,
		{
			"暗"
		},
		"暗之神柱",
		{
			15018,
			15021,
			15027
		},
		500,
		24,
		4,
		5,
		{
			388,
			-75
		},
		{
			{
				-67,
				-56
			},
			{
				38,
				-20
			},
			{
				90,
				82
			}
		}
	},
	{
		434001,
		6,
		{
			"创",
			"空"
		},
		"空创神柱",
		{
			16024,
			16019,
			17014
		},
		500,
		24,
		4,
		5,
		{
			-10,
			100
		},
		{
			{
				-150,
				-16
			},
			{
				-61,
				-73
			},
			{
				40,
				-20
			}
		}
	}
}
local t_ultimate_war_defence_line = {
	[434001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_ultimate_war_defence_line.dataList = dataList

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

return t_ultimate_war_defence_line
