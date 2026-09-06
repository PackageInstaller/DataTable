-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_zhengli_settle_plan.lua

module("logicconfig.config.t_origin_zhengli_settle_plan", package.seeall)

local title = {
	settlePlanId = 2,
	settleType = 4,
	num = 3,
	activityId = 1,
	points = 5
}
local dataList = {
	{
		587001,
		1,
		{
			6,
			6
		},
		"ActiveCount",
		10
	},
	{
		587001,
		1,
		{
			4,
			5
		},
		"ActiveCount",
		8
	},
	{
		587001,
		1,
		{
			1,
			3
		},
		"ActiveCount",
		4
	},
	{
		587001,
		2,
		{
			1,
			1
		},
		"CircleCount",
		10
	},
	{
		587001,
		2,
		{
			2,
			3
		},
		"CircleCount",
		8
	},
	{
		587001,
		2,
		{
			4,
			99
		},
		"CircleCount",
		4
	},
	{
		587001,
		3,
		{
			13,
			99
		},
		"UltimateCount",
		10
	},
	{
		587001,
		3,
		{
			8,
			12
		},
		"UltimateCount",
		8
	},
	{
		587001,
		3,
		{
			1,
			7
		},
		"UltimateCount",
		4
	}
}
local t_origin_zhengli_settle_plan = {
	[587001] = {
		{
			[{
				6,
				6
			}] = dataList[1],
			[{
				4,
				5
			}] = dataList[2],
			[{
				1,
				3
			}] = dataList[3]
		},
		{
			[{
				1,
				1
			}] = dataList[4],
			[{
				2,
				3
			}] = dataList[5],
			[{
				4,
				99
			}] = dataList[6]
		},
		{
			[{
				13,
				99
			}] = dataList[7],
			[{
				8,
				12
			}] = dataList[8],
			[{
				1,
				7
			}] = dataList[9]
		}
	}
}

t_origin_zhengli_settle_plan.dataList = dataList

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

return t_origin_zhengli_settle_plan
