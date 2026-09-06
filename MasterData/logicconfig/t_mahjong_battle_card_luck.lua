-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mahjong_battle_card_luck.lua

module("logicconfig.config.t_mahjong_battle_card_luck", package.seeall)

local title = {
	activityId = 1,
	cardLuckId = 2,
	buffs = 3,
	buffName = 5,
	buffIcon = 6,
	showDesc = 4
}
local dataList = {
	{
		571001,
		1,
		"4969:99",
		"暴击率+30%",
		"暴击率+30%",
		"expevents/icon_expedition_jingzhun01"
	},
	{
		571001,
		2,
		"215:99",
		"暴击伤害+50%",
		"暴击伤害+50%",
		"expevents/icon_expedition_yisun01"
	},
	{
		571001,
		3,
		"20070710:99",
		"攻击+25%",
		"攻击+25%",
		"expevents/icon_expedition_chushouqianjianshang"
	},
	{
		571001,
		4,
		"20070734:99",
		"防御+25%",
		"防御+25%",
		"expevents/icon_expedition_shenqi_guang"
	},
	{
		571001,
		5,
		"477:99",
		"伤害+20%",
		"伤害+20%",
		"expevents/icon_expedition_wugong3"
	},
	{
		571001,
		6,
		"20063410:99#20062234:99",
		"免伤及非伤免伤+20%",
		"免伤及非伤免伤+20%",
		"expevents/icon_expedition_wugong1"
	}
}
local t_mahjong_battle_card_luck = {
	[571001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_mahjong_battle_card_luck.dataList = dataList

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

return t_mahjong_battle_card_luck
