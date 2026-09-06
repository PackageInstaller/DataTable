-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_order_dragon_clg.lua

module("logicconfig.config.t_origin_order_dragon_clg", package.seeall)

local title = {
	gotoStr1 = 4,
	signBuffId = 2,
	gotoStr2 = 5,
	skinId = 3,
	gotoStr3 = 6,
	gotoStr4 = 7,
	activityId = 1,
	ruleKey = 8
}
local dataList = {
	{
		568001,
		30000007,
		11037,
		"func#618#11037",
		"ui#goddailyrankmainview#568001",
		"ui#lottery",
		"mibao#jinglingyangcheng",
		"yqzhixulong_rule"
	}
}
local t_origin_order_dragon_clg = {
	[568001] = dataList[1]
}

t_origin_order_dragon_clg.dataList = dataList

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

return t_origin_order_dragon_clg
