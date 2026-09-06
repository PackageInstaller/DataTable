-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_manual_cube_exp.lua

module("logicconfig.config.t_pet_manual_cube_exp", package.seeall)

local title = {
	cubeExp = 2,
	petRaceId = 1
}
local dataList = {}
local t_pet_manual_cube_exp = {}

t_pet_manual_cube_exp.dataList = dataList

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

return t_pet_manual_cube_exp
