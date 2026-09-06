-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_find_treasure_activity.lua

module("logicconfig.config.t_miracle_find_treasure_activity", package.seeall)

local title = {
	costItemCount = 3,
	activityId = 1,
	lotteryItem = 2
}
local dataList = {
	{
		379001,
		379001,
		9
	}
}
local t_miracle_find_treasure_activity = {
	[379001] = dataList[1]
}

t_miracle_find_treasure_activity.dataList = dataList

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

return t_miracle_find_treasure_activity
