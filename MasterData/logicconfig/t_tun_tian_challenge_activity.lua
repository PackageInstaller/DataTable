-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tun_tian_challenge_activity.lua

module("logicconfig.config.t_tun_tian_challenge_activity", package.seeall)

local title = {
	extremeClgPrize = 6,
	comPlanId = 8,
	normalClgDailyCount = 2,
	refreshNormalClgMonsterCost = 4,
	normalClgMonsterCount = 3,
	redPointId = 7,
	activityId = 1,
	normalClgDailyRefreshCount = 5
}
local dataList = {
	{
		289001,
		5,
		5,
		"105:6065:100",
		5,
		"100:11014:1:1",
		502,
		1
	},
	{
		289002,
		5,
		5,
		"105:6065:100",
		5,
		"8:1:1000",
		647,
		2
	}
}
local t_tun_tian_challenge_activity = {
	[289001] = dataList[1],
	[289002] = dataList[2]
}

t_tun_tian_challenge_activity.dataList = dataList

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

return t_tun_tian_challenge_activity
