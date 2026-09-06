-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anchor_simulator_activity.lua

module("logicconfig.config.t_anchor_simulator_activity", package.seeall)

local title = {
	dailyLiveLimit = 8,
	strengthLimit = 2,
	breakAddStrength = 4,
	strengthItem = 5,
	goalArray = 14,
	trainTimes = 7,
	classExp = 11,
	buffRatio = 9,
	classLimit = 6,
	goalIconArray = 15,
	classCostStrength = 10,
	initStrength = 3,
	ruleKeyMain = 12,
	activityId = 1,
	ruleKeyLive = 13
}
local dataList = {
	{
		446001,
		120,
		60,
		30,
		"1004:1435",
		4,
		3,
		3,
		0.2,
		15,
		5,
		"nailongstream_rule_1",
		"nailongstream_rule_2",
		{
			"直播时长",
			"观看人数",
			"礼物数量"
		},
		{
			"anchorsimulator/board_zhubomoniqi_13",
			"anchorsimulator/board_zhubomoniqi_14",
			"anchorsimulator/board_zhubomoniqi_16"
		}
	}
}
local t_anchor_simulator_activity = {
	[446001] = dataList[1]
}

t_anchor_simulator_activity.dataList = dataList

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

return t_anchor_simulator_activity
