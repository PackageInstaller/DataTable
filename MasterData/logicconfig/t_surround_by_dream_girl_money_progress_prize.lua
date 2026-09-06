-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_surround_by_dream_girl_money_progress_prize.lua

module("logicconfig.config.t_surround_by_dream_girl_money_progress_prize", package.seeall)

local title = {
	progress = 4,
	conPath = 6,
	levelDesc = 3,
	moneyPrizePlanId = 1,
	prize = 5,
	level = 2
}
local dataList = {
	{
		1,
		1,
		"一贫如洗",
		0,
		"",
		"goddessshop/board_ns_aoqi_01"
	},
	{
		1,
		2,
		"捉襟见肘",
		2000,
		"4:112:10",
		"goddessshop/board_ns_aoqi_01"
	},
	{
		1,
		3,
		"自给自足",
		10000,
		"4:30006:50",
		"goddessshop/board_ns_aoqi_02"
	},
	{
		1,
		4,
		"衣食无忧",
		50000,
		"4:510022:5",
		"goddessshop/board_ns_aoqi_02"
	},
	{
		1,
		5,
		"丰衣足食",
		100000,
		"4:36:10",
		"goddessshop/board_ns_aoqi_03"
	},
	{
		1,
		6,
		"金玉满堂",
		500000,
		"4:30006:50",
		"goddessshop/board_ns_aoqi_03"
	},
	{
		1,
		7,
		"腰缠万贯",
		1000000,
		"4:90091:1",
		"goddessshop/board_ns_aoqi_04"
	},
	{
		1,
		8,
		"富可敌国",
		2000000,
		"2:221:1",
		"goddessshop/board_ns_aoqi_04"
	}
}
local t_surround_by_dream_girl_money_progress_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_surround_by_dream_girl_money_progress_prize.dataList = dataList

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

return t_surround_by_dream_girl_money_progress_prize
