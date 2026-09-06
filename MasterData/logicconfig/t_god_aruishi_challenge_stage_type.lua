-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_aruishi_challenge_stage_type.lua

module("logicconfig.config.t_god_aruishi_challenge_stage_type", package.seeall)

local title = {
	name = 2,
	effectRuleEnd = 7,
	effectMove = 3,
	type = 1,
	effectPos = 4,
	rulePath = 9,
	enemyEffect = 5,
	effectHeadIcon = 8,
	effectRuleShow = 6
}
local dataList = {
	{
		1,
		"生命祭坛",
		"fx_ui_sqars_lv",
		"fx_ui_sqars_jdlv",
		false,
		"fx_ui_sqars_choupai_lv",
		"fx_ui_sqars_choupai_lv_xiaoshi",
		"fx_ui_sqars_qiu_lv",
		"icon_jzkj_05"
	},
	{
		2,
		"生命抵抗",
		"fx_ui_sqars_zi",
		"fx_ui_sqars_jdzi",
		false,
		"fx_ui_sqars_choupai_zi",
		"fx_ui_sqars_choupai_zi_xiaoshi",
		"fx_ui_sqars_qiu_zi",
		"icon_jzkj_11"
	},
	{
		3,
		"生命凋零",
		"fx_ui_sqars_hui",
		"fx_ui_sqars_jdhui",
		false,
		"fx_ui_sqars_choupai_hui",
		"fx_ui_sqars_choupai_hui_xiaoshi",
		"fx_ui_sqars_qiu_hui",
		"icon_jzkj_01"
	},
	{
		4,
		"生命万物",
		"fx_ui_sqars_cheng",
		"fx_ui_sqars_jdcheng",
		false,
		"fx_ui_sqars_choupai_cheng",
		"fx_ui_sqars_choupai_cheng_xiaoshi",
		"fx_ui_sqars_qiu_cheng",
		"icon_jzkj_02"
	}
}
local t_god_aruishi_challenge_stage_type = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_god_aruishi_challenge_stage_type.dataList = dataList

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

return t_god_aruishi_challenge_stage_type
