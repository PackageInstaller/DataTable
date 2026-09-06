-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_maze_game_activity.lua

module("logicconfig.config.t_maze_game_activity", package.seeall)

local title = {
	redPointId = 3,
	gameRuleDesc = 5,
	titanProgressActivityId = 4,
	ruleKey = 6,
	activityId = 1,
	dailyPassStageLimit = 2
}
local dataList = {
	{
		523001,
		1,
		732,
		525001,
		"通过操控金色小点行走，找到不同元素泰坦（地图上的其他小点）所在的位置，并收集，所有元素泰坦均收集完成即可通关",
		"maze_game_rule"
	}
}
local t_maze_game_activity = {
	[523001] = dataList[1]
}

t_maze_game_activity.dataList = dataList

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

return t_maze_game_activity
