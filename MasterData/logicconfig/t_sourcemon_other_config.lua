-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sourcemon_other_config.lua

module("logicconfig.config.t_sourcemon_other_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {}
local t_sourcemon_other_config = {}

t_sourcemon_other_config.dataList = dataList

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

return t_sourcemon_other_config
