-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_god_messenger.lua

module("logicconfig.config.t_star_god_messenger", package.seeall)

local title = {
	materialCost = 3,
	messengerId = 1,
	name = 2
}
local dataList = {}
local t_star_god_messenger = {}

t_star_god_messenger.dataList = dataList

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

return t_star_god_messenger
