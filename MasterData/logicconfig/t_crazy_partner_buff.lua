-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_crazy_partner_buff.lua

module("logicconfig.config.t_crazy_partner_buff", package.seeall)

local title = {
	clientBufferId = 1,
	desc = 3,
	params = 4,
	type = 2
}
local dataList = {
	{
		1,
		1,
		"引爆力量：每击杀1只BOSS周围的自爆豆，己阵精灵伤害提升<color=red>20%</color>",
		""
	},
	{
		2,
		2,
		"引爆力量：按顺序击杀BOSS周围的自爆豆，下回合<color=red>己阵精灵伤害提升200%</color>",
		"1,2,3"
	},
	{
		3,
		3,
		"引爆力量：BOSS周围的自爆豆<color=red>免疫</color>非火系精灵伤害，使用火系精灵才可击杀，击杀后己阵精灵伤害提升<color=red>50%</color>",
		""
	},
	{
		4,
		1,
		"引爆力量：每击杀1只BOSS周围的自爆豆，己阵精灵伤害提升<color=red>20%</color>",
		""
	},
	{
		5,
		2,
		"引爆力量：按顺序击杀BOSS周围的自爆豆，下回合<color=red>己阵精灵伤害提升200%</color>",
		"4,6,9"
	},
	{
		6,
		3,
		"引爆力量：BOSS周围的自爆豆<color=red>免疫</color>非火系精灵伤害，使用火系精灵才可击杀，击杀后己阵精灵伤害提升<color=red>50%</color>",
		""
	},
	{
		7,
		1,
		"引爆力量：每击杀1只BOSS周围的自爆豆，己阵精灵伤害提升<color=red>20%</color>",
		""
	},
	{
		8,
		2,
		"引爆力量：按顺序击杀BOSS周围的自爆豆，下回合<color=red>己阵精灵伤害提升200%</color>",
		"2,7,8"
	},
	{
		9,
		3,
		"引爆力量：BOSS周围的自爆豆<color=red>免疫</color>非火系精灵伤害，使用火系精灵才可击杀，击杀后己阵精灵伤害提升<color=red>50%</color>",
		""
	},
	{
		10,
		1,
		"引爆力量：每击杀1只BOSS周围的自爆豆，己阵精灵伤害提升<color=red>20%</color>",
		""
	},
	{
		11,
		2,
		"引爆力量：按顺序击杀BOSS周围的自爆豆，下回合<color=red>己阵精灵伤害提升200%</color>",
		"4,6,8"
	},
	{
		12,
		3,
		"引爆力量：BOSS周围的自爆豆<color=red>免疫</color>非火系精灵伤害，使用火系精灵才可击杀，击杀后己阵精灵伤害提升<color=red>50%</color>",
		""
	},
	{
		13,
		1,
		"引爆力量：每击杀1只BOSS周围的自爆豆，己阵精灵伤害提升<color=red>20%</color>",
		""
	},
	{
		14,
		2,
		"引爆力量：按顺序击杀BOSS周围的自爆豆，下回合<color=red>己阵精灵伤害提升200%</color>",
		"1,2,7"
	},
	{
		15,
		3,
		"引爆力量：BOSS周围的自爆豆<color=red>免疫</color>非火系精灵伤害，使用火系精灵才可击杀，击杀后己阵精灵伤害提升<color=red>50%</color>",
		""
	},
	{
		16,
		1,
		"引爆力量：每击杀1只BOSS周围的自爆豆，己阵精灵伤害提升<color=red>20%</color>",
		""
	},
	{
		17,
		2,
		"引爆力量：按顺序击杀BOSS周围的自爆豆，下回合<color=red>己阵精灵伤害提升200%</color>",
		"3,7,9"
	},
	{
		18,
		3,
		"引爆力量：BOSS周围的自爆豆<color=red>免疫</color>非火系精灵伤害，使用火系精灵才可击杀，击杀后己阵精灵伤害提升<color=red>50%</color>",
		""
	}
}
local t_crazy_partner_buff = {
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

t_crazy_partner_buff.dataList = dataList

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

return t_crazy_partner_buff
