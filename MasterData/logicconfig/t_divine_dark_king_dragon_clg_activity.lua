-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dark_king_dragon_clg_activity.lua

module("logicconfig.config.t_divine_dark_king_dragon_clg_activity", package.seeall)

local title = {
	jumpToShop = 6,
	jumpToRank = 4,
	jumpToFirstPass = 7,
	skinId = 2,
	jumpToCall = 5,
	activityId = 1,
	ruleKey = 3
}
local dataList = {
	{
		526001,
		15039,
		"divine_dark_king_dragon_rule",
		"func#618#15039",
		"ui#lottery",
		"mibao#jinglingyangcheng",
		"event#gotofirstpassrankview#526001"
	}
}
local t_divine_dark_king_dragon_clg_activity = {
	[526001] = dataList[1]
}

t_divine_dark_king_dragon_clg_activity.dataList = dataList

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

return t_divine_dark_king_dragon_clg_activity
