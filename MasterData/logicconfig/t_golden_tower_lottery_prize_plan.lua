-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_golden_tower_lottery_prize_plan.lua

module("logicconfig.config.t_golden_tower_lottery_prize_plan", package.seeall)

local title = {
	prizeId = 2,
	gainAll = 4,
	prizePlanId = 1,
	gainLimit = 5,
	prize = 3
}
local dataList = {
	{
		1001,
		1,
		"4:410069:1",
		false,
		1
	},
	{
		1002,
		1,
		"4:510831:1",
		false,
		2
	},
	{
		1002,
		2,
		"8:26:50",
		false,
		1
	},
	{
		1002,
		3,
		"",
		true,
		1
	},
	{
		1003,
		1,
		"4:400002:150",
		false,
		2
	},
	{
		1003,
		2,
		"4:901:5000",
		false,
		4
	},
	{
		1003,
		3,
		"4:902:100",
		false,
		1
	},
	{
		1003,
		4,
		"",
		true,
		1
	},
	{
		1004,
		1,
		"4:36:10",
		false,
		2
	},
	{
		1004,
		2,
		"4:12102:10",
		false,
		1
	},
	{
		1004,
		3,
		"4:11002:10000",
		false,
		3
	},
	{
		1004,
		4,
		"8:1:5000000",
		false,
		2
	},
	{
		1004,
		5,
		"",
		true,
		1
	},
	{
		2001,
		1,
		"4:410070:1",
		false,
		1
	},
	{
		2002,
		1,
		"8:26:50",
		false,
		1
	},
	{
		2002,
		2,
		"4:902:50",
		false,
		2
	},
	{
		2002,
		3,
		"",
		true,
		1
	},
	{
		2003,
		1,
		"4:400002:150",
		false,
		2
	},
	{
		2003,
		2,
		"4:7008:50",
		false,
		2
	},
	{
		2003,
		3,
		"4:30006:50",
		false,
		4
	},
	{
		2003,
		4,
		"",
		true,
		1
	},
	{
		2004,
		1,
		"4:901:5000",
		false,
		4
	},
	{
		2004,
		2,
		"4:36:10",
		false,
		2
	},
	{
		2004,
		3,
		"4:510022:10",
		false,
		1
	},
	{
		2004,
		4,
		"8:1:5000000",
		false,
		2
	},
	{
		2004,
		5,
		"",
		true,
		1
	},
	{
		3001,
		1,
		"4:410072:1",
		false,
		1
	},
	{
		3002,
		1,
		"4:510834:1",
		false,
		2
	},
	{
		3002,
		2,
		"8:26:50",
		false,
		1
	},
	{
		3002,
		3,
		"",
		true,
		1
	},
	{
		3003,
		1,
		"4:400002:150",
		false,
		2
	},
	{
		3003,
		2,
		"4:901:5000",
		false,
		4
	},
	{
		3003,
		3,
		"4:902:100",
		false,
		1
	},
	{
		3003,
		4,
		"",
		true,
		1
	},
	{
		3004,
		1,
		"4:36:10",
		false,
		2
	},
	{
		3004,
		2,
		"4:12102:10",
		false,
		1
	},
	{
		3004,
		3,
		"4:11002:10000",
		false,
		3
	},
	{
		3004,
		4,
		"8:1:5000000",
		false,
		2
	},
	{
		3004,
		5,
		"",
		true,
		1
	}
}
local t_golden_tower_lottery_prize_plan = {
	[1001] = {
		dataList[1]
	},
	[1002] = {
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[1003] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[1004] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13]
	},
	[2001] = {
		dataList[14]
	},
	[2002] = {
		dataList[15],
		dataList[16],
		dataList[17]
	},
	[2003] = {
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21]
	},
	[2004] = {
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26]
	},
	[3001] = {
		dataList[27]
	},
	[3002] = {
		dataList[28],
		dataList[29],
		dataList[30]
	},
	[3003] = {
		dataList[31],
		dataList[32],
		dataList[33],
		dataList[34]
	},
	[3004] = {
		dataList[35],
		dataList[36],
		dataList[37],
		dataList[38],
		dataList[39]
	}
}

t_golden_tower_lottery_prize_plan.dataList = dataList

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

return t_golden_tower_lottery_prize_plan
