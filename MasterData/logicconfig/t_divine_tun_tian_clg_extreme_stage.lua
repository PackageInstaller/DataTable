-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_tun_tian_clg_extreme_stage.lua

module("logicconfig.config.t_divine_tun_tian_clg_extreme_stage", package.seeall)

local title = {
	stageId = 2,
	desc = 6,
	qrsPos = 4,
	creepsMasterId = 3,
	activityId = 1,
	passPowerCondition = 5
}
local dataList = {
	{
		508001,
		1,
		1001,
		{
			0,
			-1,
			1
		},
		4,
		"1、破阵且达到目标能量即为通关。\r\n2、挑战时，己阵精灵的变身次数会转化为能量，破阵成功即可获取能量。能量会依据关卡间的距离传导，且随距离增加而衰减。\r\n3、当所有关卡的能量总值达到对应加成区间，即可激活相应buff。\r\n4、每个关卡通关后封印本次变身次数最多的精灵，多个精灵变身次数相同则都封印。"
	},
	{
		508001,
		2,
		1002,
		{
			-1,
			0,
			1
		},
		7,
		"1、破阵且达到目标能量即为通关。\r\n2、挑战时，己阵精灵的变身次数会转化为能量，破阵成功即可获取能量。能量会依据关卡间的距离传导，且随距离增加而衰减。\r\n3、当所有关卡的能量总值达到对应加成区间，即可激活相应buff。\r\n4、每个关卡通关后封印本次变身次数最多的精灵，多个精灵变身次数相同则都封印。"
	},
	{
		508001,
		3,
		1003,
		{
			1,
			-1,
			0
		},
		7,
		"1、破阵且达到目标能量即为通关。\r\n2、挑战时，己阵精灵的变身次数会转化为能量，破阵成功即可获取能量。能量会依据关卡间的距离传导，且随距离增加而衰减。\r\n3、当所有关卡的能量总值达到对应加成区间，即可激活相应buff。\r\n4、每个关卡通关后封印本次变身次数最多的精灵，多个精灵变身次数相同则都封印。"
	},
	{
		508001,
		4,
		1004,
		{
			0,
			0,
			0
		},
		15,
		"1、破阵且达到目标能量即为通关。\r\n2、挑战时，己阵精灵的变身次数会转化为能量，破阵成功即可获取能量。能量会依据关卡间的距离传导，且随距离增加而衰减。\r\n3、当所有关卡的能量总值达到对应加成区间，即可激活相应buff。\r\n4、每个关卡通关后封印本次变身次数最多的精灵，多个精灵变身次数相同则都封印。"
	},
	{
		508001,
		5,
		1005,
		{
			-1,
			1,
			0
		},
		9,
		"1、破阵且达到目标能量即为通关。\r\n2、挑战时，己阵精灵的变身次数会转化为能量，破阵成功即可获取能量。能量会依据关卡间的距离传导，且随距离增加而衰减。\r\n3、当所有关卡的能量总值达到对应加成区间，即可激活相应buff。\r\n4、每个关卡通关后封印本次变身次数最多的精灵，多个精灵变身次数相同则都封印。"
	},
	{
		508001,
		6,
		1006,
		{
			1,
			0,
			-1
		},
		9,
		"1、破阵且达到目标能量即为通关。\r\n2、挑战时，己阵精灵的变身次数会转化为能量，破阵成功即可获取能量。能量会依据关卡间的距离传导，且随距离增加而衰减。\r\n3、当所有关卡的能量总值达到对应加成区间，即可激活相应buff。\r\n4、每个关卡通关后封印本次变身次数最多的精灵，多个精灵变身次数相同则都封印。"
	},
	{
		508001,
		7,
		1007,
		{
			0,
			1,
			-1
		},
		5,
		"1、破阵且达到目标能量即为通关。\r\n2、挑战时，己阵精灵的变身次数会转化为能量，破阵成功即可获取能量。能量会依据关卡间的距离传导，且随距离增加而衰减。\r\n3、当所有关卡的能量总值达到对应加成区间，即可激活相应buff。\r\n4、每个关卡通关后封印本次变身次数最多的精灵，多个精灵变身次数相同则都封印。"
	}
}
local t_divine_tun_tian_clg_extreme_stage = {
	[508001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_divine_tun_tian_clg_extreme_stage.dataList = dataList

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

return t_divine_tun_tian_clg_extreme_stage
