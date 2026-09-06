-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_price_break_discount_tab.lua

module("logicconfig.config.t_price_break_discount_tab", package.seeall)

local title = {
	tag = 4,
	name = 3,
	itemPlan = 1,
	tabId = 2
}
local dataList = {
	{
		1,
		1,
		"精灵",
		"热"
	},
	{
		1,
		2,
		"皮肤",
		"热"
	},
	{
		1,
		3,
		"特惠礼包",
		"热"
	},
	{
		1,
		4,
		"头像",
		"热"
	},
	{
		2,
		1,
		"皮肤",
		"热"
	},
	{
		2,
		2,
		"精灵",
		"热"
	},
	{
		2,
		3,
		"特惠礼包",
		"热"
	},
	{
		2,
		4,
		"头像",
		"热"
	},
	{
		3,
		1,
		"皮肤",
		"热"
	},
	{
		3,
		2,
		"精灵",
		"热"
	},
	{
		3,
		3,
		"特惠礼包",
		"热"
	},
	{
		3,
		4,
		"头像",
		"热"
	},
	{
		4,
		1,
		"女神衣柜",
		"热"
	},
	{
		5,
		1,
		"皮肤",
		"热"
	},
	{
		5,
		2,
		"精灵",
		"热"
	},
	{
		5,
		3,
		"特惠礼包",
		"热"
	},
	{
		5,
		4,
		"头像",
		"热"
	},
	{
		6,
		1,
		"皮肤",
		"热"
	},
	{
		6,
		2,
		"精灵",
		"热"
	},
	{
		6,
		3,
		"特惠礼包",
		"热"
	},
	{
		6,
		4,
		"头像",
		"热"
	},
	{
		7,
		1,
		"女皮",
		"热"
	}
}
local t_price_break_discount_tab = {
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
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
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
	},
	{
		dataList[22]
	}
}

t_price_break_discount_tab.dataList = dataList

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

return t_price_break_discount_tab
