-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scuffle_random_buff.lua

module("logicconfig.config.t_scuffle_random_buff", package.seeall)

local title = {
	nature = 6,
	quality = 4,
	name = 2,
	id = 1,
	icon = 5,
	desc = 3
}
local dataList = {
	{
		1,
		"双刃剑",
		"技能命中目标后，额外造成攻击20%的伤害",
		1,
		"icon_expedition_jingzhun01",
		"0"
	},
	{
		2,
		"无视防御",
		"无视目标35%防御",
		1,
		"icon_expedition_yisun01",
		"0"
	},
	{
		3,
		"超杀伤害",
		"超杀伤害+20%",
		1,
		"icon_expedition_shanghaitisheng",
		"0"
	},
	{
		4,
		"恢复生命",
		"每回合结束时，恢复12%的生命",
		1,
		"icon_expedition_kaichanghuixue",
		"0"
	},
	{
		5,
		"死亡加气",
		"己方每死亡一个精灵，所有精灵+15点气势",
		1,
		"icon_expedition_liaoxiaojiangdi",
		"0"
	},
	{
		6,
		"残血收割",
		"攻击50%以下生命的目标时，伤害+25%",
		1,
		"icon_expedition_ganran",
		"0"
	},
	{
		7,
		"死亡加暴",
		"己方每死亡一个精灵，所有精灵暴击率+10%",
		1,
		"icon_expedition_chushouqianjianshang",
		"0"
	},
	{
		8,
		"克制增伤",
		"攻击目标时，若对方被自己克制，伤害+40%",
		1,
		"icon_expedition_buqu",
		"0"
	},
	{
		9,
		"吸收气势",
		"攻击命中目标后，吸收目标25点气势",
		1,
		"icon_expedition_bianyi01",
		"0"
	},
	{
		10,
		"超杀降伤",
		"释放超杀后，降低40%下次受到的伤害",
		1,
		"icon_expedition_chaoshahoumianyi",
		"0"
	},
	{
		11,
		"额外出手",
		"攻击后有100%的概率额外出手一次（每轮最多额外出手1次）",
		1,
		"icon_expedition_zhuiji",
		"0"
	},
	{
		12,
		"免疫伤害",
		"免疫一次伤害",
		1,
		"icon_expedition_wufangqishi",
		"0"
	},
	{
		13,
		"穿透护盾",
		"对带有护盾的目标伤害+50%",
		1,
		"icon_expedition_wushifangyu",
		"0"
	}
}
local t_scuffle_random_buff = {
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

t_scuffle_random_buff.dataList = dataList

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

return t_scuffle_random_buff
