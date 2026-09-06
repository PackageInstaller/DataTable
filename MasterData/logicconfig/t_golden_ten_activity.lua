-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_golden_ten_activity.lua

module("logicconfig.config.t_golden_ten_activity", package.seeall)

local title = {
	activityId = 1,
	raceUnlock = 5,
	followLimit = 2,
	msgTpId = 3,
	serialId = 6,
	totalNum = 7,
	activityItemId = 4
}
local dataList = {
	{
		259001,
		3,
		60,
		259001,
		0,
		608,
		300005
	},
	{
		259002,
		3,
		60,
		259002,
		10313,
		0,
		0
	}
}
local t_golden_ten_activity = {
	[259001] = dataList[1],
	[259002] = dataList[2]
}

t_golden_ten_activity.dataList = dataList

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

return t_golden_ten_activity
