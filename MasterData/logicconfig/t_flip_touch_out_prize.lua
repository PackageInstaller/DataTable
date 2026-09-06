-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_flip_touch_out_prize.lua

module("logicconfig.config.t_flip_touch_out_prize", package.seeall)

local title = {
	planId = 1,
	name = 3,
	raceId = 6,
	id = 2,
	prize = 4,
	energy = 5
}
local dataList = {
	{
		1,
		1,
		"哆啦梦梦",
		"104:2:99",
		150,
		10338
	},
	{
		1,
		2,
		"热血梦梦",
		"4:30003:9",
		300,
		10342
	},
	{
		1,
		3,
		"暗黑梦梦",
		"4:31:2",
		350,
		10339
	},
	{
		1,
		4,
		"炼金梦梦",
		"4:503:9",
		450,
		10341
	},
	{
		1,
		5,
		"爱心梦梦",
		"4:31:3",
		550,
		10343
	},
	{
		2,
		1,
		"哆啦梦梦",
		"8:1:20000",
		100,
		10338
	},
	{
		2,
		2,
		"热血梦梦",
		"4:25:1",
		200,
		10342
	},
	{
		2,
		3,
		"炼金梦梦",
		"4:901:1",
		300,
		10341
	},
	{
		2,
		4,
		"暗黑梦梦",
		"4:502:2",
		400,
		10339
	},
	{
		2,
		5,
		"爱心梦梦",
		"4:32:2",
		500,
		10343
	},
	{
		3,
		1,
		"命祈之舞•秩序神女",
		"8:1:800000",
		100,
		1100202
	},
	{
		3,
		2,
		"恣意墨心·昧",
		"4:30003:40",
		150,
		1601101
	},
	{
		3,
		3,
		"解神心源·白",
		"8:1:800000",
		200,
		1600102
	},
	{
		3,
		4,
		"不夜战甲·龙尊圣女",
		"4:30003:40",
		200,
		1700201
	},
	{
		4,
		6,
		"命祈之舞•秩序神女",
		"8:1:800000",
		100,
		1100202
	},
	{
		4,
		7,
		"恣意墨心·昧",
		"4:30003:40",
		150,
		1601101
	},
	{
		4,
		8,
		"解神心源·白",
		"8:1:800000",
		200,
		1600102
	},
	{
		4,
		9,
		"不夜战甲·龙尊圣女",
		"4:30003:40",
		200,
		1700201
	},
	{
		5,
		1,
		"命祈之舞•秩序神女",
		"8:1:800000",
		100,
		1100202
	},
	{
		5,
		2,
		"恣意墨心·昧",
		"4:30003:40",
		150,
		1601101
	},
	{
		5,
		3,
		"解神心源·白",
		"8:1:800000",
		200,
		1600102
	},
	{
		5,
		4,
		"不夜战甲·龙尊圣女",
		"4:30003:40",
		200,
		1700201
	},
	{
		6,
		1,
		"极耀·时空圣龙",
		"100:10325:1:1",
		100,
		10325
	},
	{
		6,
		2,
		"湮灭·时空圣龙",
		"100:10320:1:1",
		150,
		10320
	},
	{
		6,
		3,
		"无限时空·龙尊",
		"4:36:20",
		200,
		15006
	},
	{
		6,
		4,
		"恒古王者·时空龙尊",
		"4:90097:1",
		200,
		14024
	},
	{
		7,
		1,
		"命祈之舞•秩序神女",
		"8:1:800000",
		100,
		1100202
	},
	{
		7,
		2,
		"恣意墨心·昧",
		"4:30003:40",
		150,
		1601101
	},
	{
		7,
		3,
		"解神心源·白",
		"8:1:800000",
		200,
		1600102
	},
	{
		7,
		4,
		"不夜战甲·龙尊圣女",
		"4:30003:40",
		200,
		1700201
	}
}
local t_flip_touch_out_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	},
	{
		[6] = dataList[15],
		[7] = dataList[16],
		[8] = dataList[17],
		[9] = dataList[18]
	},
	{
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22]
	},
	{
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26]
	},
	{
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	}
}

t_flip_touch_out_prize.dataList = dataList

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

return t_flip_touch_out_prize
