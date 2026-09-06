-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_god_level_define.lua

module("logicconfig.config.t_star_god_level_define", package.seeall)

local title = {
	description = 6,
	propertyApp = 5,
	zhanDouLi = 4,
	exp = 3,
	starGodDefineId = 1,
	level = 2
}
local dataList = {}
local t_star_god_level_define = {}

t_star_god_level_define.dataList = dataList

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

return t_star_god_level_define
