-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ancient_fossil_site_period.lua

module("logicconfig.config.t_ancient_fossil_site_period", package.seeall)

local title = {
	startTime = 3,
	periodId = 1,
	endTime = 4,
	prizePlanId = 2
}
local dataList = {
	{
		1,
		1,
		"2022-03-04T05:00:00",
		"2022-03-18T05:00:00"
	},
	{
		2,
		2,
		"2022-08-19T05:00:00",
		"2022-08-26T05:00:00"
	}
}
local t_ancient_fossil_site_period = {
	dataList[1],
	dataList[2]
}

t_ancient_fossil_site_period.dataList = dataList

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

return t_ancient_fossil_site_period
