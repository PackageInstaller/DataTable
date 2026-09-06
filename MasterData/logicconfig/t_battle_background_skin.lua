-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_battle_background_skin.lua

module("logicconfig.config.t_battle_background_skin", package.seeall)

local title = {
	qualityIcon = 6,
	name = 2,
	bgName = 3,
	id = 1,
	isSpine = 8,
	source = 12,
	previewIcon = 4,
	desc = 11,
	validPeriodType = 13,
	validPeriodParam = 14,
	quality = 15,
	icon2 = 7,
	icon = 5,
	notOnline = 10,
	sortValue = 9
}
local dataList = {
	{
		1,
		"默认战斗场景",
		"xingkong",
		"battlepreview_8",
		"battlestart_8",
		"battlequality_1",
		"",
		0,
		1,
		0,
		"默认效果",
		"",
		0,
		"",
		4
	},
	{
		2,
		"终绯之焰",
		"scence_zdcj_12020",
		"battlepreview_7",
		"battlestart_7",
		"battlequality_2",
		"icon_kaichang_07",
		0,
		2,
		0,
		"终绯战斗场景；\n在个人信息-外观-战斗场景中使用。",
		"5360",
		0,
		"",
		4
	},
	{
		3,
		"闲暇海边",
		"haitan",
		"battlepreview_11",
		"battlestart_10",
		"battlequality_2",
		"icon_kaichang_11",
		0,
		3,
		0,
		"夏日战斗场景；\n在个人信息-外观-战斗场景中使用。",
		"5360",
		0,
		"",
		4
	},
	{
		4,
		"创世神源",
		"feixisi",
		"battlepreview_17",
		"battlestart_17",
		"battlequality_2",
		"icon_kaichang_16",
		0,
		4,
		0,
		"斐希司战斗场景；\n在个人信息-外观-战斗场景中使用。",
		"5360",
		0,
		"",
		4
	},
	{
		5,
		"绝命终焉",
		"juemingzhongyan",
		"battlepreview_lyjd_01",
		"battlestart_lyjd_01",
		"battlequality_2",
		"icon_kaichang_20",
		0,
		5,
		0,
		"路因加德战斗场景；\n在个人信息-外观-战斗场景中使用。",
		"5360",
		0,
		"",
		4
	},
	{
		6,
		"浴血罪冠",
		"sizulong",
		"battlepreview_lyjd_03",
		"battlestart_lyjd_03",
		"battlequality_2",
		"icon_kaichang_26",
		0,
		6,
		0,
		"誓祖圣龙战斗场景；\n在个人信息-外观-战斗场景中使用。",
		"5360",
		0,
		"",
		4
	},
	{
		7,
		"离阳龙脉",
		"aojiu",
		"battlestart_aj_02",
		"battlestart_aj_01",
		"battlequality_2",
		"icon_kaichang_30",
		0,
		7,
		0,
		"神曜敖九战斗场景；\n在个人信息-外观-战斗场景中使用。",
		"5360",
		0,
		"",
		4
	},
	{
		8,
		"幽谧狐森",
		"ruihuxian",
		"battlepreview_rhxnf_01",
		"battlestart_rhxnf_01",
		"battlequality_2",
		"icon_zdcj_01",
		0,
		8,
		0,
		"瑞狐仙·创世神女战斗场景；\n在个人信息-外观-战斗场景中使用。",
		"5360",
		0,
		"",
		4
	},
	{
		9,
		"帝昭天道",
		"kaijiayongshi",
		"battlestart_kaijiayongshi_03",
		"battlestart_kaijiayongshi_04",
		"battlequality_2",
		"icon_zdcj_02",
		0,
		9,
		0,
		"帝昭天道·帝皇侠战斗场景；\n在个人信息-外观-战斗场景中使用。",
		"5360",
		0,
		"",
		4
	},
	{
		10,
		"春神绘卷",
		"chunshen",
		"battlestart_djc_04",
		"battlestart_djc_03",
		"battlequality_2",
		"icon_zdcj_03",
		0,
		10,
		0,
		"待见春·无烬神女战斗场景；\n在个人信息-外观-战斗场景中使用。",
		"5360",
		0,
		"",
		4
	},
	{
		11,
		"剑心如我",
		"bojiaqiu",
		"battlestart_jxrw_03",
		"battlestart_jxrw_04",
		"battlequality_2",
		"icon_zdcj_04",
		0,
		11,
		0,
		"剑心如我·薄伽丘战斗场景；\n在个人信息-外观-战斗场景中使用。",
		"5360",
		0,
		"",
		4
	},
	{
		12,
		"碧汐珠殿",
		"haidilonggong",
		"battlepreview_xyzghjsn_01",
		"battlestart_xyzghjsn_01",
		"battlequality_2",
		"icon_zdcj_05",
		0,
		12,
		0,
		"仙蕴珠光·黄金神女战斗场景；\n在个人信息-外观-战斗场景中使用。",
		"5360",
		0,
		"",
		4
	},
	{
		13,
		"零界矩阵",
		"feichuan",
		"battlestart_wuxianweilai_03",
		"battlestart_wuxianweilai_04",
		"battlequality_2",
		"icon_wxwl_02",
		0,
		13,
		0,
		"零界矩阵·无限未来战斗场景；\n在个人信息-外观-战斗场景中使用。",
		"5360",
		0,
		"",
		4
	}
}
local t_battle_background_skin = {
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

t_battle_background_skin.dataList = dataList

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

return t_battle_background_skin
