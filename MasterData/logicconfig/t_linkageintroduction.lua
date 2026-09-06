-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_linkageintroduction.lua

module("logicconfig.config.t_linkageintroduction", package.seeall)

local title = {
	tabId = 2,
	name = 3,
	url = 7,
	typeId = 1,
	desc = 8,
	descOfficial = 6,
	redPointId = 4,
	viewName = 5,
	reportBehavior = 9
}
local dataList = {
	{
		1,
		1,
		"主题曲",
		"",
		"linkagedocumentaryview",
		"联动主题曲MV《醒·狮》\r\n已上线B站",
		"https://www.bilibili.com/video/BV1Xx4y1u7NT/",
		"小奥奇们可到各大官方论坛，搜索相关信息哦！",
		"201154#201162"
	},
	{
		1,
		2,
		"联动\nPV",
		"",
		"linkagepvview",
		"联动PV《醒狮舞春》\r\n已上线B站",
		"https://www.bilibili.com/video/BV12A411d7Sr/",
		"小奥奇们可到各大官方论坛，搜索相关信息哦！",
		"201153#201161"
	},
	{
		1,
		3,
		"纪录片",
		"",
		"linkageshowrewardview",
		"【奥奇传说x广东醒狮】联动宣传片\r\n将于1月21日上线B站",
		"https://www.bilibili.com/video/BV1aG4y1X7LW/",
		"【奥奇传说x广东醒狮】联动宣传片将于1月21日上线\r\n小奥奇们可到各大官方论坛，搜索相关信息哦！",
		"201215#201216"
	},
	{
		1,
		4,
		"电视节目",
		"o7",
		"linkagetvshowview",
		"《国潮粤品》节目将于9月11日\r\n在珠江电视台上映",
		"",
		"《国潮粤品》节目将于9月11日上映\r\n小奥奇们可到各大官方论坛，搜索相关信息哦！",
		"201152#201155"
	},
	{
		2,
		1,
		"",
		"",
		"",
		"彩灯官包描述",
		"",
		"彩灯渠道描述",
		""
	}
}
local t_linkageintroduction = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5]
	}
}

t_linkageintroduction.dataList = dataList

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

return t_linkageintroduction
