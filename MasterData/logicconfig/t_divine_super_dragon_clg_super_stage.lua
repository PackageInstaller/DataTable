-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_super_dragon_clg_super_stage.lua

module("logicconfig.config.t_divine_super_dragon_clg_super_stage", package.seeall)

local title = {
	stageId = 2,
	passedPrize = 5,
	creepsMasterId = 3,
	raceId = 6,
	buffEffected = 4,
	ruleDesc = 7,
	activityId = 1
}
local dataList = {
	{
		344001,
		1,
		1001,
		false,
		"4:510259:5",
		0,
		"击败敌阵即可通关"
	},
	{
		344001,
		2,
		1002,
		false,
		"4:510259:5",
		0,
		"击败敌阵即可通关"
	},
	{
		344001,
		3,
		1003,
		false,
		"4:510259:10",
		0,
		"击败敌阵即可通关"
	},
	{
		344001,
		4,
		1004,
		false,
		"4:510259:10",
		0,
		"击败敌阵即可通关"
	},
	{
		344001,
		5,
		1005,
		false,
		"4:510259:10",
		0,
		"击败敌阵即可通关"
	},
	{
		344001,
		6,
		1006,
		false,
		"4:510259:10",
		0,
		"击败敌阵即可通关"
	},
	{
		344001,
		7,
		1007,
		true,
		"4:510259:50",
		16004,
		"1、敌阵boss将在7回合时结束战斗。\r\n2、星湮龙吟：每回合开始时，boss对我方所有单位造成boss攻击100%伤害并减低40点气势。\r\n3、boss免疫非直接伤害并且单次受到攻击伤害上限75万。\r\n4、boss攻击时附带无法回血（2回合）效果。"
	},
	{
		344002,
		1,
		1001,
		false,
		"4:510259:5",
		0,
		"击败敌阵即可通关"
	},
	{
		344002,
		2,
		1002,
		false,
		"4:510259:5",
		0,
		"击败敌阵即可通关"
	},
	{
		344002,
		3,
		1003,
		false,
		"4:510259:10",
		0,
		"击败敌阵即可通关"
	},
	{
		344002,
		4,
		1004,
		false,
		"4:510259:10",
		0,
		"击败敌阵即可通关"
	},
	{
		344002,
		5,
		1005,
		false,
		"4:510259:10",
		0,
		"击败敌阵即可通关"
	},
	{
		344002,
		6,
		1006,
		false,
		"4:510259:10",
		0,
		"击败敌阵即可通关"
	},
	{
		344002,
		7,
		1007,
		true,
		"4:510259:50",
		16004,
		"1、敌阵boss将在7回合时结束战斗。\r\n2、星湮龙吟：每回合开始时，boss对我方所有单位造成boss攻击100%伤害并减低40点气势。\r\n3、boss免疫非直接伤害并且单次受到攻击伤害上限75万。\r\n4、boss攻击时附带无法回血（2回合）效果。"
	}
}
local t_divine_super_dragon_clg_super_stage = {
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

t_divine_super_dragon_clg_super_stage.dataList = dataList

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

return t_divine_super_dragon_clg_super_stage
