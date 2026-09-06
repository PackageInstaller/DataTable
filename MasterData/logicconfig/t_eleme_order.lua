-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eleme_order.lua

module("logicconfig.config.t_eleme_order", package.seeall)

local title = {
	sceneId = 3,
	orderId = 2,
	likeNum = 6,
	creepsMasterId = 4,
	activityId = 1,
	desc = 5
}
local dataList = {
	{
		332001,
		1,
		106,
		1001,
		"不要辣酱，要很多甜酸酱",
		3
	},
	{
		332001,
		2,
		106,
		1002,
		"饮料麻烦去冰",
		3
	},
	{
		332001,
		3,
		106,
		1003,
		"外卖直接放门口",
		3
	},
	{
		332001,
		4,
		106,
		1004,
		"来的路上帮我带点奥奇城特产",
		3
	},
	{
		332001,
		5,
		106,
		1005,
		"送达不要敲门！不要敲门！",
		3
	},
	{
		332001,
		6,
		106,
		1006,
		"薯条麻烦装的满满满满的！",
		3
	},
	{
		332001,
		7,
		106,
		1007,
		"上次漏送了鸡块这次补送下",
		3
	},
	{
		332001,
		8,
		106,
		1008,
		"骑手路上小心，祝你新年快乐",
		4
	},
	{
		332001,
		9,
		106,
		1009,
		"这单请派给帅哥谢谢",
		4
	},
	{
		332001,
		10,
		106,
		1010,
		"内有守门精灵，胆子小的别接",
		4
	},
	{
		332001,
		11,
		106,
		1011,
		"奥奇铁粉，能随餐送周边吗",
		4
	},
	{
		332001,
		12,
		106,
		1012,
		"不要辣酱，要很多甜酸酱",
		4
	},
	{
		332001,
		13,
		106,
		1013,
		"饮料麻烦去冰",
		4
	},
	{
		332001,
		14,
		106,
		1014,
		"外卖直接放门口",
		4
	},
	{
		332001,
		15,
		106,
		1015,
		"来的路上帮我带点奥奇城特产",
		4
	},
	{
		332001,
		16,
		106,
		1016,
		"送达不要敲门！不要敲门！",
		4
	},
	{
		332001,
		17,
		106,
		1017,
		"薯条要现炸的！",
		4
	},
	{
		332001,
		18,
		106,
		1018,
		"上次漏送了鸡块这次补送下",
		4
	},
	{
		332001,
		19,
		106,
		1019,
		"骑手路上小心，祝你新年快乐",
		4
	},
	{
		332001,
		20,
		106,
		1020,
		"这单请派给帅哥谢谢",
		4
	},
	{
		332001,
		21,
		106,
		1021,
		"内有守门精灵，胆子小的别接",
		5
	},
	{
		332001,
		22,
		106,
		1022,
		"奥奇铁粉，能随餐送周边吗",
		5
	},
	{
		332001,
		23,
		106,
		1023,
		"在打游戏，放门口就行",
		5
	},
	{
		332001,
		24,
		106,
		1024,
		"来的路上帮我带点奥奇城特产",
		5
	},
	{
		332001,
		25,
		106,
		1025,
		"骑手快来我要饿疯了！！！",
		5
	}
}
local t_eleme_order = {
	[332001] = {
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
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25]
	}
}

t_eleme_order.dataList = dataList

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

return t_eleme_order
