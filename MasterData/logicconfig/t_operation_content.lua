-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_operation_content.lua

module("logicconfig.config.t_operation_content", package.seeall)

local title = {
	id = 1,
	content = 2
}
local dataList = {
	{
		1,
		"2012年，幻光冰原，第一次与小诺相遇！"
	},
	{
		2,
		"2013年，获得神之力量，超进化！神诺亚！"
	},
	{
		3,
		"2014年，英雄诺亚降临，挥舞正义之剑，斩断一切邪恶！"
	},
	{
		4,
		"2015年，全新突破！诺亚神灵超进化-时间主宰诺亚！"
	},
	{
		5,
		"2016年，时间之王降临，超神力量爆发！"
	},
	{
		6,
		"2016年，最强的伙伴，诺亚超神进化！"
	},
	{
		7,
		"2017年，找寻最强的自己，神职进化开启！"
	},
	{
		8,
		"2017年，以神之名，斩灭黑暗。诺亚神职进化！"
	},
	{
		9,
		"2017年，小诺生日会，诺亚王者加冕！"
	},
	{
		10,
		"2018年，万众瞩目，时间之王，传说归来！"
	},
	{
		11,
		"2018年，小诺生日会，王者诺亚传说加冕！"
	},
	{
		12,
		"2019年，神光之剑，时之所指，诺亚天启进化！"
	},
	{
		13,
		"2019年，小诺生日会，诺亚属性皮肤登场！"
	},
	{
		14,
		"2020年，白昼之魂，王者之势，诺亚双职进化！"
	},
	{
		15,
		"2020年，神圣之光，时间之王，诺亚启元进化！"
	},
	{
		16,
		"2021年，你的时间，我来守护！"
	}
}
local t_operation_content = {
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
	dataList[16]
}

t_operation_content.dataList = dataList

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

return t_operation_content
