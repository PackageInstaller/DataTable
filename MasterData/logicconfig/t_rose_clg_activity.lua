-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rose_clg_activity.lua

module("logicconfig.config.t_rose_clg_activity", package.seeall)

local title = {
	raceId = 2,
	paramStr = 3,
	activityId = 1
}
local dataList = {
	{
		414001,
		15029,
		"{\"jumpStr1\":\"func#618#15029\",\"jumpStr2\":\"func#545#54\",\"jumpStr3\":\"func#5143\",\"jumpStr4\":\"func#545#52\"}"
	}
}
local t_rose_clg_activity = {
	[414001] = dataList[1]
}

t_rose_clg_activity.dataList = dataList

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

return t_rose_clg_activity
