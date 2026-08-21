-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_player_card_attribute_mainline.lua

module("logic.config.t_player_card_attribute_mainline", package.seeall)

local title = {
	id = 2,
	code = 1
}
local dataList = {
	{
		1,
		110116
	},
	{
		2,
		110138
	},
	{
		3,
		110214
	},
	{
		4,
		110238
	},
	{
		5,
		110317
	},
	{
		6,
		110338
	}
}
local t_player_card_attribute_mainline = {}

t_player_card_attribute_mainline.dataList = dataList

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
	t_player_card_attribute_mainline[v[1]] = v

	setmetatable(v, mt)
end

return t_player_card_attribute_mainline
