-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_eternal_dragon_clg_stage.lua

module("logicconfig.config.t_divine_eternal_dragon_clg_stage", package.seeall)

local title = {
	stageId = 2,
	prize = 5,
	raceTypeSeq = 4,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		445001,
		1,
		{
			1001,
			1002
		},
		{
			"火",
			"火",
			"火"
		},
		"4:265:5"
	},
	{
		445001,
		2,
		{
			1003,
			1004
		},
		{
			"草",
			"空",
			"光"
		},
		"4:265:5"
	},
	{
		445001,
		3,
		{
			1005,
			1006
		},
		{
			"火",
			"草",
			"光"
		},
		"4:265:10"
	},
	{
		445001,
		4,
		{
			1007,
			1008
		},
		{
			"创",
			"空",
			"创",
			"空"
		},
		"4:265:15"
	},
	{
		445001,
		5,
		{
			1009,
			1010
		},
		{
			"火",
			"草",
			"水",
			"火"
		},
		"4:265:15"
	},
	{
		445001,
		6,
		{
			1011,
			1012
		},
		{
			"光",
			"光",
			"光",
			"光"
		},
		"4:265:50"
	},
	{
		445002,
		1,
		{
			1001,
			1002
		},
		{
			"火",
			"火",
			"火"
		},
		"8:1:1"
	},
	{
		445002,
		2,
		{
			1003,
			1004
		},
		{
			"草",
			"空",
			"光"
		},
		"8:1:1"
	},
	{
		445002,
		3,
		{
			1005,
			1006
		},
		{
			"火",
			"草",
			"光"
		},
		"8:1:1"
	},
	{
		445002,
		4,
		{
			1007,
			1008
		},
		{
			"创",
			"空",
			"创",
			"空"
		},
		"8:1:1"
	},
	{
		445002,
		5,
		{
			1009,
			1010
		},
		{
			"火",
			"草",
			"水",
			"火"
		},
		"8:1:1"
	},
	{
		445002,
		6,
		{
			1011,
			1012
		},
		{
			"光",
			"光",
			"光",
			"光"
		},
		"8:1:1"
	}
}
local t_divine_eternal_dragon_clg_stage = {
	[445001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[445002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_divine_eternal_dragon_clg_stage.dataList = dataList

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

return t_divine_eternal_dragon_clg_stage
