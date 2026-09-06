-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_louna_challenge_prize.lua

module("logicconfig.config.t_louna_challenge_prize", package.seeall)

local title = {
	prizeId = 2,
	score = 3,
	prize = 4,
	prizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		100,
		"8:1:50000"
	},
	{
		1,
		2,
		200,
		"8:1:50000"
	},
	{
		1,
		3,
		400,
		"8:1:50000"
	},
	{
		1,
		4,
		800,
		"8:1:50000"
	},
	{
		1,
		5,
		1200,
		"8:1:50000"
	},
	{
		1,
		6,
		1400,
		"8:1:50000"
	},
	{
		1,
		7,
		1600,
		"8:1:50000"
	},
	{
		1,
		8,
		1800,
		"8:1:50000"
	},
	{
		1,
		9,
		2200,
		"8:1:50000"
	},
	{
		1,
		10,
		2400,
		"8:1:50000"
	},
	{
		1,
		11,
		2600,
		"8:1:50000"
	},
	{
		1,
		12,
		2800,
		"8:1:50000"
	},
	{
		1,
		13,
		3000,
		"8:1:50000"
	},
	{
		1,
		14,
		3200,
		"8:1:50000"
	},
	{
		1,
		15,
		3400,
		"8:1:50000"
	},
	{
		1,
		16,
		3600,
		"8:1:50000"
	},
	{
		1,
		17,
		4000,
		"8:1:50000"
	},
	{
		1,
		18,
		4400,
		"8:1:50000"
	},
	{
		1,
		19,
		4800,
		"8:1:50000"
	},
	{
		1,
		20,
		5200,
		"100:13004:1:1"
	},
	{
		1,
		21,
		5800,
		"8:1:50000"
	},
	{
		1,
		22,
		6400,
		"8:1:50000"
	},
	{
		1,
		23,
		7000,
		"8:1:50000"
	},
	{
		1,
		24,
		7600,
		"4:80342:1"
	},
	{
		1,
		25,
		8200,
		"8:1:50000"
	},
	{
		1,
		26,
		8800,
		"8:1:50000"
	},
	{
		1,
		27,
		9400,
		"8:1:50000"
	},
	{
		1,
		28,
		10000,
		"8:1:50000"
	},
	{
		1,
		29,
		10600,
		"4:80342:1"
	}
}
local t_louna_challenge_prize = {
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
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29]
	}
}

t_louna_challenge_prize.dataList = dataList

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

return t_louna_challenge_prize
