-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_battle_rules.lua

module("logicconfig.config.t_family_battle_rules", package.seeall)

local title = {
	icon = 2,
	rulesId = 1,
	desc = 3
}
local dataList = {
	{
		1,
		"board_llzz_guiz01",
		"家族战分为4个阶段。1、报名阶段，持续3天，由族长或副族长报名,报名后新成员无法参战。2、布阵阶段，参战成员都可改变布阵。3、调配阶段，族长对守护神柱的20层布置守护。4、对抗阶段，家族成员可以进攻其他家族神柱或巢穴来获得能量。"
	},
	{
		2,
		"board_llzz_guiz01",
		"1、报名阶段结束后，族长/副族长距离上次登陆天数在2天以内，且家族等级为5级，家族成员在30人以上的家族，将自动进行报名。"
	},
	{
		3,
		"board_llzz_guiz02",
		"在对抗阶段中，神柱防守阵型血量大幅度提高。家族成员每天可以进攻其他家族神柱，战斗失败保留防守方血量，胜利可获得对应家族能量，防守失败损失能量。当守阵不足20人时，将会自动填充系统守阵，系统守阵不可替换。"
	},
	{
		4,
		"board_llzz_guiz03",
		"在结束后，根据家族累计能量排行发放全家族奖励跟赛季积分，累计赛季积分达到后，即可获得对应的赛季奖励。"
	}
}
local t_family_battle_rules = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_family_battle_rules.dataList = dataList

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

return t_family_battle_rules
