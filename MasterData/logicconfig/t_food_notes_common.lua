-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_food_notes_common.lua

module("logicconfig.config.t_food_notes_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"JUMP_SHOP",
		""
	},
	{
		"JUMP_ITEM",
		""
	},
	{
		"SHOW_SKINID",
		"15026"
	}
}
local t_food_notes_common = {
	JUMP_SHOP = dataList[1],
	JUMP_ITEM = dataList[2],
	SHOW_SKINID = dataList[3]
}

t_food_notes_common.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_food_notes_common
