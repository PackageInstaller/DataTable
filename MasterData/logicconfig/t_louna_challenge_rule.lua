-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_louna_challenge_rule.lua

module("logicconfig.config.t_louna_challenge_rule", package.seeall)

local title = {
	rulePlanId = 1,
	ruleParams = 3,
	ruleId = 4,
	ruleDesc = 5,
	ruleHandler = 2,
	resetDesc = 7,
	ruleUnderDesc = 6
}
local dataList = {
	{
		1,
		"DiePet",
		{
			reset = true
		},
		"xiuluoyuchallenge_rule",
		"阵亡精灵无法进入战斗",
		"1.使用自己精灵挑战，精灵满养成\n2.战胜本层<color=#C54949>任意敌阵</color>，次日<color=#C54949>刷新下一层</color>敌阵",
		"确定要重置本层挑战进度吗？\n保留本层历史最高积分，重新挑战只累加超过历史最高积分的部分"
	},
	{
		2,
		"Formation",
		{
			reset = true,
			times = 2
		},
		"xiuluoyuchallenge_rule",
		"每只精灵最多上阵<color=#C54949>2</color>次",
		"1.使用自己精灵挑战，精灵满养成\n2.战胜本层<color=#C54949>任意敌阵</color>，次日<color=#C54949>刷新下一层</color>敌阵",
		"确定要重置本层挑战进度吗？\n保留本层历史最高积分，重新挑战只累加超过历史最高积分的部分"
	},
	{
		3,
		"EnemyBuffs",
		{
			reset = true,
			buffs = "20038101:99"
		},
		"xiuluoyuchallenge_rule",
		"每战胜一个敌阵，剩余敌阵全属性提升<color=#C54949>3%</color>",
		"1.使用自己精灵挑战，精灵满养成\n2.战胜本层<color=#C54949>任意敌阵</color>，次日<color=#C54949>刷新下一层</color>敌阵",
		"确定要重置本层挑战进度吗？\n保留本层历史最高积分，重新挑战只累加超过历史最高积分的部分"
	},
	{
		4,
		"EnemyBuffs",
		{
			reset = true,
			buffs = "20038102:99"
		},
		"xiuluoyuchallenge_rule",
		"每战胜一个敌阵，剩余敌阵起始气势增加<color=#C54949>10</color>点",
		"1.使用自己精灵挑战，精灵满养成\n2.战胜本层<color=#C54949>任意敌阵</color>，次日<color=#C54949>刷新下一层</color>敌阵",
		"确定要重置本层挑战进度吗？\n保留本层历史最高积分，重新挑战只累加超过历史最高积分的部分"
	},
	{
		5,
		"Formation",
		{
			job = "英雄",
			reset = true,
			times = 1
		},
		"xiuluoyuchallenge_rule",
		"每只英雄精灵最多上阵<color=#C54949>1</color>次",
		"1.使用自己精灵挑战，精灵满养成\n2.战胜本层<color=#C54949>任意敌阵</color>，次日<color=#C54949>刷新下一层</color>敌阵",
		"确定要重置本层挑战进度吗？\n保留本层历史最高积分，重新挑战只累加超过历史最高积分的部分"
	}
}
local t_louna_challenge_rule = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_louna_challenge_rule.dataList = dataList

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

return t_louna_challenge_rule
