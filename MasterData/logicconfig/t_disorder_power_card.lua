-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_disorder_power_card.lua

module("logicconfig.config.t_disorder_power_card", package.seeall)

local title = {
	creepsMasterId = 3,
	item = 5,
	skinId = 9,
	rewardPath = 6,
	cardId = 2,
	buffDesc = 4,
	raceId = 8,
	cardShowId = 7,
	activityId = 1
}
local dataList = {
	{
		422001,
		1,
		1001,
		"神奇的buff效果1",
		"1004:1406:1",
		"img_11011_shenyaoshuizhixu",
		1,
		11011,
		11011
	},
	{
		422001,
		2,
		1002,
		"神奇的buff效果2",
		"1004:1407:1",
		"img_12021_shenyaowujinlong",
		2,
		12021,
		12021
	},
	{
		422001,
		3,
		1003,
		"神奇的buff效果3",
		"1004:1408:1",
		"img_13008_yonghengshenglong",
		3,
		13008,
		13008
	},
	{
		422001,
		4,
		1004,
		"神奇的buff效果4",
		"1004:1409:1",
		"img_14013_shenyaohuangjinlong",
		4,
		14013,
		14013
	},
	{
		422001,
		5,
		1005,
		"神奇的buff效果5",
		"1004:1410:1",
		"img_14016_shenyaoguangciyuan",
		5,
		14016,
		14016
	},
	{
		422001,
		6,
		1006,
		"神奇的buff效果1",
		"1004:1411:1",
		"img_15027_shenyaoanshikonglong",
		6,
		15027,
		15027
	},
	{
		422001,
		7,
		1007,
		"神奇的buff效果2",
		"1004:1412:1",
		"img_16022_shenyaochaoshenlong",
		7,
		16022,
		16022
	},
	{
		422001,
		8,
		1008,
		"神奇的buff效果3",
		"1004:1413:1",
		"img_16026_shenyaochi",
		8,
		16026,
		16026
	},
	{
		422001,
		9,
		1009,
		"神奇的buff效果4",
		"1004:1414:1",
		"img_17014_shenyaowangzhelong",
		9,
		17014,
		17014
	},
	{
		422001,
		10,
		1010,
		"神奇的buff效果5",
		"1004:1415:1",
		"img_17015_shenyaolongzunshengzhu",
		10,
		17015,
		17015
	}
}
local t_disorder_power_card = {
	[422001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_disorder_power_card.dataList = dataList

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

return t_disorder_power_card
