-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_waking_lion_game_class.lua

module("logicconfig.config.t_waking_lion_game_class", package.seeall)

local title = {
	index = 2,
	tid = 1,
	desc = 4,
	tabName = 3
}
local dataList = {
	{
		1,
		1,
		"醒狮文化",
		"醒狮又称舞狮、瑞狮、雄狮等，属于中国狮舞中的南派醒狮。据历史而言由唐代宫廷狮子舞脱胎而来，五代十国之后，随着中原移民的南迁，舞狮文化传入岭南地区。明代时，醒狮出现在明代广州府南海县（现今佛山南海）。\r\n醒狮是融合武术、舞蹈、音乐等为一体的汉族民俗传统文化。被认为是驱邪避害的吉祥物，每逢传统节庆或有重大喜庆活动必有醒狮助兴，历代相传、鼎盛不衰。"
	},
	{
		1,
		2,
		"醒狮文化",
		"醒狮文化现广泛流传于广东、广西、珠三角地区以及海外华侨社区，成为海外同胞认祖归宗的文化脊梁，其历史文化价值和影响十分深远。中华文化博大精深，岭南文化源远流长，醒狮等民俗文化气息更是绚丽多彩，耀人眼目。塑造积极向上、奋发图强、携手共进的“尚武精神”，培育树立：仁义勇智孝忠的中华传统美德。"
	},
	{
		2,
		1,
		"大师介绍",
		"曾参加过2006年卡塔尔多哈亚运会开幕式舞狮表演，2009荣获创新健力士世界纪录之“最大型鼓乐演奏”，2012、2013年连续2年荣获广东省传统龙狮、麒麟锦标赛第一名，2014年参加“福永杯”全国南狮公开赛荣获银奖，2016年参加两岸四地狮王争霸赛荣获金奖，2017年作为广州市代表队出征广东省第四届体育大会，赢得成年组传统南狮第一名，2021年被评为广东省乡村工匠民间杂技舞狮专业正高级工程师，2022年荣获第十六届广东省运动会龙传统南狮成年组冠军。"
	},
	{
		3,
		1,
		"醒狮点睛",
		"醒狮开光都是较为神圣而隆重的，据风俗传承，新醒狮必须进过点睛开光后，才会被赋生命与灵性。"
	},
	{
		3,
		2,
		"醒狮点睛",
		"由德高望重的人，为醒狮簪花挂红，然后手提新毛笔，沾上用白酒和朱砂或鸡血调配的配方，按着顺序天灵、眼睛、耳朵、鼻子、嘴巴、爪、角，然后一笔由头点到尾。"
	},
	{
		3,
		3,
		"醒狮点睛",
		"在点睛的同时，也会念一些吉祥的话语，例如：点睛开光，威振八方，风调雨顺，国泰民安；簪花挂红，事业兴隆，宏图大展，马到成功。"
	},
	{
		4,
		1,
		"南狮狮头",
		"南派醒狮在岭南地区及海外较为流行，又称为醒狮、瑞狮、雄狮等。舞动时注重形神、马步，首尾呼应，人狮合一，配上大锣、大鼓和广钹，气派十足。狮头以戏剧脸谱三国时期的刘备、关羽、张飞等英雄人物作为搭配参考，每个脸谱颜色不同，代表的人物和意义都不同。"
	}
}
local t_waking_lion_game_class = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7]
	}
}

t_waking_lion_game_class.dataList = dataList

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

return t_waking_lion_game_class
