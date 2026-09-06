-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_golden_dragon_clg_prophecy.lua

module("logicconfig.config.t_origin_golden_dragon_clg_prophecy", package.seeall)

local title = {
	activityId = 1,
	name = 4,
	desc = 5,
	fmtTips = 6,
	prophecyId = 2,
	baseScore = 3
}
local dataList = {
	{
		617001,
		1,
		20,
		"首杀",
		"敌阵2号位最先被我方击败",
		"敌阵2号位最先被我方击败"
	},
	{
		617001,
		2,
		20,
		"存活",
		"本场战斗中无任何精灵阵亡",
		"本场战斗中无任何精灵阵亡"
	},
	{
		617001,
		3,
		20,
		"速杀",
		"在2个回合内战斗胜利",
		"在2个回合内战斗胜利"
	},
	{
		617001,
		4,
		20,
		"承伤",
		"我方2号位精灵承受伤害总量最高",
		"我方2号位精灵承受伤害总量最高"
	},
	{
		617001,
		5,
		20,
		"连杀",
		"单次出手击败2名及以上敌人",
		"单次出手击败2名及以上敌人"
	},
	{
		617001,
		6,
		20,
		"治疗",
		"一个大回合内治疗量达到600000",
		"一个大回合内治疗量达到600000"
	},
	{
		617001,
		7,
		20,
		"克制",
		"造成克制伤害次数>=5次",
		"造成克制伤害次数>=5次"
	},
	{
		617001,
		8,
		20,
		"站位",
		"5号位精灵存活",
		"5号位精灵存活"
	}
}
local t_origin_golden_dragon_clg_prophecy = {
	[617001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_origin_golden_dragon_clg_prophecy.dataList = dataList

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

return t_origin_golden_dragon_clg_prophecy
