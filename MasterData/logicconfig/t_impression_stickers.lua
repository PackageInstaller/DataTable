-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_impression_stickers.lua

module("logicconfig.config.t_impression_stickers", package.seeall)

local title = {
	defaultDesc = 6,
	quality = 8,
	id = 1,
	name = 2,
	animRes = 9,
	desc = 7,
	res = 4,
	raceId = 3,
	icon = 5
}
local dataList = {
	{
		1,
		"斐希司印象贴",
		18021,
		"board_mingzitie_25nianfei",
		"icon_yinxiangtie_01",
		"全服前10万名玩家获得创世神源·斐希司将获得印象贴",
		"全服前10万名玩家获得创世神源·斐希司将获得印象贴",
		4,
		"yinxiangtie_01"
	},
	{
		2,
		"无烬龙印象贴",
		12027,
		"board_yinxiangtie_wujinlong",
		"icon_yinxiangtie_02",
		"全服前8888名玩家获得烈焰王者·无烬将获得印象贴",
		"全服前8888名玩家获得烈焰王者·无烬将获得印象贴",
		4,
		"yinxiangtie_02"
	},
	{
		3,
		"神曜无限未来印象贴",
		16032,
		"board_mingzitie_wuxianweilai",
		"icon_yinxiangtie_03",
		"全服前6666名玩家获得神曜光维·无限未来印象贴",
		"全服前6666名玩家获得神曜光维·无限未来印象贴",
		4,
		"yinxiangtie_03"
	},
	{
		4,
		"路因加德印象贴",
		15032,
		"board_yinxiangtie_luyinjiade",
		"icon_yinxiangtie_04",
		"全服前10000名玩家获得绝命终焉·路因加德印象贴",
		"全服前10000名玩家获得绝命终焉·路因加德印象贴",
		4,
		"yinxiangtie_04"
	},
	{
		5,
		"神曜双生龙印象贴",
		16034,
		"board_yinxiangtie_shuangshenglong",
		"icon_yinxiangtie_05",
		"全服前10000名玩家获得神曜双生·圣龙印象贴",
		"全服前10000名玩家获得该印象贴",
		4,
		"yinxiangtie_05"
	},
	{
		6,
		"空灵圣龙印象贴",
		16039,
		"board_yinxiangtie_linghailong",
		"icon_yinxiangtie_06",
		"全服前10000名玩家获得天恩圣祭·空灵圣龙",
		"全服前10000名玩家获得该印象贴",
		4,
		"yinxiangtie_06"
	},
	{
		7,
		"誓祖圣龙印象贴",
		12037,
		"board_yinxiangtie_shizushenglong",
		"icon_yinxiangtie_08",
		"全服前20000名玩家获得浴血罪冠·誓祖圣龙",
		"全服前20000名玩家获得该印象贴",
		4,
		"yinxiangtie_07"
	},
	{
		8,
		"神曜敖九印象贴",
		16040,
		"board_yinxiangtie_shenyaoaojiu",
		"icon_yinxiangtie_07",
		"全服前10000名玩家获得神曜离阳·敖九",
		"全服前10000名玩家获得该印象贴",
		4,
		"yinxiangtie_08"
	},
	{
		9,
		"神曜希望印象贴",
		14038,
		"board_yinxiangtie_shenyaoxiayin",
		"icon_yinxiangtie_09",
		"全服前10000名玩家获得神曜祈愿希望",
		"全服前10000名玩家获得该印象贴",
		4,
		"yinxiangtie_09"
	},
	{
		10,
		"悼影圣龙印象贴",
		15041,
		"board_yinxiangtie_daoyingshenglong",
		"icon_yinxiangtie_10",
		"全服前10000名玩家获得哀光伪面·悼影圣龙",
		"全服前10000名玩家获得该印象贴",
		4,
		"yinxiangtie_10"
	},
	{
		11,
		"星崇尊上印象贴",
		14042,
		"board_yinxiangtie_wangzheciyuanlong",
		"icon_yinxiangtie_11",
		"全服前10000名玩家获得星崇尊上·次元",
		"全服前10000名玩家获得该印象贴",
		4,
		"yinxiangtie_11"
	},
	{
		12,
		"超神龙印象贴",
		16045,
		"board_yinxiangtie_yuanqichaoshenlong",
		"icon_yinxiangtie_12",
		"全服前10000名玩家获得星宇守望·超神龙尊",
		"全服前100000名玩家获得该印象贴",
		4,
		"yinxiangtie_12"
	},
	{
		13,
		"至高天理印象贴",
		18031,
		"board_yinxiangtie_heichuang",
		"icon_yinxiangtie_13",
		"全服前100000名玩家获得至高天理·创世圣龙",
		"全服前10000名玩家获得该印象贴",
		4,
		"yinxiangtie_13"
	},
	{
		14,
		"永恒龙尊印象贴",
		13028,
		"board_yinxiangtie_yuanqiyonghenglong",
		"icon_yinxiangtie_14",
		"全服前10000名玩家获得亘古年轮·永恒龙尊",
		"全服前10000名玩家获得该印象贴",
		4,
		"yinxiangtie_14"
	},
	{
		15,
		"无烬龙尊印象贴",
		12041,
		"board_yinxiangtie_wujinlong_02",
		"icon_yinxiangtie_15",
		"全服前10000名玩家获得亘狱火泰坦·无烬龙尊",
		"全服前10000名玩家获得该印象贴",
		4,
		"yinxiangtie_15"
	},
	{
		16,
		"秩序龙尊印象贴",
		11037,
		"board_yinxiangtie_yuanqizhixvlong",
		"icon_yinxiangtie_16",
		"全服前10000名玩家获得公理衡律·秩序龙尊",
		"全服前10000名玩家获得该印象贴",
		4,
		"yinxiangtie_16"
	},
	{
		17,
		"薄伽丘印象贴",
		17027,
		"board_yinxiangtie_fujiaqiu",
		"icon_yinxiangtie_17",
		"全服前10000名玩家获得虚骸噬灭·薄伽丘",
		"全服前10000名玩家获得该印象贴",
		4,
		"yinxiangtie_17"
	},
	{
		18,
		"龙尊圣主印象贴",
		17029,
		"board_yinxiangtie_longzhu",
		"icon_yinxiangtie_18",
		"全服前10000名玩家获得御宇天权·龙尊圣主",
		"全服前10000名玩家获得该印象贴",
		4,
		"yinxiangtie_18"
	},
	{
		19,
		"时空龙尊印象贴",
		15045,
		"board_yinxiangtie_shikonglongzun",
		"icon_yinxiangtie_21",
		"全服前10000名玩家获得终时泰坦·时空龙尊",
		"全服前10000名玩家获得该印象贴",
		4,
		"yinxiangtie_19"
	},
	{
		20,
		"源起次元龙尊印象贴",
		14045,
		"board_yinxiangtie_ciyuanlong",
		"icon_yinxiangtie_22",
		"全服前10000名玩家获得天罗诸界·次元龙尊",
		"全服前10000名玩家获得该印象贴",
		4,
		"yinxiangtie_20"
	},
	{
		21,
		"源起双生龙印象贴",
		16048,
		"board_yinxiangtie_heibaishuangsheng",
		"icon_yinxiangtie_24",
		"全服前10000名玩家获得万法裁夺·双生龙尊",
		"全服前10000名玩家获得该印象贴",
		4,
		"yinxiangtie_21"
	}
}
local t_impression_stickers = {
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
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21]
}

t_impression_stickers.dataList = dataList

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

return t_impression_stickers
