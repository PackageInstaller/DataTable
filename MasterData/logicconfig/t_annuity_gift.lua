-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annuity_gift.lua

module("logicconfig.config.t_annuity_gift", package.seeall)

local title = {
	progressGain = 4,
	prize = 10,
	isInstallment = 11,
	payGoodsId = 5,
	timesLimit = 3,
	discountEndTime = 8,
	giftStartTime = 9,
	discountPayGoodsId = 6,
	giftId = 2,
	activityId = 1,
	discountStartTime = 7
}
local dataList = {
	{
		8002,
		1,
		3,
		600,
		"rmb_6",
		"rmb_6",
		nil,
		nil,
		"2021-12-31T05:00:00",
		"",
		true
	},
	{
		8002,
		2,
		5,
		1800,
		"rmb_18",
		"rmb_18",
		nil,
		nil,
		"2021-12-31T05:00:00",
		"",
		true
	},
	{
		8002,
		3,
		3,
		3000,
		"rmb_30",
		"rmb_30",
		nil,
		nil,
		"2021-12-31T05:00:00",
		"",
		true
	},
	{
		8002,
		4,
		1,
		19800,
		"rmb_198",
		"rmb_168",
		"2021-12-24T05:00:00",
		"2021-12-31T05:00:00",
		"2021-12-24T05:00:00",
		"",
		false
	},
	{
		8003,
		1,
		1,
		1800,
		"rmb_18",
		"rmb_18",
		nil,
		nil,
		"2022-12-23T05:00:00",
		"",
		true
	},
	{
		8003,
		2,
		4,
		4500,
		"rmb_45",
		"rmb_45",
		nil,
		nil,
		"2022-12-23T05:00:00",
		"",
		true
	},
	{
		8003,
		3,
		1,
		19800,
		"rmb_198",
		"rmb_198",
		nil,
		nil,
		"2022-12-23T05:00:00",
		"",
		false
	},
	{
		8003,
		4,
		1,
		32800,
		"rmb_328",
		"rmb_328",
		nil,
		nil,
		"2022-12-23T05:00:00",
		"4:90161:4#4:90189:1#4:503:1020#8:1:4400000#4:90204:1",
		false
	}
}
local t_annuity_gift = {
	[8002] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[8003] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_annuity_gift.dataList = dataList

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

return t_annuity_gift
