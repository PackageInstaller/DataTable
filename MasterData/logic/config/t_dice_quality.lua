-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_dice_quality.lua

module("logic.config.t_dice_quality", package.seeall)

local title = {
	decomposedItem = 2,
	quality = 1
}
local dataList = {
	{
		2,
		"{1008001:1}"
	},
	{
		3,
		"{1008001:1}"
	},
	{
		4,
		"{1008001:1}"
	},
	{
		5,
		"{1008001:1}"
	}
}
local t_dice_quality = {}

t_dice_quality.dataList = dataList

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
	t_dice_quality[v[1]] = v

	setmetatable(v, mt)
end

return t_dice_quality
