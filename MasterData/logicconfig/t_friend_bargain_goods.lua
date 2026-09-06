-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_friend_bargain_goods.lua

module("logicconfig.config.t_friend_bargain_goods", package.seeall)

local title = {
	goodsId = 2,
	dec = 5,
	goods = 7,
	endTime = 4,
	goodsPlanId = 1,
	decNum = 6,
	startTime = 3
}
local dataList = {
	{
		1,
		1,
		"2023-03-31T05:00:00",
		"2023-04-07T05:00:00",
		"204:190003",
		356,
		"4:84374:2"
	},
	{
		1,
		2,
		"2023-04-07T05:00:00",
		"2023-04-14T05:00:00",
		"204:190004",
		356,
		"4:84374:2"
	},
	{
		1,
		3,
		"2023-04-14T05:00:00",
		"2023-04-21T05:00:00",
		"204:190005",
		356,
		"4:84374:2"
	}
}
local t_friend_bargain_goods = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_friend_bargain_goods.dataList = dataList

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

return t_friend_bargain_goods
