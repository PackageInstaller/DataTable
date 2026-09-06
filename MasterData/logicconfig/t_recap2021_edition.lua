-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_recap2021_edition.lua

module("logicconfig.config.t_recap2021_edition", package.seeall)

local title = {
	versionName = 2,
	bgName = 4,
	editionId = 1,
	descPlanId = 6,
	isZongjie = 7,
	prize = 5,
	iconName = 3
}
local dataList = {
	{
		1,
		"红莲神冕",
		"icon_12009_shenyaomoyan",
		"operationsummary/bg_smdj_01",
		"104:2:20",
		"26",
		false
	},
	{
		2,
		"神堕虚无",
		"icon_12014_fuyao",
		"operationsummary/bg_fuyao_01",
		"104:2:20",
		"27",
		false
	},
	{
		3,
		"梦想启航",
		"icon_11010_wangzhemengmeng",
		"operationsummary/bg_mengxiangzhilv_01",
		"104:2:20",
		"28",
		false
	},
	{
		4,
		"神逆海流",
		"icon_11014_tuntian",
		"operationsummary/bg_xiaridazuozhan",
		"104:2:20",
		"29",
		false
	},
	{
		5,
		"永恒国度",
		"icon_13009_shenyaoaruisi",
		"operationsummary/bg_yonghengguodu_01",
		"104:2:20",
		"30",
		false
	},
	{
		6,
		"万象归极",
		"icon_17010_wangzheji",
		"operationsummary/bg_wangzheji",
		"104:2:20",
		"31",
		false
	},
	{
		7,
		"迷雾骰局",
		"icon_17012_sada",
		"operationsummary/bg_lingshenneizhan_01",
		"104:2:20",
		"32",
		false
	},
	{
		8,
		"小诺生日会",
		"icon_14018_shenyaowangzhenuoya",
		"operationsummary/bg_shengrihuizong_01",
		"104:2:20",
		"33",
		false
	},
	{
		9,
		"毁灭新生",
		"icon_15021_fanasi",
		"operationsummary/bg_huimiezhen",
		"104:2:20",
		"34",
		false
	},
	{
		10,
		"唐宫乐宴",
		"icon_14023_xiayin",
		"operationsummary/bg_tanggongyeyan",
		"104:2:20",
		"35",
		false
	},
	{
		11,
		"命运神谕",
		"icon_16019_nvdi",
		"operationsummary/bg_nvdihuizong_01",
		"104:2:20",
		"36",
		false
	},
	{
		12,
		"炽炎归心",
		"icon_16022_shenyaochaoshenlong",
		"operationsummary/bg_shizhounian_02",
		"104:2:20",
		"37",
		false
	},
	{
		13,
		"冒险再启",
		"icon_16022_shenyaochaoshenlong",
		"operationsummary/bg_shizhounian_02",
		"",
		"38",
		true
	}
}
local t_recap2021_edition = {
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

t_recap2021_edition.dataList = dataList

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

return t_recap2021_edition
