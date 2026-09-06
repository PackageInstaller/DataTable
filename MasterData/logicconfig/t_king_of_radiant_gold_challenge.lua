-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_of_radiant_gold_challenge.lua

module("logicconfig.config.t_king_of_radiant_gold_challenge", package.seeall)

local title = {
	challengeId = 2,
	openTime = 4,
	name = 3,
	ruleTips = 5,
	activityId = 1
}
local dataList = {
	{
		462001,
		1,
		"傀儡共生",
		"2025-04-03T05:00:00",
		"1.敌阵存在3只有傀儡标记（黄色骷髅）的精灵，有傀儡标记的精灵额外含有傀儡技能\r\n傀儡技能：每回合开始前，给我方一横排的精灵施加混乱，从第一横排开始，每个回合顺延一横排。"
	},
	{
		462001,
		2,
		"人偶合体",
		"2025-04-04T05:00:00",
		"1.敌阵有一个傀儡标记的精灵，傀儡精灵存在时会给己阵施加负面效果\r\n2.负面效果补充：真身存活会给敌阵战力最高的精灵施加一个效果：此效果达到两层会给我方施加无法回血以及造成秒杀伤害。傀儡精灵受击时，会给我方全体精灵造成受击者攻击*120%的伤害"
	},
	{
		462001,
		3,
		"千机暴走",
		"2025-04-05T05:00:00",
		"1.敌阵拥有两个傀儡标记的精灵，傀儡精灵存在时会给己阵施加负面效果，并且每个大回合给我方一横排的精灵施加混乱\r\n2.负面效果：傀儡存活会给敌阵战力最高的精灵施加一个效果，此效果达到两层会给自身施加无法回血以及造成秒杀伤害。傀儡精灵受击时，会给我方全体精灵造成受击者攻击*120%的伤害"
	}
}
local t_king_of_radiant_gold_challenge = {
	[462001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_king_of_radiant_gold_challenge.dataList = dataList

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

return t_king_of_radiant_gold_challenge
