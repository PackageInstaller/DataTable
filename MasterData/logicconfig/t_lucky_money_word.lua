-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lucky_money_word.lua

module("logicconfig.config.t_lucky_money_word", package.seeall)

local title = {
	id = 2,
	word = 3,
	activityId = 1
}
local dataList = {
	{
		438001,
		1,
		"金蛇迎春，岁序更新，幸福安康伴你行"
	},
	{
		438001,
		2,
		"灵蛇送福，岁岁安康"
	},
	{
		438001,
		3,
		"祥蛇纳福，喜乐无边"
	},
	{
		438001,
		4,
		"祥蛇送，福运增，家和万事兴"
	},
	{
		438001,
		5,
		"瑞彩祥光，春回大地，幸福美满又一年"
	},
	{
		438001,
		6,
		"祥蛇贺岁，平安喜乐"
	},
	{
		438001,
		7,
		"蛇舞新春，福满人间"
	},
	{
		438001,
		8,
		"蛇年旺，财源广，生活更甜蜜"
	},
	{
		438001,
		9,
		"蛇年到，好运绕，岁岁平安笑"
	},
	{
		438001,
		10,
		"新春佳节，福星高照，吉祥如意乐逍遥"
	}
}
local t_lucky_money_word = {
	[438001] = {
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

t_lucky_money_word.dataList = dataList

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

return t_lucky_money_word
