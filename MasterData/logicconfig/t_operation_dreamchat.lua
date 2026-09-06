-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_operation_dreamchat.lua

module("logicconfig.config.t_operation_dreamchat", package.seeall)

local title = {
	id = 2,
	image = 3,
	activityId = 1,
	content = 4
}
local dataList = {
	{
		18003,
		1,
		"dreamnews_8",
		"2012年，幻光冰原，第一次与小诺相遇！"
	},
	{
		18003,
		2,
		"dreamnews_3",
		"2013年，获得神之力量，超进化！神诺亚！"
	},
	{
		18003,
		3,
		"dreamnews_3",
		"2014年，英雄诺亚降临，挥舞正义之剑，斩断一切邪恶！"
	},
	{
		18003,
		4,
		"dreamnews_4",
		"2015年，全新突破！诺亚神灵超进化-时间主宰诺亚！"
	},
	{
		18003,
		5,
		"dreamnews_5",
		"2016年，时间之王降临，超神力量爆发！"
	},
	{
		18003,
		6,
		"dreamnews_6",
		"2016年，最强的伙伴，诺亚超神进化！"
	},
	{
		18003,
		7,
		"dreamnews_7",
		"2017年，找寻最强的自己，神职进化开启！"
	},
	{
		18003,
		8,
		"dreamnews_9",
		"2017年，以神之名，斩灭黑暗。诺亚神职进化！"
	},
	{
		18003,
		9,
		"dreamnews_1",
		"2017年，小诺生日会，诺亚王者加冕！"
	},
	{
		18003,
		10,
		"dreamnews_10",
		"2018年，万众瞩目，时间之王，传说归来！"
	}
}
local t_operation_dreamchat = {
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

t_operation_dreamchat.dataList = dataList

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

return t_operation_dreamchat
