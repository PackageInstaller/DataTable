-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_seek_pet_common_config.lua

module("logicconfig.config.t_seek_pet_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CHALLENGE_TIMES",
		"5"
	},
	{
		"DIRECTIONAL_SEEK_COST",
		"8:1:1000"
	}
}
local t_seek_pet_common_config = {
	CHALLENGE_TIMES = dataList[1],
	DIRECTIONAL_SEEK_COST = dataList[2]
}

t_seek_pet_common_config.dataList = dataList

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

return t_seek_pet_common_config
