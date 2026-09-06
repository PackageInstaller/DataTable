-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_popularity_list.lua

module("logicconfig.config.t_popularity_list", package.seeall)

local title = {
	reward = 8,
	titlePos = 12,
	vipTimesPlanId = 5,
	freeTimes = 6,
	popularityRatio = 7,
	title = 11,
	dailyActiveScoreAddTimes = 10,
	dailyTimesPlanId = 4,
	type = 2,
	sortIdx = 3,
	activityId = 1,
	dailyActiveScoreCondition = 9
}
local dataList = {
	{
		72001,
		"race",
		0,
		1,
		0,
		3,
		1,
		"104:2:5",
		0,
		0,
		"",
		{
			-148.5,
			248
		}
	},
	{
		72001,
		"skin",
		0,
		1,
		0,
		3,
		1,
		"104:2:5",
		0,
		0,
		""
	},
	{
		72002,
		"1",
		1,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"年度最佳精灵"
	},
	{
		72002,
		"2",
		2,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"最想加强精灵"
	},
	{
		72002,
		"3",
		3,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"最期待皮肤系列"
	},
	{
		72002,
		"4",
		4,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"年度最佳皮肤"
	},
	{
		72002,
		"5",
		5,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"最期待上线精灵"
	},
	{
		72003,
		"1",
		1,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"年度最佳精灵"
	},
	{
		72003,
		"2",
		2,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"最想神曜精灵"
	},
	{
		72003,
		"3",
		3,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"最期待皮肤系列"
	},
	{
		72003,
		"4",
		4,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"年度最佳皮肤"
	},
	{
		72003,
		"5",
		5,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"最期待上线精灵"
	},
	{
		72004,
		"1",
		1,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"年度最佳精灵"
	},
	{
		72004,
		"2",
		2,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"最想神曜精灵"
	},
	{
		72004,
		"3",
		3,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"最期待皮肤系列"
	},
	{
		72004,
		"4",
		4,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"年度最佳皮肤"
	},
	{
		72004,
		"5",
		5,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"最期待上线精灵"
	},
	{
		72005,
		"1",
		1,
		0,
		1,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"最期待女皮"
	},
	{
		72006,
		"1",
		4,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"年度神曜精灵",
		{
			-148.5,
			248
		}
	},
	{
		72006,
		"2",
		5,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"期待源起精灵",
		{
			-148.5,
			248
		}
	},
	{
		72006,
		"3",
		6,
		2,
		0,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"年度最佳皮肤",
		{
			-148.5,
			248
		}
	},
	{
		72006,
		"4",
		1,
		0,
		1,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"最期待女皮"
	},
	{
		72006,
		"5",
		2,
		0,
		1,
		3,
		1,
		"9:80060:1",
		100,
		2,
		"最期待男皮"
	}
}
local t_popularity_list = {
	[72001] = {
		race = dataList[1],
		skin = dataList[2]
	},
	[72002] = {
		["1"] = dataList[3],
		["2"] = dataList[4],
		["3"] = dataList[5],
		["4"] = dataList[6],
		["5"] = dataList[7]
	},
	[72003] = {
		["1"] = dataList[8],
		["2"] = dataList[9],
		["3"] = dataList[10],
		["4"] = dataList[11],
		["5"] = dataList[12]
	},
	[72004] = {
		["1"] = dataList[13],
		["2"] = dataList[14],
		["3"] = dataList[15],
		["4"] = dataList[16],
		["5"] = dataList[17]
	},
	[72005] = {
		["1"] = dataList[18]
	},
	[72006] = {
		["1"] = dataList[19],
		["2"] = dataList[20],
		["3"] = dataList[21],
		["4"] = dataList[22],
		["5"] = dataList[23]
	}
}

t_popularity_list.dataList = dataList

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

return t_popularity_list
