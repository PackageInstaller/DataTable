-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mahjong_battle_activity.lua

module("logicconfig.config.t_mahjong_battle_activity", package.seeall)

local title = {
	gotoTask = 3,
	ruleKey = 4,
	goldBarStr = 5,
	activityId = 1,
	gotoShop = 2
}
local dataList = {
	{
		571001,
		"func#191#571#571001",
		"ui#commongrouptaskmainview#571001",
		"majiang_rule",
		"10:571001"
	}
}
local t_mahjong_battle_activity = {
	[571001] = dataList[1]
}

t_mahjong_battle_activity.dataList = dataList

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

return t_mahjong_battle_activity
