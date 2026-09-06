-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ares_mom_activity.lua

module("logicconfig.config.t_divine_ares_mom_activity", package.seeall)

local title = {
	junpStr2 = 4,
	junpStr1 = 3,
	junpStr3 = 5,
	skinId = 6,
	showPrize = 7,
	activityId = 1,
	ruleTip = 2
}
local dataList = {
	{
		369001,
		"divine_Gasiri_rule",
		"func#618#13014",
		"mibao#yingsenzhuxiang1",
		"mibao#shenyaolibao",
		13014,
		"4:510300"
	}
}
local t_divine_ares_mom_activity = {
	[369001] = dataList[1]
}

t_divine_ares_mom_activity.dataList = dataList

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

return t_divine_ares_mom_activity
