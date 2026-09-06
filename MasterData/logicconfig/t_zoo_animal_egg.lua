-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_animal_egg.lua

module("logicconfig.config.t_zoo_animal_egg", package.seeall)

local title = {
	id = 1
}
local dataList = {
	{
		1
	}
}
local t_zoo_animal_egg = {
	dataList[1]
}

t_zoo_animal_egg.dataList = dataList

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

return t_zoo_animal_egg
