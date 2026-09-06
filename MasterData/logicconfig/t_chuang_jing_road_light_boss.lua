-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_jing_road_light_boss.lua

module("logicconfig.config.t_chuang_jing_road_light_boss", package.seeall)

local title = {
	creepsMasterId = 3,
	activityId = 1,
	zoneId = 2
}
local dataList = {
	{
		396001,
		1,
		102
	}
}
local t_chuang_jing_road_light_boss = {
	[396001] = {
		dataList[1]
	}
}

t_chuang_jing_road_light_boss.dataList = dataList

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

return t_chuang_jing_road_light_boss
