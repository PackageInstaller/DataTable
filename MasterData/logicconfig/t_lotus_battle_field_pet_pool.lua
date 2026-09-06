-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lotus_battle_field_pet_pool.lua

module("logicconfig.config.t_lotus_battle_field_pet_pool", package.seeall)

local title = {
	id = 2,
	creepIds = 3,
	petPoolId = 1
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
			6,
			7,
			8,
			9,
			10
		}
	},
	{
		1,
		2,
		{
			11,
			12,
			13,
			14,
			15,
			16,
			17,
			18,
			19,
			20
		}
	},
	{
		1,
		3,
		{
			21,
			6,
			23,
			24,
			25,
			13,
			10,
			28,
			29,
			30
		}
	},
	{
		1,
		4,
		{
			31,
			32,
			33,
			34,
			35,
			36,
			37,
			38,
			39,
			40
		}
	},
	{
		1,
		5,
		{
			41,
			42,
			43,
			44,
			45,
			46,
			47,
			39,
			37,
			13
		}
	},
	{
		2,
		1,
		{
			48,
			49,
			50,
			51,
			52,
			53,
			54,
			55,
			56,
			57
		}
	},
	{
		2,
		2,
		{
			58,
			59,
			60,
			61,
			62,
			63,
			64,
			65,
			66,
			67
		}
	},
	{
		2,
		3,
		{
			54,
			55,
			68,
			69,
			70,
			71,
			72,
			73,
			74,
			75
		}
	},
	{
		2,
		4,
		{
			63,
			75,
			67,
			53,
			59,
			76,
			77,
			78,
			79,
			80
		}
	},
	{
		2,
		5,
		{
			63,
			64,
			74,
			70,
			69,
			81,
			82,
			83,
			84,
			85
		}
	}
}
local t_lotus_battle_field_pet_pool = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_lotus_battle_field_pet_pool.dataList = dataList

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

return t_lotus_battle_field_pet_pool
