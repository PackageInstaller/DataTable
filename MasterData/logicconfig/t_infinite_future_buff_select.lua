-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_infinite_future_buff_select.lua

module("logicconfig.config.t_infinite_future_buff_select", package.seeall)

local title = {
	stageId = 5,
	name = 3,
	buffId = 2,
	icon = 6,
	planId = 1,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		"超杀降伤",
		"释放超杀后，降低下次受到的伤害20%",
		1,
		"icon_expedition_chaoshahoumianyi"
	},
	{
		1,
		2,
		"意志坚强",
		"受到非直接伤害减少50%",
		1,
		"icon_expedition_shoujibingdong"
	},
	{
		1,
		3,
		"格挡",
		"格挡率+20%",
		1,
		"icon_expedition_wufangqishi"
	},
	{
		1,
		4,
		"双刃剑",
		"技能命中目标后，额外造成攻击20%的伤害",
		4,
		"icon_expedition_jingzhun01"
	},
	{
		1,
		5,
		"超杀增幅",
		"超杀伤害+20%",
		4,
		"icon_expedition_shanghaitisheng"
	},
	{
		1,
		6,
		"复苏之风",
		"每回合结束时，恢复8%的生命",
		7,
		"icon_expedition_chixue01"
	},
	{
		1,
		7,
		"残血收割",
		"攻击50%以下生命的目标时，伤害+25%",
		7,
		"icon_expedition_ganran"
	},
	{
		1,
		8,
		"穿透护盾",
		"对带有护盾的目标伤害+25%",
		7,
		"icon_expedition_wushifangyu"
	},
	{
		2,
		1,
		"超杀降伤",
		"释放超杀后，降低下次受到的伤害20%",
		1,
		"icon_expedition_chaoshahoumianyi"
	},
	{
		2,
		2,
		"意志坚强",
		"受到非直接伤害减少50%",
		1,
		"icon_expedition_shoujibingdong"
	},
	{
		2,
		3,
		"格挡",
		"格挡率+20%",
		1,
		"icon_expedition_wufangqishi"
	},
	{
		2,
		4,
		"双刃剑",
		"技能命中目标后，额外造成攻击20%的伤害",
		4,
		"icon_expedition_jingzhun01"
	},
	{
		2,
		5,
		"超杀增幅",
		"超杀伤害+20%",
		4,
		"icon_expedition_shanghaitisheng"
	},
	{
		2,
		6,
		"复苏之风",
		"每回合结束时，恢复8%的生命",
		7,
		"icon_expedition_chixue01"
	},
	{
		2,
		7,
		"残血收割",
		"攻击50%以下生命的目标时，伤害+25%",
		7,
		"icon_expedition_ganran"
	},
	{
		2,
		8,
		"穿透护盾",
		"对带有护盾的目标伤害+25%",
		7,
		"icon_expedition_wushifangyu"
	},
	{
		3,
		1,
		"超杀降伤",
		"释放超杀后，降低下次受到的伤害20%",
		1,
		"icon_expedition_chaoshahoumianyi"
	},
	{
		3,
		2,
		"意志坚强",
		"受到非直接伤害减少50%",
		1,
		"icon_expedition_shoujibingdong"
	},
	{
		3,
		3,
		"格挡",
		"格挡率+20%",
		1,
		"icon_expedition_wufangqishi"
	},
	{
		3,
		4,
		"双刃剑",
		"技能命中目标后，额外造成攻击20%的伤害",
		4,
		"icon_expedition_jingzhun01"
	},
	{
		3,
		5,
		"超杀增幅",
		"超杀伤害+20%",
		4,
		"icon_expedition_shanghaitisheng"
	},
	{
		3,
		6,
		"复苏之风",
		"每回合结束时，恢复8%的生命",
		7,
		"icon_expedition_chixue01"
	},
	{
		3,
		7,
		"残血收割",
		"攻击50%以下生命的目标时，伤害+25%",
		7,
		"icon_expedition_ganran"
	},
	{
		3,
		8,
		"穿透护盾",
		"对带有护盾的目标伤害+25%",
		7,
		"icon_expedition_wushifangyu"
	}
}
local t_infinite_future_buff_select = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	},
	{
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	}
}

t_infinite_future_buff_select.dataList = dataList

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

return t_infinite_future_buff_select
