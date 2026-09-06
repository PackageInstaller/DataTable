-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_scratch_activity.lua

module("logicconfig.config.t_star_scratch_activity", package.seeall)

local title = {
	cost = 2,
	bigPirzeTag = 5,
	jumpTo = 4,
	activityId = 1,
	positionNum = 3
}
local dataList = {
	{
		364001,
		"10:364001:10",
		6,
		"ui#starscratchtaskview",
		"大奖"
	}
}
local t_star_scratch_activity = {
	[364001] = dataList[1]
}

t_star_scratch_activity.dataList = dataList

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

return t_star_scratch_activity
