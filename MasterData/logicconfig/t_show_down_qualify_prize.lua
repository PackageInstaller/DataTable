-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_down_qualify_prize.lua

module("logicconfig.config.t_show_down_qualify_prize", package.seeall)

local title = {
	winPrizeCount = 3,
	losePrizeCount = 4,
	times = 2,
	prizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		200,
		100
	},
	{
		1,
		2,
		200,
		100
	},
	{
		1,
		3,
		200,
		100
	},
	{
		1,
		4,
		200,
		100
	},
	{
		1,
		5,
		200,
		100
	},
	{
		1,
		6,
		200,
		100
	},
	{
		1,
		7,
		200,
		100
	},
	{
		1,
		8,
		200,
		100
	},
	{
		1,
		9,
		200,
		100
	},
	{
		1,
		10,
		200,
		100
	}
}
local t_show_down_qualify_prize = {
	{
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
}

t_show_down_qualify_prize.dataList = dataList

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

return t_show_down_qualify_prize
