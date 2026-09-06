-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_isaac_clg_activity.lua

module("logicconfig.config.t_king_isaac_clg_activity", package.seeall)

local title = {
	activityId = 1,
	comPlanId = 3,
	redPointId = 2
}
local dataList = {
	{
		347001,
		559,
		1
	}
}
local t_king_isaac_clg_activity = {
	[347001] = dataList[1]
}

t_king_isaac_clg_activity.dataList = dataList

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

return t_king_isaac_clg_activity
