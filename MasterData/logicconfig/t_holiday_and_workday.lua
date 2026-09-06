-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holiday_and_workday.lua

module("logicconfig.config.t_holiday_and_workday", package.seeall)

local title = {
	endDate = 2,
	startDate = 1,
	type = 3
}
local dataList = {
	{
		"2018-04-01",
		"2018-04-01",
		1
	}
}
local t_holiday_and_workday = {
	["2018-04-01"] = {
		["2018-04-01"] = dataList[1]
	}
}

t_holiday_and_workday.dataList = dataList

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

return t_holiday_and_workday
