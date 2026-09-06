-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fan_rui_challenge_activity.lua

module("logicconfig.config.t_fan_rui_challenge_activity", package.seeall)

local title = {
	challengeId = 4,
	jumpTo2 = 6,
	themeControlOpenTime = 3,
	themeDestinyOpenTime = 2,
	reward1 = 9,
	reward3 = 11,
	jumpTo3 = 7,
	jumpTo1 = 5,
	reward2 = 10,
	jumpTo4 = 8,
	activityId = 1
}
local dataList = {
	{
		293001,
		"2023-09-09T05:00:00",
		"2023-09-10T05:00:00",
		124,
		"func#936",
		"func#618#13011",
		"mibao#yonghengguodu4",
		"",
		"4:378:30",
		"4:378:30",
		"4:378:60"
	},
	{
		293002,
		"2025-09-26T05:00:00",
		"2025-09-26T05:00:00",
		252,
		"ui#lottery",
		"func#618#15036",
		"mibao#yonghengguodu4",
		"func#545#1",
		"4:397:20",
		"4:397:30",
		"4:397:50"
	},
	{
		293003,
		"2026-05-09T05:00:00",
		"2026-05-10T05:00:00",
		296,
		"func#545#52",
		"func#618#15048",
		"mibao#jinglingyangcheng",
		"ui#lottery",
		"4:510781:20",
		"4:510781:30",
		"4:510781:50"
	}
}
local t_fan_rui_challenge_activity = {
	[293001] = dataList[1],
	[293002] = dataList[2],
	[293003] = dataList[3]
}

t_fan_rui_challenge_activity.dataList = dataList

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

return t_fan_rui_challenge_activity
