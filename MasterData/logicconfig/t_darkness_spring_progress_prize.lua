-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_darkness_spring_progress_prize.lua

module("logicconfig.config.t_darkness_spring_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	progress = 3,
	activityId = 1,
	characterPath = 5
}
local dataList = {
	{
		430001,
		1,
		5,
		"8:1:500000",
		"bg_anshizhiquan_07"
	},
	{
		430001,
		2,
		10,
		"4:30006:20",
		"bg_anshizhiquan_07_01"
	},
	{
		430001,
		3,
		15,
		"4:112:5",
		"bg_anshizhiquan_07_02"
	},
	{
		430001,
		4,
		20,
		"4:90316:1",
		"bg_anshizhiquan_07_03"
	},
	{
		430001,
		5,
		25,
		"4:510394:1",
		"bg_anshizhiquan_07_04"
	},
	{
		430001,
		6,
		30,
		"4:30006:40",
		"bg_anshizhiquan_07_06"
	}
}
local t_darkness_spring_progress_prize = {
	[430001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_darkness_spring_progress_prize.dataList = dataList

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

return t_darkness_spring_progress_prize
