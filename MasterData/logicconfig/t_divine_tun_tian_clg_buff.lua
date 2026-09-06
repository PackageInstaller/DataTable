-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_tun_tian_clg_buff.lua

module("logicconfig.config.t_divine_tun_tian_clg_buff", package.seeall)

local title = {
	desc = 3,
	powerArrDesc = 4,
	buffPlanId = 1,
	progress = 2
}
local dataList = {
	{
		1,
		0,
		"敌阵免伤、非伤免伤+10%",
		"0-4"
	},
	{
		1,
		5,
		"敌阵免伤、非伤免伤及全属性+10%",
		"5-9"
	},
	{
		1,
		10,
		"敌阵免伤、非伤免伤+20%及全属性+30%",
		"10-19"
	},
	{
		1,
		20,
		"敌阵免伤、非伤免伤+30%及全属性+30%",
		"20-29"
	},
	{
		1,
		30,
		"敌阵免伤、非伤免伤+30%，全属性+30%及免疫无法行动",
		"30-39"
	},
	{
		1,
		40,
		"敌阵免伤、非伤免伤+30%及全属性+30%,精灵首次死亡时变身为无垢天使",
		"40-"
	},
	{
		2,
		0,
		"敌阵全属性+<color=#20b376>10%</color>",
		"0-1"
	},
	{
		2,
		2,
		"敌阵全属性+<color=#20b376>20%</color>",
		"2-3"
	},
	{
		2,
		4,
		"敌阵全属性+<color=#20b376>30%</color>",
		"4-5"
	},
	{
		2,
		6,
		"敌阵全属性+<color=#20b376>40%</color>",
		"6-7"
	},
	{
		2,
		8,
		"敌阵全属性+<color=#20b376>50%</color>",
		"8-9"
	},
	{
		2,
		10,
		"敌阵全属性+<color=#20b376>60%</color>",
		"10-"
	}
}
local t_divine_tun_tian_clg_buff = {
	{
		[0] = dataList[1],
		[5] = dataList[2],
		[10] = dataList[3],
		[20] = dataList[4],
		[30] = dataList[5],
		[40] = dataList[6]
	},
	{
		[0] = dataList[7],
		[2] = dataList[8],
		[4] = dataList[9],
		[6] = dataList[10],
		[8] = dataList[11],
		[10] = dataList[12]
	}
}

t_divine_tun_tian_clg_buff.dataList = dataList

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

return t_divine_tun_tian_clg_buff
