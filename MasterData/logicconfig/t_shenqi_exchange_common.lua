-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shenqi_exchange_common.lua

module("logicconfig.config.t_shenqi_exchange_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"SHOW_ITEM",
		"4:126"
	}
}
local t_shenqi_exchange_common = {
	SHOW_ITEM = dataList[1]
}

t_shenqi_exchange_common.dataList = dataList

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

return t_shenqi_exchange_common
