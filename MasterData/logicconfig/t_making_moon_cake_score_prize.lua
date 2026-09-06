-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_making_moon_cake_score_prize.lua

module("logicconfig.config.t_making_moon_cake_score_prize", package.seeall)

local title = {
	id = 2,
	scorePrizePlanId = 1,
	prize = 4,
	score = 3
}
local dataList = {
	{
		1,
		1,
		10,
		"4:10:120"
	},
	{
		1,
		2,
		20,
		"4:10:120"
	},
	{
		1,
		3,
		30,
		"4:10:120"
	},
	{
		1,
		4,
		40,
		"4:10:120"
	},
	{
		1,
		5,
		50,
		"4:10:120"
	},
	{
		1,
		6,
		60,
		"4:10:120"
	},
	{
		1,
		7,
		70,
		"4:10:120"
	},
	{
		1,
		8,
		80,
		"4:10:120"
	},
	{
		1,
		9,
		90,
		"4:10:120"
	},
	{
		1,
		10,
		100,
		"4:10:120"
	},
	{
		1,
		11,
		110,
		"4:10:120"
	},
	{
		1,
		12,
		120,
		"4:10:120"
	},
	{
		1,
		13,
		130,
		"4:10:120"
	},
	{
		1,
		14,
		140,
		"4:10:120"
	},
	{
		1,
		15,
		150,
		"4:10:120"
	}
}
local t_making_moon_cake_score_prize = {
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
		dataList[15]
	}
}

t_making_moon_cake_score_prize.dataList = dataList

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

return t_making_moon_cake_score_prize
