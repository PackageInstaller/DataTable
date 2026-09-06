-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_yun_jie_dragon_clg_phase.lua

module("logicconfig.config.t_yun_jie_dragon_clg_phase", package.seeall)

local title = {
	openDay = 3,
	name = 4,
	phaseId = 2,
	ruleDesc = 5,
	activityId = 1
}
local dataList = {
	{
		572001,
		1,
		1,
		"领域展开",
		"敌阵获得20%免伤及非伤免伤，并在受到克制伤害时，将此次伤害降低20%，敌阵精灵首次受到致命伤害时，若受到的致命伤害是克制伤害，则解除无法回血状态复活并获得100%血量和30%免伤及非伤免伤，否则解除无法回血状态复活并获得100%血量"
	},
	{
		572001,
		2,
		1,
		"骸骨王座",
		"敌阵精灵每次出手后，令敌阵全阵伤害、暴击率、破击率及命中率增加20%（非增益，上限5层），敌阵精灵首次受到致命伤害时，若受到的致命伤害是克制伤害，则解除无法回血状态复活并获得100%血量和30%免伤及非伤免伤，否则解除无法回血状态复活并获得100%血量"
	},
	{
		572001,
		3,
		1,
		"解禁之力",
		"拥有前两层所有效果，并在攻击时降低20点通灵点，敌阵精灵首次受到致命伤害时，若受到的致命伤害是克制伤害，则解除无法回血状态复活并获得100%血量和30%免伤及非伤免伤，否则解除无法回血状态复活并获得100%血量"
	}
}
local t_yun_jie_dragon_clg_phase = {
	[572001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_yun_jie_dragon_clg_phase.dataList = dataList

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

return t_yun_jie_dragon_clg_phase
