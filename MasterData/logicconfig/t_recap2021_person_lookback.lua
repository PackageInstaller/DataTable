-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_recap2021_person_lookback.lua

module("logicconfig.config.t_recap2021_person_lookback", package.seeall)

local title = {
	param = 7,
	detailPlanId = 4,
	viewName = 6,
	tagPlanId = 5,
	id = 2,
	name = 3,
	planId = 1
}
local dataList = {
	{
		1,
		1,
		"奥奇个人年终总结-精灵篇",
		1,
		0,
		"recap2021lookbackpetview",
		"1"
	},
	{
		1,
		2,
		"奥奇个人年终总结-精灵篇",
		2,
		0,
		"recap2021lookbackpetview",
		"3"
	},
	{
		1,
		3,
		"奥奇个人年终总结-精灵篇",
		3,
		0,
		"recap2021lookbackpetview",
		"2"
	},
	{
		1,
		4,
		"奥奇个人年终总结-荣誉篇",
		4,
		1,
		"recap2021lookbackhonorview",
		""
	},
	{
		1,
		5,
		"奥奇个人年终总结-战斗篇",
		5,
		2,
		"recap2021lookbackbattleview",
		"1"
	},
	{
		1,
		6,
		"奥奇个人年终总结-战斗篇",
		6,
		2,
		"recap2021lookbackbattleview",
		"2"
	},
	{
		1,
		7,
		"奥奇个人年终总结-爆肝篇",
		7,
		3,
		"recap2021lookbackbaoganview",
		"1"
	},
	{
		1,
		8,
		"奥奇个人年终总结-爆肝篇",
		8,
		3,
		"recap2021lookbackbaoganview",
		"2"
	},
	{
		1,
		9,
		"奥奇个人年终总结-异界篇",
		10,
		0,
		"recap2021lookbackyijieview",
		""
	},
	{
		1,
		10,
		"奥奇传说-个人周年回顾",
		9,
		0,
		"recap2021lookbackzongjieview",
		""
	}
}
local t_recap2021_person_lookback = {
	{
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
}

t_recap2021_person_lookback.dataList = dataList

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

return t_recap2021_person_lookback
