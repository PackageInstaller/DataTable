-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_collect_clothes_collection.lua

module("logicconfig.config.t_collect_clothes_collection", package.seeall)

local title = {
	type = 3,
	collections = 4,
	jumpTo = 11,
	collectId = 1,
	title = 9,
	prize = 6,
	desc = 10,
	collectPlanId = 2,
	endTime = 8,
	icon = 5,
	startTime = 7
}
local dataList = {
	{
		1,
		1,
		1,
		{
			11129,
			11130,
			11131,
			11132
		},
		"items/icon_fz_zqfs",
		"4:90298:1",
		nil,
		nil,
		"秋月佳话套装",
		"9.9-9.23限时折扣售卖",
		"func#545#10&&report_behavior#201123&&report_behavior#201123"
	},
	{
		2,
		1,
		1,
		{
			12014
		},
		"dress/icon_zqfs_piaofu",
		"1:12014:-1:1",
		nil,
		nil,
		"卯兔弄月悬浮",
		"9.9-9.23限时折扣售卖",
		"func#545#10&&report_behavior#&&report_behavior#201127"
	},
	{
		3,
		1,
		2,
		{
			23
		},
		"items/icon_zhongqiuyuetu",
		"4:1023:1",
		nil,
		nil,
		"秋香玉兔坐骑",
		"通行证30元特惠购（需激活）",
		"func#545#16&&report_behavior#&&report_behavior#201124"
	},
	{
		4,
		1,
		1,
		{
			400019
		},
		"dress/icon_zqfs_shouchi",
		"1:400019:-1:1",
		nil,
		nil,
		"胧月之杖手持",
		"活动已结束",
		"event#xiaonuobirthviewchangetab#holidaygiftmainview&&report_behavior#&&report_behavior#201125"
	},
	{
		5,
		1,
		1,
		{
			500008
		},
		"dress/icon_zqfs_beishi",
		"1:500008:-1:1",
		nil,
		nil,
		"月宫折桂背饰",
		"累充68元领取",
		"func#545#1&&report_behavior#&&report_behavior#201126"
	},
	{
		1,
		2,
		1,
		{
			11129,
			11130,
			11131,
			11132
		},
		"items/icon_fz_zqfs",
		"4:90298:1",
		nil,
		nil,
		"秋月佳话套装",
		"9.9-9.23限时折扣售卖",
		"func#545#10&&report_behavior#201123&&report_behavior#201123"
	},
	{
		2,
		2,
		1,
		{
			12014
		},
		"dress/icon_zqfs_piaofu",
		"1:12014:-1:1",
		nil,
		nil,
		"卯兔弄月悬浮",
		"9.9-9.23限时折扣售卖",
		"func#545#10&&report_behavior#&&report_behavior#201127"
	},
	{
		3,
		2,
		2,
		{
			23
		},
		"items/icon_zhongqiuyuetu",
		"4:1023:1",
		nil,
		nil,
		"秋香玉兔坐骑",
		"通行证30元特惠购（需激活）",
		"func#545#16&&report_behavior#&&report_behavior#201124"
	},
	{
		4,
		2,
		1,
		{
			400019
		},
		"dress/icon_zqfs_shouchi",
		"1:400019:-1:1",
		nil,
		nil,
		"胧月之杖手持",
		"9.10中秋登录礼包领取",
		"event#xiaonuobirthviewchangetab#holidaygiftmainview&&report_behavior#&&report_behavior#201125"
	},
	{
		5,
		2,
		1,
		{
			500008
		},
		"dress/icon_zqfs_beishi",
		"1:500008:-1:1",
		"2022-09-30T05:00:00",
		"2022-10-07T05:00:00",
		"月宫折桂背饰",
		"累充68元领取",
		"func#545#1&&report_behavior#&&report_behavior#201126"
	}
}
local t_collect_clothes_collection = {
	{
		dataList[1],
		dataList[6]
	},
	{
		dataList[2],
		dataList[7]
	},
	{
		dataList[3],
		dataList[8]
	},
	{
		dataList[4],
		dataList[9]
	},
	{
		dataList[5],
		dataList[10]
	}
}

t_collect_clothes_collection.dataList = dataList

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

return t_collect_clothes_collection
