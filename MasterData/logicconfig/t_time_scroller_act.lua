-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_scroller_act.lua

module("logicconfig.config.t_time_scroller_act", package.seeall)

local title = {
	progressPlanId = 4,
	taskShowPetRaceId = 5,
	storyId = 2,
	taskBgPath = 6,
	activityId = 1,
	adPlanId = 3
}
local dataList = {
	{
		197002,
		4380001,
		1,
		1,
		1700901,
		"bg_shijianjuanzhou_01"
	}
}
local t_time_scroller_act = {
	[197002] = dataList[1]
}

t_time_scroller_act.dataList = dataList

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

return t_time_scroller_act
