-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_canton_opera_road_common.lua

module("logicconfig.config.t_canton_opera_road_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"BOSS_PRIZE_PREVIEW",
		"10:17017#4:100000#8:1"
	},
	{
		"BOSS_STORYID",
		"4320001"
	}
}
local t_canton_opera_road_common = {
	BOSS_PRIZE_PREVIEW = dataList[1],
	BOSS_STORYID = dataList[2]
}

t_canton_opera_road_common.dataList = dataList

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

return t_canton_opera_road_common
