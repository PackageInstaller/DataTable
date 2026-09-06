-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dragon_arya_clg_monster.lua

module("logicconfig.config.t_origin_dragon_arya_clg_monster", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	heavenAwakenSummonPetId = 13,
	skipTime = 3,
	retreatMsgType = 7,
	heavenAwakenMasterId = 12,
	ruleDesc = 11,
	btlMode = 5,
	btlBg = 4,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 10
}
local dataList = {
	{
		1001,
		"源起龙主挑战-1",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"敌阵精灵减伤和非伤减伤+25%，每次出手后提高自身8%攻击力，累计受到3次伤害后，下一次受击时吸收伤害并转化为自身血量，且每个大回合开始时获得自身最大生命值*30%的护盾",
		"6",
		"7"
	},
	{
		1002,
		"源起龙主挑战-2",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"敌阵精灵减伤和非伤减伤+25%，每次出手后提高自身8%攻击力，累计受到3次伤害后，下一次受击时吸收伤害并转化为自身血量，且每个大回合开始时获得自身最大生命值*30%的护盾",
		"",
		""
	},
	{
		1003,
		"源起龙主挑战-3",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"敌阵精灵减伤和非伤减伤+25%，每次出手后提高自身8%攻击力，累计受到3次伤害后，下一次受击时吸收伤害并转化为自身血量，且免疫无法行动，攻击无视对手30%防御",
		"5",
		"6"
	},
	{
		1004,
		"源起龙主挑战-4",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"敌阵精灵减伤和非伤减伤+25%，每次出手后提高自身8%攻击力，累计受到3次伤害后，下一次受击时吸收伤害并转化为自身血量，且出手后令敌阵战力最高的精灵获得一次立即出手（全阵每个大回合限3次）",
		"5",
		"7"
	}
}
local t_origin_dragon_arya_clg_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4]
}

t_origin_dragon_arya_clg_monster.dataList = dataList

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

return t_origin_dragon_arya_clg_monster
