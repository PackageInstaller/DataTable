-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_family_battle_rules.lua

module("logicconfig.config.t_new_family_battle_rules", package.seeall)

local title = {
	rulePlanId = 1,
	icon = 3,
	rulesId = 2,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		"board_llzz_guiz01",
		"1、家族战分为战区赛与全服赛，各战区积分排名前4的家族进入全服赛。2、全服赛为淘汰制，每场比赛排行第一的家族进入下一轮比赛，全服赛分为全服64进16、16进4、决赛，共三轮比拼。3、战区赛前64名进入全服赛，且自动报名下一赛季的比赛。"
	},
	{
		1,
		2,
		"board_llzz_guiz01",
		"1、报名阶段，族长、副族长报名，报名后新成员无法参战。族长、副族长的离线天数在2天内，5级且30人以上的家族自动报名。2、布阵阶段，参战成员布置守阵。3、调配阶段，族长、副族长调配20层神柱守阵。4、对抗阶段，进攻其他家族神柱或巢穴获得能量。"
	},
	{
		1,
		3,
		"board_llzz_guiz02",
		"对抗阶段中，神柱防守阵型血量大幅提升。每分钟根据神柱剩余层数自动获得生存能量。族员挑战其他家族神柱，战斗失败保留防守方血量，胜利可获得对应家族能量，防守失败损失能量。当守阵数量不足时，自动填充系统守阵，可用玩家守阵替换。"
	},
	{
		1,
		4,
		"board_llzz_guiz03",
		"1、单场比赛结束后，根据家族累计能量排行给比赛中活跃的成员发放奖励（完成了布阵或战斗即为活跃成员）。2、神柱能量按比例换算成赛季积分，累计赛季积分达到后，即可获得对应的赛季奖励。"
	}
}
local t_new_family_battle_rules = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_new_family_battle_rules.dataList = dataList

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

return t_new_family_battle_rules
