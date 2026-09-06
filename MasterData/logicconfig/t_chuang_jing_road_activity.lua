-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_jing_road_activity.lua

module("logicconfig.config.t_chuang_jing_road_activity", package.seeall)

local title = {
	lvlupCost = 12,
	awakenOpen = 8,
	equipmentOpen = 5,
	jumpTo = 9,
	bossRaceId = 10,
	starGodPlusOpen = 6,
	bossCreepsMasterId = 2,
	buyCost = 11,
	holyStripeOpen = 7,
	fightBossCost = 3,
	redPointId = 4,
	mainCost = 13,
	activityId = 1
}
local dataList = {
	{
		396001,
		101,
		"66:13:6",
		600,
		6,
		4,
		2,
		8,
		"func#191#396#396001",
		"10354",
		"10:396002:1",
		"10:396001:1",
		"66:13:1"
	}
}
local t_chuang_jing_road_activity = {
	[396001] = dataList[1]
}

t_chuang_jing_road_activity.dataList = dataList

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

return t_chuang_jing_road_activity
