-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_group.lua

module("logicconfig.config.t_camp_battle_group", package.seeall)

local title = {
	campId = 2,
	name = 5,
	buffPlanId = 4,
	path = 6,
	groupId = 1,
	titleId = 7,
	reportBehavior = 8,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		"可使用<color=#C54949>绝息者.楼那</color>作为助阵精灵\n加成效果：楼那可禁疗目标且对受伤敌人伤害加深\n助阵场景：阵营乱斗、击败入侵者",
		3,
		"混乱阵营",
		"funcamp_choose_1",
		75,
		"201176#201179"
	},
	{
		1,
		2,
		"可使用<color=#C54949>神祇·阿瑞斯</color>作为助阵精灵\n加成效果：阿瑞斯拥有生命护盾，且反弹伤害\n助阵场景：阵营乱斗、击败入侵者",
		2,
		"守序阵营",
		"funcamp_choose_3",
		73,
		"201175#201178"
	},
	{
		1,
		3,
		"可使用<color=#C54949>王者圣龙</color>作为助阵精灵\n加成效果：王者圣龙攻击享有溅射伤害\n助阵场景：阵营乱斗、击败入侵者",
		1,
		"均衡阵营",
		"funcamp_choose_2",
		74,
		"201174#201177"
	}
}
local t_camp_battle_group = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_camp_battle_group.dataList = dataList

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

return t_camp_battle_group
