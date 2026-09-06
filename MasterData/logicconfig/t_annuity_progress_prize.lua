-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annuity_progress_prize.lua

module("logicconfig.config.t_annuity_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	activityId = 1,
	gainPrizeStartTime = 5,
	showTip = 6,
	progressReq = 3,
	prize = 4
}
local dataList = {
	{
		8002,
		1,
		600,
		"4:36:5",
		"2021-12-24T05:00:00",
		"神唤券*5"
	},
	{
		8002,
		2,
		1200,
		"4:36:5",
		"2021-12-24T05:00:00",
		"神唤券*5"
	},
	{
		8002,
		3,
		3000,
		"4:36:5",
		"2021-12-24T05:00:00",
		"神唤券*5"
	},
	{
		8002,
		4,
		6000,
		"104:2:1000",
		"2021-12-24T05:00:00",
		"钻石*1000"
	},
	{
		8002,
		5,
		19800,
		"9:1031:1",
		"2021-12-31T05:00:00",
		"满级满觉年费礼包*1"
	},
	{
		8003,
		1,
		1800,
		"4:90346:1",
		"2022-12-23T05:00:00",
		"离阳时装抵扣券"
	},
	{
		8003,
		2,
		9800,
		"4:90343:1",
		"2022-12-23T05:00:00",
		"神唤/召唤"
	},
	{
		8003,
		3,
		16800,
		"4:90344:1",
		"2022-12-23T05:00:00",
		"神唤/钻石"
	},
	{
		8003,
		4,
		19800,
		"4:90345:1",
		"2022-12-30T05:00:00",
		"满级满觉敖九礼包"
	},
	{
		8004,
		1,
		1800,
		"4:90424:1",
		"2024-01-01T05:00:00",
		"年费时装抵扣券"
	},
	{
		8004,
		2,
		9800,
		"4:90343:1",
		"2024-01-01T05:00:00",
		"神唤/召唤"
	},
	{
		8004,
		3,
		16800,
		"4:90344:1",
		"2024-01-01T05:00:00",
		"神唤/钻石"
	},
	{
		8004,
		4,
		19800,
		"4:90425:1",
		"2024-01-01T05:00:00",
		"满级满觉礼包"
	},
	{
		8005,
		1,
		1800,
		"4:510404:1",
		"2025-01-01T05:00:00",
		"年费时装抵扣券"
	},
	{
		8005,
		2,
		9800,
		"4:90343:1",
		"2025-01-01T05:00:00",
		"神唤/召唤"
	},
	{
		8005,
		3,
		16800,
		"4:90344:1",
		"2025-01-01T05:00:00",
		"神唤/钻石"
	},
	{
		8005,
		4,
		19800,
		"4:510405:1",
		"2025-01-01T05:00:00",
		"满级满觉礼包"
	},
	{
		8006,
		1,
		19800,
		"100:18031:100:1#4:84558:6#4:410001:1#4:510663:1#19:35:1#14:453:1#30:19:1#13:502:1#4:36:20#104:2:1000",
		"2026-01-01T05:00:00",
		"满级满觉礼包"
	}
}
local t_annuity_progress_prize = {
	[8002] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[8003] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[8004] = {
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13]
	},
	[8005] = {
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17]
	},
	[8006] = {
		dataList[18]
	}
}

t_annuity_progress_prize.dataList = dataList

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

return t_annuity_progress_prize
