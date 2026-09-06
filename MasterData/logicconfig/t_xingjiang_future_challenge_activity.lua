-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xingjiang_future_challenge_activity.lua

module("logicconfig.config.t_xingjiang_future_challenge_activity", package.seeall)

local title = {
	activityId = 1,
	challengePlanId = 2
}
local dataList = {
	{
		128001,
		1
	},
	{
		128002,
		2
	}
}
local t_xingjiang_future_challenge_activity = {
	[128001] = dataList[1],
	[128002] = dataList[2]
}

t_xingjiang_future_challenge_activity.dataList = dataList

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

return t_xingjiang_future_challenge_activity
