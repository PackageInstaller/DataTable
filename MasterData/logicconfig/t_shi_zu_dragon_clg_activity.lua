-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shi_zu_dragon_clg_activity.lua

module("logicconfig.config.t_shi_zu_dragon_clg_activity", package.seeall)

local title = {
	jumpToPrize = 4,
	jumpToCard = 5,
	jumpToFirstRank = 3,
	jumpToRank = 6,
	raceId = 2,
	activityId = 1
}
local dataList = {
	{
		500001,
		12037,
		"event#gotofirstpassrankview#500001",
		"mibao#ZhounianShop2",
		"func#1246",
		"func#618#12037"
	}
}
local t_shi_zu_dragon_clg_activity = {
	[500001] = dataList[1]
}

t_shi_zu_dragon_clg_activity.dataList = dataList

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

return t_shi_zu_dragon_clg_activity
