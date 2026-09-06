-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_champion_king_knockout_rank_prize.lua

module("logicconfig.config.t_young_champion_king_knockout_rank_prize", package.seeall)

local title = {
	roundId = 3,
	title = 5,
	rank = 4,
	prize = 6,
	rankPrizeId = 2,
	activityId = 1,
	showPrize = 7
}
local dataList = {
	{
		391001,
		1,
		0,
		1,
		"第1名",
		"204:2:6480#2:178:1#14:288:1#1:300048:-1:1#1:500018:-1:1",
		"204:2:6480#2:178:1#14:288:1#1:300048:-1:1#1:500018:-1:1#1004:1390:1#1004:1391:1#1004:1392:1"
	},
	{
		391001,
		2,
		0,
		2,
		"第2名",
		"204:2:3280#2:179:1#14:289:1#1:300049:-1:1#1:500018:-1:1",
		"204:2:3280#2:179:1#14:289:1#1:300049:-1:1#1:500018:-1:1#1004:1390:1#1004:1391:1#1004:1392:1"
	},
	{
		391001,
		3,
		0,
		3,
		"第3名",
		"204:2:1980#2:180:1#14:290:1#1:300050:-1:1#1:500018:-1:1",
		"204:2:1980#2:180:1#14:290:1#1:300050:-1:1#1:500018:-1:1#1004:1390:1#1004:1391:1#1004:1392:1"
	},
	{
		391001,
		4,
		0,
		4,
		"第4名",
		"204:2:980#2:181:1#14:291:1#1:500018:-1:1",
		"204:2:980#2:181:1#14:291:1#1:500018:-1:1#1004:1390:1#1004:1391:1#1004:1392:1"
	},
	{
		391001,
		5,
		7,
		8,
		"第5~8名",
		"8:25:3600#8:14:168#4:70003:2#14:292:1",
		"8:25:3600#8:14:168#4:70003:2#14:292:1#1004:1390:1#1004:1392:1"
	},
	{
		391001,
		6,
		6,
		16,
		"第9~16名",
		"8:25:3000#8:14:148#4:70003:2#14:292:1",
		"8:25:3000#8:14:148#4:70003:2#14:292:1#1004:1390:1#1004:1392:1"
	},
	{
		391001,
		7,
		5,
		32,
		"第17~32名",
		"8:25:2400#8:14:128#4:70003:2#14:292:1",
		"8:25:2400#8:14:128#4:70003:2#14:292:1"
	},
	{
		391001,
		8,
		4,
		64,
		"第33~64名",
		"8:25:1800#8:14:98#4:70003:1#14:292:1",
		"8:25:1800#8:14:98#4:70003:1#14:292:1"
	},
	{
		391001,
		9,
		3,
		128,
		"第65~128名",
		"8:25:1200#8:14:68#4:70003:1#14:292:1",
		"8:25:1200#8:14:68#4:70003:1#14:292:1"
	}
}
local t_young_champion_king_knockout_rank_prize = {
	[391001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_young_champion_king_knockout_rank_prize.dataList = dataList

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

return t_young_champion_king_knockout_rank_prize
