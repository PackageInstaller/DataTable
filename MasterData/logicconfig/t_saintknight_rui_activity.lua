-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saintknight_rui_activity.lua

module("logicconfig.config.t_saintknight_rui_activity", package.seeall)

local title = {
	gameActivityId = 3,
	challengeDailyTimes = 4,
	puyTo = 10,
	skinId = 5,
	getTo = 9,
	animPath = 13,
	prize = 8,
	stageName = 6,
	storyId1 = 14,
	res = 12,
	storyId2 = 15,
	funcId = 7,
	rankTo = 11,
	activityId = 1,
	challengePlanId = 2
}
local dataList = {
	{
		172001,
		1,
		58003,
		9999,
		13001,
		"救赎之战",
		5033,
		"4:143:1",
		"ui#publicdragontabview#2#1",
		"func#43",
		"func#618#13001",
		"4:12:1",
		"storyconfig/animations/mizong_dengchang.txt",
		4290010,
		4290011
	}
}
local t_saintknight_rui_activity = {
	[172001] = dataList[1]
}

t_saintknight_rui_activity.dataList = dataList

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

return t_saintknight_rui_activity
