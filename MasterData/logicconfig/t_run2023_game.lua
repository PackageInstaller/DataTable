-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_run2023_game.lua

module("logicconfig.config.t_run2023_game", package.seeall)

local title = {
	wiesWordPlanId = 9,
	prizePlanId = 2,
	rulesKey = 7,
	maxTime = 6,
	times = 4,
	gameName = 3,
	endTime = 5,
	activityId = 1,
	statePlanId = 8
}
local dataList = {
	{
		1,
		1,
		"奔向2023",
		3,
		30,
		60,
		"firerule",
		1,
		1
	}
}
local t_run2023_game = {
	dataList[1]
}

t_run2023_game.dataList = dataList

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

return t_run2023_game
