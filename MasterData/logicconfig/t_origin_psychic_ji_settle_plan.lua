-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_psychic_ji_settle_plan.lua

module("logicconfig.config.t_origin_psychic_ji_settle_plan", package.seeall)

local title = {
	settlePlanId = 2,
	settleType = 4,
	num = 3,
	activityId = 1,
	energy = 5
}
local dataList = {
	{
		542001,
		1,
		{
			1,
			2
		},
		"ActiveCount",
		10
	},
	{
		542001,
		1,
		{
			3,
			4
		},
		"ActiveCount",
		20
	},
	{
		542001,
		1,
		{
			5,
			5
		},
		"ActiveCount",
		30
	},
	{
		542001,
		1,
		{
			6,
			6
		},
		"ActiveCount",
		40
	},
	{
		542001,
		2,
		{
			1,
			2
		},
		"CircleCount",
		40
	},
	{
		542001,
		2,
		{
			3,
			4
		},
		"CircleCount",
		30
	},
	{
		542001,
		2,
		{
			5,
			8
		},
		"CircleCount",
		20
	},
	{
		542001,
		2,
		{
			9,
			999
		},
		"CircleCount",
		10
	},
	{
		542001,
		3,
		{
			1,
			4
		},
		"UltimateCount",
		10
	},
	{
		542001,
		3,
		{
			5,
			8
		},
		"UltimateCount",
		20
	},
	{
		542001,
		3,
		{
			9,
			12
		},
		"UltimateCount",
		30
	},
	{
		542001,
		3,
		{
			13,
			999
		},
		"UltimateCount",
		40
	}
}
local t_origin_psychic_ji_settle_plan = {
	[542001] = {
		{
			[{
				1,
				2
			}] = dataList[1],
			[{
				3,
				4
			}] = dataList[2],
			[{
				5,
				5
			}] = dataList[3],
			[{
				6,
				6
			}] = dataList[4]
		},
		{
			[{
				1,
				2
			}] = dataList[5],
			[{
				3,
				4
			}] = dataList[6],
			[{
				5,
				8
			}] = dataList[7],
			[{
				9,
				999
			}] = dataList[8]
		},
		{
			[{
				1,
				4
			}] = dataList[9],
			[{
				5,
				8
			}] = dataList[10],
			[{
				9,
				12
			}] = dataList[11],
			[{
				13,
				999
			}] = dataList[12]
		}
	}
}

t_origin_psychic_ji_settle_plan.dataList = dataList

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

return t_origin_psychic_ji_settle_plan
