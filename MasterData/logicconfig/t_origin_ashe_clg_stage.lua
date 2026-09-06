-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ashe_clg_stage.lua

module("logicconfig.config.t_origin_ashe_clg_stage", package.seeall)

local title = {
	winIds = 3,
	stageId = 2,
	winDesc = 4,
	creepsMasterId = 7,
	buffIds = 5,
	activityId = 1,
	passPrize = 6
}
local dataList = {
	{
		533001,
		1,
		{
			148,
			131
		},
		{
			"敌方精灵存活>=1",
			"我方精灵存活>=1"
		},
		{
			1,
			2
		},
		"4:510635:5",
		1001
	},
	{
		533001,
		2,
		{
			273,
			58
		},
		{
			"敌方精灵存活>=2",
			"我方精灵存活>=2"
		},
		{
			1,
			2
		},
		"4:510635:5",
		1002
	},
	{
		533001,
		3,
		{
			274,
			57
		},
		{
			"敌方精灵存活>=3",
			"我方精灵存活>=3"
		},
		{
			1,
			2
		},
		"4:510635:10",
		1003
	},
	{
		533001,
		4,
		{
			275,
			56
		},
		{
			"敌方精灵存活>=4",
			"我方精灵存活>=4"
		},
		{
			1,
			2
		},
		"4:510635:10",
		1004
	},
	{
		533001,
		5,
		{
			275,
			56
		},
		{
			"敌方精灵存活>=4",
			"我方精灵存活>=4"
		},
		{
			1,
			2
		},
		"4:510635:10",
		1005
	},
	{
		533001,
		6,
		{
			276,
			55
		},
		{
			"敌方精灵存活>=5",
			"我方精灵存活>=5"
		},
		{
			1,
			2
		},
		"4:510635:10",
		1006
	},
	{
		533001,
		7,
		{
			276,
			55
		},
		{
			"敌方精灵存活>=5",
			"我方精灵存活>=5"
		},
		{
			1,
			2
		},
		"4:510635:10",
		1007
	},
	{
		533001,
		8,
		{
			277,
			25
		},
		{
			"敌方精灵存活>=6",
			"我方精灵存活>=6"
		},
		{
			1,
			2
		},
		"4:510635:20",
		1008
	},
	{
		533001,
		9,
		{
			277,
			25
		},
		{
			"敌方精灵存活>=6",
			"我方精灵存活>=6"
		},
		{
			1,
			2
		},
		"4:510635:20",
		1009
	}
}
local t_origin_ashe_clg_stage = {
	[533001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_origin_ashe_clg_stage.dataList = dataList

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

return t_origin_ashe_clg_stage
