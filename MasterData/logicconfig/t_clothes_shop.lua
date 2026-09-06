-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_clothes_shop.lua

module("logicconfig.config.t_clothes_shop", package.seeall)

local title = {
	id = 1,
	goodsId = 6,
	buyType = 5,
	days = 4,
	clothesId = 3,
	desc = 2
}
local dataList = {
	{
		1,
		"帽子",
		1,
		0,
		"pay",
		"rmb_6"
	},
	{
		2,
		"上衣",
		2,
		1,
		"item",
		"8:14:1"
	},
	{
		3,
		"裤子",
		3,
		0,
		"item",
		"8:14:2"
	},
	{
		4,
		"连衣裙",
		4,
		1,
		"item",
		"8:14:1"
	},
	{
		5,
		"鞋子",
		5,
		0,
		"item",
		"8:14:2"
	},
	{
		6,
		"翅膀",
		6,
		1,
		"item",
		"8:14:1"
	},
	{
		7,
		"刀",
		7,
		1,
		"item",
		"8:14:2"
	},
	{
		8,
		"帽子",
		8,
		0,
		"pay",
		"rmb_6"
	},
	{
		9,
		"上衣",
		9,
		1,
		"item",
		"8:14:1"
	},
	{
		10,
		"裤子",
		10,
		0,
		"item",
		"8:14:2"
	},
	{
		11,
		"连衣裙",
		11,
		1,
		"item",
		"8:14:1"
	},
	{
		12,
		"鞋子",
		12,
		0,
		"item",
		"8:14:2"
	},
	{
		13,
		"翅膀",
		13,
		1,
		"item",
		"8:14:1"
	},
	{
		14,
		"刀",
		14,
		1,
		"item",
		"8:14:2"
	},
	{
		15,
		"帽子",
		15,
		0,
		"pay",
		"rmb_6"
	},
	{
		16,
		"上衣",
		16,
		1,
		"item",
		"8:14:1"
	},
	{
		17,
		"裤子",
		17,
		0,
		"item",
		"8:14:2"
	},
	{
		18,
		"连衣裙",
		18,
		1,
		"item",
		"8:14:1"
	},
	{
		19,
		"鞋子",
		19,
		0,
		"item",
		"8:14:2"
	},
	{
		20,
		"翅膀",
		20,
		1,
		"item",
		"8:14:1"
	},
	{
		21,
		"刀",
		21,
		1,
		"item",
		"8:14:2"
	}
}
local t_clothes_shop = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21]
}

t_clothes_shop.dataList = dataList

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

return t_clothes_shop
