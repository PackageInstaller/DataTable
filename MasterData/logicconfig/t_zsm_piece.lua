-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zsm_piece.lua

module("logicconfig.config.t_zsm_piece", package.seeall)

local title = {
	id = 1,
	score = 3,
	imgPath = 2
}
local dataList = {
	{
		1,
		"board_jztb_19",
		8
	},
	{
		2,
		"board_jztb_21",
		12
	},
	{
		3,
		"board_jztb_20",
		16
	}
}
local t_zsm_piece = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_zsm_piece.dataList = dataList

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

return t_zsm_piece
