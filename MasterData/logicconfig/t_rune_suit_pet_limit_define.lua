-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rune_suit_pet_limit_define.lua

module("logicconfig.config.t_rune_suit_pet_limit_define", package.seeall)

local title = {
	suitId = 1,
	petLimit = 3,
	needLevel = 2
}
local dataList = {
	{
		1,
		0,
		1
	},
	{
		1,
		60,
		2
	},
	{
		1,
		75,
		3
	},
	{
		2,
		0,
		1
	},
	{
		2,
		60,
		2
	},
	{
		2,
		75,
		3
	},
	{
		3,
		0,
		1
	},
	{
		3,
		60,
		2
	},
	{
		3,
		75,
		3
	},
	{
		4,
		0,
		1
	},
	{
		4,
		60,
		2
	},
	{
		4,
		75,
		3
	},
	{
		5,
		0,
		1
	},
	{
		5,
		60,
		2
	},
	{
		5,
		75,
		3
	},
	{
		6,
		0,
		1
	},
	{
		6,
		84,
		2
	},
	{
		6,
		105,
		3
	},
	{
		7,
		0,
		1
	},
	{
		7,
		84,
		2
	},
	{
		7,
		105,
		3
	},
	{
		8,
		0,
		1
	},
	{
		8,
		84,
		2
	},
	{
		8,
		105,
		3
	},
	{
		9,
		0,
		1
	},
	{
		9,
		84,
		2
	},
	{
		9,
		105,
		3
	},
	{
		10,
		0,
		1
	},
	{
		10,
		84,
		2
	},
	{
		10,
		105,
		3
	},
	{
		11,
		0,
		1
	},
	{
		11,
		108,
		2
	},
	{
		11,
		135,
		3
	},
	{
		12,
		0,
		1
	},
	{
		12,
		108,
		2
	},
	{
		12,
		135,
		3
	},
	{
		13,
		0,
		1
	},
	{
		13,
		108,
		2
	},
	{
		13,
		135,
		3
	},
	{
		14,
		0,
		1
	},
	{
		14,
		108,
		2
	},
	{
		14,
		135,
		3
	},
	{
		15,
		0,
		1
	},
	{
		15,
		108,
		2
	},
	{
		15,
		135,
		3
	}
}
local t_rune_suit_pet_limit_define = {
	{
		[0] = dataList[1],
		[60] = dataList[2],
		[75] = dataList[3]
	},
	{
		[0] = dataList[4],
		[60] = dataList[5],
		[75] = dataList[6]
	},
	{
		[0] = dataList[7],
		[60] = dataList[8],
		[75] = dataList[9]
	},
	{
		[0] = dataList[10],
		[60] = dataList[11],
		[75] = dataList[12]
	},
	{
		[0] = dataList[13],
		[60] = dataList[14],
		[75] = dataList[15]
	},
	{
		[0] = dataList[16],
		[84] = dataList[17],
		[105] = dataList[18]
	},
	{
		[0] = dataList[19],
		[84] = dataList[20],
		[105] = dataList[21]
	},
	{
		[0] = dataList[22],
		[84] = dataList[23],
		[105] = dataList[24]
	},
	{
		[0] = dataList[25],
		[84] = dataList[26],
		[105] = dataList[27]
	},
	{
		[0] = dataList[28],
		[84] = dataList[29],
		[105] = dataList[30]
	},
	{
		[0] = dataList[31],
		[108] = dataList[32],
		[135] = dataList[33]
	},
	{
		[0] = dataList[34],
		[108] = dataList[35],
		[135] = dataList[36]
	},
	{
		[0] = dataList[37],
		[108] = dataList[38],
		[135] = dataList[39]
	},
	{
		[0] = dataList[40],
		[108] = dataList[41],
		[135] = dataList[42]
	},
	{
		[0] = dataList[43],
		[108] = dataList[44],
		[135] = dataList[45]
	}
}

t_rune_suit_pet_limit_define.dataList = dataList

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

return t_rune_suit_pet_limit_define
