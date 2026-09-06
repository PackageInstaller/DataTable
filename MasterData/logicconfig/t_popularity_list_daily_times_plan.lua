-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_popularity_list_daily_times_plan.lua

module("logicconfig.config.t_popularity_list_daily_times_plan", package.seeall)

local title = {
	dailyTimesPlanId = 1,
	freeTimes = 2
}
local dataList = {
	{
		1,
		3
	},
	{
		2,
		2
	}
}
local t_popularity_list_daily_times_plan = {
	dataList[1],
	dataList[2]
}

t_popularity_list_daily_times_plan.dataList = dataList

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

return t_popularity_list_daily_times_plan
