-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_make_snowman_prize.lua

module("logicconfig.config.t_make_snowman_prize", package.seeall)

local title = {
	prizeId = 2,
	progress = 4,
	snowmanId = 5,
	prizePlanId = 1,
	prize = 3
}
local dataList = {
	{
		1,
		1,
		"8:1:10000",
		10,
		6
	},
	{
		1,
		2,
		"4:31:10",
		90,
		1
	},
	{
		1,
		3,
		"60:1:1000",
		180,
		2
	},
	{
		1,
		4,
		"4:31:10",
		260,
		3
	},
	{
		1,
		5,
		"4:40008:2",
		350,
		4
	},
	{
		1,
		6,
		"4:40008:2",
		440,
		5
	},
	{
		1,
		7,
		"4:30003:200",
		530,
		1
	},
	{
		1,
		8,
		"4:30003:200",
		620,
		2
	},
	{
		1,
		9,
		"4:30003:200",
		710,
		3
	},
	{
		1,
		10,
		"4:30003:200",
		800,
		4
	},
	{
		1,
		11,
		"4:30003:200",
		1000,
		5
	},
	{
		2,
		1,
		"4:36:5",
		10,
		6
	},
	{
		2,
		2,
		"4:11002:15000",
		90,
		1
	},
	{
		2,
		3,
		"4:12102:2",
		180,
		2
	},
	{
		2,
		4,
		"4:400002:50",
		260,
		3
	},
	{
		2,
		5,
		"4:7008:50",
		350,
		4
	},
	{
		2,
		6,
		"4:36:5",
		440,
		5
	},
	{
		2,
		7,
		"4:12102:3",
		530,
		1
	},
	{
		2,
		8,
		"4:11002:15000",
		620,
		2
	},
	{
		2,
		9,
		"4:400002:50",
		710,
		3
	},
	{
		2,
		10,
		"4:12102:5",
		800,
		4
	},
	{
		2,
		11,
		"4:7008:50",
		1000,
		5
	}
}
local t_make_snowman_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	},
	{
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22]
	}
}

t_make_snowman_prize.dataList = dataList

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

return t_make_snowman_prize
