-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_weak_path_finding.lua

module("logicconfig.config.t_weak_path_finding", package.seeall)

local title = {
	gamePlanId = 6,
	copyId = 7,
	allTimes = 4,
	prizePlanId = 5,
	dailyTimes = 3,
	scenePlanId = 2,
	activityId = 1
}
local dataList = {
	{
		151001,
		1,
		5,
		20,
		1,
		1,
		4230002
	}
}
local t_weak_path_finding = {
	[151001] = dataList[1]
}

t_weak_path_finding.dataList = dataList

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

return t_weak_path_finding
