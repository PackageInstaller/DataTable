-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_night_feast_boss_common.lua

module("logicconfig.config.t_night_feast_boss_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"ACTIVITY_ID",
		"335002"
	}
}
local t_night_feast_boss_common = {
	ACTIVITY_ID = dataList[1]
}

t_night_feast_boss_common.dataList = dataList

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

return t_night_feast_boss_common
