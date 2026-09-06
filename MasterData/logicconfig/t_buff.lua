-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_buff.lua

module("logicconfig.config.t_buff", package.seeall)

local title = {
	uiEffectId = 13,
	maxOverlays = 6,
	decreaseOccasion = 9,
	excludeBuff = 8,
	value = 5,
	addEffectId = 10,
	sustainEffectId = 11,
	removeEffectId = 12,
	triggerType = 4,
	type = 3,
	id = 1,
	classType = 2,
	mutexBuff = 7
}
local dataList = {
	{
		1,
		"clear_buff",
		2,
		1,
		{
			clearBuffType = 1
		},
		1,
		0,
		0,
		2,
		0,
		0,
		0,
		0
	},
	{
		2,
		"charm",
		2,
		1,
		{
			targetType = 1
		},
		1,
		0,
		0,
		1,
		0,
		2,
		0,
		0
	},
	{
		3,
		"rebound",
		0,
		2,
		{
			criticDmgReboundRate = 1.2,
			dmgReboundRate = 0.3
		},
		2,
		0,
		0,
		1,
		0,
		3,
		0,
		0
	},
	{
		4,
		"burn",
		2,
		3,
		{
			extraDmg = 1200
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		5,
		"burn",
		2,
		3,
		{
			extraDmg = 2000
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		6,
		"shield",
		1,
		2,
		{
			reboundDmg = 800
		},
		1,
		0,
		0,
		1,
		0,
		6,
		0,
		0
	},
	{
		7,
		"shield",
		1,
		2,
		{
			reboundDmg = 1000
		},
		1,
		0,
		0,
		1,
		0,
		6,
		0,
		0
	},
	{
		8,
		"attr_add",
		1,
		1,
		{
			criticRateAdd = 0.4,
			dodgeRateAdd = 0.4
		},
		3,
		0,
		0,
		1,
		0,
		8,
		0,
		0
	},
	{
		9,
		"attr_add",
		1,
		1,
		{
			dodgeRateAdd = 0.15,
			phyAtkRateAdd = 0.1
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		10,
		"attr_add",
		1,
		1,
		{
			magAtkRateAdd = 0.15
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		11,
		"attr_add",
		1,
		1,
		{
			magAtkRateAdd = 0.15,
			accurateRateAdd = 0.15
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		12,
		"attr_add",
		1,
		1,
		{
			ultAtkRateAdd = 0.2,
			magAtkRateAdd = 0.2,
			accurateRateAdd = 0.2
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		13,
		"attr_add",
		1,
		1,
		{
			magAtkRateAdd = 0.15
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		14,
		"attr_add",
		1,
		1,
		{
			phyAtkRateAdd = 0.15
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		15,
		"attr_add",
		1,
		1,
		{
			ultAtkRateAdd = 0.15
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		16,
		"attr_add",
		1,
		1,
		{
			phyDefRateAdd = 0.15
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		17,
		"attr_add",
		1,
		1,
		{
			magDefRateAdd = 0.15
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		18,
		"attr_add",
		1,
		1,
		{
			ultDefRateAdd = 0.15
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		19,
		"hp_absorb",
		1,
		3,
		{
			absorbRate = 0.15
		},
		1,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		20,
		"attr_add",
		1,
		1,
		{
			magAtkRateAdd = 0.15,
			accurateRateAdd = 0.15
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		21,
		"attr_add",
		1,
		1,
		{
			ultAtkRateAdd = 0.2,
			magAtkRateAdd = 0.2,
			accurateRateAdd = 0.99
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		22,
		"attr_add",
		1,
		1,
		{
			phyDefRateAdd = 0.15,
			magDefRateAdd = 0.15,
			magAtkRateAdd = 0.15,
			ultDefRateAdd = 0.15,
			ultAtkRateAdd = 0.15,
			phyAtkRateAdd = 0.15
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	},
	{
		23,
		"attr_add",
		1,
		1,
		{
			phyDefRateAdd = 0.25,
			magDefRateAdd = 0.25,
			magAtkRateAdd = 0.25,
			ultDefRateAdd = 0.25,
			ultAtkRateAdd = 0.25,
			phyAtkRateAdd = 0.25
		},
		3,
		0,
		0,
		1,
		0,
		0,
		0,
		0
	}
}
local t_buff = {
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
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21],
	dataList[22],
	dataList[23]
}

t_buff.dataList = dataList

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

return t_buff
