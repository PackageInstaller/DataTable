-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_tacitStage.lua

module("logic.config.t_tacitStage", package.seeall)

local title = {
	id = 1,
	level = 2
}
local dataList = {
	{
		1,
		0
	},
	{
		2,
		2
	},
	{
		3,
		4
	}
}
local t_tacitStage = {}

t_tacitStage.dataList = dataList

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
	t_tacitStage[v[1]] = v

	setmetatable(v, mt)
end

return t_tacitStage
