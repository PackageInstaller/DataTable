-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_answer_problem_plot_stage.lua

module("logicconfig.config.t_answer_problem_plot_stage", package.seeall)

local title = {
	onlyId = 2,
	stageId = 6,
	storyId = 7,
	chapterId = 5,
	plotPlanId = 1,
	stageName = 8,
	prize = 3,
	scoreLimit = 4
}
local dataList = {
	{
		1,
		1,
		"10:217007:1600",
		20,
		1,
		1,
		4360010,
		"第一节"
	},
	{
		1,
		2,
		"10:217007:1601",
		60,
		1,
		2,
		4360011,
		"第二节"
	},
	{
		1,
		3,
		"10:217007:1602",
		120,
		1,
		3,
		4360006,
		"第三节"
	},
	{
		1,
		4,
		"10:217007:1603",
		210,
		1,
		4,
		4360007,
		"第四节"
	},
	{
		1,
		5,
		"10:217007:1604",
		270,
		1,
		5,
		4360008,
		"第五节"
	},
	{
		1,
		6,
		"10:217007:1605",
		360,
		1,
		6,
		4360009,
		"第六节"
	},
	{
		2,
		1,
		"8:1:1000000",
		40,
		1,
		1,
		4460001,
		"剧情-第一节"
	},
	{
		2,
		2,
		"8:1:1000000",
		120,
		1,
		2,
		4460002,
		"剧情-第二节"
	},
	{
		3,
		1,
		"8:1:1000000",
		40,
		1,
		3,
		4460003,
		"剧情-第一节"
	},
	{
		3,
		2,
		"8:1:1000000",
		120,
		1,
		4,
		4460004,
		"剧情-第二节"
	},
	{
		4,
		1,
		"8:1:1000000",
		40,
		1,
		5,
		4460005,
		"剧情-第一节"
	},
	{
		4,
		2,
		"8:1:1000000",
		120,
		1,
		6,
		4460006,
		"剧情-第二节"
	},
	{
		5,
		1,
		"8:1:1000000",
		40,
		1,
		7,
		4460007,
		"剧情-第一节"
	},
	{
		5,
		2,
		"8:1:1000000",
		120,
		1,
		8,
		4460008,
		"剧情-第二节"
	}
}
local t_answer_problem_plot_stage = {
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
		dataList[8]
	},
	{
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14]
	}
}

t_answer_problem_plot_stage.dataList = dataList

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

return t_answer_problem_plot_stage
