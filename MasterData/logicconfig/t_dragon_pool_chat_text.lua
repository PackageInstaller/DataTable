-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_pool_chat_text.lua

module("logicconfig.config.t_dragon_pool_chat_text", package.seeall)

local title = {
	content = 3,
	actId = 1,
	textId = 2
}
local dataList = {
	{
		300001,
		1,
		"蛋蛋，我好像近视又严重了，打开钱包竟然找不到钱，你说奇不奇怪！"
	},
	{
		300001,
		2,
		"蛋蛋，隔壁农场收成有点差，我来看看你，原来那边的植物都长到你这边了！"
	},
	{
		300001,
		3,
		"蛋蛋，你知道阿瑞又把我鸡腿偷走了吗，但其实我没告诉他，鸡腿已经掉在地上好几天了！"
	},
	{
		300001,
		4,
		"蛋蛋，早餐的茶叶蛋和水煮蛋，你更喜欢哪一种？等等，你怎么好像开始发抖了！"
	},
	{
		300001,
		5,
		"蛋蛋，里面能听到我碎碎念吗？听不到倒也没关系，那我敲开蛋壳你就能听到了！"
	},
	{
		300001,
		6,
		"蛋蛋，我在奥奇城很想你，想你的风还是吹到了奥奇城……你怎么开始抠地板了？"
	},
	{
		300001,
		7,
		"蛋蛋，青春没有售价，走路直达永恒国度……要不你也加入我吧？"
	},
	{
		300001,
		8,
		"蛋蛋，孵出来的小龙会有像我一样喜欢阴暗爬行吗？噢，原来你们是靠飞……"
	}
}
local t_dragon_pool_chat_text = {
	[300001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_dragon_pool_chat_text.dataList = dataList

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

return t_dragon_pool_chat_text
