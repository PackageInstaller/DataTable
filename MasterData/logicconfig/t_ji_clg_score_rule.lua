-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ji_clg_score_rule.lua

module("logicconfig.config.t_ji_clg_score_rule", package.seeall)

local title = {
	score = 3,
	range = 2,
	ruleId = 1
}
local dataList = {
	{
		1,
		{
			0,
			2
		},
		400
	},
	{
		1,
		{
			3,
			3
		},
		300
	},
	{
		1,
		{
			4,
			4
		},
		200
	},
	{
		2,
		{
			6,
			6
		},
		400
	},
	{
		2,
		{
			5,
			5
		},
		300
	},
	{
		2,
		{
			4,
			4
		},
		200
	},
	{
		2,
		{
			3,
			3
		},
		100
	}
}
local t_ji_clg_score_rule = {
	{
		[{
			0,
			2
		}] = dataList[1],
		[{
			3,
			3
		}] = dataList[2],
		[{
			4,
			4
		}] = dataList[3]
	},
	{
		[{
			6,
			6
		}] = dataList[4],
		[{
			5,
			5
		}] = dataList[5],
		[{
			4,
			4
		}] = dataList[6],
		[{
			3,
			3
		}] = dataList[7]
	}
}

t_ji_clg_score_rule.dataList = dataList

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

return t_ji_clg_score_rule
