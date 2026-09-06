-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_linkendless_game_activity.lua

module("logicconfig.config.t_linkendless_game_activity", package.seeall)

local title = {
	redPointId = 7,
	ruleId = 2,
	jumpTo = 3,
	dailyTimes = 5,
	gameTime = 4,
	activityId = 1,
	scoreLimit = 6
}
local dataList = {
	{
		394001,
		1,
		"func#191#303#303001",
		60,
		3,
		99,
		730
	},
	{
		394002,
		1,
		"",
		60,
		3,
		99,
		730
	},
	{
		394003,
		1,
		"",
		60,
		3,
		99,
		730
	}
}
local t_linkendless_game_activity = {
	[394001] = dataList[1],
	[394002] = dataList[2],
	[394003] = dataList[3]
}

t_linkendless_game_activity.dataList = dataList

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

return t_linkendless_game_activity
