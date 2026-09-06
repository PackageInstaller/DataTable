-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_jing_road_water_boss.lua

module("logicconfig.config.t_chuang_jing_road_water_boss", package.seeall)

local title = {
	teamA = 3,
	activityId = 1,
	zoneId = 2,
	damageGap = 5,
	teamB = 4,
	desc = 6
}
local dataList = {
	{
		396001,
		2,
		103,
		104,
		1000000,
		"对每个BOSS造成最低三千万伤害且伤害差值不高于100万时获胜"
	}
}
local t_chuang_jing_road_water_boss = {
	[396001] = {
		[2] = dataList[1]
	}
}

t_chuang_jing_road_water_boss.dataList = dataList

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

return t_chuang_jing_road_water_boss
