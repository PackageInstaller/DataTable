-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hex_lineup_activity.lua

module("logicconfig.config.t_hex_lineup_activity", package.seeall)

local title = {
	dailyGameLimit = 2,
	gamePlanIdArray = 4,
	redPointId = 3,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		590001,
		3,
		771,
		{
			1,
			2
		},
		"hex_lineup_rule"
	}
}
local t_hex_lineup_activity = {
	[590001] = dataList[1]
}

t_hex_lineup_activity.dataList = dataList

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

return t_hex_lineup_activity
