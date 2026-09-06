-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_colorful_lantern.lua

module("logicconfig.config.t_colorful_lantern", package.seeall)

local title = {
	activityId = 1,
	scorePlanId = 3,
	fragmentPlanId = 2
}
local dataList = {
	{
		182001,
		1,
		1
	}
}
local t_colorful_lantern = {
	[182001] = dataList[1]
}

t_colorful_lantern.dataList = dataList

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

return t_colorful_lantern
