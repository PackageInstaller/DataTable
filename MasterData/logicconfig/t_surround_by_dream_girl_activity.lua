-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_surround_by_dream_girl_activity.lua

module("logicconfig.config.t_surround_by_dream_girl_activity", package.seeall)

local title = {
	maxMoney = 3,
	ruleKeyMain = 4,
	activityId = 1,
	moneyPrizePlanId = 2
}
local dataList = {
	{
		459001,
		1,
		999999999,
		"surround_by_dream_girl_rule"
	}
}
local t_surround_by_dream_girl_activity = {
	[459001] = dataList[1]
}

t_surround_by_dream_girl_activity.dataList = dataList

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

return t_surround_by_dream_girl_activity
