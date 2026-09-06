-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sourcemon_skill.lua

module("logicconfig.config.t_sourcemon_skill", package.seeall)

local title = {
	propertyParam = 4,
	name = 2,
	skillZdl = 5,
	skillId = 1,
	level = 7,
	num = 6,
	desc = 3
}
local dataList = {}
local t_sourcemon_skill = {}

t_sourcemon_skill.dataList = dataList

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

return t_sourcemon_skill
