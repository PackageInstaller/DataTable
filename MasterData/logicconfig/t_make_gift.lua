-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_make_gift.lua

module("logicconfig.config.t_make_gift", package.seeall)

local title = {
	bubblePlanId = 6,
	dayTimesSkip = 5,
	makePlanId = 3,
	prizePlanId = 2,
	weeklyLimit = 4,
	activityId = 1
}
local dataList = {
	{
		92001,
		1,
		1,
		54,
		1,
		0
	},
	{
		92002,
		2,
		1,
		45,
		1,
		1
	}
}
local t_make_gift = {
	[92001] = dataList[1],
	[92002] = dataList[2]
}

t_make_gift.dataList = dataList

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

return t_make_gift
