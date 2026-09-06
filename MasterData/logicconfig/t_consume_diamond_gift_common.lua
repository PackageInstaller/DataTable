-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_consume_diamond_gift_common.lua

module("logicconfig.config.t_consume_diamond_gift_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"consumeSource",
		"5659"
	}
}
local t_consume_diamond_gift_common = {
	consumeSource = dataList[1]
}

t_consume_diamond_gift_common.dataList = dataList

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

return t_consume_diamond_gift_common
