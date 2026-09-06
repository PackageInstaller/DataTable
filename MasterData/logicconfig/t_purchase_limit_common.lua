-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_purchase_limit_common.lua

module("logicconfig.config.t_purchase_limit_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"SHOW_ACTID",
		"298001"
	}
}
local t_purchase_limit_common = {
	SHOW_ACTID = dataList[1]
}

t_purchase_limit_common.dataList = dataList

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

return t_purchase_limit_common
