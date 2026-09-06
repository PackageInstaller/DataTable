-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_survival_king_buff.lua

module("logicconfig.config.t_survival_king_buff", package.seeall)

local title = {
	cost = 3,
	name = 4,
	buffId = 2,
	iconUrl = 6,
	activityId = 1,
	desc = 5
}
local dataList = {
	{
		529001,
		1,
		"10:529001:345",
		"幽煌灭却",
		"每个大回合对敌阵全体造成己阵最高攻击力精灵的攻击力*100%的伤害",
		"ui/icon/expevents/icon_expedition_bianyi02"
	},
	{
		529001,
		2,
		"10:529001:345",
		"血祭狂歌",
		"己阵战力最高的精灵每损失1%的生命值提高0.5%的攻击力，最高提升40%",
		"ui/icon/expevents/icon_expedition_yadao01"
	},
	{
		529001,
		3,
		"10:529001:345",
		"魅影连击",
		"己阵精灵每次攻击有30%的概率获得一次立即出手，己阵全阵最多触发10次",
		"ui/icon/expevents/icon_expedition_chaoshafanshi"
	},
	{
		529001,
		4,
		"10:529001:345",
		"冥腐击穿",
		"己阵攻击力最高的精灵每次攻击无视目标25%的防御",
		"ui/icon/expevents/icon_expedition_wushifangyu"
	},
	{
		529001,
		5,
		"10:529001:345",
		"幽魂净化",
		"己阵精灵每次受击时有30%的概率解除自身当前所有减益效果，每场战斗每只精灵最多触发两次",
		"ui/icon/expevents/icon_expedition_chixue01"
	},
	{
		529001,
		6,
		"10:529001:345",
		"永夜帷幕",
		"己阵精灵复活后进入隐身状态（1回合），己阵全阵最多触发4次",
		"ui/icon/expevents/icon_expedition_liaoxiao"
	},
	{
		529001,
		7,
		"10:529001:345",
		"巫毒禁疗",
		"己阵精灵每次攻击有30%概率对目标施加禁疗效果（2回合），每场战斗每只精灵最多触发两次",
		"ui/icon/expevents/icon_expedition_baotou"
	},
	{
		529001,
		8,
		"10:529001:345",
		"魂啸夺魄",
		"己阵战力最高的精灵每次攻击降低目标30气势",
		"ui/icon/expevents/icon_expedition_shenqi_huo"
	},
	{
		529002,
		1,
		"10:529003:200",
		"幽煌灭却",
		"每个大回合对敌阵全体造成己阵最高攻击力精灵的攻击力*100%的伤害",
		"ui/icon/expevents/icon_expedition_bianyi02"
	},
	{
		529002,
		2,
		"10:529003:200",
		"血祭狂歌",
		"己阵战力最高的精灵每损失1%的生命值提高1%的攻击力，最高提升40%",
		"ui/icon/expevents/icon_expedition_yadao01"
	},
	{
		529002,
		3,
		"10:529003:200",
		"魅影连击",
		"己阵精灵每次攻击有30%的概率获得一次立即出手，己阵全阵最多触发10次",
		"ui/icon/expevents/icon_expedition_chaoshafanshi"
	},
	{
		529002,
		4,
		"10:529003:200",
		"冥腐击穿",
		"己阵攻击力最高的精灵每次攻击无视目标25%的防御",
		"ui/icon/expevents/icon_expedition_wushifangyu"
	},
	{
		529002,
		5,
		"10:529003:200",
		"幽魂净化",
		"己阵精灵每次受击时有30%的概率解除自身当前所有减益效果，每场战斗每只精灵最多触发三次",
		"ui/icon/expevents/icon_expedition_chixue01"
	},
	{
		529002,
		6,
		"10:529003:200",
		"永夜帷幕",
		"己阵精灵复活后获得300%闪避率（1回合），己阵全阵最多触发4次",
		"ui/icon/expevents/icon_expedition_liaoxiao"
	},
	{
		529002,
		7,
		"10:529003:200",
		"巫毒禁疗",
		"己阵精灵每次攻击有30%概率对目标施加禁疗效果（2回合），每场战斗每只精灵最多触发三次",
		"ui/icon/expevents/icon_expedition_baotou"
	},
	{
		529002,
		8,
		"10:529003:200",
		"魂啸夺魄",
		"己阵战力最高的精灵每次攻击降低目标30气势",
		"ui/icon/expevents/icon_expedition_shenqi_huo"
	}
}
local t_survival_king_buff = {
	[529001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[529002] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_survival_king_buff.dataList = dataList

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

return t_survival_king_buff
