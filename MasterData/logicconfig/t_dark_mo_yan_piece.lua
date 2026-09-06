-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_mo_yan_piece.lua

module("logicconfig.config.t_dark_mo_yan_piece", package.seeall)

local title = {
	buyLimit = 4,
	gainLimit = 5,
	consume = 3,
	id = 1,
	iconName = 2
}
local dataList = {
	{
		1,
		"board_yazhililiang_45",
		"105:162:10",
		1,
		999
	},
	{
		2,
		"board_yazhililiang_46",
		"105:162:10",
		1,
		999
	},
	{
		3,
		"board_yazhililiang_44",
		"105:162:10",
		1,
		999
	}
}
local t_dark_mo_yan_piece = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_dark_mo_yan_piece.dataList = dataList

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

return t_dark_mo_yan_piece
