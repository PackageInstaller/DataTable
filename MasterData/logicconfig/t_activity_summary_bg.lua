-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_summary_bg.lua

module("logicconfig.config.t_activity_summary_bg", package.seeall)

local title = {
	pvStoryId = 6,
	effect = 5,
	bgName = 2,
	endTime = 4,
	planId = 1,
	startTime = 3
}
local dataList = {
	{
		1,
		"board_jjbx_01",
		"2021-04-15T05:00:00",
		"2021-04-29T05:00:00",
		"",
		0
	},
	{
		2,
		"board_tysmz_01",
		"2021-04-17T05:00:00",
		"2021-04-29T05:00:00",
		"",
		0
	},
	{
		3,
		"board_xy_01",
		"2021-03-17T05:00:00",
		"2021-04-30T05:00:00",
		"fx_ui_shijianchuancheng/fx_ui_shijianchuancheng_03",
		0
	},
	{
		4,
		"board_bg_yyhz",
		"2021-04-29T05:00:00",
		"2021-06-24T05:00:00",
		"",
		0
	},
	{
		5,
		"board_bg_yyhz",
		"2021-07-02T05:00:00",
		"2022-10-23T00:00:00",
		"fx_ui_qirirenwu/fx_qirirenwu_pingmu",
		0
	},
	{
		6,
		"bg_lzny_02",
		"2021-07-02T05:00:00",
		"2022-10-15T05:00:00",
		"fx_ui_2021930/fx_ui_nuoyahuizong/fx_ui_nuoyahuizong2",
		0
	},
	{
		7,
		"board_bg_wsj",
		"2021-07-02T05:00:00",
		"2022-10-15T05:00:00",
		"20211028/wanshengjie_huizong/fx_ui_wanshengjie_huizong",
		0
	},
	{
		8,
		"bg_thzc_01",
		"2021-07-02T05:00:00",
		"2022-10-15T05:00:00",
		"20211028/tehuizhuanchang/fx_ui_tehuizhuanchang",
		0
	},
	{
		9,
		"board_xnbg_01",
		"2021-07-02T05:00:00",
		"2022-10-15T05:00:00",
		"20211126/xiaonuoshengrihui/fx_ui_xiaonuoshengrihui",
		0
	}
}
local t_activity_summary_bg = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_activity_summary_bg.dataList = dataList

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

return t_activity_summary_bg
