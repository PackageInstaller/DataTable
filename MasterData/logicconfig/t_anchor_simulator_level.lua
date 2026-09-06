-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anchor_simulator_level.lua

module("logicconfig.config.t_anchor_simulator_level", package.seeall)

local title = {
	heatValue = 3,
	desc = 4,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		446001,
		1,
		0,
		"无"
	},
	{
		446001,
		2,
		500,
		"小有名气"
	},
	{
		446001,
		3,
		1000,
		"中有名气"
	},
	{
		446001,
		4,
		1500,
		"大有名气"
	},
	{
		446001,
		5,
		2000,
		"直播天才"
	}
}
local t_anchor_simulator_level = {
	[446001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_anchor_simulator_level.dataList = dataList

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

return t_anchor_simulator_level
