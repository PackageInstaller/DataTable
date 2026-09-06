-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_ext_strength.lua

module("logicconfig.config.t_pet_ext_strength", package.seeall)

local title = {
	desc = 2,
	uniqueId = 1
}
local dataList = {
	{
		1,
		"无条件"
	}
}
local t_pet_ext_strength = {
	dataList[1]
}

t_pet_ext_strength.dataList = dataList

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

return t_pet_ext_strength
