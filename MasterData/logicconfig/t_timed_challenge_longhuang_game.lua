-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_longhuang_game.lua

module("logicconfig.config.t_timed_challenge_longhuang_game", package.seeall)

local title = {
	velocityRatio = 5,
	time = 2,
	id = 1,
	numberWeights = 3,
	directionWeights = 4
}
local dataList = {
	{
		1,
		1,
		"3,50#4,50",
		"1,100",
		1
	},
	{
		2,
		2,
		"3,50#4,50",
		"1,100",
		1
	},
	{
		3,
		3,
		"3,50#4,50",
		"1,100",
		1.1
	},
	{
		4,
		4,
		"3,50#4,50",
		"1,100",
		1.1
	},
	{
		5,
		5,
		"4,50#5,50",
		"1,100",
		1.1
	},
	{
		6,
		6,
		"4,50#5,50",
		"1,100",
		1.1
	},
	{
		7,
		7,
		"4,50#5,50",
		"1,50#2,50",
		1.2
	},
	{
		8,
		8,
		"4,50#5,50",
		"1,50#2,50",
		1.2
	},
	{
		9,
		9,
		"5,50#6,50",
		"1,50#2,50",
		1.2
	},
	{
		10,
		10,
		"5,50#6,50",
		"1,50#2,50",
		1.2
	},
	{
		11,
		11,
		"5,30#6,30#7,40",
		"1,50#2,50",
		1.3
	},
	{
		12,
		12,
		"5,20#6,30#7,50",
		"1,50#2,50",
		1.3
	},
	{
		13,
		13,
		"6,50#7,50",
		"1,50#2,50",
		1.3
	},
	{
		14,
		14,
		"6,50#7,30#8,20",
		"1,50#2,50",
		1.3
	},
	{
		15,
		15,
		"6,30#7,30#8,40",
		"1,50#2,50",
		1.4
	},
	{
		16,
		16,
		"6,20#7,30#8,50",
		"1,50#2,50",
		1.4
	},
	{
		17,
		17,
		"7,50#8,50",
		"1,50#2,50",
		1.4
	},
	{
		18,
		18,
		"7,50#8,30#9,20",
		"1,50#2,50",
		1.5
	},
	{
		19,
		19,
		"7,30#8,30#9,40",
		"1,50#2,50",
		1.5
	},
	{
		20,
		20,
		"7,20#8,30#9,50",
		"1,50#2,50",
		1.5
	}
}
local t_timed_challenge_longhuang_game = {
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
	dataList[20]
}

t_timed_challenge_longhuang_game.dataList = dataList

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

return t_timed_challenge_longhuang_game
