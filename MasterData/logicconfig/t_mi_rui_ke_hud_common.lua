-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mi_rui_ke_hud_common.lua

module("logicconfig.config.t_mi_rui_ke_hud_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"WELFARE_RACE_ID",
		"16008"
	},
	{
		"H5_URL",
		"http://aoqi.100bt.com/h5/"
	},
	{
		"INTRODUCE",
		"1.4月15日起连续两天登陆奥奇页游，签到可领取蜜蕊可橙+1神器兑换码。\r\n2.参与拼图活动，可领取满觉蜜蕊可专属魂。"
	},
	{
		"TAB2_ACT_ID",
		"96009"
	},
	{
		"MAIN_ACT_ID",
		"96009"
	},
	{
		"ENTER_TIP",
		"4.29日活动结束后\n蜜蕊可将加入普通卡池"
	},
	{
		"ENTER_INTRODUCE",
		"<color=#FFFFFF>通灵师战斗时，达标通灵条件后，通灵师精灵可以触发通灵技。\r\n①.通灵条件：集齐通灵进度后，触发通灵技。\r\n②.进度获得：己阵指定条件精灵每次出手，获得通灵进度。\r\n③.通灵效果：获得超强的战斗通灵技，同时获得通灵普攻和通灵超杀，持续到战斗结束。</color>"
	},
	{
		"ENTER_INTRODUCE_TITLE",
		"通灵师"
	},
	{
		"TAB_TAG_1",
		"特惠礼包"
	},
	{
		"TAB_TAG_2",
		"签到礼包"
	}
}
local t_mi_rui_ke_hud_common = {
	WELFARE_RACE_ID = dataList[1],
	H5_URL = dataList[2],
	INTRODUCE = dataList[3],
	TAB2_ACT_ID = dataList[4],
	MAIN_ACT_ID = dataList[5],
	ENTER_TIP = dataList[6],
	ENTER_INTRODUCE = dataList[7],
	ENTER_INTRODUCE_TITLE = dataList[8],
	TAB_TAG_1 = dataList[9],
	TAB_TAG_2 = dataList[10]
}

t_mi_rui_ke_hud_common.dataList = dataList

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

return t_mi_rui_ke_hud_common
