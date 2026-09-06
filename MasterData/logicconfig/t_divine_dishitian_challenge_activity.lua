-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dishitian_challenge_activity.lua

module("logicconfig.config.t_divine_dishitian_challenge_activity", package.seeall)

local title = {
	challengeId = 5,
	jumpTo2 = 7,
	refreshCost = 3,
	jumpTo4 = 9,
	refreshTimes = 2,
	jumpTo3 = 8,
	jumpTo1 = 6,
	extremeReward = 4,
	activityId = 1
}
local dataList = {
	{
		363001,
		15,
		"105:9:50",
		"4:233:100",
		165,
		"mibao#shenyaolibao",
		"func#545#22",
		"mibao#xinqionglongming2",
		"func#618#11021"
	}
}
local t_divine_dishitian_challenge_activity = {
	[363001] = dataList[1]
}

t_divine_dishitian_challenge_activity.dataList = dataList

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

return t_divine_dishitian_challenge_activity
