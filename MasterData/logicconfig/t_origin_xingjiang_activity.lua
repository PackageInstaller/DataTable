-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_xingjiang_activity.lua

module("logicconfig.config.t_origin_xingjiang_activity", package.seeall)

local title = {
	passNeedAliveTransmog = 3,
	jumpList = 5,
	passAllStagePrize = 2,
	raceId = 4,
	activityId = 1
}
local dataList = {
	{
		570001,
		"4:510724:100",
		16,
		11036,
		{
			"event#gotofirstpassrankview#570001",
			"func#618#11036",
			"func#43#144",
			"ui#lottery"
		}
	}
}
local t_origin_xingjiang_activity = {
	[570001] = dataList[1]
}

t_origin_xingjiang_activity.dataList = dataList

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

return t_origin_xingjiang_activity
