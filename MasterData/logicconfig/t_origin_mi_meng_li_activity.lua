-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_mi_meng_li_activity.lua

module("logicconfig.config.t_origin_mi_meng_li_activity", package.seeall)

local title = {
	gotoStrs = 5,
	memoryEffPath = 6,
	dreamEffPath = 7,
	skinId = 3,
	ruleKey = 4,
	activityId = 1,
	passPrize = 2
}
local dataList = {
	{
		621001,
		"4:510848:100",
		12047,
		"originmimenglimainview_rule",
		{
			"func#618#12047",
			"mibao#jinglingyangcheng",
			"ui#lottery",
			"event#gotofirstpassrankview#621001"
		},
		"fx_ui_jinglinggezi/fx_ui_buzhen_08",
		"fx_ui_jinglinggezi/fx_ui_buzhen_02"
	}
}
local t_origin_mi_meng_li_activity = {
	[621001] = dataList[1]
}

t_origin_mi_meng_li_activity.dataList = dataList

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

return t_origin_mi_meng_li_activity
