-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_dark_dragon_activity.lua

module("logicconfig.config.t_god_dark_dragon_activity", package.seeall)

local title = {
	storyId = 5,
	redPointId = 2,
	jumpTo = 3,
	raceId = 4,
	activityId = 1
}
local dataList = {
	{
		331001,
		546,
		{
			"func#1011",
			"mibao#huimiexinsheng1",
			"func#618#15020"
		},
		15020,
		4580019
	}
}
local t_god_dark_dragon_activity = {
	[331001] = dataList[1]
}

t_god_dark_dragon_activity.dataList = dataList

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

return t_god_dark_dragon_activity
