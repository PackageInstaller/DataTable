-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_work.lua

module("logicconfig.config.t_rich_man_x_plan_work", package.seeall)

local title = {
	workName = 6,
	activityId = 1,
	baseIncome = 4,
	unlockCost = 3,
	exclusiveRaceId = 5,
	posId = 2
}
local dataList = {
	{
		373001,
		1,
		0,
		50,
		{
			1,
			2
		},
		"街边走访"
	},
	{
		373001,
		2,
		300000,
		60,
		{
			3,
			4
		},
		"调查取证"
	},
	{
		373001,
		3,
		500000,
		70,
		{
			5,
			6
		},
		"街道潜行"
	},
	{
		373001,
		4,
		800000,
		80,
		{
			7,
			8
		},
		"深夜出逃"
	},
	{
		373001,
		5,
		1000000,
		90,
		{
			9,
			10
		},
		"据点巡逻"
	},
	{
		373001,
		6,
		1500000,
		100,
		{
			11,
			12
		},
		"采购物资"
	},
	{
		373001,
		7,
		2100000,
		110,
		{
			13,
			14
		},
		"深入虎穴"
	},
	{
		373001,
		8,
		2400000,
		120,
		{
			15,
			16
		},
		"直面敌方"
	}
}
local t_rich_man_x_plan_work = {
	[373001] = {
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

t_rich_man_x_plan_work.dataList = dataList

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

return t_rich_man_x_plan_work
