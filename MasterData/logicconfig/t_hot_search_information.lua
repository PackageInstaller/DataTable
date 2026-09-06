-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hot_search_information.lua

module("logicconfig.config.t_hot_search_information", package.seeall)

local title = {
	replyPlanId = 4,
	heatValue = 3,
	informationId = 2,
	activityId = 1,
	desc = 5
}
local dataList = {
	{
		443001,
		1,
		30,
		1,
		"第一次来到奥奇城，各位有什么推荐打卡饭店嘛！"
	},
	{
		443001,
		2,
		30,
		2,
		"今天在曙光森林下煮泡面，流星说要加个荷包蛋才完美！"
	},
	{
		443001,
		3,
		30,
		3,
		"偷吃了小炎兜里的发光糖果，舌头在蹦迪，在线等急救！"
	},
	{
		443001,
		4,
		30,
		4,
		"和砂之城的石头雕像猜拳输了，要替他顶班一天！"
	},
	{
		443001,
		5,
		30,
		5,
		"我今晚会在蓝龙湾摆摊卖冰棍，买三个可以换我的签名爪印喔！"
	},
	{
		443001,
		6,
		30,
		6,
		"今日景点是星神界，好高呀，云朵都说我的肚腩像棉花！"
	},
	{
		443001,
		7,
		30,
		7,
		"在无尽之海海边被巨大海鸥追了三条街，它是不是把我认成会跑的糯米糍了？"
	}
}
local t_hot_search_information = {
	[443001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_hot_search_information.dataList = dataList

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

return t_hot_search_information
