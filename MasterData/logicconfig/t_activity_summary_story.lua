-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_summary_story.lua

module("logicconfig.config.t_activity_summary_story", package.seeall)

local title = {
	startTime = 5,
	summaryId = 3,
	id = 1,
	title = 4,
	subId = 2
}
local dataList = {
	{
		4060001,
		1,
		17005,
		""
	},
	{
		4060002,
		2,
		17005,
		""
	},
	{
		4060003,
		3,
		17005,
		""
	},
	{
		4060004,
		4,
		17005,
		""
	},
	{
		4120001,
		1,
		17023,
		""
	},
	{
		4120002,
		2,
		17023,
		""
	},
	{
		4120003,
		3,
		17023,
		""
	},
	{
		4120004,
		4,
		17023,
		""
	},
	{
		4210001,
		1,
		17040,
		""
	},
	{
		4210002,
		2,
		17040,
		""
	},
	{
		4210003,
		3,
		17040,
		""
	},
	{
		4210004,
		4,
		17040,
		""
	},
	{
		4210005,
		5,
		17040,
		""
	},
	{
		4760001,
		1,
		17142,
		"知识讲堂"
	},
	{
		4760002,
		2,
		17142,
		"新春对联"
	},
	{
		4760003,
		3,
		17142,
		"新春烟花"
	},
	{
		4760004,
		4,
		17142,
		"拜年压岁钱"
	},
	{
		4760005,
		5,
		17142,
		"新春祝福"
	},
	{
		4760006,
		6,
		17142,
		"六艺道馆"
	},
	{
		4760010,
		1,
		17145,
		"天外来客"
	},
	{
		4760011,
		2,
		17145,
		"享用主义"
	},
	{
		4760012,
		3,
		17145,
		"拉面传说"
	},
	{
		4760013,
		4,
		17145,
		"密林食旅"
	},
	{
		4760014,
		5,
		17145,
		"生死之交"
	},
	{
		4760015,
		6,
		17145,
		"情义不渝"
	},
	{
		4820051,
		1,
		17180,
		"顽石误结尘缘",
		"2026-01-01T05:00:00"
	},
	{
		4820052,
		2,
		17180,
		"灵鲛勤拜仙师",
		"2026-01-09T05:00:00"
	},
	{
		4820055,
		3,
		17180,
		"青鸾情系风月",
		"2026-01-30T05:00:00"
	}
}
local t_activity_summary_story = {
	[4060001] = {
		dataList[1]
	},
	[4060002] = {
		[2] = dataList[2]
	},
	[4060003] = {
		[3] = dataList[3]
	},
	[4060004] = {
		[4] = dataList[4]
	},
	[4120001] = {
		dataList[5]
	},
	[4120002] = {
		[2] = dataList[6]
	},
	[4120003] = {
		[3] = dataList[7]
	},
	[4120004] = {
		[4] = dataList[8]
	},
	[4210001] = {
		dataList[9]
	},
	[4210002] = {
		[2] = dataList[10]
	},
	[4210003] = {
		[3] = dataList[11]
	},
	[4210004] = {
		[4] = dataList[12]
	},
	[4210005] = {
		[5] = dataList[13]
	},
	[4760001] = {
		dataList[14]
	},
	[4760002] = {
		[2] = dataList[15]
	},
	[4760003] = {
		[3] = dataList[16]
	},
	[4760004] = {
		[4] = dataList[17]
	},
	[4760005] = {
		[5] = dataList[18]
	},
	[4760006] = {
		[6] = dataList[19]
	},
	[4760010] = {
		dataList[20]
	},
	[4760011] = {
		[2] = dataList[21]
	},
	[4760012] = {
		[3] = dataList[22]
	},
	[4760013] = {
		[4] = dataList[23]
	},
	[4760014] = {
		[5] = dataList[24]
	},
	[4760015] = {
		[6] = dataList[25]
	},
	[4820051] = {
		dataList[26]
	},
	[4820052] = {
		[2] = dataList[27]
	},
	[4820055] = {
		[3] = dataList[28]
	}
}

t_activity_summary_story.dataList = dataList

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

return t_activity_summary_story
