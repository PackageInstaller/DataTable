-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tarot_lottery_activity.lua

module("logicconfig.config.t_tarot_lottery_activity", package.seeall)

local title = {
	cost = 2,
	supportLotteryTimes = 3,
	redPointId = 5,
	jumpTo = 6,
	activityId = 1,
	guaranteeTimes = 4
}
local dataList = {
	{
		345001,
		"10:345001:1",
		{
			1,
			10
		},
		{
			25,
			50,
			75,
			100,
			125,
			150,
			175,
			200,
			225,
			250,
			275,
			300
		},
		556,
		"ui#commongrouptaskmainview#345001"
	}
}
local t_tarot_lottery_activity = {
	[345001] = dataList[1]
}

t_tarot_lottery_activity.dataList = dataList

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

return t_tarot_lottery_activity
