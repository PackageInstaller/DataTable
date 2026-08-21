-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_atk_free.lua

module("logic.config.t_air_atk_free", package.seeall)

local title = {
	id = 1,
	name = 2,
	endless = 3
}
local dataList = {
	{
		101,
		"简单",
		0
	},
	{
		102,
		"普通",
		0
	},
	{
		103,
		"困难",
		0
	},
	{
		104,
		"极难",
		0
	},
	{
		105,
		"无尽裂痕",
		1
	}
}
local t_air_atk_free = {}

t_air_atk_free.dataList = dataList

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
	t_air_atk_free[v[1]] = v

	setmetatable(v, mt)
end

return t_air_atk_free
