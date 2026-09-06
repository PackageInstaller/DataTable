-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_zhengli_activity.lua

module("logicconfig.config.t_origin_zhengli_activity", package.seeall)

local title = {
	firstPassPrize = 3,
	gotoStrs = 6,
	startingStageId = 2,
	skinId = 4,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		587001,
		5,
		"4:510778:100",
		15049,
		"yqzhengli_rule",
		{
			"event#gotofirstpassrankview#587001",
			"func#618#15049",
			"ui#lottery",
			"mibao#jinglingyangcheng"
		}
	}
}
local t_origin_zhengli_activity = {
	[587001] = dataList[1]
}

t_origin_zhengli_activity.dataList = dataList

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

return t_origin_zhengli_activity
