-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_nuo_birthday_normal_game.lua

module("logicconfig.config.t_xiao_nuo_birthday_normal_game", package.seeall)

local title = {
	diffLv = 2,
	stageGroupId = 7,
	maxSecond = 6,
	activityId = 1,
	doubleSecond = 5,
	maxScore = 3,
	prize = 4
}
local dataList = {
	{
		220001,
		1,
		50,
		"8:1:10000",
		10,
		60,
		1
	},
	{
		220001,
		2,
		70,
		"8:1:10000",
		15,
		60,
		2
	},
	{
		220001,
		3,
		150,
		"8:1:10000",
		30,
		90,
		3
	},
	{
		220002,
		1,
		50,
		"8:1:10000",
		10,
		60,
		1
	},
	{
		220002,
		2,
		70,
		"8:1:10000",
		15,
		60,
		2
	},
	{
		220002,
		3,
		150,
		"8:1:10000",
		30,
		90,
		3
	},
	{
		220003,
		1,
		50,
		"8:1:10000",
		10,
		60,
		1
	},
	{
		220003,
		2,
		70,
		"8:1:10000",
		15,
		60,
		2
	},
	{
		220003,
		3,
		150,
		"8:1:10000",
		30,
		90,
		3
	},
	{
		220004,
		1,
		50,
		"8:1:10000",
		10,
		60,
		1
	},
	{
		220004,
		2,
		70,
		"8:1:10000",
		15,
		60,
		2
	},
	{
		220004,
		3,
		150,
		"8:1:10000",
		30,
		90,
		3
	},
	{
		220005,
		1,
		50,
		"8:1:10000",
		10,
		60,
		1
	},
	{
		220005,
		2,
		70,
		"8:1:10000",
		15,
		60,
		2
	},
	{
		220005,
		3,
		150,
		"8:1:10000",
		30,
		90,
		3
	}
}
local t_xiao_nuo_birthday_normal_game = {
	[220001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[220002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[220003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[220004] = {
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[220005] = {
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_xiao_nuo_birthday_normal_game.dataList = dataList

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

return t_xiao_nuo_birthday_normal_game
