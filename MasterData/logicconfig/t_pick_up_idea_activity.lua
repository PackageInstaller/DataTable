-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pick_up_idea_activity.lua

module("logicconfig.config.t_pick_up_idea_activity", package.seeall)

local title = {
	standTime = 12,
	size = 6,
	passScore = 3,
	timeSpider = 5,
	endStoryId = 9,
	protectTime = 11,
	gameTime = 7,
	timeBlock = 4,
	playTime = 8,
	reliveItem = 10,
	playCost = 2,
	activityId = 1
}
local dataList = {
	{
		338001,
		20,
		200,
		9,
		9,
		{
			5,
			8
		},
		60,
		15,
		4600015,
		"8:1:5000",
		5,
		5
	}
}
local t_pick_up_idea_activity = {
	[338001] = dataList[1]
}

t_pick_up_idea_activity.dataList = dataList

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

return t_pick_up_idea_activity
