-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_year_pray_activity.lua

module("logicconfig.config.t_new_year_pray_activity", package.seeall)

local title = {
	comPlanId = 3,
	wishingPlanId = 4,
	redPointId = 6,
	burnPlanId = 5,
	dailyActCount = 2,
	progressItem = 7,
	activityId = 1
}
local dataList = {
	{
		326001,
		2,
		1,
		1,
		1,
		537,
		"10:326001"
	}
}
local t_new_year_pray_activity = {
	[326001] = dataList[1]
}

t_new_year_pray_activity.dataList = dataList

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

return t_new_year_pray_activity
