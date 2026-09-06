-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fight_dungeon_event.lua

module("logicconfig.config.t_origin_fight_dungeon_event", package.seeall)

local title = {
	eventParam = 6,
	finishToExit = 7,
	y = 5,
	eventPlanId = 1,
	eventId = 2,
	x = 4,
	eventType = 3
}
local dataList = {
	{
		1,
		1,
		"switchCtrl",
		2,
		1,
		"2",
		false
	},
	{
		1,
		2,
		"rail",
		4,
		2,
		"close",
		false
	},
	{
		1,
		3,
		"barrier",
		3,
		2,
		"",
		false
	},
	{
		1,
		4,
		"exit",
		0,
		3,
		"",
		false
	},
	{
		1,
		5,
		"exit",
		3,
		4,
		"",
		false
	}
}
local t_origin_fight_dungeon_event = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_origin_fight_dungeon_event.dataList = dataList

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

return t_origin_fight_dungeon_event
