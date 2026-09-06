-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_teshamu_floor.lua

module("logicconfig.config.t_divine_teshamu_floor", package.seeall)

local title = {
	activityId = 1,
	ruleDesc = 3,
	floorId = 2
}
local dataList = {
	{
		504001,
		1,
		"xxxxxxxxxxxxxxxxxxxxxx"
	}
}
local t_divine_teshamu_floor = {
	[504001] = {
		dataList[1]
	}
}

t_divine_teshamu_floor.dataList = dataList

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

return t_divine_teshamu_floor
