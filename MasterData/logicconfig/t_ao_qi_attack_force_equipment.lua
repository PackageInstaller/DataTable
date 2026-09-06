-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ao_qi_attack_force_equipment.lua

module("logicconfig.config.t_ao_qi_attack_force_equipment", package.seeall)

local title = {
	equipmentInGameId = 5,
	name = 3,
	equipmentId = 2,
	activityId = 1,
	initLevel = 4
}
local dataList = {
	{
		436001,
		1,
		"匕首",
		0,
		2
	},
	{
		436001,
		2,
		"长剑",
		0,
		3
	},
	{
		436001,
		3,
		"飞镖",
		0,
		4
	},
	{
		436001,
		4,
		"斧头",
		0,
		5
	},
	{
		436001,
		5,
		"弓箭",
		0,
		6
	},
	{
		436001,
		6,
		"回旋镖",
		1,
		7
	},
	{
		436001,
		7,
		"火魔法书",
		0,
		8
	},
	{
		436001,
		8,
		"冰魔杖",
		0,
		9
	},
	{
		436001,
		9,
		"毒药瓶",
		1,
		10
	},
	{
		436001,
		10,
		"手套",
		1,
		11
	},
	{
		436001,
		11,
		"帽子",
		0,
		12
	},
	{
		436001,
		12,
		"盾牌",
		0,
		13
	},
	{
		436001,
		13,
		"落雷法杖",
		0,
		14
	},
	{
		436001,
		14,
		"十字弩",
		0,
		15
	},
	{
		436001,
		15,
		"指环",
		0,
		16
	},
	{
		436002,
		1,
		"匕首",
		0,
		2
	},
	{
		436002,
		2,
		"长剑",
		0,
		3
	},
	{
		436002,
		3,
		"飞镖",
		0,
		4
	},
	{
		436002,
		4,
		"斧头",
		0,
		5
	},
	{
		436002,
		5,
		"弓箭",
		0,
		6
	},
	{
		436002,
		6,
		"回旋镖",
		1,
		7
	},
	{
		436002,
		7,
		"火魔法书",
		0,
		8
	},
	{
		436002,
		8,
		"冰魔杖",
		0,
		9
	},
	{
		436002,
		9,
		"毒药瓶",
		1,
		10
	},
	{
		436002,
		10,
		"手套",
		1,
		11
	},
	{
		436002,
		11,
		"帽子",
		0,
		12
	},
	{
		436002,
		12,
		"盾牌",
		0,
		13
	},
	{
		436002,
		13,
		"落雷法杖",
		0,
		14
	},
	{
		436002,
		14,
		"十字弩",
		0,
		15
	},
	{
		436002,
		15,
		"指环",
		0,
		16
	}
}
local t_ao_qi_attack_force_equipment = {
	[436001] = {
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
		dataList[15]
	},
	[436002] = {
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	}
}

t_ao_qi_attack_force_equipment.dataList = dataList

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

return t_ao_qi_attack_force_equipment
