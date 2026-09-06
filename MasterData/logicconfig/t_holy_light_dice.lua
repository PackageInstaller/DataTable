-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_light_dice.lua

module("logicconfig.config.t_holy_light_dice", package.seeall)

local title = {
	desc = 5,
	randList = 3,
	diceId = 2,
	dicePlanId = 1,
	name = 6,
	unlock = 4
}
local dataList = {
	{
		1,
		1,
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		0,
		"无",
		"普通骰子"
	},
	{
		1,
		2,
		{
			3,
			3,
			3,
			4,
			4,
			4
		},
		4,
		"击杀4次灵界恶灵后解锁",
		"圣光骰子"
	},
	{
		1,
		3,
		{
			1,
			1,
			1,
			1,
			8,
			9
		},
		16,
		"击杀16次灵界恶灵后解锁",
		"命运骰子"
	},
	{
		2,
		1,
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		0,
		"无",
		"普通骰子"
	},
	{
		2,
		2,
		{
			3,
			3,
			3,
			4,
			4,
			4
		},
		4,
		"击杀4次捣乱恶灵后解锁",
		"机敏骰子"
	},
	{
		2,
		3,
		{
			1,
			1,
			1,
			1,
			8,
			9
		},
		16,
		"击杀16次捣乱恶灵后解锁",
		"命运骰子"
	},
	{
		3,
		1,
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		0,
		"无",
		"普通骰子"
	},
	{
		3,
		2,
		{
			3,
			3,
			3,
			4,
			4,
			4
		},
		4,
		"击杀4次捣乱恶灵后解锁",
		"机敏骰子"
	},
	{
		3,
		3,
		{
			1,
			1,
			1,
			1,
			8,
			9
		},
		16,
		"击杀16次捣乱恶灵后解锁",
		"命运骰子"
	},
	{
		4,
		1,
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		0,
		"无",
		"普通骰子"
	},
	{
		4,
		2,
		{
			3,
			3,
			3,
			4,
			4,
			4
		},
		4,
		"击杀4次捣乱恶灵后解锁",
		"机敏骰子"
	},
	{
		4,
		3,
		{
			1,
			1,
			1,
			1,
			8,
			9
		},
		16,
		"击杀16次捣乱恶灵后解锁",
		"命运骰子"
	}
}
local t_holy_light_dice = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_holy_light_dice.dataList = dataList

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

return t_holy_light_dice
