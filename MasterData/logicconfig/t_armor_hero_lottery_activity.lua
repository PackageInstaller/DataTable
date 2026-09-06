-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_armor_hero_lottery_activity.lua

module("logicconfig.config.t_armor_hero_lottery_activity", package.seeall)

local title = {
	cost = 3,
	redPointId = 2,
	taskJump = 4,
	shopJump = 5,
	raceId = 6,
	activityId = 1
}
local dataList = {
	{
		553001,
		753,
		"10:553001:1",
		"itemsource#10:553001",
		"mibao#kaijiamanghe",
		1203901
	},
	{
		553002,
		753,
		"10:553002:1",
		"itemsource#10:553002",
		"ui#commongrouptaskmainview#553002",
		1032204
	}
}
local t_armor_hero_lottery_activity = {
	[553001] = dataList[1],
	[553002] = dataList[2]
}

t_armor_hero_lottery_activity.dataList = dataList

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

return t_armor_hero_lottery_activity
