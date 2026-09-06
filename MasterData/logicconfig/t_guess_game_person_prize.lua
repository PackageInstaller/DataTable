-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guess_game_person_prize.lua

module("logicconfig.config.t_guess_game_person_prize", package.seeall)

local title = {
	id = 2,
	personPrizePlanId = 1,
	prize = 4,
	progress = 3
}
local dataList = {
	{
		1,
		1,
		30,
		"8:1:125000"
	},
	{
		1,
		2,
		60,
		"8:1:125000"
	},
	{
		1,
		3,
		120,
		"4:90165:1"
	},
	{
		1,
		4,
		180,
		"8:1:125000"
	},
	{
		1,
		5,
		240,
		"8:1:125000"
	},
	{
		1,
		6,
		300,
		"8:1:125000"
	},
	{
		1,
		7,
		375,
		"8:1:125000"
	},
	{
		1,
		8,
		450,
		"4:90165:1"
	},
	{
		1,
		9,
		525,
		"8:1:125000"
	},
	{
		1,
		10,
		600,
		"8:1:125000"
	},
	{
		1,
		11,
		675,
		"8:1:125000"
	},
	{
		1,
		12,
		750,
		"4:90165:1"
	},
	{
		1,
		13,
		825,
		"8:1:125000"
	},
	{
		1,
		14,
		900,
		"8:1:125000"
	},
	{
		1,
		15,
		975,
		"8:1:125000"
	},
	{
		1,
		16,
		1050,
		"4:90165:1"
	},
	{
		2,
		1,
		50,
		"4:90311:3"
	},
	{
		2,
		2,
		100,
		"4:90311:3"
	},
	{
		2,
		3,
		150,
		"4:90311:5"
	},
	{
		2,
		4,
		200,
		"4:90311:3"
	},
	{
		2,
		5,
		250,
		"4:90311:3"
	},
	{
		2,
		6,
		300,
		"4:90311:5"
	},
	{
		2,
		7,
		350,
		"4:90311:3"
	},
	{
		2,
		8,
		400,
		"4:90311:3"
	},
	{
		2,
		9,
		450,
		"4:90311:3"
	},
	{
		2,
		10,
		500,
		"4:90311:5"
	}
}
local t_guess_game_person_prize = {
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
		dataList[16]
	},
	{
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

t_guess_game_person_prize.dataList = dataList

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

return t_guess_game_person_prize
