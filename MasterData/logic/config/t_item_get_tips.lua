-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_item_get_tips.lua

module("logic.config.t_item_get_tips", package.seeall)

local title = {
	tips = 2,
	type = 1
}
local dataList = {
	{
		1,
		"必得"
	},
	{
		2,
		"大概率"
	},
	{
		3,
		"中概率"
	},
	{
		4,
		"小概率"
	}
}
local t_item_get_tips = {}

t_item_get_tips.dataList = dataList

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
	t_item_get_tips[v[1]] = v

	setmetatable(v, mt)
end

return t_item_get_tips
