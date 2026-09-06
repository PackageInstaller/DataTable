-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_weekly_big_box_pool_prize.lua

module("logicconfig.config.t_weekly_big_box_pool_prize", package.seeall)

local title = {
	poolPrizeType = 2,
	onceDrawMaxNum = 4,
	prize = 3,
	poolPrizeId = 1
}
local dataList = {
	{
		1,
		1,
		"8:1:10000",
		0
	},
	{
		2,
		1,
		"4:2:20",
		0
	},
	{
		3,
		1,
		"4:30001:20",
		0
	},
	{
		4,
		1,
		"4:501:40",
		0
	},
	{
		5,
		1,
		"4:901:500",
		0
	},
	{
		6,
		1,
		"4:30004:20",
		0
	},
	{
		7,
		2,
		"4:90215:1",
		2
	},
	{
		8,
		2,
		"4:71003:1",
		1
	},
	{
		9,
		2,
		"4:36:1",
		2
	},
	{
		10,
		2,
		"4:112:1",
		2
	}
}
local t_weekly_big_box_pool_prize = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10]
}

t_weekly_big_box_pool_prize.dataList = dataList

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

return t_weekly_big_box_pool_prize
