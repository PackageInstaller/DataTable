-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_challenge_buff.lua

module("logicconfig.config.t_eternal_challenge_buff", package.seeall)

local title = {
	cost = 6,
	name = 4,
	buffId = 2,
	buffDesc = 7,
	iconPath = 5,
	activityId = 1,
	level = 3
}
local dataList = {
	{
		297001,
		1,
		0,
		"增气",
		"expevents/icon_expedition_kaichangqishi",
		"",
		"每次受击后，令同横排的存活精灵获得0气势"
	},
	{
		297001,
		1,
		1,
		"增气",
		"expevents/icon_expedition_kaichangqishi",
		"4:510210:100",
		"每次受击后，令同横排的存活精灵获得5气势"
	},
	{
		297001,
		1,
		2,
		"增气",
		"expevents/icon_expedition_kaichangqishi",
		"4:510210:150",
		"每次受击后，令同横排的存活精灵获得10气势"
	},
	{
		297001,
		1,
		3,
		"增气",
		"expevents/icon_expedition_kaichangqishi",
		"4:510210:200",
		"每次受击后，令同横排的存活精灵获得15气势"
	},
	{
		297001,
		1,
		4,
		"增气",
		"expevents/icon_expedition_kaichangqishi",
		"4:510210:300",
		"每次受击后，令同横排的存活精灵获得20气势"
	},
	{
		297001,
		1,
		5,
		"增气",
		"expevents/icon_expedition_kaichangqishi",
		"4:510210:500",
		"每次受击后，令同横排的存活精灵获得25气势"
	},
	{
		297001,
		2,
		0,
		"回血",
		"expevents/icon_expedition_kaichanghuixue",
		"",
		"每次攻击后，令同横排血量最低的存活精灵恢复0%生命值"
	},
	{
		297001,
		2,
		1,
		"回血",
		"expevents/icon_expedition_kaichanghuixue",
		"4:510210:100",
		"每次攻击后，令同横排血量最低的存活精灵恢复2%生命值"
	},
	{
		297001,
		2,
		2,
		"回血",
		"expevents/icon_expedition_kaichanghuixue",
		"4:510210:150",
		"每次攻击后，令同横排血量最低的存活精灵恢复4%生命值"
	},
	{
		297001,
		2,
		3,
		"回血",
		"expevents/icon_expedition_kaichanghuixue",
		"4:510210:200",
		"每次攻击后，令同横排血量最低的存活精灵恢复6%生命值"
	},
	{
		297001,
		2,
		4,
		"回血",
		"expevents/icon_expedition_kaichanghuixue",
		"4:510210:300",
		"每次攻击后，令同横排血量最低的存活精灵恢复8%生命值"
	},
	{
		297001,
		2,
		5,
		"回血",
		"expevents/icon_expedition_kaichanghuixue",
		"4:510210:500",
		"每次攻击后，令同横排血量最低的存活精灵恢复10%生命值"
	},
	{
		297001,
		3,
		0,
		"减伤",
		"expevents/icon_expedition_chushouqianjianshang",
		"",
		"每个大回合结束时，令己阵血量最低的存活精灵获得0%减伤"
	},
	{
		297001,
		3,
		1,
		"减伤",
		"expevents/icon_expedition_chushouqianjianshang",
		"4:510210:100",
		"每个大回合结束时，令己阵血量最低的存活精灵获得10%减伤"
	},
	{
		297001,
		3,
		2,
		"减伤",
		"expevents/icon_expedition_chushouqianjianshang",
		"4:510210:150",
		"每个大回合结束时，令己阵血量最低的存活精灵获得20%减伤"
	},
	{
		297001,
		3,
		3,
		"减伤",
		"expevents/icon_expedition_chushouqianjianshang",
		"4:510210:200",
		"每个大回合结束时，令己阵血量最低的存活精灵获得30%减伤"
	},
	{
		297001,
		3,
		4,
		"减伤",
		"expevents/icon_expedition_chushouqianjianshang",
		"4:510210:300",
		"每个大回合结束时，令己阵血量最低的存活精灵获得40%减伤"
	},
	{
		297001,
		3,
		5,
		"减伤",
		"expevents/icon_expedition_chushouqianjianshang",
		"4:510210:500",
		"每个大回合结束时，令己阵血量最低的存活精灵获得50%减伤"
	},
	{
		297001,
		4,
		0,
		"护盾",
		"expevents/icon_expedition_guijia01",
		"",
		"进入战斗时，获得0%最大生命值的护盾"
	},
	{
		297001,
		4,
		1,
		"护盾",
		"expevents/icon_expedition_guijia01",
		"4:510210:100",
		"进入战斗时，获得10%最大生命值的护盾"
	},
	{
		297001,
		4,
		2,
		"护盾",
		"expevents/icon_expedition_guijia01",
		"4:510210:150",
		"进入战斗时，获得20%最大生命值的护盾"
	},
	{
		297001,
		4,
		3,
		"护盾",
		"expevents/icon_expedition_guijia01",
		"4:510210:200",
		"进入战斗时，获得30%最大生命值的护盾"
	},
	{
		297001,
		4,
		4,
		"护盾",
		"expevents/icon_expedition_guijia01",
		"4:510210:300",
		"进入战斗时，获得40%最大生命值的护盾"
	},
	{
		297001,
		4,
		5,
		"护盾",
		"expevents/icon_expedition_guijia01",
		"4:510210:500",
		"进入战斗时，获得50%最大生命值的护盾"
	},
	{
		297001,
		5,
		0,
		"加攻",
		"expevents/icon_expedition_wushang",
		"",
		"每次死亡后，全体存活精灵攻击力增加0%"
	},
	{
		297001,
		5,
		1,
		"加攻",
		"expevents/icon_expedition_wushang",
		"4:510210:100",
		"每次死亡后，全体存活精灵攻击力增加3%"
	},
	{
		297001,
		5,
		2,
		"加攻",
		"expevents/icon_expedition_wushang",
		"4:510210:150",
		"每次死亡后，全体存活精灵攻击力增加6%"
	},
	{
		297001,
		5,
		3,
		"加攻",
		"expevents/icon_expedition_wushang",
		"4:510210:200",
		"每次死亡后，全体存活精灵攻击力增加9%"
	},
	{
		297001,
		5,
		4,
		"加攻",
		"expevents/icon_expedition_wushang",
		"4:510210:300",
		"每次死亡后，全体存活精灵攻击力增加12%"
	},
	{
		297001,
		5,
		5,
		"加攻",
		"expevents/icon_expedition_wushang",
		"4:510210:500",
		"每次死亡后，全体存活精灵攻击力增加15%"
	}
}
local t_eternal_challenge_buff = {
	[297001] = {
		{
			[0] = dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			[0] = dataList[7],
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		},
		{
			[0] = dataList[13],
			dataList[14],
			dataList[15],
			dataList[16],
			dataList[17],
			dataList[18]
		},
		{
			[0] = dataList[19],
			dataList[20],
			dataList[21],
			dataList[22],
			dataList[23],
			dataList[24]
		},
		{
			[0] = dataList[25],
			dataList[26],
			dataList[27],
			dataList[28],
			dataList[29],
			dataList[30]
		}
	}
}

t_eternal_challenge_buff.dataList = dataList

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

return t_eternal_challenge_buff
