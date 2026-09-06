-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scratch_task.lua

module("logicconfig.config.t_scratch_task", package.seeall)

local title = {
	score = 8,
	jumpTo = 9,
	fix = 6,
	type = 5,
	title = 3,
	planId = 2,
	desc = 4,
	id = 1,
	maxProgress = 7
}
local dataList = {
	{
		1,
		1,
		"副本",
		"通关冒险剧情副本100次(含扫荡)",
		6,
		true,
		100,
		10,
		"ui#plotcopyview#0"
	},
	{
		2,
		1,
		"护送",
		"完成2次家族护送",
		9,
		false,
		2,
		10,
		"func#60#familyescort"
	},
	{
		3,
		1,
		"竞技场",
		"累计进行5场竞技场战斗",
		13,
		false,
		5,
		10,
		"func#19"
	},
	{
		4,
		1,
		"精灵挑战",
		"完成5次任意精灵挑战",
		14,
		false,
		5,
		10,
		"func#169"
	},
	{
		5,
		1,
		"家族试炼",
		"挑战2次任意家族试炼",
		15,
		false,
		2,
		10,
		"func#60#boss"
	},
	{
		6,
		1,
		"资源副本",
		"通关冒险幻境6次",
		7,
		false,
		6,
		10,
		"ui#rescopyview"
	},
	{
		7,
		1,
		"精灵升级",
		"精灵升级10次",
		1,
		false,
		10,
		10,
		"func#9"
	},
	{
		8,
		1,
		"装备升级操作",
		"进行5次装备强化",
		2,
		false,
		5,
		10,
		"func#50"
	},
	{
		10,
		2,
		"副本",
		"通关冒险剧情副本10次(含扫荡)",
		6,
		true,
		10,
		10,
		"ui#plotcopyview#0"
	},
	{
		11,
		2,
		"家族捐献",
		"完成5次家族捐献",
		8,
		false,
		5,
		10,
		"func#60#contri"
	},
	{
		12,
		2,
		"护送",
		"完成2次家族护送",
		9,
		false,
		2,
		10,
		"func#60#familyescort"
	},
	{
		13,
		2,
		"竞技场",
		"累计进行5场竞技场战斗",
		13,
		false,
		5,
		10,
		"func#19"
	},
	{
		14,
		2,
		"精灵挑战",
		"完成5次任意精灵挑战",
		14,
		false,
		5,
		10,
		"func#169"
	},
	{
		15,
		2,
		"家族试炼",
		"挑战2次任意家族试炼",
		15,
		false,
		2,
		10,
		"func#60#boss"
	},
	{
		16,
		2,
		"资源副本",
		"通关冒险幻境6次",
		7,
		false,
		6,
		10,
		"ui#rescopyview"
	},
	{
		17,
		2,
		"精灵升级",
		"精灵升级1次",
		1,
		false,
		1,
		10,
		"func#9"
	},
	{
		18,
		2,
		"装备升级操作",
		"进行5次装备强化",
		2,
		false,
		5,
		10,
		"func#50"
	},
	{
		19,
		2,
		"挖宝",
		"进行1次挖宝",
		11,
		false,
		1,
		10,
		"func#7"
	},
	{
		20,
		3,
		"副本",
		"通关冒险剧情副本100次(含扫荡)",
		6,
		true,
		100,
		10,
		"ui#plotcopyview#0"
	},
	{
		21,
		3,
		"护送",
		"完成2次家族护送",
		9,
		false,
		2,
		10,
		"func#60#familyescort"
	},
	{
		22,
		3,
		"竞技场",
		"累计进行5场竞技场战斗",
		13,
		false,
		5,
		10,
		"func#19"
	},
	{
		23,
		3,
		"精灵挑战",
		"完成5次任意精灵挑战",
		14,
		false,
		5,
		10,
		"func#169"
	},
	{
		24,
		3,
		"家族试炼",
		"挑战2次任意家族试炼",
		15,
		false,
		2,
		10,
		"func#60#boss"
	},
	{
		25,
		3,
		"资源副本",
		"通关冒险幻境6次",
		7,
		false,
		6,
		10,
		"ui#rescopyview"
	},
	{
		26,
		3,
		"精灵升级",
		"精灵升级10次",
		1,
		false,
		10,
		10,
		"func#9"
	},
	{
		27,
		3,
		"装备升级操作",
		"进行5次装备强化",
		2,
		false,
		5,
		10,
		"func#50"
	}
}
local t_scratch_task = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	[10] = dataList[9],
	[11] = dataList[10],
	[12] = dataList[11],
	[13] = dataList[12],
	[14] = dataList[13],
	[15] = dataList[14],
	[16] = dataList[15],
	[17] = dataList[16],
	[18] = dataList[17],
	[19] = dataList[18],
	[20] = dataList[19],
	[21] = dataList[20],
	[22] = dataList[21],
	[23] = dataList[22],
	[24] = dataList[23],
	[25] = dataList[24],
	[26] = dataList[25],
	[27] = dataList[26]
}

t_scratch_task.dataList = dataList

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

return t_scratch_task
