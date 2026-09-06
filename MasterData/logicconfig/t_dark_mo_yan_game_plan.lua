-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_mo_yan_game_plan.lua

module("logicconfig.config.t_dark_mo_yan_game_plan", package.seeall)

local title = {
	bigNum = 7,
	smallNum = 5,
	circleSpeed = 4,
	rotateSpeed = 8,
	circleRadius = 3,
	dropPlanId = 9,
	planId = 1,
	midNum = 6,
	riptide = 10,
	level = 2
}
local dataList = {
	{
		1,
		1,
		{
			90,
			95
		},
		{
			1,
			2
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			0,
			0
		},
		{
			1,
			2
		},
		6,
		{
			1.2,
			2.3
		}
	},
	{
		1,
		3,
		{
			90,
			95
		},
		{
			1,
			2
		},
		{
			1,
			2
		},
		{
			0,
			1
		},
		{
			0,
			0
		},
		{
			1,
			2
		},
		6,
		{
			1.2,
			2.3
		}
	},
	{
		1,
		6,
		{
			90,
			95
		},
		{
			1,
			2
		},
		{
			1,
			2
		},
		{
			0,
			1
		},
		{
			0,
			1
		},
		{
			2,
			3
		},
		6,
		{
			1.2,
			2.3
		}
	},
	{
		1,
		11,
		{
			90,
			95
		},
		{
			1,
			2
		},
		{
			1,
			3
		},
		{
			1,
			2
		},
		{
			0,
			1
		},
		{
			2,
			3
		},
		6,
		{
			1.2,
			2.3
		}
	},
	{
		1,
		16,
		{
			90,
			95
		},
		{
			1,
			2
		},
		{
			1,
			3
		},
		{
			1,
			2
		},
		{
			1,
			1
		},
		{
			2,
			3
		},
		6,
		{
			1.2,
			2.3
		}
	},
	{
		1,
		21,
		{
			80,
			90
		},
		{
			1,
			2
		},
		{
			1,
			2
		},
		{
			1,
			2
		},
		{
			1,
			2
		},
		{
			2,
			3
		},
		6,
		{
			1.2,
			2.5
		}
	},
	{
		1,
		26,
		{
			80,
			90
		},
		{
			1,
			2
		},
		{
			2,
			3
		},
		{
			1,
			2
		},
		{
			1,
			1
		},
		{
			2,
			3
		},
		6,
		{
			1.2,
			2.3
		}
	},
	{
		1,
		30,
		{
			80,
			90
		},
		{
			1,
			2
		},
		{
			2,
			3
		},
		{
			1,
			1
		},
		{
			1,
			2
		},
		{
			2,
			3
		},
		6,
		{
			1.3,
			2.5
		}
	}
}
local t_dark_mo_yan_game_plan = {
	{
		dataList[1],
		[3] = dataList[2],
		[6] = dataList[3],
		[11] = dataList[4],
		[16] = dataList[5],
		[21] = dataList[6],
		[26] = dataList[7],
		[30] = dataList[8]
	}
}

t_dark_mo_yan_game_plan.dataList = dataList

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

return t_dark_mo_yan_game_plan
