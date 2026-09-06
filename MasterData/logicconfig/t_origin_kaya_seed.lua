-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_kaya_seed.lua

module("logicconfig.config.t_origin_kaya_seed", package.seeall)

local title = {
	formConditionId = 4,
	effectPos = 5,
	type = 3,
	seedId = 2,
	activityId = 1,
	desc = 6
}
local dataList = {
	{
		548001,
		1,
		1,
		95,
		nil,
		"2号位必须上阵<color=#C54950>1个</color>精灵"
	},
	{
		548001,
		2,
		2,
		0,
		nil,
		"敌阵精灵超杀后，获得50气势并立即出手一次（敌阵每只精灵每个大回合限2次）"
	},
	{
		548001,
		3,
		2,
		0,
		nil,
		"敌阵不会受到负面效果及非直接伤害"
	},
	{
		548001,
		4,
		2,
		0,
		nil,
		"敌阵精灵进入战斗时获得自身攻击*200%的护盾"
	},
	{
		548001,
		5,
		2,
		0,
		nil,
		"敌阵精灵攻击时清除被攻击目标的所有气势"
	},
	{
		548001,
		6,
		2,
		0,
		nil,
		"敌阵精灵每个大回合开始时提高自身20%物防和魔防"
	},
	{
		548001,
		7,
		2,
		0,
		nil,
		"敌阵精灵死亡时，解除无法回血状态，复活并恢复100%生命值（敌阵全阵每个大回合限2次）"
	},
	{
		548001,
		8,
		1,
		21,
		nil,
		"本关卡至少上阵4个<color=#C54950>魔法</color>职业精灵"
	}
}
local t_origin_kaya_seed = {
	[548001] = {
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

t_origin_kaya_seed.dataList = dataList

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

return t_origin_kaya_seed
