-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ashless_long_yan_score_rule.lua

module("logicconfig.config.t_ashless_long_yan_score_rule", package.seeall)

local title = {
	index = 2,
	range = 3,
	ruleId = 1,
	score = 4
}
local dataList = {
	{
		1,
		1,
		{
			0,
			1
		},
		1
	},
	{
		1,
		2,
		{
			2,
			2
		},
		2
	},
	{
		1,
		3,
		{
			3,
			3
		},
		3
	},
	{
		1,
		4,
		{
			4,
			4
		},
		4
	},
	{
		1,
		5,
		{
			5,
			5
		},
		5
	},
	{
		1,
		6,
		{
			6,
			6
		},
		6
	},
	{
		2,
		1,
		{
			6,
			99
		},
		1
	},
	{
		2,
		2,
		{
			5,
			5
		},
		2
	},
	{
		2,
		3,
		{
			4,
			4
		},
		3
	},
	{
		2,
		4,
		{
			3,
			3
		},
		4
	},
	{
		2,
		5,
		{
			2,
			2
		},
		5
	},
	{
		2,
		6,
		{
			1,
			1
		},
		6
	},
	{
		3,
		1,
		{
			0,
			3
		},
		1
	},
	{
		3,
		2,
		{
			4,
			6
		},
		2
	},
	{
		3,
		3,
		{
			7,
			10
		},
		3
	},
	{
		3,
		4,
		{
			11,
			14
		},
		4
	},
	{
		3,
		5,
		{
			15,
			19
		},
		5
	},
	{
		3,
		6,
		{
			20,
			25
		},
		6
	},
	{
		3,
		7,
		{
			26,
			35
		},
		7
	},
	{
		3,
		8,
		{
			36,
			99
		},
		8
	}
}
local t_ashless_long_yan_score_rule = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_ashless_long_yan_score_rule.dataList = dataList

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

return t_ashless_long_yan_score_rule
