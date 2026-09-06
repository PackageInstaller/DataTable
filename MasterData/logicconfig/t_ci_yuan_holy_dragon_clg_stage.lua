-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ci_yuan_holy_dragon_clg_stage.lua

module("logicconfig.config.t_ci_yuan_holy_dragon_clg_stage", package.seeall)

local title = {
	stageId = 2,
	ruleDesc = 5,
	creepsMasterId = 3,
	displayId = 4,
	activityId = 1
}
local dataList = {
	{
		306001,
		1,
		999001,
		11002,
		"1.只能上阵水火草系精灵，敌阵精灵视为BOSS，双方最多出手100次\r\n2..每只BOSS受到攻击后自身会免疫除了连击伤害外的单体伤害（连击的第一段不算连击伤害），直到其他BOSS受到单体攻击\r\n3.己阵精灵每连击一次，该次连击伤害增加50%"
	},
	{
		306001,
		2,
		999002,
		10324,
		"1.只能上阵光暗系精灵，敌阵精灵视为BOSS，双方最多出手100次\r\n2..每只BOSS受到攻击后自身会免疫除了连击伤害外的单体伤害（连击的第一段不算连击伤害），直到其他BOSS受到单体攻击\r\n3.己阵精灵每连击一次，该次连击伤害增加50%"
	},
	{
		306001,
		3,
		999003,
		17003,
		"1.只能上阵空创系精灵，敌阵精灵视为BOSS，双方最多出手100次\r\n2..每只BOSS受到攻击后自身会免疫除了连击伤害外的单体伤害（连击的第一段不算连击伤害），直到其他BOSS受到单体攻击\r\n3.己阵精灵每连击一次，该次连击伤害增加50%"
	}
}
local t_ci_yuan_holy_dragon_clg_stage = {
	[306001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_ci_yuan_holy_dragon_clg_stage.dataList = dataList

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

return t_ci_yuan_holy_dragon_clg_stage
