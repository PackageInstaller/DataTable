-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sell_shop_item.lua

module("logicconfig.config.t_sell_shop_item", package.seeall)

local title = {
	bgImg = 3,
	shopItemId = 2,
	activityId = 1
}
local dataList = {
	{
		62001,
		14001,
		"board_pfhd_05"
	},
	{
		63001,
		15001,
		"board_pfhd_05"
	},
	{
		62002,
		14002,
		"board_pfhd_05"
	},
	{
		63002,
		15002,
		"board_pfhd_05"
	},
	{
		62003,
		11029,
		"board_pfhd_05"
	},
	{
		63003,
		11030,
		"board_pfhd_05"
	}
}
local t_sell_shop_item = {
	[62001] = dataList[1],
	[63001] = dataList[2],
	[62002] = dataList[3],
	[63002] = dataList[4],
	[62003] = dataList[5],
	[63003] = dataList[6]
}

t_sell_shop_item.dataList = dataList

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

return t_sell_shop_item
