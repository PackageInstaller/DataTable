-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_disorder_power_progress_prize.lua

module("logicconfig.config.t_disorder_power_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		422001,
		1,
		1,
		"8:1:1000000"
	},
	{
		422001,
		2,
		2,
		"4:510022:5"
	},
	{
		422001,
		3,
		3,
		"4:30006:100"
	},
	{
		422001,
		4,
		4,
		"4:111:10"
	},
	{
		422001,
		5,
		5,
		"4:11002:30000"
	},
	{
		422001,
		6,
		6,
		"4:90037:1"
	},
	{
		422001,
		7,
		8,
		"4:12102:10"
	},
	{
		422001,
		8,
		10,
		"4:7008:100"
	}
}
local t_disorder_power_progress_prize = {
	[422001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_disorder_power_progress_prize.dataList = dataList

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

return t_disorder_power_progress_prize
