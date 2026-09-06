-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jigsaw_exchange_group_prize.lua

module("logicconfig.config.t_jigsaw_exchange_group_prize", package.seeall)

local title = {
	groupPrizePlanId = 1,
	prize = 3,
	groupPrizeId = 2
}
local dataList = {
	{
		101,
		1,
		"4:36:1"
	},
	{
		101,
		2,
		"4:36:1"
	},
	{
		101,
		3,
		"4:36:1"
	},
	{
		101,
		4,
		"4:111:1"
	},
	{
		101,
		5,
		"4:111:1"
	},
	{
		101,
		6,
		"4:111:1"
	},
	{
		101,
		7,
		"4:111:1"
	},
	{
		101,
		8,
		"4:111:1"
	},
	{
		201,
		1,
		"4:111:5"
	},
	{
		201,
		2,
		"4:111:5"
	},
	{
		201,
		3,
		"4:12102:5"
	},
	{
		201,
		4,
		"8:1:500000"
	},
	{
		201,
		5,
		"8:1:500000"
	},
	{
		201,
		6,
		"8:25:600"
	},
	{
		201,
		7,
		"8:25:600"
	},
	{
		201,
		8,
		"10:17087:1000"
	}
}
local t_jigsaw_exchange_group_prize = {
	[101] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[201] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_jigsaw_exchange_group_prize.dataList = dataList

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

return t_jigsaw_exchange_group_prize
