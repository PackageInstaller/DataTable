-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_carve_up_diamon_lottery_big_pool.lua

module("logicconfig.config.t_carve_up_diamon_lottery_big_pool", package.seeall)

local title = {
	prizeId = 2,
	personalLimit = 5,
	globalDailyLimit = 6,
	prizeType = 3,
	isBigPrize = 7,
	materialParam = 4,
	planId = 1,
	icon = 8
}
local dataList = {
	{
		1,
		1,
		3,
		"104:2:99",
		0,
		0,
		false,
		"board_gfzs_11"
	},
	{
		1,
		2,
		3,
		"104:2:3999",
		1,
		1,
		true,
		"board_gfzs_10"
	},
	{
		1,
		3,
		3,
		"104:2:999",
		10,
		0,
		false,
		"board_gfzs_09"
	},
	{
		1,
		4,
		2,
		"10:21004:999",
		0,
		0,
		false,
		"board_gfzs_08"
	},
	{
		2,
		1,
		3,
		"104:2:99",
		0,
		0,
		false,
		"board_gfzs_11"
	},
	{
		2,
		2,
		3,
		"100:10143:1:1",
		1,
		10,
		false,
		"board_gfzs_15"
	},
	{
		2,
		3,
		3,
		"100:10142:1:1",
		1,
		10,
		false,
		"board_gfzs_16"
	},
	{
		2,
		4,
		3,
		"100:10144:1:1",
		1,
		0,
		false,
		"board_gfzs_17"
	}
}
local t_carve_up_diamon_lottery_big_pool = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_carve_up_diamon_lottery_big_pool.dataList = dataList

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

return t_carve_up_diamon_lottery_big_pool
