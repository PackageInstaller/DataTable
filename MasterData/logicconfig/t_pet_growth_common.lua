-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_growth_common.lua

module("logicconfig.config.t_pet_growth_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"HEART_RACEID",
		"11001"
	},
	{
		"HEART_OPENTIME",
		"2021-10-29 05:00:00"
	}
}
local t_pet_growth_common = {
	HEART_RACEID = dataList[1],
	HEART_OPENTIME = dataList[2]
}

t_pet_growth_common.dataList = dataList

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

return t_pet_growth_common
