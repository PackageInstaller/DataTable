-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xingjiang_formula_challenge_task.lua

module("logicconfig.config.t_xingjiang_formula_challenge_task", package.seeall)

local title = {
	desc = 8,
	maxProgress = 5,
	jumpTo = 9,
	type = 4,
	title = 7,
	prize = 6,
	taskId = 2,
	pageId = 3,
	taskPlanId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		100,
		20,
		"4:136:2",
		"星之神唤",
		"消耗20张神唤券",
		"func#43"
	},
	{
		1,
		2,
		1,
		100,
		40,
		"4:136:2",
		"星之神唤",
		"消耗40张神唤券",
		"func#43"
	},
	{
		1,
		3,
		1,
		100,
		80,
		"4:136:3",
		"星之神唤",
		"消耗80张神唤券",
		"func#43"
	},
	{
		1,
		4,
		1,
		100,
		120,
		"4:136:3",
		"星之神唤",
		"消耗120张神唤券",
		"func#43"
	},
	{
		1,
		5,
		1,
		100,
		160,
		"4:136:3",
		"星之神唤",
		"消耗160张神唤券",
		"func#43"
	},
	{
		1,
		6,
		1,
		100,
		200,
		"4:136:3",
		"星之神唤",
		"消耗200张神唤券",
		"func#43"
	},
	{
		1,
		7,
		1,
		100,
		240,
		"4:136:3",
		"星之神唤",
		"消耗240张神唤券",
		"func#43"
	},
	{
		1,
		8,
		1,
		100,
		280,
		"4:136:3",
		"星之神唤",
		"消耗280张神唤券",
		"func#43"
	},
	{
		1,
		9,
		1,
		100,
		360,
		"4:136:3",
		"星之神唤",
		"消耗360张神唤券",
		"func#43"
	},
	{
		1,
		10,
		2,
		100,
		20,
		"4:136:2",
		"星之召唤",
		"消耗20张召唤券",
		"func#273"
	},
	{
		1,
		11,
		2,
		100,
		40,
		"4:136:2",
		"星之召唤",
		"消耗40张召唤券",
		"func#273"
	},
	{
		1,
		12,
		2,
		100,
		80,
		"4:136:3",
		"星之召唤",
		"消耗80张召唤券",
		"func#273"
	},
	{
		1,
		13,
		2,
		100,
		120,
		"4:136:3",
		"星之召唤",
		"消耗120张召唤券",
		"func#273"
	},
	{
		1,
		14,
		2,
		100,
		160,
		"4:136:3",
		"星之召唤",
		"消耗160张召唤券",
		"func#273"
	}
}
local t_xingjiang_formula_challenge_task = {
	{
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
}

t_xingjiang_formula_challenge_task.dataList = dataList

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

return t_xingjiang_formula_challenge_task
