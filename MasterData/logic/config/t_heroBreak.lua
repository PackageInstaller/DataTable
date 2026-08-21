-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_heroBreak.lua

module("logic.config.t_heroBreak", package.seeall)

local title = {
	breakLv = 1,
	needNum = 2
}
local dataList = {
	{
		1,
		1
	},
	{
		2,
		1
	},
	{
		3,
		1
	},
	{
		4,
		1
	},
	{
		5,
		1
	}
}
local t_heroBreak = {}

t_heroBreak.dataList = dataList

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
	t_heroBreak[v[1]] = v

	setmetatable(v, mt)
end

return t_heroBreak
