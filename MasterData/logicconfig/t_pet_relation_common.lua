-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_relation_common.lua

module("logicconfig.config.t_pet_relation_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"RADIUS",
		"120"
	},
	{
		"MIN_SCALE",
		"0.4"
	},
	{
		"MAX_SCALE",
		"1.5"
	},
	{
		"DEFAULT_SCALE",
		"1"
	}
}
local t_pet_relation_common = {
	RADIUS = dataList[1],
	MIN_SCALE = dataList[2],
	MAX_SCALE = dataList[3],
	DEFAULT_SCALE = dataList[4]
}

t_pet_relation_common.dataList = dataList

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

return t_pet_relation_common
