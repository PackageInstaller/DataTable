-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ciyuan_boss_buff_plan.lua

module("logicconfig.config.t_king_ciyuan_boss_buff_plan", package.seeall)

local title = {
	buffPlanId = 1,
	name = 4,
	buffId = 2,
	icon = 3,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		"icon_expedition_yadao01",
		"满气势",
		"满气势：战斗开始时，玩家精灵气势+150"
	},
	{
		1,
		2,
		"icon_expedition_zengshang",
		"易燃体质",
		"易燃体质：战斗开始时，令敌方受伤增加25%（2回合）"
	},
	{
		1,
		3,
		"icon_expedition_xueliang",
		"不屈",
		"不屈：己方每次第1个阵亡的精灵，将强制保留1点血量"
	},
	{
		1,
		4,
		"icon_expedition_baotou",
		"凝神一击",
		"凝神一击：超杀技能的伤害提升20%"
	},
	{
		1,
		5,
		"icon_expedition_zhuiji",
		"魔法水晶",
		"魔法水晶：魔法伤害提升25%"
	},
	{
		1,
		6,
		"icon_expedition_bianyi01",
		"天使之剑",
		"天使之剑：物理伤害提升25%"
	},
	{
		1,
		7,
		"icon_expedition_huishou",
		"元素罗盘",
		"元素罗盘：每次攻击时，属性克制效果提升50%"
	},
	{
		1,
		8,
		"icon_expedition_chixue01",
		"穿云剑",
		"穿云剑：每次攻击会造成攻击12%的额外伤害"
	}
}
local t_king_ciyuan_boss_buff_plan = {
	{
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

t_king_ciyuan_boss_buff_plan.dataList = dataList

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

return t_king_ciyuan_boss_buff_plan
