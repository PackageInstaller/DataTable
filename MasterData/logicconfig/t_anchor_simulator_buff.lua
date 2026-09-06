-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anchor_simulator_buff.lua

module("logicconfig.config.t_anchor_simulator_buff", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	times = 2
}
local dataList = {
	{
		446001,
		1,
		"105:6105:100"
	},
	{
		446001,
		2,
		"105:6105:100"
	},
	{
		446001,
		3,
		"105:6105:100"
	},
	{
		446001,
		4,
		"105:6105:100"
	},
	{
		446001,
		5,
		"105:6105:100"
	}
}
local t_anchor_simulator_buff = {
	[446001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_anchor_simulator_buff.dataList = dataList

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

return t_anchor_simulator_buff
