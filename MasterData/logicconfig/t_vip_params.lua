-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_vip_params.lua

module("logicconfig.config.t_vip_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"SKIP_FIGHT_LV_LIMIT",
		"25"
	}
}
local t_vip_params = {
	SKIP_FIGHT_LV_LIMIT = dataList[1]
}

t_vip_params.dataList = dataList

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

return t_vip_params
