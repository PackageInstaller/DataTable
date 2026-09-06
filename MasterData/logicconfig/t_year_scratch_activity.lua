-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_year_scratch_activity.lua

module("logicconfig.config.t_year_scratch_activity", package.seeall)

local title = {
	activityId = 1,
	gainGodGemTime = 3,
	redPointId = 2
}
local dataList = {
	{
		356001,
		567,
		"2024-04-26T05:00:00"
	}
}
local t_year_scratch_activity = {
	[356001] = dataList[1]
}

t_year_scratch_activity.dataList = dataList

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

return t_year_scratch_activity
