-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_main_interact_element_r.lua

module("logic.config.t_main_interact_element_r", package.seeall)

local title = {
	id = 1,
	charSysCamGroup = 2
}
local dataList = {
	{
		10001,
		1
	},
	{
		10002,
		2
	},
	{
		10003,
		2
	},
	{
		10004,
		2
	},
	{
		10005,
		2
	},
	{
		10006,
		2
	},
	{
		10007,
		2
	},
	{
		15000,
		2
	},
	{
		20001,
		1
	},
	{
		20002,
		1
	},
	{
		20003,
		1
	}
}
local t_main_interact_element_r = {}

t_main_interact_element_r.dataList = dataList

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
	t_main_interact_element_r[v[1]] = v

	setmetatable(v, mt)
end

return t_main_interact_element_r
