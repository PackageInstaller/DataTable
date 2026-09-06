-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_theater_rule.lua

module("logicconfig.config.t_theater_rule", package.seeall)

local title = {
	id = 1,
	ruleList = 2
}
local dataList = {
	{
		1,
		{
			"ruleA#defaultFace:6",
			"ruleB#defaultFace:2"
		}
	},
	{
		2,
		{
			"ruleA#defaultFace:6",
			"ruleB#defaultFace:2"
		}
	},
	{
		3,
		{
			"ruleA#defaultFace:6",
			"ruleB#defaultFace:2"
		}
	},
	{
		4,
		{
			"ruleA#defaultFace:6",
			"ruleB#defaultFace:2"
		}
	},
	{
		5,
		{
			"ruleA#defaultFace:6",
			"ruleB#defaultFace:2"
		}
	},
	{
		6,
		{
			"ruleA#defaultFace:6",
			"ruleB#defaultFace:2"
		}
	},
	{
		7,
		{
			"ruleA#defaultFace:6",
			"ruleB#defaultFace:2"
		}
	},
	{
		8,
		{
			"ruleA#defaultFace:6",
			"ruleB#defaultFace:2"
		}
	},
	{
		9,
		{
			"ruleA#defaultFace:6",
			"ruleB#defaultFace:2"
		}
	},
	{
		10,
		{
			"ruleA#defaultFace:6",
			"ruleB#defaultFace:2"
		}
	},
	{
		11,
		{
			"ruleA#defaultFace:6",
			"ruleB#defaultFace:2"
		}
	},
	{
		12,
		{
			"ruleA#defaultFace:6",
			"ruleB#defaultFace:2"
		}
	},
	{
		13,
		{
			"ruleA#defaultFace:6",
			"ruleB#defaultFace:2"
		}
	},
	{
		14,
		{
			"ruleA#defaultFace:6",
			"ruleB#defaultFace:2"
		}
	}
}
local t_theater_rule = {
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
	dataList[14]
}

t_theater_rule.dataList = dataList

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

return t_theater_rule
