-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_challenge_activity.lua

module("logicconfig.config.t_eternal_challenge_activity", package.seeall)

local title = {
	creepsMasterId = 2,
	comPlanId = 3,
	activityId = 1
}
local dataList = {
	{
		297001,
		101,
		1
	}
}
local t_eternal_challenge_activity = {
	[297001] = dataList[1]
}

t_eternal_challenge_activity.dataList = dataList

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

return t_eternal_challenge_activity
