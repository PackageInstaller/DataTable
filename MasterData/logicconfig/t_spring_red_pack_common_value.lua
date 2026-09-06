-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_spring_red_pack_common_value.lua

module("logicconfig.config.t_spring_red_pack_common_value", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"EDITION_ACTIVITY",
		"113009"
	},
	{
		"EDITION_FUNC",
		"1013"
	}
}
local t_spring_red_pack_common_value = {
	EDITION_ACTIVITY = dataList[1],
	EDITION_FUNC = dataList[2]
}

t_spring_red_pack_common_value.dataList = dataList

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

return t_spring_red_pack_common_value
