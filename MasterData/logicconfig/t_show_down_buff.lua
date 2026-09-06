-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_down_buff.lua

module("logicconfig.config.t_show_down_buff", package.seeall)

local title = {
	name = 3,
	buffId = 2,
	selectBuffPlanId = 1,
	iconPath = 5,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		"死亡减伤",
		"己方每死亡一个精灵，所有精灵受伤-5%",
		"icon_expedition_chushouqianjianshang"
	},
	{
		1,
		2,
		"克制增伤",
		"攻击目标时，若对方被自己克制，伤害+25%",
		"icon_expedition_buqu"
	},
	{
		1,
		3,
		"吸收气势",
		"攻击命中目标后，吸收目标10点气势",
		"icon_expedition_bianyi01"
	},
	{
		1,
		4,
		"超杀降伤",
		"释放超杀后，降低20%下次受到的伤害",
		"icon_expedition_chaoshahoumianyi"
	},
	{
		1,
		5,
		"额外出手",
		"攻击后有20%的概率额外出手一次（每轮最多额外出手1次）",
		"icon_expedition_zhuiji"
	},
	{
		1,
		6,
		"格挡",
		"格挡率+20%",
		"icon_expedition_wufangqishi"
	},
	{
		1,
		7,
		"穿透护盾",
		"对带有护盾的目标伤害+25%",
		"icon_expedition_wushifangyu"
	},
	{
		2,
		1,
		"双刃剑",
		"技能命中目标后，额外造成攻击20%的伤害，女性精灵在每个大回合结束时给自身+20气势",
		"icon_expedition_jingzhun01"
	},
	{
		2,
		2,
		"无视防御",
		"无视目标35%防御，女性精灵在每个大回合结束时给自身+20气势",
		"icon_expedition_yisun01"
	},
	{
		2,
		3,
		"超杀伤害",
		"超杀伤害+20%，女性精灵在每个大回合结束时给自身+20气势",
		"icon_expedition_shanghaitisheng"
	},
	{
		2,
		4,
		"恢复生命",
		"每回合结束时，恢复12%的生命，女性精灵在每个大回合结束时给自身+20气势",
		"icon_expedition_kaichanghuixue"
	},
	{
		2,
		5,
		"死亡加气",
		"己方每死亡一个精灵，所有精灵+15点气势，女性精灵在每个大回合结束时给自身+20气势",
		"icon_expedition_liaoxiaojiangdi"
	},
	{
		2,
		6,
		"残血收割",
		"攻击50%以下生命的目标时，伤害+25%，女性精灵在每个大回合结束时给自身+20气势",
		"icon_expedition_ganran"
	},
	{
		2,
		7,
		"死亡加暴",
		"己方每死亡一个精灵，所有精灵暴击率+10%，女性精灵在每个大回合结束时给自身+20气势",
		"icon_expedition_chushouqianjianshang"
	},
	{
		2,
		8,
		"克制增伤",
		"攻击目标时，若对方被自己克制，伤害+40%，女性精灵在每个大回合结束时给自身+20气势",
		"icon_expedition_buqu"
	},
	{
		2,
		9,
		"吸收气势",
		"攻击命中目标后，吸收目标25点气势，女性精灵在每个大回合结束时给自身+20气势",
		"icon_expedition_bianyi01"
	},
	{
		2,
		10,
		"超杀降伤",
		"释放超杀后，降低40%下次受到的伤害，女性精灵在每个大回合结束时给自身+20气势",
		"icon_expedition_chaoshahoumianyi"
	},
	{
		2,
		11,
		"额外出手",
		"攻击后有100%的概率额外出手一次（每轮最多额外出手1次），女性精灵在每个大回合结束时给自身+20气势",
		"icon_expedition_zhuiji"
	},
	{
		2,
		12,
		"免疫伤害",
		"免疫一次伤害，女性精灵在每个大回合结束时给自身+20气势",
		"icon_expedition_wufangqishi"
	},
	{
		2,
		13,
		"穿透护盾",
		"对带有护盾的目标伤害+50%，女性精灵在每个大回合结束时给自身+20气势",
		"icon_expedition_wushifangyu"
	}
}
local t_show_down_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	{
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
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_show_down_buff.dataList = dataList

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

return t_show_down_buff
