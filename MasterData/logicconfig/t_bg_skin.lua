-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bg_skin.lua

module("logicconfig.config.t_bg_skin", package.seeall)

local title = {
	shopId = 2,
	effConfig = 5,
	tabImg = 3,
	time = 6,
	id = 1,
	bgImg = 4
}
local dataList = {
	{
		1,
		11033,
		"btn_pfhd_01",
		"board_pfhd_05",
		"",
		"2021-07-05 05:00:00#2021-08-06 04:59:59"
	},
	{
		2,
		5004,
		"btn_pfhd_01",
		"board_pfhd_05",
		"fx_ui_grxx/fx_ui_zhanshi_xiuer.prefab",
		"2021-08-12 05:00:00#2021-08-19 04:59:59"
	},
	{
		3,
		5005,
		"btn_pfhd_02",
		"board_pfhd_06",
		"fx_ui_grxx/fx_ui_zhanshi_yilishabai.prefab",
		"2021-08-12 05:00:00#2021-08-19 04:59:59"
	},
	{
		4,
		5006,
		"btn_pfhd_03",
		"board_pfhd_07",
		"fx_ui_tianmanwang/fx_ui_tianmanwang_beijingjiemian.prefab",
		"2021-09-09 05:00:00#2021-09-16 04:59:59"
	},
	{
		5,
		5007,
		"btn_pfhd_05",
		"board_pfhd_12",
		"fx_ui_grxx/fx_ui_grxx_nuoya.prefab",
		"2021-09-30 05:00:00#2021-10-14 04:59:59"
	},
	{
		6,
		5008,
		"btn_pfhd_06",
		"board_pfhd_13",
		"fx_ui_grxx/fx_ui_grxx_mimengli.prefab",
		"2021-10-03 05:00:00#2021-10-14 04:59:59"
	},
	{
		7,
		5009,
		"btn_pfhd_04",
		"board_pfhd_11",
		"fx_ui_grxx/fx_ui_grxx_fengbaobao.prefab",
		"2021-10-14 05:00:00#2021-10-22 04:59:59"
	},
	{
		8,
		5010,
		"btn_pfhd_09",
		"board_pfhd_18",
		"fx_ui_grxx/fx_ui_grxx_zhixushenglong.prefab",
		"2021-10-29 05:00:00#2021-11-12 04:59:59"
	},
	{
		9,
		5011,
		"btn_pfhd_10",
		"board_pfhd_19",
		"fx_ui_grxx/fx_ui_grxx_xinian_tanchuang.prefab",
		"2021-10-29 05:00:00#2021-11-12 04:59:59"
	},
	{
		10,
		5012,
		"btn_pfhd_12",
		"board_pfhd_20",
		"fx_ui_grxx/fx_ui_grxx_zhentandishitian.prefab",
		"2021-11-12 05:00:00#2021-11-26 04:59:59"
	},
	{
		11,
		5013,
		"btn_pfhd_13",
		"board_pfhd_21",
		"fx_ui_grxx/fx_ui_grxx_yadiana.prefab",
		"2021-11-12 05:00:00#2021-11-26 04:59:59"
	},
	{
		12,
		5014,
		"btn_pfhd_15",
		"board_pfhd_27",
		"fx_ui_grxx/fx_ui_zhumengshaonianhuodong.prefab",
		"2021-11-26 05:00:00#2021-12-17 04:59:59"
	}
}
local t_bg_skin = {
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
	dataList[12]
}

t_bg_skin.dataList = dataList

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

return t_bg_skin
