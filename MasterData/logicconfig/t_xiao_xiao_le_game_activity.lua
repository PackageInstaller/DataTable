-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_xiao_le_game_activity.lua

module("logicconfig.config.t_xiao_xiao_le_game_activity", package.seeall)

local title = {
	lineScore = 6,
	redPointId = 2,
	rankLimit = 4,
	planId = 7,
	dailyTimes = 3,
	blockTimes = 5,
	activityId = 1
}
local dataList = {
	{
		454001,
		677,
		3,
		100,
		15,
		10,
		1
	},
	{
		454002,
		677,
		3,
		100,
		15,
		10,
		1
	}
}
local t_xiao_xiao_le_game_activity = {
	[454001] = dataList[1],
	[454002] = dataList[2]
}

t_xiao_xiao_le_game_activity.dataList = dataList

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

return t_xiao_xiao_le_game_activity
