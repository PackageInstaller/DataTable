-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fight_against_landlords_card.lua

module("logicconfig.config.t_fight_against_landlords_card", package.seeall)

local title = {
	cardId = 1,
	creepIds = 2
}
local dataList = {
	{
		1,
		{
			1,
			2,
			3,
			4,
			5,
			6
		}
	},
	{
		2,
		{
			7,
			8,
			9,
			10,
			11,
			12
		}
	},
	{
		3,
		{
			13,
			14,
			15,
			16,
			17,
			18
		}
	},
	{
		4,
		{
			19,
			20,
			21,
			22,
			23,
			24
		}
	},
	{
		5,
		{
			25,
			26,
			27,
			28,
			29,
			30
		}
	},
	{
		6,
		{
			31,
			32,
			33,
			34,
			35,
			36
		}
	},
	{
		7,
		{
			37,
			38,
			39,
			40,
			41,
			42
		}
	},
	{
		8,
		{
			43,
			44,
			45,
			46,
			47,
			48
		}
	},
	{
		9,
		{
			49,
			50,
			51,
			52,
			53,
			54
		}
	},
	{
		10,
		{
			55,
			56,
			57,
			58,
			59,
			60
		}
	},
	{
		11,
		{
			61,
			62,
			63,
			64,
			65,
			66
		}
	},
	{
		12,
		{
			67,
			68,
			69,
			70,
			71,
			72
		}
	},
	{
		13,
		{
			73,
			74,
			75,
			76,
			77,
			78
		}
	},
	{
		14,
		{
			79,
			80,
			81,
			82,
			83,
			84
		}
	},
	{
		15,
		{
			85,
			86,
			87,
			88,
			89,
			90
		}
	}
}
local t_fight_against_landlords_card = {
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

t_fight_against_landlords_card.dataList = dataList

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

return t_fight_against_landlords_card
