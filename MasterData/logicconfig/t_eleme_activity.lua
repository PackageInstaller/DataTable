-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eleme_activity.lua

module("logicconfig.config.t_eleme_activity", package.seeall)

local title = {
	refreshNum = 3,
	redPointId = 4,
	activityId = 1,
	orderNum = 2
}
local dataList = {
	{
		332001,
		5,
		5,
		547
	}
}
local t_eleme_activity = {
	[332001] = dataList[1]
}

t_eleme_activity.dataList = dataList

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

return t_eleme_activity
