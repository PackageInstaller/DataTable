-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_down_client_common.lua

module("logicconfig.config.t_show_down_client_common", package.seeall)

local title = {
	rankShowTipsInFunc = 7,
	skinIdInFunc = 10,
	detailTips_1 = 3,
	skinId = 9,
	rankShowTips = 6,
	eliminateAutoCloseTime = 8,
	jumpStrShop = 11,
	detailTips_2 = 4,
	comPlanId = 1,
	ruleKeyMain = 2,
	detailTips_3 = 5,
	heatIconPath = 12
}
local dataList = {
	{
		1,
		"leitaisai_rule",
		"",
		"leitaisai_rule1",
		"leitaisai_rule2",
		"1.排行榜前2560名将进入小组赛\n2.将于%s结算",
		"1.娱乐赛排行榜积分\n2.间隔5分钟刷新一次排行榜信息",
		5,
		10324,
		10324,
		"func#191#360#360004",
		"ui/icon/items/com_icon_relizhi"
	}
}
local t_show_down_client_common = {
	dataList[1]
}

t_show_down_client_common.dataList = dataList

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

return t_show_down_client_common
