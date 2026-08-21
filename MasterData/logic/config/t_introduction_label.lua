-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_introduction_label.lua

module("logic.config.t_introduction_label", package.seeall)

local title = {
	id = 1
}
local dataList = {
	{
		1012
	},
	{
		1004
	},
	{
		1008
	},
	{
		1011
	},
	{
		1009
	},
	{
		1010
	},
	{
		1013
	}
}
local t_introduction_label = {}

t_introduction_label.dataList = dataList

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
	t_introduction_label[v[1]] = v

	setmetatable(v, mt)
end

return t_introduction_label
