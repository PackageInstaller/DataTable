-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_summary_start_up.lua

module("logicconfig.config.t_activity_summary_start_up", package.seeall)

local title = {
	viewName = 1,
	redId = 3,
	activityId = 2,
	viewPrefab = 4
}
local dataList = {
	{
		"dragonancestorsummaryview",
		17190,
		-281,
		"dragonancestorsummaryview"
	},
	{
		"activitysmallsummarytwoview",
		0,
		-155,
		"activitysmalljumpsummaryview"
	},
	{
		"activitysmallsummaryfourview",
		0,
		-157,
		"activitysmalljumpsummaryview"
	},
	{
		"activitysmallsummaryeightview",
		0,
		0,
		"activitysmalljumpsummaryview"
	},
	{
		"activitysmallsummarynineview",
		17199,
		0,
		"activitysmalljumpsummaryview"
	},
	{
		"activitysmallsummarytenview",
		0,
		0,
		"activitysmalljumpsummaryview"
	},
	{
		"activitysmallsummarysixview",
		17198,
		0,
		"activitysmalljumpsummarytwoview"
	},
	{
		"activitysmalljumpsummarythreeview",
		17196,
		0,
		"activitysmalljumpsummarythreeview"
	},
	{
		"activitysmallsummarysevenview",
		17197,
		0,
		"activitysmalltwojumpsummaryview"
	},
	{
		"activitypaladinsummaryview",
		17195,
		-154,
		"activitypaladinsummaryview"
	},
	{
		"zhihuijiazuhudview",
		0,
		0,
		"activityzhihuijiazuview"
	},
	{
		"culturalsummaryview",
		0,
		-267,
		"culturalsummaryview"
	},
	{
		"activitysmallsummaryfiveview",
		0,
		-156,
		"activitypaladinsummaryview"
	},
	{
		"activityfuyaosummaryview",
		0,
		0,
		"activityfuyaosummaryview"
	},
	{
		"aolaishimainview",
		17102,
		0,
		"aolaishimainview"
	},
	{
		"activitysmallsummarythreeview",
		17127,
		-156,
		"activitysmallsummaryview"
	},
	{
		"goddesscompetitionhudview",
		17185,
		0,
		"goddesscompetitionhudview"
	},
	{
		"luyngardehudview",
		17152,
		0,
		"luyngardehudview"
	},
	{
		"dragonkingaruishihudview",
		17163,
		0,
		"dragonkingaruishihudview"
	},
	{
		"bingqibusummaryview",
		17165,
		0,
		"bingqibusummaryview"
	},
	{
		"activitymagicschoolsummaryview",
		17168,
		0,
		"activitymagicschoolsummaryview"
	},
	{
		"gamelobbyview",
		17191,
		0,
		"gamelobbyview"
	}
}
local t_activity_summary_start_up = {
	dragonancestorsummaryview = dataList[1],
	activitysmallsummarytwoview = dataList[2],
	activitysmallsummaryfourview = dataList[3],
	activitysmallsummaryeightview = dataList[4],
	activitysmallsummarynineview = dataList[5],
	activitysmallsummarytenview = dataList[6],
	activitysmallsummarysixview = dataList[7],
	activitysmalljumpsummarythreeview = dataList[8],
	activitysmallsummarysevenview = dataList[9],
	activitypaladinsummaryview = dataList[10],
	zhihuijiazuhudview = dataList[11],
	culturalsummaryview = dataList[12],
	activitysmallsummaryfiveview = dataList[13],
	activityfuyaosummaryview = dataList[14],
	aolaishimainview = dataList[15],
	activitysmallsummarythreeview = dataList[16],
	goddesscompetitionhudview = dataList[17],
	luyngardehudview = dataList[18],
	dragonkingaruishihudview = dataList[19],
	bingqibusummaryview = dataList[20],
	activitymagicschoolsummaryview = dataList[21],
	gamelobbyview = dataList[22]
}

t_activity_summary_start_up.dataList = dataList

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

return t_activity_summary_start_up
