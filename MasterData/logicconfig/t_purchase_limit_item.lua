-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_purchase_limit_item.lua

module("logicconfig.config.t_purchase_limit_item", package.seeall)

local title = {
	spaceCountLimit = 8,
	content = 3,
	itemId = 2,
	personCountLimit = 9,
	salePrice = 5,
	giftName = 6,
	originalPrice = 4,
	activityId = 1,
	tagName = 7
}
local dataList = {
	{
		298001,
		1,
		"4:510211:100",
		"204:298001:1440",
		"204:298001:580",
		"神曜材料",
		"热",
		99999,
		1
	},
	{
		298001,
		2,
		"4:91104:1",
		"204:298002:488",
		"204:298002:388",
		"皮肤宝箱",
		"8折",
		99999,
		1
	},
	{
		298001,
		3,
		"4:510211:100#4:91104:1#4:510216:8",
		"204:298005:1612",
		"204:298005:1088",
		"超值套餐一",
		"限量抢购",
		2000,
		1
	},
	{
		298001,
		4,
		"4:510211:100#4:91104:1",
		"204:298003:1068",
		"204:298003:788",
		"超值套餐二",
		"7.4折",
		99999,
		1
	},
	{
		298001,
		5,
		"4:510211:100#4:510216:8",
		"204:298004:1124",
		"204:298004:788",
		"超值套餐三",
		"限量抢购",
		1500,
		1
	}
}
local t_purchase_limit_item = {
	[298001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_purchase_limit_item.dataList = dataList

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

return t_purchase_limit_item
