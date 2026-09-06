-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sun_wu_kong_challenge_prize.lua

module("logicconfig.config.t_sun_wu_kong_challenge_prize", package.seeall)

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
		1,
		"8:1:100000#4:190:20"
	},
	{
		2,
		1,
		0,
		"8:1:100000#4:190:20"
	},
	{
		3,
		1,
		0,
		"4:90316:1#4:190:20"
	},
	{
		4,
		1,
		1,
		"8:1:100000#4:190:30"
	},
	{
		4,
		2,
		30,
		"8:1:130000#4:190:30"
	},
	{
		4,
		3,
		50,
		"8:1:160000#4:190:30"
	},
	{
		4,
		4,
		70,
		"8:1:180000#4:190:30"
	},
	{
		4,
		5,
		90,
		"8:1:200000#4:190:30"
	},
	{
		5,
		1,
		0,
		"8:1:100000#4:190:30"
	},
	{
		6,
		1,
		1,
		"4:292:2"
	},
	{
		7,
		1,
		0,
		"4:292:2"
	},
	{
		8,
		1,
		0,
		"4:292:2"
	},
	{
		9,
		1,
		1,
		"4:292:3"
	},
	{
		9,
		2,
		30,
		"4:292:3"
	},
	{
		9,
		3,
		50,
		"4:292:3"
	},
	{
		9,
		4,
		70,
		"4:292:3"
	},
	{
		9,
		5,
		90,
		"4:292:3"
	},
	{
		10,
		1,
		0,
		"4:292:3"
	}
}
local t_sun_wu_kong_challenge_prize = {
	{
		dataList[1]
	},
	{
		dataList[2]
	},
	{
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9]
	},
	{
		dataList[10]
	},
	{
		dataList[11]
	},
	{
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17]
	},
	{
		dataList[18]
	}
}

t_sun_wu_kong_challenge_prize.dataList = dataList

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

return t_sun_wu_kong_challenge_prize
