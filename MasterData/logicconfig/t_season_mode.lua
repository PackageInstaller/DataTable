-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode.lua

module("logicconfig.config.t_season_mode", package.seeall)

local title = {
	bgmIds = 13,
	name = 2,
	seasonId = 1,
	storyId = 8,
	type = 3,
	viewname = 4,
	imgInfo = 11,
	rankRuleKey = 12,
	mapDataName = 5,
	isUseHightLow = 14,
	imgTitle = 6,
	endTime = 10,
	raceId = 7,
	startTime = 9
}
local dataList = {
	{
		1,
		"信仰之役",
		1,
		"seasonmainview",
		"season_scene",
		"board_saijiwanfa_24",
		17004,
		4350003,
		"2022-10-28T05:00:00",
		"2022-11-25T05:00:00",
		"board_saijiwanfa_44",
		"seasonrankmain",
		{
			12004
		},
		false
	},
	{
		2,
		"狮王争霸",
		1,
		"s2_seasonmainview",
		"season_scene_s2",
		"board_s2_saijiwanfa_30",
		1014603,
		4410002,
		"2023-01-20T05:00:00",
		"2023-02-17T05:00:00",
		"board_s2_saijiwanfa_36",
		"seasonrankmain2",
		{
			12004
		},
		true
	},
	{
		3,
		"迷雾骰局",
		1,
		"seasonmainview",
		"season_scene_s3",
		"board_saijiwanfa3_05",
		17012,
		4550001,
		"2023-10-27T05:00:00",
		"2023-11-24T05:00:00",
		"board_saijiwanfa3_02",
		"seasonrankmain",
		{
			12004
		},
		false
	}
}
local t_season_mode = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_season_mode.dataList = dataList

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

return t_season_mode
