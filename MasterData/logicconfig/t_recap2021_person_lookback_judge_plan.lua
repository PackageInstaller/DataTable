-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_recap2021_person_lookback_judge_plan.lua

module("logicconfig.config.t_recap2021_person_lookback_judge_plan", package.seeall)

local title = {
	judgeType = 3,
	judgePlanId = 1,
	dataIds = 2,
	judgeValue = 4
}
local dataList = {
	{
		1,
		{
			14,
			15,
			16,
			17,
			18,
			19
		},
		"TOTAL_ADD_PERCENT",
		"5,6"
	},
	{
		2,
		{
			14,
			15,
			16,
			17,
			18,
			19
		},
		"TOTAL_ADD_PERCENT",
		"4,5"
	},
	{
		3,
		{
			14,
			15,
			16,
			17,
			18,
			19
		},
		"TOTAL_ADD_PERCENT",
		"3,4"
	},
	{
		4,
		{
			14,
			15,
			16,
			17,
			18,
			19
		},
		"TOTAL_ADD_PERCENT",
		"2,3"
	},
	{
		5,
		{
			14,
			15,
			16,
			17,
			18,
			19
		},
		"TOTAL_ADD_PERCENT",
		"1.1,2"
	},
	{
		6,
		{
			14,
			15,
			16,
			17,
			18,
			19
		},
		"TOTAL_ADD_PERCENT",
		"0.5,1.1"
	},
	{
		7,
		{
			14,
			15,
			16,
			17,
			18,
			19
		},
		"TOTAL_ADD_PERCENT",
		"0,0.5"
	},
	{
		8,
		{
			20,
			22
		},
		"MORE_THEN",
		"200"
	},
	{
		9,
		{
			20,
			22
		},
		"MORE_THEN",
		"160"
	},
	{
		10,
		{
			20,
			22
		},
		"MORE_THEN",
		"120"
	},
	{
		11,
		{
			20,
			22
		},
		"MORE_THEN",
		"80"
	},
	{
		12,
		{
			20,
			22
		},
		"MORE_THEN",
		"40"
	},
	{
		13,
		{
			20,
			22
		},
		"MORE_THEN",
		"0"
	}
}
local t_recap2021_person_lookback_judge_plan = {
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
	dataList[13]
}

t_recap2021_person_lookback_judge_plan.dataList = dataList

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

return t_recap2021_person_lookback_judge_plan
