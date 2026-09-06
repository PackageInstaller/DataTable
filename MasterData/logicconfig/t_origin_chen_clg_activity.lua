-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_chen_clg_activity.lua

module("logicconfig.config.t_origin_chen_clg_activity", package.seeall)

local title = {
	extRuleDesc = 6,
	jumpList = 5,
	suitPlanId = 3,
	skinId = 4,
	norRuleDesc = 7,
	activityId = 1,
	extremePrize = 2
}
local dataList = {
	{
		620001,
		"4:510844:100",
		1,
		16046,
		{
			"event#gotofirstpassrankview#620001",
			"func#618#16046",
			"mibao#jinglingyangcheng",
			"ui#lottery",
			"func#43#144"
		},
		82058249,
		82058248
	}
}
local t_origin_chen_clg_activity = {
	[620001] = dataList[1]
}

t_origin_chen_clg_activity.dataList = dataList

local multiLanguageCells = {
	norRuleDesc = true,
	extRuleDesc = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_origin_chen_clg_activity
