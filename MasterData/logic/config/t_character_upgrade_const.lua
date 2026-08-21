-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_character_upgrade_const.lua

module("logic.config.t_character_upgrade_const", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"goldPerExp",
		"1"
	}
}
local t_character_upgrade_const = {}

t_character_upgrade_const.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_character_upgrade_const[v[1]] = v

	setmetatable(v, mt)
end

return t_character_upgrade_const
