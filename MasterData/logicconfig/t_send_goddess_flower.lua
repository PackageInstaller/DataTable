-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_send_goddess_flower.lua

module("logicconfig.config.t_send_goddess_flower", package.seeall)

local title = {
	activityId = 1,
	redPointId = 5,
	flowerPlanId = 2,
	goddessPlanId = 3,
	progressPrizePlanId = 4
}
local dataList = {
	{
		137001,
		1,
		1,
		1,
		227
	}
}
local t_send_goddess_flower = {
	[137001] = dataList[1]
}

t_send_goddess_flower.dataList = dataList

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

return t_send_goddess_flower
