-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_island_station_activity.lua

module("logicconfig.config.t_island_station_activity", package.seeall)

local title = {
	bossId = 4,
	profileGainMp = 6,
	dailyGameTimes = 2,
	skinId = 8,
	collectSkinPrize = 10,
	bubbleKeepTime = 7,
	profitUnit = 5,
	dailyChatTimes = 3,
	ruleKeyMain = 11,
	activityId = 1,
	bossSkinId = 9
}
local dataList = {
	{
		487001,
		5,
		3,
		1001,
		50,
		"10:487001:1",
		3,
		10354,
		10351,
		"14:413:1",
		"island_station_rule"
	}
}
local t_island_station_activity = {
	[487001] = dataList[1]
}

t_island_station_activity.dataList = dataList

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

return t_island_station_activity
