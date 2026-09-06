-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sourcemon_upgrade.lua

module("logicconfig.config.t_sourcemon_upgrade", package.seeall)

local title = {
	value = 1,
	beanCost = 3,
	rates = 2
}
local dataList = {}
local t_sourcemon_upgrade = {}

t_sourcemon_upgrade.dataList = dataList

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

return t_sourcemon_upgrade
