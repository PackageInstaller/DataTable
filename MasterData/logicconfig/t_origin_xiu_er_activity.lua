-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_xiu_er_activity.lua

module("logicconfig.config.t_origin_xiu_er_activity", package.seeall)

local title = {
	banNeedMarkNum = 3,
	jumpTo = 6,
	buffId = 2,
	skinId = 5,
	ruleKeyMain = 4,
	activityId = 1
}
local dataList = {
	{
		537001,
		20067902,
		3,
		"orginxiuermainview_rule",
		15042,
		{
			"func#618#15042",
			"mibao#MibaoShop",
			"ui#lottery",
			"func#545#52",
			"func#545#52"
		}
	}
}
local t_origin_xiu_er_activity = {
	[537001] = dataList[1]
}

t_origin_xiu_er_activity.dataList = dataList

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

return t_origin_xiu_er_activity
