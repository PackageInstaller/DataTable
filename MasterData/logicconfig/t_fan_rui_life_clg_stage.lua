-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fan_rui_life_clg_stage.lua

module("logicconfig.config.t_fan_rui_life_clg_stage", package.seeall)

local title = {
	stageId = 2,
	buffDesc = 5,
	passStagePrize = 4,
	creepsMasterId = 3,
	title = 6,
	activityId = 1
}
local dataList = {
	{
		293001,
		1,
		101,
		"4:378:10",
		"敌阵受到的伤害减少20%",
		"生命之源•第1关"
	},
	{
		293001,
		2,
		102,
		"4:378:10",
		"敌阵超杀后会免疫下一次攻击",
		"生命之源•第2关"
	},
	{
		293001,
		3,
		103,
		"4:378:10",
		"敌阵生命值最高的精灵会获得嘲讽",
		"生命之源•第3关"
	},
	{
		293002,
		1,
		401,
		"4:397:5",
		"敌阵受到的伤害减少20%",
		"玄冥守契·第1关"
	},
	{
		293002,
		2,
		402,
		"4:397:5",
		"敌阵超杀后会免疫下一次攻击",
		"玄冥守契·第2关"
	},
	{
		293002,
		3,
		403,
		"4:397:10",
		"敌阵生命值最高的精灵会获得嘲讽",
		"玄冥守契·第3关"
	},
	{
		293003,
		1,
		1001,
		"4:510781:5",
		"敌阵精灵超杀后降低目标25%攻击力（2回合）",
		"暗香浮动·第1关"
	},
	{
		293003,
		2,
		1002,
		"4:510781:5",
		"敌阵精灵受到伤害降低25%",
		"暗香浮动·第2关"
	},
	{
		293003,
		3,
		1003,
		"4:510781:10",
		"敌阵战力最高的精灵受到致命伤害时随机令一位己阵精灵复活并恢复50%生命值",
		"暗香浮动·第3关"
	}
}
local t_fan_rui_life_clg_stage = {
	[293001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[293002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[293003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_fan_rui_life_clg_stage.dataList = dataList

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

return t_fan_rui_life_clg_stage
