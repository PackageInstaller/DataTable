-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_companion_mall_preview.lua

module("logicconfig.config.t_companion_mall_preview", package.seeall)

local title = {
	id = 2,
	desc = 4,
	activityId = 1,
	path = 3
}
local dataList = {
	{
		492001,
		1,
		"board_zhounianshangcheng_09",
		"折叠晴雨两用雨伞"
	},
	{
		492001,
		2,
		"board_zhounianshangcheng_10",
		"PBT定制键帽"
	},
	{
		492001,
		3,
		"board_zhounianshangcheng_11",
		"摇摇乐立牌"
	},
	{
		492001,
		4,
		"board_zhounianshangcheng_12",
		"镭射包装盒"
	},
	{
		492001,
		5,
		"board_zhounianshangcheng_06",
		"斐妮娅立牌正面"
	},
	{
		492001,
		6,
		"board_zhounianshangcheng_07",
		"斐妮娅立牌背面+底座"
	},
	{
		492001,
		7,
		"board_zhounianshangcheng_08",
		"斐妮娅立牌尺寸展示"
	},
	{
		492002,
		1,
		"board_zhounianshangcheng_18",
		"斐妮娅泳装流麻立牌"
	},
	{
		492002,
		2,
		"board_zhounianshangcheng_17",
		"斐妮娅泳装流麻立牌"
	},
	{
		492002,
		3,
		"board_zhounianshangcheng_19",
		"音织护腕鼠标垫"
	},
	{
		492002,
		4,
		"board_zhounianshangcheng_20",
		"誓祖护腕鼠标垫"
	},
	{
		492002,
		5,
		"board_zhounianshangcheng_21",
		"绮梦晚夏光栅卡"
	},
	{
		492002,
		6,
		"board_zhounianshangcheng_22",
		"斐妮娅泳装光栅卡"
	},
	{
		492003,
		1,
		"bg_zhoubianshangchang_04",
		"灵瑞系列双闪烫金吧唧"
	},
	{
		492003,
		2,
		"bg_zhoubianshangchang_03",
		"灵瑞系列双闪烫金吧唧"
	},
	{
		492003,
		3,
		"bg_zhoubianshangchang_06",
		"瑞狐仙三插绕线器立牌"
	},
	{
		492003,
		4,
		"bg_zhoubianshangchang_07",
		"瑞狐仙三插绕线器立牌"
	},
	{
		492003,
		5,
		"bg_zhoubianshangchang_05",
		"灵瑞亚克力扭蛋机"
	},
	{
		492003,
		6,
		"bg_zhoubianshangchang_02",
		"黑创亚克力摆件"
	},
	{
		492003,
		7,
		"bg_zhoubianshangchang_11",
		"五周年礼盒"
	},
	{
		492003,
		8,
		"bg_zhoubianshangchang_12",
		"五周年礼盒"
	}
}
local t_companion_mall_preview = {
	[492001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[492002] = {
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13]
	},
	[492003] = {
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21]
	}
}

t_companion_mall_preview.dataList = dataList

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

return t_companion_mall_preview
