-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_martial_contest_activity.lua

module("logicconfig.config.t_martial_contest_activity", package.seeall)

local title = {
	jumpToShop = 4,
	costItem = 3,
	redPointId = 2,
	activityId = 1
}
local dataList = {
	{
		583001,
		774,
		"10:583020",
		"func#191#583#583001"
	}
}
local t_martial_contest_activity = {
	[583001] = dataList[1]
}

t_martial_contest_activity.dataList = dataList

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

return t_martial_contest_activity
