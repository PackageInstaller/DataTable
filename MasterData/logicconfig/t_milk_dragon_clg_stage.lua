-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_milk_dragon_clg_stage.lua

module("logicconfig.config.t_milk_dragon_clg_stage", package.seeall)

local title = {
	stageId = 2,
	name = 8,
	supportPetId = 4,
	passAddScore = 7,
	winDesc = 9,
	passPrize = 6,
	minAccConsumeScore = 5,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		451001,
		1,
		1001,
		100000001,
		0,
		"4:424:10",
		0,
		"第1关",
		"光耀圣龙存活且生命大于10%"
	},
	{
		451001,
		2,
		1002,
		100000001,
		0,
		"4:424:10",
		1,
		"第2关",
		"光耀圣龙普攻1次或全阵普攻次数不超过1次"
	},
	{
		451001,
		3,
		1003,
		100000001,
		0,
		"4:424:10",
		0,
		"第3关",
		"光耀圣龙超杀1次或全阵超杀次数不超过1次"
	},
	{
		451001,
		4,
		1004,
		100000002,
		0,
		"4:424:10",
		1,
		"第4关",
		"光耀圣龙存活且生命大于40%"
	},
	{
		451001,
		5,
		1005,
		100000002,
		0,
		"4:424:10",
		0,
		"第5关",
		"光耀圣龙普攻3次或全阵普攻次数不超过3次"
	},
	{
		451001,
		6,
		1006,
		100000002,
		0,
		"4:424:10",
		1,
		"第6关",
		"光耀圣龙超杀3次或全阵超杀次数不超过3次"
	},
	{
		451001,
		7,
		1007,
		100000003,
		0,
		"4:424:20",
		0,
		"第7关",
		"光耀圣龙存活且生命大于70%"
	},
	{
		451001,
		8,
		1008,
		100000003,
		0,
		"4:424:20",
		1,
		"第8关",
		"光耀圣龙普攻5次或全阵普攻次数不超过5次"
	},
	{
		451001,
		9,
		1009,
		100000003,
		0,
		"4:424:20",
		0,
		"第9关",
		"光耀圣龙超杀5次或全阵超杀次数不超过5次"
	}
}
local t_milk_dragon_clg_stage = {
	[451001] = {
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

t_milk_dragon_clg_stage.dataList = dataList

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

return t_milk_dragon_clg_stage
