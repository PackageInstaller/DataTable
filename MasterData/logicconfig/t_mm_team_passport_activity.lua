-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mm_team_passport_activity.lua

module("logicconfig.config.t_mm_team_passport_activity", package.seeall)

local title = {
	activityId = 1,
	allMemberCount = 2
}
local dataList = {
	{
		600001,
		3
	}
}
local t_mm_team_passport_activity = {
	[600001] = dataList[1]
}

t_mm_team_passport_activity.dataList = dataList

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

return t_mm_team_passport_activity
