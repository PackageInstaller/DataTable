-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_darkness_spring_activity.lua

module("logicconfig.config.t_darkness_spring_activity", package.seeall)

local title = {
	redPointId = 4,
	stage1ActId = 2,
	activityId = 1,
	stage2ProgressMaterialKey = 3
}
local dataList = {
	{
		430001,
		158008,
		"10:430002",
		655
	}
}
local t_darkness_spring_activity = {
	[430001] = dataList[1]
}

t_darkness_spring_activity.dataList = dataList

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

return t_darkness_spring_activity
