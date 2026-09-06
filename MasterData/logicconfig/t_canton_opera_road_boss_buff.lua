-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_canton_opera_road_boss_buff.lua

module("logicconfig.config.t_canton_opera_road_boss_buff", package.seeall)

local title = {
	raceId = 2,
	buffText = 3,
	planId = 1
}
local dataList = {
	{
		1,
		10002,
		"上阵XX精灵获得增益"
	}
}
local t_canton_opera_road_boss_buff = {
	dataList[1]
}

t_canton_opera_road_boss_buff.dataList = dataList

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

return t_canton_opera_road_boss_buff
