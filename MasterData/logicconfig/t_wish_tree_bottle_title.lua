-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wish_tree_bottle_title.lua

module("logicconfig.config.t_wish_tree_bottle_title", package.seeall)

local title = {
	activityId = 1,
	content = 3,
	titleId = 2
}
local dataList = {
	{
		328001,
		1,
		"万事如意"
	},
	{
		328001,
		2,
		"财源广进"
	},
	{
		328001,
		3,
		"身体健康"
	},
	{
		328001,
		4,
		"蒸蒸日上"
	},
	{
		328001,
		5,
		"学业有成"
	},
	{
		328002,
		1,
		"世界和平"
	},
	{
		328002,
		2,
		"财源广进"
	},
	{
		328002,
		3,
		"爱神降临"
	},
	{
		328002,
		4,
		"蒸蒸日上"
	},
	{
		328002,
		5,
		"金榜题名"
	},
	{
		328003,
		1,
		"回忆"
	},
	{
		328003,
		2,
		"成长"
	},
	{
		328003,
		3,
		"遗憾"
	},
	{
		328003,
		4,
		"希望"
	},
	{
		328003,
		5,
		"传承"
	}
}
local t_wish_tree_bottle_title = {
	[328001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[328002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[328003] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_wish_tree_bottle_title.dataList = dataList

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

return t_wish_tree_bottle_title
