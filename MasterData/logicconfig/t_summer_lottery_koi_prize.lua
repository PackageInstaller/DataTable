-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summer_lottery_koi_prize.lua

module("logicconfig.config.t_summer_lottery_koi_prize", package.seeall)

local title = {
	koiPrizeId = 2,
	name = 4,
	count = 5,
	koiPrizePlanId = 1,
	prize = 3
}
local dataList = {
	{
		1,
		1,
		"104:2:100000",
		"十万钻石",
		100
	},
	{
		2,
		1,
		"104:2:100000",
		"十万钻石",
		100
	},
	{
		2,
		2,
		"9:80006:100",
		"随机红色灵纹*100",
		100
	},
	{
		2,
		3,
		"4:41004:10",
		"随机橙色星神*10",
		100
	},
	{
		2,
		4,
		"4:40008:20",
		"随机橙色装备*20",
		200
	},
	{
		3,
		1,
		"104:2:100000",
		"十万钻石",
		0
	},
	{
		3,
		2,
		"9:80006:100",
		"随机红色灵纹*100",
		0
	},
	{
		3,
		3,
		"4:41004:10",
		"随机橙色星神*10",
		0
	},
	{
		3,
		4,
		"8:1:6",
		"金币*6",
		0
	},
	{
		4,
		1,
		"8:1:6",
		"金币*6",
		0
	},
	{
		4,
		2,
		"8:1:6",
		"金币*6",
		0
	},
	{
		4,
		3,
		"8:1:6",
		"金币*6",
		0
	},
	{
		4,
		4,
		"8:1:6",
		"金币*6",
		0
	},
	{
		5,
		1,
		"8:1:6",
		"金币*6",
		0
	},
	{
		5,
		2,
		"8:1:6",
		"金币*6",
		0
	},
	{
		5,
		3,
		"8:1:6",
		"金币*6",
		0
	},
	{
		5,
		4,
		"8:1:6",
		"金币*6",
		0
	},
	{
		6,
		1,
		"8:1:6",
		"金币*6",
		0
	},
	{
		6,
		2,
		"8:1:6",
		"金币*6",
		0
	},
	{
		6,
		3,
		"8:1:6",
		"金币*6",
		0
	},
	{
		6,
		4,
		"8:1:6",
		"金币*6",
		0
	}
}
local t_summer_lottery_koi_prize = {
	{
		dataList[1]
	},
	{
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13]
	},
	{
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17]
	},
	{
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21]
	}
}

t_summer_lottery_koi_prize.dataList = dataList

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

return t_summer_lottery_koi_prize
