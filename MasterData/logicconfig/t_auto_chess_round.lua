-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_auto_chess_round.lua

module("logicconfig.config.t_auto_chess_round", package.seeall)

local title = {
	nextBuffPhase = 5,
	formationNum = 3,
	roundId = 1,
	phaseTimeSec = 4,
	scienceLevel = 6,
	addMoney = 2,
	decHp = 7
}
local dataList = {
	{
		1,
		1,
		1,
		15,
		false,
		1,
		3
	},
	{
		2,
		2,
		2,
		15,
		false,
		1,
		3
	},
	{
		3,
		3,
		4,
		30,
		false,
		1,
		3
	},
	{
		4,
		4,
		6,
		30,
		false,
		2,
		6
	},
	{
		5,
		5,
		6,
		30,
		false,
		2,
		6
	},
	{
		6,
		6,
		6,
		30,
		true,
		2,
		6
	},
	{
		7,
		7,
		6,
		45,
		false,
		3,
		9
	},
	{
		8,
		8,
		6,
		45,
		false,
		3,
		9
	},
	{
		9,
		9,
		6,
		45,
		false,
		3,
		9
	},
	{
		10,
		10,
		6,
		60,
		false,
		4,
		12
	},
	{
		11,
		10,
		6,
		60,
		false,
		4,
		12
	},
	{
		12,
		10,
		6,
		60,
		true,
		4,
		12
	},
	{
		13,
		10,
		6,
		60,
		false,
		5,
		15
	},
	{
		14,
		10,
		6,
		60,
		false,
		5,
		15
	},
	{
		15,
		10,
		6,
		60,
		true,
		5,
		15
	},
	{
		16,
		10,
		6,
		60,
		false,
		6,
		20
	},
	{
		17,
		10,
		6,
		60,
		false,
		6,
		30
	},
	{
		18,
		10,
		6,
		60,
		false,
		6,
		40
	},
	{
		19,
		10,
		6,
		60,
		false,
		6,
		50
	},
	{
		20,
		10,
		6,
		60,
		false,
		6,
		70
	}
}
local t_auto_chess_round = {
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

t_auto_chess_round.dataList = dataList

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

return t_auto_chess_round
