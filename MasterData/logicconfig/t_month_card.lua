-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_month_card.lua

module("logicconfig.config.t_month_card", package.seeall)

local title = {
	day = 7,
	cardName = 2,
	payGoodsId = 3,
	faceId = 11,
	offlineTime = 10,
	onceGain = 4,
	cardId = 1,
	extraGain = 5,
	dailyGain = 6,
	repeatBuyDay = 8,
	version = 9
}
local dataList = {
	{
		1,
		"月卡",
		"card_30",
		"4:36:3#104:2:300",
		"14:3:1",
		"104:2:100#60:1:240",
		30,
		90,
		1,
		"2022-08-05T05:00:00",
		0
	},
	{
		2,
		"终身卡",
		"card_88",
		"4:1006:1#2:28:1",
		"18:410:1#4:90145:2",
		"104:2:100#4:10:88",
		99999,
		0,
		0,
		nil,
		0
	},
	{
		3,
		"资源月卡",
		"card_30",
		"4:36:3#104:2:300",
		"13:19:1",
		"4:11:100#4:12:100#4:13:100#4:14:100",
		30,
		90,
		1,
		"2022-08-05T05:00:00",
		0
	},
	{
		4,
		"冒险卡",
		"rmb_12",
		"4:36:3",
		"",
		"60:1:200",
		7,
		1,
		0,
		"2021-10-22T05:00:00",
		0
	},
	{
		5,
		"萌新卡",
		"rmb_12",
		"4:36:3",
		"",
		"104:2:100",
		7,
		1,
		0,
		"2021-10-22T05:00:00",
		0
	},
	{
		6,
		"月卡",
		"card_30",
		"4:90145:1#104:2:3000",
		"14:3:1",
		"204:2:10#9:1300002:1",
		30,
		120,
		1,
		"2024-09-27T05:00:00",
		0
	},
	{
		7,
		"资源卡",
		"rmb_18",
		"4:36:10#4:112:10",
		"13:19:1",
		"4:90274:400#4:90275:1",
		30,
		30,
		1,
		"2024-09-27T05:00:00",
		0
	},
	{
		8,
		"回归月卡",
		"rmb_18",
		"4:90145:1#104:2:3000",
		"14:3:1",
		"204:2:10#9:1300002:1",
		30,
		0,
		1,
		"2024-09-27T05:00:00",
		0
	},
	{
		9,
		"全新月卡",
		"card_30",
		"4:510257:1#104:2:3000",
		"14:3:1",
		"204:2:10#9:1300030:1",
		30,
		30,
		1,
		nil,
		0
	},
	{
		10,
		"全新资源卡",
		"rmb_18",
		"4:36:10#4:112:10",
		"13:19:1",
		"4:90274:400#9:1300013:1",
		30,
		30,
		1,
		nil,
		0
	},
	{
		11,
		"新回归月卡",
		"rmb_18",
		"4:510257:1#104:2:3000",
		"14:3:1",
		"204:2:10#9:1300030:1",
		30,
		0,
		1,
		nil,
		0
	},
	{
		12,
		"暴击版月卡",
		"card_30",
		"4:510257:1#104:2:3000",
		"14:3:1",
		"9:1300019:1#9:1300030:1",
		30,
		30,
		1,
		"2026-08-21T05:00:00",
		0
	}
}
local t_month_card = {
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
	dataList[11],
	dataList[12]
}

t_month_card.dataList = dataList

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

return t_month_card
