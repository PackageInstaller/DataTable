-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_duo_la_mm_piece.lua

module("logicconfig.config.t_duo_la_mm_piece", package.seeall)

local title = {
	gainLimit = 5,
	gain = 2,
	consume = 3,
	id = 1,
	buyLimit = 4
}
local dataList = {
	{
		1,
		"10:17014:1",
		"105:162:10",
		10,
		120
	},
	{
		2,
		"10:17015:1",
		"105:162:10",
		10,
		120
	},
	{
		3,
		"10:17016:1",
		"105:162:10",
		10,
		120
	}
}
local t_duo_la_mm_piece = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_duo_la_mm_piece.dataList = dataList

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

return t_duo_la_mm_piece
