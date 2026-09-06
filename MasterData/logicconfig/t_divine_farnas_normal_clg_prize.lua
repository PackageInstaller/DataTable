-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_farnas_normal_clg_prize.lua

module("logicconfig.config.t_divine_farnas_normal_clg_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	dodgeTimes = 3
}
local dataList = {
	{
		522001,
		1,
		5,
		"8:1:1000000"
	},
	{
		522001,
		2,
		10,
		"4:427:5"
	},
	{
		522001,
		3,
		15,
		"4:90004:1"
	},
	{
		522001,
		4,
		20,
		"4:427:5"
	},
	{
		522001,
		5,
		25,
		"4:30006:40"
	},
	{
		522001,
		6,
		30,
		"4:427:10"
	}
}
local t_divine_farnas_normal_clg_prize = {
	[522001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_farnas_normal_clg_prize.dataList = dataList

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

return t_divine_farnas_normal_clg_prize
