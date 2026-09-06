-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_power_land_task.lua

module("logicconfig.config.t_power_land_task", package.seeall)

local title = {
	taskType = 3,
	prize = 5,
	title = 6,
	jumpTo = 8,
	desc = 7,
	maxProgress = 4,
	activityId = 1,
	taskId = 2
}
local dataList = {
	{
		156001,
		1,
		1,
		20,
		"4:137:2",
		"烬之神唤",
		"在神唤卡池中消耗20张神唤券",
		"func#43"
	},
	{
		156001,
		2,
		1,
		40,
		"4:137:2",
		"烬之神唤",
		"在神唤卡池中消耗40张神唤券",
		"func#43"
	},
	{
		156001,
		3,
		1,
		80,
		"4:137:2",
		"烬之神唤",
		"在神唤卡池中消耗80张神唤券",
		"func#43"
	},
	{
		156001,
		4,
		1,
		120,
		"4:137:2",
		"烬之神唤",
		"在神唤卡池中消耗120张神唤券",
		"func#43"
	},
	{
		156001,
		5,
		1,
		160,
		"4:137:2",
		"烬之神唤",
		"在神唤卡池中消耗160张神唤券",
		"func#43"
	},
	{
		156001,
		6,
		1,
		200,
		"4:137:2",
		"烬之神唤",
		"在神唤卡池中消耗200张神唤券",
		"func#43"
	},
	{
		156001,
		7,
		1,
		240,
		"4:137:2",
		"烬之神唤",
		"在神唤卡池中消耗240张神唤券",
		"func#43"
	},
	{
		156001,
		8,
		1,
		280,
		"4:137:2",
		"烬之神唤",
		"在神唤卡池中消耗280张神唤券",
		"func#43"
	},
	{
		156001,
		9,
		1,
		360,
		"4:137:2",
		"烬之神唤",
		"在神唤卡池中消耗360张神唤券",
		"func#43"
	},
	{
		156001,
		10,
		2,
		20,
		"4:137:2",
		"烬之召唤",
		"在召唤卡池中消耗20张召唤券",
		"func#273"
	},
	{
		156001,
		11,
		2,
		40,
		"4:137:2",
		"烬之召唤",
		"在召唤卡池中消耗40张召唤券",
		"func#273"
	},
	{
		156001,
		12,
		2,
		80,
		"4:137:2",
		"烬之召唤",
		"在召唤卡池中消耗80张召唤券",
		"func#273"
	},
	{
		156001,
		13,
		2,
		120,
		"4:137:2",
		"烬之召唤",
		"在召唤卡池中消耗120张召唤券",
		"func#273"
	},
	{
		156001,
		14,
		2,
		160,
		"4:137:2",
		"烬之召唤",
		"在召唤卡池中消耗160张召唤券",
		"func#273"
	},
	{
		156001,
		15,
		2,
		200,
		"4:137:2",
		"烬之召唤",
		"在召唤卡池中消耗200张召唤券",
		"func#273"
	},
	{
		156001,
		16,
		2,
		240,
		"4:137:2",
		"烬之召唤",
		"在召唤卡池中消耗240张召唤券",
		"func#273"
	},
	{
		156001,
		17,
		2,
		280,
		"4:137:2",
		"烬之召唤",
		"在召唤卡池中消耗280张召唤券",
		"func#273"
	},
	{
		156001,
		18,
		2,
		360,
		"4:137:2",
		"烬之召唤",
		"在召唤卡池中消耗360张召唤券",
		"func#273"
	}
}
local t_power_land_task = {
	[156001] = {
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
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_power_land_task.dataList = dataList

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

return t_power_land_task
