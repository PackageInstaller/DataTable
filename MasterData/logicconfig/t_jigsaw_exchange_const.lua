-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jigsaw_exchange_const.lua

module("logicconfig.config.t_jigsaw_exchange_const", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"ACTIVITYID",
		"122004"
	}
}
local t_jigsaw_exchange_const = {
	ACTIVITYID = dataList[1]
}

t_jigsaw_exchange_const.dataList = dataList

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

return t_jigsaw_exchange_const
