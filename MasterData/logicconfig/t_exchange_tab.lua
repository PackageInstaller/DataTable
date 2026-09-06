-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_exchange_tab.lua

module("logicconfig.config.t_exchange_tab", package.seeall)

local title = {
	cost = 7,
	name = 2,
	cycle = 3,
	conditionHandler = 5,
	openActivity = 10,
	tips = 9,
	openActivityType = 11,
	hideRefresh = 12,
	conditionParams = 6,
	funcId = 4,
	id = 1,
	resetProgram = 8
}
local dataList = {
	{
		1,
		"家族",
		"weekly",
		60,
		"",
		nil,
		"104:2#8:1#8:5",
		1,
		"<color=#c54949>每周五</color>凌晨5点更新，每轮刷新中，所有商品均<color=#c54949>限购1次</color>",
		0,
		0,
		0
	},
	{
		2,
		"竞技场",
		"weekly",
		19,
		"",
		nil,
		"104:2#8:1#8:3",
		2,
		"<color=#c54949>每周五</color>凌晨5点更新，每轮刷新中，所有商品均<color=#c54949>限购1次</color>",
		0,
		0,
		0
	},
	{
		7,
		"神秘币商店",
		"weekly",
		52,
		"",
		nil,
		"104:2#8:1#8:10#8:22",
		7,
		"<color=#c54949>每周五</color>凌晨5点更新，每轮刷新中，所有商品均<color=#c54949>限购1次</color>",
		0,
		0,
		0
	},
	{
		8,
		"高级竞技场",
		"weekly",
		171,
		"",
		nil,
		"104:2#8:1#8:16",
		8,
		"<color=#c54949>每周五</color>凌晨5点更新，每轮刷新中，所有商品均<color=#c54949>限购1次</color>",
		0,
		0,
		0
	},
	{
		10,
		"世界魔王",
		"weekly",
		93,
		"",
		nil,
		"104:2#8:1#8:20",
		9,
		"<color=#c54949>每周五</color>凌晨5点更新，每轮刷新中，所有商品均<color=#c54949>限购1次</color>",
		0,
		0,
		0
	},
	{
		11,
		"宠物园",
		"monthly",
		110,
		"",
		nil,
		"104:2#8:1#8:24",
		11,
		"<color=#c54949>每周五</color>凌晨5点更新，每轮刷新中，所有商品均<color=#c54949>限购1次</color>",
		0,
		0,
		0
	},
	{
		12,
		"神器币商店",
		"weekly",
		52,
		"",
		nil,
		"204:2#8:1#8:10#8:25",
		1,
		"<color=#c54949>每周五</color>凌晨5点更新，每轮刷新中，所有商品均<color=#c54949>限购1次</color>\r\n<color=#c54949>神器币</color>可以通过<color=#c54949>失落遗迹挑战</color>或者<color=#c54949>分解神器</color>获得。",
		0,
		0,
		1
	},
	{
		13,
		"家族（高）",
		"weekly",
		60,
		"",
		nil,
		"104:2#8:1#8:27",
		13,
		"<color=#c54949>每周五</color>凌晨5点更新，每轮刷新中，所有商品均<color=#c54949>限购1次</color>",
		0,
		0,
		1
	},
	{
		14,
		"师徒",
		"monthly",
		623,
		"",
		nil,
		"104:2#8:1#8:30",
		14,
		"<color=#c54949>每月1号</color>凌晨5点更新，每轮刷新中，所有商品均<color=#c54949>限购1次</color>",
		0,
		0,
		1
	},
	{
		15,
		"组队",
		"weekly",
		610,
		"",
		nil,
		"10:170001#104:2",
		15,
		"<color=#c54949>每周五</color>凌晨5点更新，每轮刷新中，所有商品均<color=#c54949>限购1次</color>",
		0,
		0,
		0
	},
	{
		18,
		"宠物园",
		"weekly",
		910,
		"",
		nil,
		"4:11003#8:37#104:2",
		18,
		"<color=#c54949>每周五</color>凌晨5点更新",
		0,
		0,
		1
	},
	{
		19,
		"工坊商店",
		"weekly",
		470,
		"",
		nil,
		"4:207",
		19,
		"<color=#c54949>每周五</color>凌晨5点更新",
		0,
		0,
		1
	},
	{
		20,
		"神柱之战",
		"monthly",
		60,
		"",
		nil,
		"8:42",
		20,
		"<color=#c54949>每月1号</color>凌晨5点更新，每轮刷新中，所有商品均<color=#c54949>限购1次</color>",
		0,
		0,
		1
	},
	{
		21,
		"奥秘币商店",
		"weekly",
		52,
		"",
		nil,
		"204:2#8:22#8:25",
		20,
		"<color=#c54949>每周五</color>凌晨5点更新，每轮刷新中，所有商品均<color=#c54949>限购1次</color>",
		0,
		0,
		1
	}
}
local t_exchange_tab = {
	dataList[1],
	dataList[2],
	[7] = dataList[3],
	[8] = dataList[4],
	[10] = dataList[5],
	[11] = dataList[6],
	[12] = dataList[7],
	[13] = dataList[8],
	[14] = dataList[9],
	[15] = dataList[10],
	[18] = dataList[11],
	[19] = dataList[12],
	[20] = dataList[13],
	[21] = dataList[14]
}

t_exchange_tab.dataList = dataList

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

return t_exchange_tab
