-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kun_lun_challenge_extreme_card.lua

module("logicconfig.config.t_kun_lun_challenge_extreme_card", package.seeall)

local title = {
	cardId = 4,
	groupId = 2,
	param = 6,
	type = 5,
	index = 3,
	iconPath = 8,
	activityId = 1,
	desc = 7
}
local dataList = {
	{
		304001,
		1,
		1,
		1,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051201:99\"}}]",
		"敌阵精灵每次攻击吸收目标30点气势",
		"expevents/icon_expedition_kaichangqishi"
	},
	{
		304001,
		1,
		2,
		2,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051202:99\"}}]",
		"敌阵精灵每次攻击吸收目标60点气势",
		"expevents/icon_expedition_kaichangqishi"
	},
	{
		304001,
		1,
		3,
		3,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051203:99\"}}]",
		"敌阵精灵每次攻击吸收目标90点气势",
		"expevents/icon_expedition_kaichangqishi"
	},
	{
		304001,
		2,
		1,
		4,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051214:99\"}}]",
		"敌阵精灵优先攻击己阵气势最高的目标（被攻击1次后移除）",
		"expevents/icon_expedition_kaichanghuixue"
	},
	{
		304001,
		2,
		2,
		5,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051215:99\"}}]",
		"敌阵精灵优先攻击己阵气势最高的目标（被攻击2次后移除）",
		"expevents/icon_expedition_kaichanghuixue"
	},
	{
		304001,
		2,
		3,
		6,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051216:99\"}}]",
		"敌阵精灵优先攻击己阵气势最高的目标（被攻击3次后移除）",
		"expevents/icon_expedition_kaichanghuixue"
	},
	{
		304001,
		3,
		1,
		7,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051204:99#20051208:99#20051209:99\"}}]",
		"敌阵受到的非连击伤害减少15%",
		"expevents/icon_expedition_chushouqianjianshang"
	},
	{
		304001,
		3,
		2,
		8,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051204:99#20051208:99#20051210:99\"}}]",
		"敌阵受到的非连击伤害减少30%",
		"expevents/icon_expedition_chushouqianjianshang"
	},
	{
		304001,
		3,
		3,
		9,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051204:99#20051208:99#20051211:99\"}}]",
		"敌阵受到的非连击伤害减少45%",
		"expevents/icon_expedition_chushouqianjianshang"
	},
	{
		304001,
		4,
		1,
		10,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"myself\", \"params\":{\"buffs\":\"20051217:99\"}}]",
		"5回合内结束战斗",
		"expevents/icon_expedition_guijia01"
	},
	{
		304001,
		4,
		2,
		11,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"myself\", \"params\":{\"buffs\":\"20051218:99\"}}]",
		"4回合内结束战斗",
		"expevents/icon_expedition_guijia01"
	},
	{
		304001,
		4,
		3,
		12,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"myself\", \"params\":{\"buffs\":\"20051219:99\"}}]",
		"3回合内结束战斗",
		"expevents/icon_expedition_guijia01"
	},
	{
		304001,
		5,
		1,
		13,
		2,
		"140",
		"我方精灵至少连击5次",
		"expevents/icon_expedition_wushang"
	},
	{
		304001,
		5,
		2,
		14,
		2,
		"141",
		"我方精灵出手次数达到25次",
		"expevents/icon_expedition_wushang"
	},
	{
		304001,
		5,
		3,
		15,
		2,
		"25",
		"我方精灵存活=6",
		"expevents/icon_expedition_wushang"
	},
	{
		304001,
		6,
		1,
		16,
		3,
		"167",
		"必须上阵六只火系精灵或者水系或者草系精灵",
		"expevents/icon_expedition_yadao01"
	},
	{
		304001,
		6,
		2,
		17,
		3,
		"168",
		"必须上阵六只空系精灵或者创系精灵",
		"expevents/icon_expedition_yadao01"
	},
	{
		304001,
		6,
		3,
		18,
		3,
		"169",
		"必须上阵六只光系精灵或者暗系精灵",
		"expevents/icon_expedition_yadao01"
	},
	{
		304002,
		1,
		1,
		1,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051201:99\"}}]",
		"敌阵精灵每次攻击吸收目标30点气势",
		"expevents/icon_expedition_kaichangqishi"
	},
	{
		304002,
		1,
		2,
		2,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051202:99\"}}]",
		"敌阵精灵每次攻击吸收目标60点气势",
		"expevents/icon_expedition_kaichangqishi"
	},
	{
		304002,
		1,
		3,
		3,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051203:99\"}}]",
		"敌阵精灵每次攻击吸收目标90点气势",
		"expevents/icon_expedition_kaichangqishi"
	},
	{
		304002,
		2,
		1,
		4,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051214:99\"}}]",
		"敌阵精灵优先攻击己阵气势最高的目标（被攻击1次后移除）",
		"expevents/icon_expedition_kaichanghuixue"
	},
	{
		304002,
		2,
		2,
		5,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051215:99\"}}]",
		"敌阵精灵优先攻击己阵气势最高的目标（被攻击2次后移除）",
		"expevents/icon_expedition_kaichanghuixue"
	},
	{
		304002,
		2,
		3,
		6,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051216:99\"}}]",
		"敌阵精灵优先攻击己阵气势最高的目标（被攻击3次后移除）",
		"expevents/icon_expedition_kaichanghuixue"
	},
	{
		304002,
		3,
		1,
		7,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051204:99#20051208:99#20051209:99\"}}]",
		"敌阵受到的非连击伤害减少15%",
		"expevents/icon_expedition_chushouqianjianshang"
	},
	{
		304002,
		3,
		2,
		8,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051204:99#20051208:99#20051210:99\"}}]",
		"敌阵受到的非连击伤害减少30%",
		"expevents/icon_expedition_chushouqianjianshang"
	},
	{
		304002,
		3,
		3,
		9,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"enemy\", \"params\":{\"buffs\":\"20051204:99#20051208:99#20051211:99\"}}]",
		"敌阵受到的非连击伤害减少45%",
		"expevents/icon_expedition_chushouqianjianshang"
	},
	{
		304002,
		4,
		1,
		10,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"myself\", \"params\":{\"buffs\":\"20051217:99\"}}]",
		"5回合内结束战斗",
		"expevents/icon_expedition_guijia01"
	},
	{
		304002,
		4,
		2,
		11,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"myself\", \"params\":{\"buffs\":\"20051218:99\"}}]",
		"4回合内结束战斗",
		"expevents/icon_expedition_guijia01"
	},
	{
		304002,
		4,
		3,
		12,
		1,
		"[{\"clazz\":\"Common\", \"target\":\"myself\", \"params\":{\"buffs\":\"20051219:99\"}}]",
		"3回合内结束战斗",
		"expevents/icon_expedition_guijia01"
	},
	{
		304002,
		5,
		1,
		13,
		2,
		"140",
		"我方精灵至少连击5次",
		"expevents/icon_expedition_wushang"
	},
	{
		304002,
		5,
		2,
		14,
		2,
		"141",
		"我方精灵出手次数达到25次",
		"expevents/icon_expedition_wushang"
	},
	{
		304002,
		5,
		3,
		15,
		2,
		"25",
		"我方精灵存活=6",
		"expevents/icon_expedition_wushang"
	},
	{
		304002,
		6,
		1,
		16,
		3,
		"167",
		"必须上阵六只火系精灵或者水系或者草系精灵",
		"expevents/icon_expedition_yadao01"
	},
	{
		304002,
		6,
		2,
		17,
		3,
		"168",
		"必须上阵六只空系精灵或者创系精灵",
		"expevents/icon_expedition_yadao01"
	},
	{
		304002,
		6,
		3,
		18,
		3,
		"169",
		"必须上阵六只光系精灵或者暗系精灵",
		"expevents/icon_expedition_yadao01"
	}
}
local t_kun_lun_challenge_extreme_card = {
	[304001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9]
		},
		{
			dataList[10],
			dataList[11],
			dataList[12]
		},
		{
			dataList[13],
			dataList[14],
			dataList[15]
		},
		{
			dataList[16],
			dataList[17],
			dataList[18]
		}
	},
	[304002] = {
		{
			dataList[19],
			dataList[20],
			dataList[21]
		},
		{
			dataList[22],
			dataList[23],
			dataList[24]
		},
		{
			dataList[25],
			dataList[26],
			dataList[27]
		},
		{
			dataList[28],
			dataList[29],
			dataList[30]
		},
		{
			dataList[31],
			dataList[32],
			dataList[33]
		},
		{
			dataList[34],
			dataList[35],
			dataList[36]
		}
	}
}

t_kun_lun_challenge_extreme_card.dataList = dataList

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

return t_kun_lun_challenge_extreme_card
