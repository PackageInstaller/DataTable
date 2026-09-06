-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_dispatch_common_config.lua

module("logicconfig.config.t_pet_dispatch_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"GAIN_BOX_PRIZE_SECURITY_TIMES",
		"15"
	},
	{
		"SECURITY_BOX_QUALITY",
		"5"
	}
}
local t_pet_dispatch_common_config = {
	GAIN_BOX_PRIZE_SECURITY_TIMES = dataList[1],
	SECURITY_BOX_QUALITY = dataList[2]
}

t_pet_dispatch_common_config.dataList = dataList

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

return t_pet_dispatch_common_config
