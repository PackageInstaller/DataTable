-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lotus_battle_field_buff.lua

module("logicconfig.config.t_lotus_battle_field_buff", package.seeall)

local title = {
	buffPlanId = 1,
	name = 3,
	buffId = 2,
	buffDesc = 5,
	iconPath = 4
}
local dataList = {
	{
		1,
		1,
		"双刃剑",
		"icon_expedition_jingzhun01",
		"技能命中目标后，额外造成攻击20%的伤害"
	},
	{
		1,
		2,
		"无视防御",
		"icon_expedition_yisun01",
		"无视目标35%防御"
	},
	{
		1,
		3,
		"超杀伤害",
		"icon_expedition_shanghaitisheng",
		"超杀伤害+20%"
	},
	{
		1,
		4,
		"恢复生命",
		"icon_expedition_kaichanghuixue",
		"每回合结束时，恢复8%的生命"
	},
	{
		1,
		5,
		"死亡加伤",
		"icon_expedition_liaoxiaojiangdi",
		"己方每死亡一个精灵，所有精灵伤害+5%"
	},
	{
		1,
		6,
		"残血收割",
		"icon_expedition_ganran",
		"攻击50%以下生命的目标时，伤害+25%"
	},
	{
		1,
		7,
		"死亡减伤",
		"icon_expedition_chushouqianjianshang",
		"己方每死亡一个精灵，所有精灵受伤-5%"
	},
	{
		1,
		8,
		"克制增伤",
		"icon_expedition_buqu",
		"攻击目标时，若对方被自己克制，伤害+25%"
	},
	{
		1,
		9,
		"吸收气势",
		"icon_expedition_bianyi01",
		"攻击命中目标后，吸收目标10点气势"
	},
	{
		1,
		10,
		"超杀降伤",
		"icon_expedition_chaoshahoumianyi",
		"释放超杀后，降低20%下次受到的伤害"
	},
	{
		1,
		11,
		"额外出手",
		"icon_expedition_zhuiji",
		"攻击后有20%的概率额外出手一次（每轮最多额外出手1次）"
	},
	{
		1,
		12,
		"格挡",
		"icon_expedition_wufangqishi",
		"格挡率+20%"
	},
	{
		1,
		13,
		"穿透护盾",
		"icon_expedition_wushifangyu",
		"对带有护盾的目标伤害+25%"
	}
}
local t_lotus_battle_field_buff = {
	{
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
		dataList[13]
	}
}

t_lotus_battle_field_buff.dataList = dataList

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

return t_lotus_battle_field_buff
