-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_psychiced_tower_tower.lua

module("logicconfig.config.t_psychiced_tower_tower", package.seeall)

local title = {
	supportPetIds = 4,
	name = 3,
	endDateTime = 6,
	openDateTime = 5,
	bgRes = 7,
	activityId = 1,
	towerId = 2
}
local dataList = {
	{
		388001,
		1,
		"伏妖无敌塔",
		{
			1000001,
			1000002
		},
		"2024-08-02T05:00:00",
		"2024-08-23T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	},
	{
		388001,
		2,
		"昆仑法纳斯塔",
		{
			1000003,
			1000004
		},
		"2024-08-09T05:00:00",
		"2024-08-23T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_03.png"
	},
	{
		388001,
		3,
		"女帝吞天究塔",
		{
			1000005,
			1000006,
			1000007
		},
		"2024-08-16T05:00:00",
		"2024-08-23T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_01.png"
	},
	{
		388002,
		1,
		"神曜诺雅塔",
		{
			1000008
		},
		"2024-09-27T05:00:00",
		"2024-10-11T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	},
	{
		388003,
		1,
		"神曜安塔",
		{
			1000009
		},
		"2024-11-08T05:00:00",
		"2024-11-22T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	},
	{
		388004,
		1,
		"神曜极塔",
		{
			1000010
		},
		"2024-11-22T05:00:00",
		"2024-12-20T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	},
	{
		388005,
		1,
		"神曜维蕾塔塔",
		{
			1000011
		},
		"2024-12-27T05:00:00",
		"2025-01-10T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	},
	{
		388006,
		1,
		"昆吾塔",
		{
			1000012
		},
		"2025-01-31T05:00:00",
		"2025-02-28T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	},
	{
		388007,
		1,
		"神曜昆仑塔",
		{
			1000013
		},
		"2025-04-03T05:00:00",
		"2025-04-30T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	},
	{
		388008,
		1,
		"神曜圣骑塔",
		{
			1000014
		},
		"2025-06-06T05:00:00",
		"2025-06-27T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	},
	{
		388009,
		1,
		"神曜伏妖塔",
		{
			1000015
		},
		"2025-08-08T05:00:00",
		"2025-08-22T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	},
	{
		388010,
		1,
		"神曜吞天塔",
		{
			1000016
		},
		"2025-09-12T05:00:00",
		"2025-09-26T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	},
	{
		388011,
		1,
		"神曜法纳斯塔",
		{
			1000017
		},
		"2025-11-07T05:00:00",
		"2025-11-21T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	},
	{
		388012,
		1,
		"源起诺雅塔",
		{
			1000018
		},
		"2025-12-05T05:00:00",
		"2025-12-19T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	},
	{
		388013,
		1,
		"源起星绛塔",
		{
			1000021
		},
		"2026-03-27T05:00:00",
		"2026-04-03T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	},
	{
		388014,
		1,
		"源起究塔",
		{
			1000022
		},
		"2026-04-17T05:00:00",
		"2026-04-30T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	},
	{
		388015,
		1,
		"源起安塔",
		{
			1000023
		},
		"2026-05-08T05:00:00",
		"2026-05-29T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	},
	{
		388016,
		1,
		"源起尘塔",
		{
			1000024
		},
		"2026-07-31T05:00:00",
		"2026-08-21T05:00:00",
		"ui/bigbg/tonglingshihuanta/board_tonglinghuanta_02.png"
	}
}
local t_psychiced_tower_tower = {
	[388001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[388002] = {
		dataList[4]
	},
	[388003] = {
		dataList[5]
	},
	[388004] = {
		dataList[6]
	},
	[388005] = {
		dataList[7]
	},
	[388006] = {
		dataList[8]
	},
	[388007] = {
		dataList[9]
	},
	[388008] = {
		dataList[10]
	},
	[388009] = {
		dataList[11]
	},
	[388010] = {
		dataList[12]
	},
	[388011] = {
		dataList[13]
	},
	[388012] = {
		dataList[14]
	},
	[388013] = {
		dataList[15]
	},
	[388014] = {
		dataList[16]
	},
	[388015] = {
		dataList[17]
	},
	[388016] = {
		dataList[18]
	}
}

t_psychiced_tower_tower.dataList = dataList

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

return t_psychiced_tower_tower
