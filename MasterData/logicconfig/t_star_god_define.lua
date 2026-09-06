-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_god_define.lua

module("logicconfig.config.t_star_god_define", package.seeall)

local title = {
	baseExp = 8,
	name = 2,
	starGodType = 4,
	quality = 5,
	description = 9,
	starGodDefineId = 1,
	typeName = 3,
	sale = 7,
	icon = 6
}
local dataList = {}
local t_star_god_define = {}

t_star_god_define.dataList = dataList

local multiLanguageCells = {
	description = true,
	name = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_star_god_define
