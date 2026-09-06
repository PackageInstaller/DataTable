-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anchor_simulator_property.lua

module("logicconfig.config.t_anchor_simulator_property", package.seeall)

local title = {
	levelPlan = 4,
	activityId = 1,
	classesBg = 5,
	propertyType = 2,
	desc = 3
}
local dataList = {
	{
		446001,
		1,
		"创作质量",
		1,
		"anchorsimulator/board_zhubomoniqi_27"
	},
	{
		446001,
		2,
		"粉丝数",
		2,
		"anchorsimulator/board_zhubomoniqi_28"
	},
	{
		446001,
		3,
		"话题度",
		3,
		"anchorsimulator/board_zhubomoniqi_29"
	},
	{
		446001,
		4,
		"带货口才",
		4,
		"anchorsimulator/board_zhubomoniqi_30"
	}
}
local t_anchor_simulator_property = {
	[446001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_anchor_simulator_property.dataList = dataList

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

return t_anchor_simulator_property
