-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_resource_convert_define_activity.lua

module("logicconfig.config.t_resource_convert_define_activity", package.seeall)

local title = {
	periodType = 5,
	desc = 4,
	periodId = 1,
	defineId = 3,
	materialType = 2,
	returnMp = 9,
	endTime = 7,
	timeLimit = 8,
	startTime = 6
}
local dataList = {}
local t_resource_convert_define_activity = {}

t_resource_convert_define_activity.dataList = dataList

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

return t_resource_convert_define_activity
