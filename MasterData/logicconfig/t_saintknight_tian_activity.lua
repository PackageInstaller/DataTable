-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saintknight_tian_activity.lua

module("logicconfig.config.t_saintknight_tian_activity", package.seeall)

local title = {
	gamePlanId = 4,
	gamePrizePlanId = 6,
	dailyTimes = 5,
	prizePlanId = 3,
	gameItemId = 8,
	maxItemPerGain = 9,
	buffPlanId = 7,
	teamCollectPetId = 10,
	id = 1,
	challengePlanId = 2
}
local dataList = {
	{
		44,
		1,
		1,
		1,
		9999,
		1,
		1,
		"10:17019",
		1000,
		{
			11007,
			14008,
			12007,
			12008,
			13001,
			15011
		}
	}
}
local t_saintknight_tian_activity = {
	[44] = dataList[1]
}

t_saintknight_tian_activity.dataList = dataList

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

return t_saintknight_tian_activity
