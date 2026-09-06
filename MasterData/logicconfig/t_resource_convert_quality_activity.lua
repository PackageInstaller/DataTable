-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_resource_convert_quality_activity.lua

module("logicconfig.config.t_resource_convert_quality_activity", package.seeall)

local title = {
	periodType = 5,
	desc = 4,
	periodId = 1,
	materialType = 2,
	realCostQuality = 3,
	returnMp = 9,
	endTime = 7,
	timeLimit = 8,
	startTime = 6
}
local dataList = {
	{
		24004,
		24,
		5,
		"当周最多可回收20个",
		"weekly",
		"2023-09-28T05:00:00",
		"2038-12-31T05:00:00",
		20,
		"4:30006:5"
	}
}
local t_resource_convert_quality_activity = {
	[24004] = dataList[1]
}

t_resource_convert_quality_activity.dataList = dataList

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

return t_resource_convert_quality_activity
