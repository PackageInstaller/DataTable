-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_recap2021_person_random_word.lua

module("logicconfig.config.t_recap2021_person_random_word", package.seeall)

local title = {
	id = 1,
	desc = 2
}
local dataList = {
	{
		1,
		"重振荣光\r\n黄金十年"
	},
	{
		2,
		"小孩子才做选择\r\n大人我全都要"
	},
	{
		3,
		"我的阵容\r\n给你安排的明明白白"
	},
	{
		4,
		"欧皇降临\r\n水逆退散"
	},
	{
		5,
		"光明\r\n赐予我力量"
	},
	{
		6,
		"心在跳\r\n似偶遇赤焰龙皇"
	},
	{
		7,
		"U1S1\r\n你别说你还真别说"
	},
	{
		8,
		"快扶我起来\r\n我还能肝24小时"
	},
	{
		9,
		"扎心了老铁\r\n肝得尽头还是肝"
	},
	{
		10,
		"什么是快乐星球？\r\n打不过要溜溜球"
	},
	{
		11,
		"奥奇不倒\r\n陪你到老"
	},
	{
		12,
		"重铸荣光\r\n黄金十年"
	},
	{
		13,
		"希望哥来了"
	}
}
local t_recap2021_person_random_word = {
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
	dataList[13]
}

t_recap2021_person_random_word.dataList = dataList

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

return t_recap2021_person_random_word
