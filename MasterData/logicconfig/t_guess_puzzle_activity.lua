-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guess_puzzle_activity.lua

module("logicconfig.config.t_guess_puzzle_activity", package.seeall)

local title = {
	dailyTimes = 2,
	redPointId = 3,
	activityId = 1
}
local dataList = {
	{
		431001,
		40,
		656
	}
}
local t_guess_puzzle_activity = {
	[431001] = dataList[1]
}

t_guess_puzzle_activity.dataList = dataList

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

return t_guess_puzzle_activity
