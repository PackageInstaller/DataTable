-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_game_2048_activity.lua

module("logicconfig.config.t_game_2048_activity", package.seeall)

local title = {
	rankMaxScore = 3,
	bubbleItemOfNor = 6,
	redPointId = 2,
	jumpStrOne = 4,
	extremeEnergy = 7,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		320001,
		530,
		800000,
		"ui#numberpuzzlegamerankview",
		"game2048_rule",
		"",
		0
	},
	{
		320002,
		530,
		800000,
		"ui#numberpuzzlegamerankview",
		"game2048_rule",
		"10:251004:200",
		0
	},
	{
		320003,
		530,
		800000,
		"ui#numberpuzzlegamerankview",
		"game2048_rule",
		"",
		0
	},
	{
		320004,
		530,
		0,
		"ui#numberpuzzlegamerankview",
		"newgame2048_rule",
		"",
		300
	},
	{
		320005,
		530,
		0,
		"ui#numberpuzzlegamerankview",
		"newgame2048_rule",
		"",
		300
	}
}
local t_game_2048_activity = {
	[320001] = dataList[1],
	[320002] = dataList[2],
	[320003] = dataList[3],
	[320004] = dataList[4],
	[320005] = dataList[5]
}

t_game_2048_activity.dataList = dataList

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

return t_game_2048_activity
