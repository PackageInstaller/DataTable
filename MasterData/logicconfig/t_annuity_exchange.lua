-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annuity_exchange.lua

module("logicconfig.config.t_annuity_exchange", package.seeall)

local title = {
	cost = 5,
	prize = 6,
	needActiveAnnuity = 8,
	giftId = 2,
	timesLimit = 3,
	prizeDescs = 7,
	activityId = 1,
	startTime = 4
}
local dataList = {
	{
		8005,
		1,
		1,
		nil,
		"204:100005:980",
		"100:18001:1:1",
		{
			"1级凡尔维斯"
		},
		true
	},
	{
		8005,
		2,
		1,
		"2025-01-01T05:00:00",
		"204:100006:1980",
		"100:18001:100:1#4:84419:6#19:16:1#4:510244:2",
		{
			"满级凡尔维斯",
			"满觉",
			"气泡框",
			"神器*2"
		},
		false
	},
	{
		8006,
		1,
		1,
		nil,
		"204:100005:980",
		"100:18001:1:1",
		{
			"1级凡尔维斯"
		},
		true
	},
	{
		8006,
		2,
		1,
		"2026-01-01T05:00:00",
		"204:100006:1980",
		"100:18001:100:1#4:84419:6#19:16:1#4:510244:2",
		{
			"满级凡尔维斯",
			"满觉",
			"气泡框",
			"神器*2"
		},
		false
	},
	{
		8006,
		3,
		1,
		nil,
		"204:100010:980",
		"100:18021:1:1",
		{
			"1级斐希司"
		},
		true
	},
	{
		8006,
		4,
		1,
		"2026-01-01T05:00:00",
		"204:100011:1980",
		"100:18021:100:1#4:84489:6#19:21:1#4:510400:2",
		{
			"满级斐希司",
			"满觉",
			"气泡框",
			"神器*2"
		},
		false
	}
}
local t_annuity_exchange = {
	[8005] = {
		dataList[1],
		dataList[2]
	},
	[8006] = {
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_annuity_exchange.dataList = dataList

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

return t_annuity_exchange
