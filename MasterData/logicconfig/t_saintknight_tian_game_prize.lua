-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saintknight_tian_game_prize.lua

module("logicconfig.config.t_saintknight_tian_game_prize", package.seeall)

local title = {
	id = 2,
	needScore = 3,
	prize = 4,
	gamePrizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		25,
		"4:141:2"
	},
	{
		1,
		2,
		50,
		"4:90286:1"
	},
	{
		1,
		3,
		75,
		"4:141:2"
	},
	{
		1,
		4,
		100,
		"4:90286:1"
	},
	{
		1,
		5,
		125,
		"4:141:2"
	},
	{
		1,
		6,
		150,
		"4:90286:1"
	},
	{
		1,
		7,
		175,
		"4:141:2"
	},
	{
		1,
		8,
		200,
		"4:90286:1"
	},
	{
		1,
		9,
		225,
		"4:141:2"
	},
	{
		1,
		10,
		250,
		"4:90286:1"
	},
	{
		1,
		11,
		275,
		"4:141:2"
	},
	{
		1,
		12,
		300,
		"4:90286:1"
	},
	{
		1,
		13,
		325,
		"4:141:2"
	},
	{
		1,
		14,
		350,
		"4:90286:1"
	},
	{
		1,
		15,
		375,
		"4:141:2"
	},
	{
		1,
		16,
		400,
		"4:90286:1"
	},
	{
		1,
		17,
		425,
		"4:141:2"
	},
	{
		1,
		18,
		450,
		"4:90286:1"
	},
	{
		1,
		19,
		475,
		"4:141:3"
	},
	{
		1,
		20,
		500,
		"4:90287:1"
	},
	{
		1,
		21,
		525,
		"4:141:3"
	},
	{
		1,
		22,
		550,
		"4:90287:1"
	},
	{
		1,
		23,
		575,
		"4:141:3"
	},
	{
		1,
		24,
		600,
		"4:90287:1"
	},
	{
		1,
		25,
		625,
		"4:141:3"
	},
	{
		1,
		26,
		650,
		"4:90288:1"
	}
}
local t_saintknight_tian_game_prize = {
	{
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
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26]
	}
}

t_saintknight_tian_game_prize.dataList = dataList

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

return t_saintknight_tian_game_prize
