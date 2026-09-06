-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ares_mom_stage.lua

module("logicconfig.config.t_divine_ares_mom_stage", package.seeall)

local title = {
	stageId = 2,
	unlockDays = 3,
	prize = 6,
	winScoreRequirements = 5,
	creepsMasterId = 4,
	stageRuleKey = 7,
	activityId = 1
}
local dataList = {
	{
		369001,
		1,
		1,
		101,
		{
			1,
			1,
			1
		},
		"4:510300:1",
		"divine_Gasiri_stage_rule_1"
	},
	{
		369001,
		2,
		1,
		102,
		{
			1,
			1,
			1
		},
		"4:510300:1",
		"divine_Gasiri_stage_rule_1"
	},
	{
		369001,
		3,
		1,
		103,
		{
			1,
			1,
			1
		},
		"4:510300:2",
		"divine_Gasiri_stage_rule_1"
	},
	{
		369001,
		4,
		1,
		104,
		{
			3,
			3,
			3
		},
		"4:510300:3",
		"divine_Gasiri_stage_rule_1"
	},
	{
		369001,
		5,
		1,
		105,
		{
			3,
			3,
			3
		},
		"4:510300:3",
		"divine_Gasiri_stage_rule_1"
	},
	{
		369001,
		6,
		1,
		106,
		{
			4,
			3,
			3
		},
		"4:510300:3",
		"divine_Gasiri_stage_rule_2"
	},
	{
		369001,
		7,
		1,
		107,
		{
			3,
			4,
			3
		},
		"4:510300:4",
		"divine_Gasiri_stage_rule_2"
	},
	{
		369001,
		8,
		1,
		108,
		{
			5,
			5,
			6
		},
		"4:510300:5",
		"divine_Gasiri_stage_rule_2"
	},
	{
		369001,
		9,
		1,
		109,
		{
			6,
			6,
			5
		},
		"4:510300:9",
		"divine_Gasiri_stage_rule_2"
	},
	{
		369001,
		10,
		1,
		110,
		{
			6,
			5,
			6
		},
		"4:510300:9",
		"divine_Gasiri_stage_rule_2"
	},
	{
		369001,
		11,
		1,
		111,
		{
			6,
			5,
			5
		},
		"4:510300:10",
		"divine_Gasiri_stage_rule_3"
	},
	{
		369001,
		12,
		1,
		112,
		{
			8,
			8,
			7
		},
		"4:510300:11",
		"divine_Gasiri_stage_rule_3"
	},
	{
		369001,
		13,
		1,
		113,
		{
			8,
			5,
			8
		},
		"4:510300:12",
		"divine_Gasiri_stage_rule_3"
	},
	{
		369001,
		14,
		1,
		114,
		{
			8,
			6,
			8
		},
		"4:510300:13",
		"divine_Gasiri_stage_rule_3"
	},
	{
		369001,
		15,
		1,
		115,
		{
			8,
			9,
			7
		},
		"4:510300:14",
		"divine_Gasiri_stage_rule_3"
	}
}
local t_divine_ares_mom_stage = {
	[369001] = {
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
		dataList[15]
	}
}

t_divine_ares_mom_stage.dataList = dataList

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

return t_divine_ares_mom_stage
