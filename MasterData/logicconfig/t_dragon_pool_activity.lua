-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_pool_activity.lua

module("logicconfig.config.t_dragon_pool_activity", package.seeall)

local title = {
	touchCd = 9,
	weedIncMood = 8,
	touchPrize = 11,
	dailyChatTimes = 3,
	weedPrize = 12,
	dailyTouchTimes = 2,
	chatPrize = 13,
	isFullGrass = 5,
	redPointId = 4,
	touchIncMood = 6,
	chatCd = 10,
	actId = 1,
	chatIncMood = 7
}
local dataList = {
	{
		300001,
		3,
		3,
		507,
		true,
		20,
		20,
		10,
		10,
		10,
		"",
		"",
		""
	}
}
local t_dragon_pool_activity = {
	[300001] = dataList[1]
}

t_dragon_pool_activity.dataList = dataList

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

return t_dragon_pool_activity
