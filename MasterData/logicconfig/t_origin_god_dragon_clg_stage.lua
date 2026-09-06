-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_god_dragon_clg_stage.lua

module("logicconfig.config.t_origin_god_dragon_clg_stage", package.seeall)

local title = {
	stageId = 2,
	buffCost = 7,
	zoneId = 3,
	buff = 8,
	skinId = 5,
	buffDesc = 12,
	prize = 10,
	buffScore = 9,
	parallelStage = 6,
	buffName = 11,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		545001,
		1,
		1,
		1001,
		12024,
		false,
		15,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20069112:99"
				}
			}
		},
		0,
		"",
		"1-1",
		"己阵精灵攻击生命值低于50%的目标时，伤害增加40%"
	},
	{
		545001,
		2,
		1,
		1002,
		16031,
		false,
		15,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20069114:99"
				}
			}
		},
		0,
		"",
		"1-2",
		"己阵精灵攻击生命值高于50%的目标时，伤害增加40%"
	},
	{
		545001,
		3,
		1,
		1003,
		11029,
		false,
		15,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20069115:99"
				}
			}
		},
		0,
		"",
		"1-3",
		"己阵精灵攻击目标时伤害增加20%"
	},
	{
		545001,
		4,
		1,
		2001,
		12038,
		true,
		0,
		nil,
		10,
		"4:510645:10",
		"",
		""
	},
	{
		545001,
		5,
		1,
		2002,
		11030,
		true,
		0,
		nil,
		10,
		"4:510645:10",
		"",
		""
	},
	{
		545001,
		6,
		2,
		1004,
		14026,
		false,
		15,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20069116:99"
				}
			}
		},
		0,
		"4:510646:5",
		"2-1",
		"令己阵战力最高的精灵首次死亡时复活且恢复50%血量"
	},
	{
		545001,
		7,
		2,
		1005,
		12028,
		false,
		15,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20069119:99"
				}
			}
		},
		0,
		"4:510646:5",
		"2-2",
		"令己阵攻击力最高的精灵首次死亡时复活且恢复50%血量"
	},
	{
		545001,
		8,
		2,
		1006,
		16035,
		false,
		15,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20069120:99"
				}
			}
		},
		0,
		"4:510646:5",
		"2-3",
		"令己阵精灵首次死亡时保留生命值1%的血量复活，移除自身所有负面效果且免疫一次攻击"
	},
	{
		545001,
		9,
		2,
		2003,
		12033,
		true,
		0,
		nil,
		10,
		"4:510645:15",
		"",
		""
	},
	{
		545001,
		10,
		2,
		2004,
		14032,
		true,
		0,
		nil,
		10,
		"4:510645:15",
		"",
		""
	},
	{
		545001,
		11,
		3,
		1007,
		13023,
		false,
		15,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20069124:99"
				}
			}
		},
		0,
		"4:510646:5",
		"3-1",
		"令己阵攻击力最高的精灵攻击时无视目标防御"
	},
	{
		545001,
		12,
		3,
		1008,
		11030,
		false,
		15,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20069126:99"
				}
			}
		},
		0,
		"4:510646:5",
		"3-2",
		"令己阵精灵攻击时无视目标25%防御"
	},
	{
		545001,
		13,
		3,
		1009,
		15037,
		false,
		15,
		{
			{
				clazz = "Common",
				target = "myself",
				params = {
					buffs = "20069127:99"
				}
			}
		},
		0,
		"4:510646:5",
		"3-3",
		"令己阵战力前三的精灵攻击时无视目标45%防御"
	},
	{
		545001,
		14,
		3,
		2005,
		16041,
		true,
		0,
		nil,
		10,
		"4:510645:25",
		"",
		""
	},
	{
		545001,
		15,
		3,
		2006,
		14039,
		true,
		0,
		nil,
		10,
		"4:510645:25",
		"",
		""
	}
}
local t_origin_god_dragon_clg_stage = {
	[545001] = {
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
	}
}

t_origin_god_dragon_clg_stage.dataList = dataList

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

return t_origin_god_dragon_clg_stage
