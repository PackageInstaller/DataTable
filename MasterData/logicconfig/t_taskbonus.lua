-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_taskbonus.lua

module("logicconfig.config.t_taskbonus", package.seeall)

local title = {
	stepId = 2,
	bonusType = 3,
	bonus = 4,
	taskId = 1
}
local dataList = {}
local t_taskbonus = {}

t_taskbonus.dataList = dataList

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

return t_taskbonus
