-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_jing_road_fire_boss.lua

module("logicconfig.config.t_chuang_jing_road_fire_boss", package.seeall)

local title = {
	teamA = 3,
	activityId = 1,
	zoneId = 2,
	desc = 6,
	teamB = 4,
	compareTo = 5
}
local dataList = {
	{
		396001,
		3,
		105,
		106,
		"等于",
		"击败两阵时存活精灵相同即可获胜"
	}
}
local t_chuang_jing_road_fire_boss = {
	[396001] = {
		[3] = dataList[1]
	}
}

t_chuang_jing_road_fire_boss.dataList = dataList

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

return t_chuang_jing_road_fire_boss
