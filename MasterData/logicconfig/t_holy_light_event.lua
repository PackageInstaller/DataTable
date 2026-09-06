-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_light_event.lua

module("logicconfig.config.t_holy_light_event", package.seeall)

local title = {
	ruleHandler = 2,
	eventId = 1,
	name = 3
}
local dataList = {
	{
		1,
		"Resources",
		"资源事件"
	},
	{
		2,
		"Buffs",
		"buff事件"
	},
	{
		3,
		"Challenge",
		"挑战事件"
	},
	{
		4,
		"Double",
		"翻倍事件"
	},
	{
		5,
		"Finish",
		"终点事件"
	}
}
local t_holy_light_event = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_holy_light_event.dataList = dataList

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

return t_holy_light_event
