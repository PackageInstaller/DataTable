-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annuity_new_gift.lua

module("logicconfig.config.t_annuity_new_gift", package.seeall)

local title = {
	progressGain = 4,
	preorderPrize = 10,
	preorderTimesLimit = 11,
	payGoodsId = 5,
	timesLimit = 3,
	unlockConditions = 12,
	giftStartTime = 6,
	preorderStartTime = 8,
	isActiveAnnuityCanBuy = 7,
	prize = 13,
	preorderEndTime = 9,
	giftId = 2,
	isInstallment = 14,
	activityId = 1
}
local dataList = {
	{
		8004,
		1,
		1,
		1800,
		"rmb_18",
		"2024-01-01T05:00:00",
		false,
		nil,
		nil,
		"",
		0,
		"",
		"",
		true
	},
	{
		8004,
		2,
		3,
		3000,
		"rmb_30",
		"2024-01-01T05:00:00",
		false,
		"2023-12-22T05:00:00",
		"2024-01-01T04:59:59",
		"9:1300008:1",
		1,
		"",
		"",
		true
	},
	{
		8004,
		3,
		2,
		4500,
		"rmb_45",
		"2024-01-01T05:00:00",
		false,
		nil,
		nil,
		"",
		0,
		"",
		"",
		true
	},
	{
		8004,
		4,
		1,
		19800,
		"rmb_198",
		"2024-01-01T05:00:00",
		false,
		nil,
		nil,
		"",
		0,
		"not_can_buy#2,1",
		"",
		false
	},
	{
		8004,
		5,
		1,
		16800,
		"rmb_168",
		"2024-01-01T05:00:00",
		false,
		nil,
		nil,
		"",
		0,
		"can_buy#2,1",
		"",
		false
	},
	{
		8004,
		6,
		1,
		0,
		"rmb_128",
		"2024-01-01T05:00:00",
		true,
		nil,
		nil,
		"",
		0,
		"",
		"4:510249:4#4:90269:1#4:503:1020#8:1:4400000#4:90204:1#4:510243:5",
		false
	},
	{
		8005,
		1,
		1,
		1800,
		"rmb_18",
		"2025-01-01T05:00:00",
		false,
		nil,
		nil,
		"",
		0,
		"",
		"",
		true
	},
	{
		8005,
		2,
		3,
		3000,
		"rmb_30",
		"2025-01-01T05:00:00",
		false,
		"2024-12-20T05:00:00",
		"2025-01-01T04:59:59",
		"4:510406:1",
		1,
		"",
		"",
		true
	},
	{
		8005,
		3,
		2,
		4500,
		"rmb_45",
		"2025-01-01T05:00:00",
		false,
		nil,
		nil,
		"",
		0,
		"",
		"",
		true
	},
	{
		8005,
		4,
		1,
		19800,
		"rmb_198",
		"2025-01-01T05:00:00",
		false,
		nil,
		nil,
		"",
		0,
		"not_can_buy#2,1",
		"",
		false
	},
	{
		8005,
		5,
		1,
		16800,
		"rmb_168",
		"2025-01-01T05:00:00",
		false,
		nil,
		nil,
		"",
		0,
		"can_buy#2,1",
		"",
		false
	},
	{
		8005,
		6,
		1,
		0,
		"rmb_128",
		"2025-01-01T05:00:00",
		true,
		nil,
		nil,
		"",
		0,
		"",
		"4:510249:4#4:90294:1#4:12103:20#4:30006:1000#4:11002:60000#4:503:1020#8:1:4400000#4:90204:1#4:510243:5",
		false
	},
	{
		8006,
		1,
		1,
		1800,
		"rmb_18",
		"2026-01-01T05:00:00",
		false,
		nil,
		nil,
		"",
		0,
		"",
		"",
		true
	},
	{
		8006,
		2,
		3,
		3000,
		"rmb_30",
		"2026-01-01T05:00:00",
		false,
		"2025-12-19T05:00:00",
		"2026-01-01T04:59:59",
		"9:1300032:1",
		1,
		"",
		"",
		true
	},
	{
		8006,
		3,
		2,
		4500,
		"rmb_45",
		"2026-01-01T05:00:00",
		false,
		nil,
		nil,
		"",
		0,
		"",
		"",
		true
	},
	{
		8006,
		4,
		1,
		19800,
		"rmb_198",
		"2026-01-01T05:00:00",
		false,
		nil,
		nil,
		"",
		0,
		"not_can_buy#2,1",
		"",
		false
	},
	{
		8006,
		5,
		1,
		16800,
		"rmb_168",
		"2026-01-01T05:00:00",
		false,
		nil,
		nil,
		"",
		0,
		"can_buy#2,1",
		"",
		false
	},
	{
		8006,
		6,
		1,
		0,
		"rmb_128",
		"2026-01-01T05:00:00",
		true,
		nil,
		nil,
		"",
		0,
		"",
		"4:410001:4#4:510258:4#4:90162:1#4:12103:20#4:30006:1000#4:11002:60000#4:503:1020#8:1:4400000#4:510243:5",
		false
	}
}
local t_annuity_new_gift = {
	[8004] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[8005] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[8006] = {
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_annuity_new_gift.dataList = dataList

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

return t_annuity_new_gift
