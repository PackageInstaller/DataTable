-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_sign_in_landlady.lua

module("logic.config.t_sign_in_landlady", package.seeall)

local title = {
	dialogues = 4,
	type = 2,
	landlady = 3,
	formula = 1
}
local dataList = {
	{
		1,
		1,
		2000039,
		{
			1,
			5,
			6
		}
	},
	{
		2,
		2,
		2000039,
		{
			2,
			3,
			4
		}
	},
	{
		3,
		2,
		2000039,
		{
			7,
			8
		}
	}
}
local t_sign_in_landlady = {}

t_sign_in_landlady.dataList = dataList

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
	t_sign_in_landlady[v[1]] = v

	setmetatable(v, mt)
end

return t_sign_in_landlady
