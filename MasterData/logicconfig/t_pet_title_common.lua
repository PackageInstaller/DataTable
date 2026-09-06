-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_title_common.lua

module("logicconfig.config.t_pet_title_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"SPILL_CONVERT",
		"8:1:1000"
	}
}
local t_pet_title_common = {
	SPILL_CONVERT = dataList[1]
}

t_pet_title_common.dataList = dataList

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

return t_pet_title_common
