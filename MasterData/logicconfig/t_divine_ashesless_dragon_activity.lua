-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ashesless_dragon_activity.lua

module("logicconfig.config.t_divine_ashesless_dragon_activity", package.seeall)

local title = {
	jumpStrOne = 4,
	jumpStrTwo = 5,
	redPointId = 2,
	skinId = 3,
	jumpStrThree = 6,
	ruleKeyMain = 7,
	activityId = 1
}
local dataList = {
	{
		352001,
		564,
		12021,
		"func#618#12021",
		"ui#lottery",
		"mibao#shenyaolibao",
		"divineasheslessdragonmainview_rule"
	},
	{
		352002,
		0,
		12021,
		"func#618#12021",
		"ui#lottery",
		"mibao#shenyaolibao",
		"divineasheslessdragonmainview_rule"
	}
}
local t_divine_ashesless_dragon_activity = {
	[352001] = dataList[1],
	[352002] = dataList[2]
}

t_divine_ashesless_dragon_activity.dataList = dataList

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

return t_divine_ashesless_dragon_activity
