-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ciyuan_signin_activity.lua

module("logicconfig.config.t_ciyuan_signin_activity", package.seeall)

local title = {
	ruleKeyMain = 6,
	divineDragonRaceId = 4,
	ciyuanDragonRaceId = 2,
	redPointType = 5,
	ciyuanHeartItemType = 3,
	activityId = 1
}
local dataList = {
	{
		616001,
		10313,
		"4:206",
		14016,
		786,
		"ciyuansignin_rule"
	},
	{
		616002,
		10313,
		"4:206",
		14016,
		786,
		"ciyuansignin_rule"
	}
}
local t_ciyuan_signin_activity = {
	[616001] = dataList[1],
	[616002] = dataList[2]
}

t_ciyuan_signin_activity.dataList = dataList

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

return t_ciyuan_signin_activity
