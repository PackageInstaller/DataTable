-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_year_card_common.lua

module("logicconfig.config.t_year_card_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"Poster2025",
		"4:510405:1#1004:1429:1#1004:1420:1#1004:1427:1#1004:1428:1#1004:1430:1#1004:1431:1#1004:1432:1"
	},
	{
		"YearCard2025",
		"4:510405:1#1004:1419:1#1004:1418:1"
	},
	{
		"RaceId_2025",
		"18021"
	},
	{
		"SkinId_2025",
		"1802101"
	},
	{
		"Poster2026",
		"1004:1574:1#1004:1582:1#1004:1583:1#1004:1584:1#1004:1585:1#1004:1586:1#1004:1587:1#1004:1588:1"
	},
	{
		"YearCard2026",
		"1004:1574:1#1004:1575:1#1004:1589:1"
	},
	{
		"RaceId_2026",
		"18031"
	},
	{
		"SkinId_2026",
		"1803101"
	},
	{
		"CurActId",
		"8005"
	},
	{
		"NextActId",
		"8006"
	},
	{
		"LastWeekTopName",
		"即将结束"
	},
	{
		"NextActPreHeatTopName",
		"26年费预购"
	},
	{
		"NextActActiveTopName",
		"26年年费"
	}
}
local t_year_card_common = {
	Poster2025 = dataList[1],
	YearCard2025 = dataList[2],
	RaceId_2025 = dataList[3],
	SkinId_2025 = dataList[4],
	Poster2026 = dataList[5],
	YearCard2026 = dataList[6],
	RaceId_2026 = dataList[7],
	SkinId_2026 = dataList[8],
	CurActId = dataList[9],
	NextActId = dataList[10],
	LastWeekTopName = dataList[11],
	NextActPreHeatTopName = dataList[12],
	NextActActiveTopName = dataList[13]
}

t_year_card_common.dataList = dataList

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

return t_year_card_common
