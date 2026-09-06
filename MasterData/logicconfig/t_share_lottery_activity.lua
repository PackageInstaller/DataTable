-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_share_lottery_activity.lua

module("logicconfig.config.t_share_lottery_activity", package.seeall)

local title = {
	sharePrize = 3,
	lotteryCost = 4,
	dailyShareTimes = 2,
	ruleKeyMain = 5,
	activityId = 1
}
local dataList = {
	{
		448001,
		1,
		"10:448001:2",
		"10:448001:1",
		"nailongshare_rule"
	}
}
local t_share_lottery_activity = {
	[448001] = dataList[1]
}

t_share_lottery_activity.dataList = dataList

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

return t_share_lottery_activity
