-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_nuo_summary_common.lua

module("logicconfig.config.t_xiao_nuo_summary_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"SIGN_IN_JUMP",
		"mibao#XinchunShop4"
	},
	{
		"SIGN_IN_SKINID",
		"16047"
	},
	{
		"LOTTERY_JUMP",
		"func#43"
	},
	{
		"FREE_SKINID",
		"1032301"
	},
	{
		"FREE_SKIN_JUMP",
		"func#245&&report_behavior#200553"
	},
	{
		"RETURN_JUMP",
		"func#427#2"
	},
	{
		"H5_ICON_PRE",
		"board_mrk_"
	},
	{
		"H5_CELL_LIST",
		"11#12#13#14#15#16#17#18#19#20"
	},
	{
		"H5_URL",
		"http://aoqi.100bt.com/h5/?aqsy"
	},
	{
		"H5_SKINID",
		"16008"
	},
	{
		"H5_PLATFORM_LIMIT",
		"1"
	},
	{
		"SIGN_IN_TIME_LIMIT",
		"活动时间：7月24日 05:00-8月21日 05:00"
	},
	{
		"SIGN_IN_TIPS_ICON_PRE",
		"board_dhm_"
	},
	{
		"SIGN_IN_TIPS_LIST",
		"13#12#10#11"
	},
	{
		"SIGN_IN_JUMP_EXT",
		"func#417"
	},
	{
		"SIGN_IN_SKINID_EXT",
		"16047"
	},
	{
		"CURR_ACTIVITY_ID",
		"96108"
	},
	{
		"SIGN_ACT_REDID_LIST",
		"96108:-176#96104:-175"
	},
	{
		"SIGN_IN_TIME_LIMIT_EXT",
		"活动时间：%02d月%02d日 %02d:%02d-%02d月%02d日 %02d:%02d"
	},
	{
		"COSTUME_ID_FEMALE",
		"53"
	},
	{
		"COSTUME_ID_MALE",
		"54"
	},
	{
		"JIAZU_SKINID",
		"12002"
	},
	{
		"EQUIPMENT_SHOW",
		"7:211002109:5:1#7:211002209:5:1&7:211002109:5:1#7:211002209:5:1"
	},
	{
		"COPY_CURR_ACTIVITY_ID",
		"96104"
	},
	{
		"SPORT_SUP_GRADE_ITEM",
		"204:2"
	},
	{
		"SPORT_SUP_GRADE_TXT",
		"活动时间内，购买【时间绘卷】-【至尊绘卷】\r\n且所在区服玩家取得巅峰赛冠军，100%返还购买绘卷的神钻。"
	},
	{
		"SPORT_SUP_GRADE_JUMP",
		"func#545#26"
	},
	{
		"SIGN_IN_TWOTIME_LIMIT",
		"活动时间：4月3日 05:00-4月30日 05:00"
	}
}
local t_xiao_nuo_summary_common = {
	SIGN_IN_JUMP = dataList[1],
	SIGN_IN_SKINID = dataList[2],
	LOTTERY_JUMP = dataList[3],
	FREE_SKINID = dataList[4],
	FREE_SKIN_JUMP = dataList[5],
	RETURN_JUMP = dataList[6],
	H5_ICON_PRE = dataList[7],
	H5_CELL_LIST = dataList[8],
	H5_URL = dataList[9],
	H5_SKINID = dataList[10],
	H5_PLATFORM_LIMIT = dataList[11],
	SIGN_IN_TIME_LIMIT = dataList[12],
	SIGN_IN_TIPS_ICON_PRE = dataList[13],
	SIGN_IN_TIPS_LIST = dataList[14],
	SIGN_IN_JUMP_EXT = dataList[15],
	SIGN_IN_SKINID_EXT = dataList[16],
	CURR_ACTIVITY_ID = dataList[17],
	SIGN_ACT_REDID_LIST = dataList[18],
	SIGN_IN_TIME_LIMIT_EXT = dataList[19],
	COSTUME_ID_FEMALE = dataList[20],
	COSTUME_ID_MALE = dataList[21],
	JIAZU_SKINID = dataList[22],
	EQUIPMENT_SHOW = dataList[23],
	COPY_CURR_ACTIVITY_ID = dataList[24],
	SPORT_SUP_GRADE_ITEM = dataList[25],
	SPORT_SUP_GRADE_TXT = dataList[26],
	SPORT_SUP_GRADE_JUMP = dataList[27],
	SIGN_IN_TWOTIME_LIMIT = dataList[28]
}

t_xiao_nuo_summary_common.dataList = dataList

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

return t_xiao_nuo_summary_common
