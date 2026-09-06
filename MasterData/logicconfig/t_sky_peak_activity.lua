-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sky_peak_activity.lua

module("logicconfig.config.t_sky_peak_activity", package.seeall)

local title = {
	ruleKey = 3,
	scoreShowItem = 5,
	jumptoStrs = 4,
	activityId = 1,
	rankMinScore = 2
}
local dataList = {
	{
		592001,
		600,
		"sky_peak_rule",
		{
			"ui#skypeakrankview#592001",
			"func#191#592#592001",
			"ui#skypeakrewardview#592001"
		},
		"1004:1632"
	},
	{
		592002,
		600,
		"sky_peak_rule",
		{
			"ui#skypeakrankview#592002",
			"func#191#592#592002",
			"ui#skypeakrewardview#592002"
		},
		"1004:1632"
	}
}
local t_sky_peak_activity = {
	[592001] = dataList[1],
	[592002] = dataList[2]
}

t_sky_peak_activity.dataList = dataList

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

return t_sky_peak_activity
