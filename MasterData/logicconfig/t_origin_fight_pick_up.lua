-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fight_pick_up.lua

module("logicconfig.config.t_origin_fight_pick_up", package.seeall)

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
		525001,
		0,
		100,
		9,
		9,
		{
			5,
			8
		},
		20,
		15,
		4600015,
		"8:1:5000",
		5,
		5
	}
}
local t_origin_fight_pick_up = {
	[525001] = dataList[1]
}

t_origin_fight_pick_up.dataList = dataList

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

return t_origin_fight_pick_up
