-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_peak_tournament_qualifier_level.lua

module("logicconfig.config.t_peak_tournament_qualifier_level", package.seeall)

local title = {
	quaLevelId = 2,
	rankScoreInheritValue = 4,
	quaLevelPlanId = 1,
	rankScoreLimit = 3,
	levelName = 5
}
local dataList = {
	{
		1,
		1,
		{
			0,
			49
		},
		0,
		"青铜"
	},
	{
		1,
		2,
		{
			50,
			99
		},
		0,
		"白银"
	},
	{
		1,
		3,
		{
			100,
			149
		},
		0,
		"黄金"
	},
	{
		1,
		4,
		{
			150,
			199
		},
		0,
		"铂金"
	},
	{
		1,
		5,
		{
			200,
			299
		},
		0,
		"钻石"
	},
	{
		1,
		6,
		{
			300,
			399
		},
		0,
		"星耀"
	},
	{
		1,
		7,
		{
			400,
			499
		},
		0,
		"王者"
	},
	{
		1,
		8,
		{
			500,
			9999
		},
		0,
		"传说"
	}
}
local t_peak_tournament_qualifier_level = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_peak_tournament_qualifier_level.dataList = dataList

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

return t_peak_tournament_qualifier_level
