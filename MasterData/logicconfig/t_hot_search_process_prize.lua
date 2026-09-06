-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hot_search_process_prize.lua

module("logicconfig.config.t_hot_search_process_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	needProgress = 3
}
local dataList = {
	{
		443001,
		1,
		"5000000",
		"8:1:500000"
	},
	{
		443001,
		2,
		"10000000",
		"4:31:5"
	},
	{
		443001,
		3,
		"30000000",
		"8:1:500000"
	},
	{
		443001,
		4,
		"50000000",
		"4:31:5"
	},
	{
		443001,
		5,
		"100000000",
		"4:510446:1"
	}
}
local t_hot_search_process_prize = {
	[443001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_hot_search_process_prize.dataList = dataList

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

return t_hot_search_process_prize
