-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_popularity_list_text.lua

module("logicconfig.config.t_popularity_list_text", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"TEXT_1",
		"活动时间：%s"
	},
	{
		"TEXT_2",
		"剩余投票次数:%d次"
	},
	{
		"TEXT_3",
		"是否确认为%s投出宝贵的%d票\r\n每日都可为其投出1票"
	},
	{
		"TEXT_4",
		"是否确认为%s的%s投出宝贵的%d票"
	},
	{
		"TEXT_5",
		"画师名字:%s\n画师宣言:%s"
	},
	{
		"TEXT_6",
		"今天的投票次数已经用完了哦"
	},
	{
		"TEXT_7",
		"今天已经给ta投过票了哦"
	},
	{
		"TEXT_8",
		"你还有投票次数未用完，请先为心仪的精灵投票哦"
	},
	{
		"DIALOG_1",
		"1"
	},
	{
		"DIALOG_2",
		"2"
	},
	{
		"DIALOG_3",
		"3"
	},
	{
		"TEXT_9",
		"投票次数已用完"
	},
	{
		"TEXT_10",
		"已经给ta投过票"
	}
}
local t_popularity_list_text = {
	TEXT_1 = dataList[1],
	TEXT_2 = dataList[2],
	TEXT_3 = dataList[3],
	TEXT_4 = dataList[4],
	TEXT_5 = dataList[5],
	TEXT_6 = dataList[6],
	TEXT_7 = dataList[7],
	TEXT_8 = dataList[8],
	DIALOG_1 = dataList[9],
	DIALOG_2 = dataList[10],
	DIALOG_3 = dataList[11],
	TEXT_9 = dataList[12],
	TEXT_10 = dataList[13]
}

t_popularity_list_text.dataList = dataList

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

return t_popularity_list_text
