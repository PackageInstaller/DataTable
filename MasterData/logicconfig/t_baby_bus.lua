-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_baby_bus.lua

module("logicconfig.config.t_baby_bus", package.seeall)

local title = {
	redPointId = 3,
	wishActId = 4,
	activityId = 1,
	prizePlanId = 2
}
local dataList = {
	{
		256001,
		1,
		468,
		232003
	},
	{
		256002,
		2,
		468,
		232013
	},
	{
		256003,
		3,
		468,
		232025
	}
}
local t_baby_bus = {
	[256001] = dataList[1],
	[256002] = dataList[2],
	[256003] = dataList[3]
}

t_baby_bus.dataList = dataList

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

return t_baby_bus
