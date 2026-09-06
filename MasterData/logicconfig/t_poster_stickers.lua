-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_poster_stickers.lua

module("logicconfig.config.t_poster_stickers", package.seeall)

local title = {
	defaultDesc = 5,
	quality = 7,
	name = 2,
	animRes = 8,
	desc = 6,
	posterId = 9,
	res = 3,
	id = 1,
	icon = 4
}
local dataList = {
	{
		1,
		"剑荡八荒",
		"board_dc_yinxiangtie_wuxia",
		"icon_dc_yinxiangtie_01",
		"",
		"在26.4.3-26.5.8期间，集齐[剑荡八荒]系列内的所有皮肤即可在活动中领取本印象贴",
		4,
		"dcyinxiangtie_1/fx_ui_cdyxt_wuxia",
		1045
	},
	{
		2,
		"灵瑞启运",
		"board_dc_yinxiangtie_lingrui",
		"icon_dc_yinxiangtie_02",
		"",
		"在26.4.3-26.5.8期间，集齐[灵瑞启运]系列内的所有皮肤即可在活动中领取本印象贴",
		4,
		"dcyinxiangtie_2/fx_ui_cdyxt_lingrui",
		1044
	},
	{
		3,
		"潋滟群芳",
		"board_dc_yinxiangtie_lianchi",
		"icon_yinxiangtie_23",
		"",
		"在26.6.26-26.8.21期间，集齐[潋滟群芳]系列内的所有皮肤即可在活动中领取本印象贴",
		4,
		"dcyinxiangtie_3/fx_ui_cdyxt_lianchi",
		1052
	},
	{
		4,
		"瑶池仙浴",
		"board_dc_yinxiangtie_yaochi",
		"icon_yinxiangtie_26",
		"",
		"在26.8.7-26.8.21期间，集齐[瑶池仙浴]系列内的所有皮肤即可在活动中领取本印象贴",
		4,
		"dcyinxiangtie_4/fx_ui_cdyxt_yaochi",
		1058
	}
}
local t_poster_stickers = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_poster_stickers.dataList = dataList

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

return t_poster_stickers
