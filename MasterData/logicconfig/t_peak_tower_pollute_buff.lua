-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_peak_tower_pollute_buff.lua

module("logicconfig.config.t_peak_tower_pollute_buff", package.seeall)

local title = {
	activityId = 1,
	buffId = 2,
	desc = 3
}
local dataList = {
	{
		567001,
		1,
		"敌阵战力最高和攻击力最高的精灵出手前降低目标20%全属性（1回合）"
	},
	{
		567001,
		2,
		"我方精灵受到伤害加深30%"
	},
	{
		567001,
		3,
		"敌阵精灵每次出手获得自身生命值*30%的护盾（1回合）"
	},
	{
		567001,
		4,
		"敌阵精灵超杀后眩晕对手（1回合）"
	},
	{
		567001,
		5,
		"敌阵精灵攻击血量低于50%的目标时，有50%的几率使其受到本次伤害加深40%"
	},
	{
		567001,
		6,
		"敌阵精灵超杀后使敌阵攻击力最高的精灵增加30点气势并获得一次立即出手"
	},
	{
		567001,
		7,
		"敌阵精灵全属性提高20%"
	}
}
local t_peak_tower_pollute_buff = {
	[567001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_peak_tower_pollute_buff.dataList = dataList

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

return t_peak_tower_pollute_buff
