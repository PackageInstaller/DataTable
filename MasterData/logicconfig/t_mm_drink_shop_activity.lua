-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mm_drink_shop_activity.lua

module("logicconfig.config.t_mm_drink_shop_activity", package.seeall)

local title = {
	ruleKey = 4,
	showItem = 5,
	slotCount = 3,
	activityId = 1,
	initScore = 2
}
local dataList = {
	{
		596001,
		100,
		3,
		"mm_drink_shop_rule",
		"1004:1634"
	}
}
local t_mm_drink_shop_activity = {
	[596001] = dataList[1]
}

t_mm_drink_shop_activity.dataList = dataList

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

return t_mm_drink_shop_activity
