-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_slack_off_game_value_plan.lua

module("logicconfig.config.t_slack_off_game_value_plan", package.seeall)

local title = {
	studyRange = 3,
	planId = 1,
	moodRange = 2
}
local dataList = {
	{
		1,
		{
			-3,
			-1
		},
		{
			2,
			5
		}
	},
	{
		2,
		{
			1,
			3
		},
		{
			5,
			8
		}
	},
	{
		3,
		{
			-2,
			-1
		},
		{
			3,
			6
		}
	},
	{
		4,
		{
			-1,
			0
		},
		{
			3,
			6
		}
	},
	{
		5,
		{
			-4,
			-2
		},
		{
			2,
			4
		}
	},
	{
		6,
		{
			-1,
			1
		},
		{
			4,
			6
		}
	},
	{
		7,
		{
			-2,
			-1
		},
		{
			2,
			4
		}
	},
	{
		8,
		{
			-1,
			0
		},
		{
			3,
			5
		}
	},
	{
		9,
		{
			5,
			7
		},
		{
			-3,
			-1
		}
	},
	{
		10,
		{
			3,
			5
		},
		{
			0,
			1
		}
	},
	{
		11,
		{
			3,
			7
		},
		{
			-2,
			-1
		}
	},
	{
		12,
		{
			3,
			6
		},
		{
			-1,
			0
		}
	},
	{
		13,
		{
			4,
			6
		},
		{
			-2,
			-1
		}
	},
	{
		14,
		{
			2,
			4
		},
		{
			0,
			1
		}
	},
	{
		15,
		{
			3,
			5
		},
		{
			-2,
			-1
		}
	},
	{
		16,
		{
			2,
			4
		},
		{
			-1,
			0
		}
	}
}
local t_slack_off_game_value_plan = {
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
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16]
}

t_slack_off_game_value_plan.dataList = dataList

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

return t_slack_off_game_value_plan
