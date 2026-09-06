-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shadow_dragon_clg_activity.lua

module("logicconfig.config.t_shadow_dragon_clg_activity", package.seeall)

local title = {
	futurePassTierPrize = 5,
	openTime = 2,
	nowTierPrize = 4,
	skinId = 6,
	paramStr = 7,
	activityId = 1,
	futureBuffs = 3
}
local dataList = {
	{
		527001,
		"2025-11-07 09:00:00",
		"20068010:99",
		"4:510597:60",
		"4:510597:60",
		15041,
		"{\"jumpStr1\":\"func#618#15041\",\"jumpStr2\":\"func#545#70\",\"jumpStr3\":\"func#1283\",\"jumpStr4\":\"event#gotofirstpassrankview#527001\"}"
	}
}
local t_shadow_dragon_clg_activity = {
	[527001] = dataList[1]
}

t_shadow_dragon_clg_activity.dataList = dataList

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

return t_shadow_dragon_clg_activity
