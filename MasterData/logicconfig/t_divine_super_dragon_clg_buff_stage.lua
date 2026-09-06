-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_super_dragon_clg_buff_stage.lua

module("logicconfig.config.t_divine_super_dragon_clg_buff_stage", package.seeall)

local title = {
	stageId = 2,
	openTime = 4,
	raceId = 7,
	buffDesc = 6,
	creepsMasterId = 3,
	activityId = 1,
	desc = 5
}
local dataList = {
	{
		344001,
		1,
		101,
		"2024-03-15T05:00:00",
		"7回合提升至10回合",
		"7回合提升至10回合",
		17006
	},
	{
		344001,
		2,
		102,
		"2024-03-15T05:00:00",
		"boss防御降低50%",
		"boss防御降低50%",
		15020
	},
	{
		344001,
		3,
		103,
		"2024-03-15T05:00:00",
		"单次受到最大伤害提升至100万",
		"单次受到最大伤害提升至100万",
		11012
	},
	{
		344001,
		4,
		104,
		"2024-03-15T05:00:00",
		"己阵首位受到致命伤害的精灵移除负面效果后满血复活",
		"己阵首位受到致命伤害的精灵移除负面效果后满血复活",
		17010
	},
	{
		344001,
		5,
		105,
		"2024-03-15T05:00:00",
		"己阵免疫无法回血效果",
		"己阵免疫无法回血效果",
		14020
	},
	{
		344001,
		6,
		106,
		"2024-03-15T05:00:00",
		"己阵最后站位精灵每个大回合结束时获得一次立即出手",
		"己阵最后站位精灵每个大回合结束时获得一次立即出手",
		13009
	},
	{
		344001,
		7,
		107,
		"2024-03-15T05:00:00",
		"boss每回合开始时，只会对站位最靠前的横排释放星湮龙吟",
		"boss每回合开始时，只会对站位最靠前的横排释放星湮龙吟",
		12012
	},
	{
		344002,
		1,
		101,
		"2024-03-15T05:00:00",
		"7回合提升至10回合",
		"7回合提升至10回合",
		17006
	},
	{
		344002,
		2,
		102,
		"2024-03-15T05:00:00",
		"boss防御降低50%",
		"boss防御降低50%",
		15020
	},
	{
		344002,
		3,
		103,
		"2024-03-15T05:00:00",
		"单次受到最大伤害提升至100万",
		"单次受到最大伤害提升至100万",
		11012
	},
	{
		344002,
		4,
		104,
		"2024-03-15T05:00:00",
		"己阵首位受到致命伤害的精灵移除负面效果后满血复活",
		"己阵首位受到致命伤害的精灵移除负面效果后满血复活",
		17010
	},
	{
		344002,
		5,
		105,
		"2024-03-15T05:00:00",
		"己阵免疫无法回血效果",
		"己阵免疫无法回血效果",
		14020
	},
	{
		344002,
		6,
		106,
		"2024-03-15T05:00:00",
		"己阵最后站位精灵每个大回合结束时获得一次立即出手",
		"己阵最后站位精灵每个大回合结束时获得一次立即出手",
		13009
	},
	{
		344002,
		7,
		107,
		"2024-03-15T05:00:00",
		"boss每回合开始时，只会对站位最靠前的横排释放星湮龙吟",
		"boss每回合开始时，只会对站位最靠前的横排释放星湮龙吟",
		12012
	}
}
local t_divine_super_dragon_clg_buff_stage = {
	[344001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[344002] = {
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_divine_super_dragon_clg_buff_stage.dataList = dataList

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

return t_divine_super_dragon_clg_buff_stage
