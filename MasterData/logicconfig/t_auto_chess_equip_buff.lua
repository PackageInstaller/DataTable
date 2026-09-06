-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_auto_chess_equip_buff.lua

module("logicconfig.config.t_auto_chess_equip_buff", package.seeall)

local title = {
	iconPath = 3,
	name = 2,
	buffId = 1,
	buffDesc = 4
}
local dataList = {
	{
		1,
		"狙击眸",
		"expevents/icon_expedition_baojilv1",
		"己方所有精灵暴击率+40%"
	},
	{
		2,
		"天雷罚",
		"expevents/icon_expedition_numu",
		"敌方死亡后周围精灵受到最大生命值20%伤害（仅1次）"
	},
	{
		3,
		"穿盾刺",
		"expevents/icon_expedition_wushifangyu",
		"己方精灵对带有护盾的精灵造成的伤害提升35%"
	},
	{
		4,
		"电屏障",
		"expevents/icon_expedition_guijia01",
		"己方精灵每次出手获得最大生命值6%的护盾（3回合）"
	},
	{
		5,
		"自愈合",
		"expevents/icon_expedition_kaichanghuixue",
		"己方精灵每回合结束时恢复8%最大生命值"
	},
	{
		6,
		"曲光屏",
		"expevents/icon_expedition_guijia",
		"己方精灵受到的群攻伤害减少30%"
	},
	{
		7,
		"诅咒击",
		"expevents/icon_expedition_shenqi_an",
		"己方精灵的技能会使目标精灵无法回血（1回合）"
	},
	{
		8,
		"回旋镖",
		"expevents/icon_expedition_chaoshafanshi",
		"己方精灵的技能对目标造成额外伤害25%"
	},
	{
		9,
		"狂战怒",
		"expevents/icon_expedition_yadao01",
		"己方每死亡一个精灵，其余精灵伤害+10%"
	},
	{
		10,
		"黄金盾",
		"expevents/icon_expedition_wufangqishi",
		"己方精灵格挡率+30%"
	},
	{
		11,
		"无视防御",
		"expevents/icon_expedition_yisun01",
		"己方精灵无视目标35%防御"
	},
	{
		12,
		"超杀伤害",
		"expevents/icon_expedition_shanghaitisheng",
		"己方精灵超杀伤害+20%"
	},
	{
		13,
		"残血收割",
		"expevents/icon_expedition_ganran",
		"己方攻击50%以下生命的目标时，伤害+25%"
	},
	{
		14,
		"死亡减伤",
		"expevents/icon_expedition_chushouqianjianshang",
		"己方每死亡一个精灵，所有精灵受伤-5%"
	},
	{
		15,
		"克制增伤",
		"expevents/icon_expedition_buqu",
		"己方攻击目标时，若对方被自己克制，伤害+25%"
	},
	{
		16,
		"吸收气势",
		"expevents/icon_expedition_bianyi01",
		"己方攻击命中目标后，吸收目标10点气势"
	},
	{
		17,
		"超杀降伤",
		"expevents/icon_expedition_chaoshahoumianyi",
		"己方释放超杀后，降低20%下次受到的伤害"
	},
	{
		18,
		"额外出手",
		"expevents/icon_expedition_zhuiji",
		"己方攻击后有20%的概率额外出手一次（每轮最多额外出手1次）"
	}
}
local t_auto_chess_equip_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18]
}

t_auto_chess_equip_buff.dataList = dataList

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

return t_auto_chess_equip_buff
