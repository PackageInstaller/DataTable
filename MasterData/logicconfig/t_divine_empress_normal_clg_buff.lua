-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_empress_normal_clg_buff.lua

module("logicconfig.config.t_divine_empress_normal_clg_buff", package.seeall)

local title = {
	effectShow = 4,
	rulePath = 6,
	buffId = 2,
	effectEnd = 5,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		485001,
		1,
		"站位最靠前的精灵免疫1次攻击",
		"fx_ui_sqars_choupai_lv",
		"fx_ui_sqars_choupai_lv_xiaoshi",
		"icon_jzkj_05"
	},
	{
		485001,
		2,
		"己阵精灵获得10%的免伤",
		"fx_ui_sqars_choupai_zi",
		"fx_ui_sqars_choupai_zi_xiaoshi",
		"icon_jzkj_11"
	},
	{
		485001,
		3,
		"己阵每次免疫时，令战斗力最高且气势未满的精灵获得25气势",
		"fx_ui_sqars_choupai_hui",
		"fx_ui_sqars_choupai_hui_xiaoshi",
		"icon_jzkj_01"
	},
	{
		485001,
		4,
		"己阵精灵全属性+50%",
		"fx_ui_sqars_choupai_cheng",
		"fx_ui_sqars_choupai_cheng_xiaoshi",
		"icon_jzkj_02"
	}
}
local t_divine_empress_normal_clg_buff = {
	[485001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_divine_empress_normal_clg_buff.dataList = dataList

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

return t_divine_empress_normal_clg_buff
