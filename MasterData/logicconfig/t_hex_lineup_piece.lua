-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hex_lineup_piece.lua

module("logicconfig.config.t_hex_lineup_piece", package.seeall)

local title = {
	offsets = 2,
	pieceId = 1
}
local dataList = {
	{
		1,
		"0:0"
	},
	{
		2,
		"0:0#1:0"
	},
	{
		3,
		"0:0#0:1"
	},
	{
		4,
		"0:0#-1:1"
	},
	{
		5,
		"0:0#1:0#2:0#3:0"
	},
	{
		6,
		"0:0#1:0#0:1#1:1"
	},
	{
		7,
		"0:0#1:0#2:0#1:1"
	},
	{
		8,
		"0:0#1:-1#1:0#0:1"
	},
	{
		9,
		"0:0#-1:1#0:1#1:0"
	},
	{
		10,
		"0:0#1:-1#1:0#2:-2"
	},
	{
		11,
		"0:0#0:1#0:2#1:0"
	},
	{
		12,
		"0:0#0:1#1:-1#2:-1"
	},
	{
		13,
		"0:0#0:2#1:0#1:1"
	},
	{
		14,
		"0:0#0:1#0:2#1:1"
	},
	{
		15,
		"0:0#0:1#1:0#2:-1"
	},
	{
		16,
		"0:0#1:-2#1:-1#2:-2"
	},
	{
		17,
		"0:0#1:-2#1:-1#1:0"
	},
	{
		18,
		"0:0#1:-1#2:-2#3:-3"
	},
	{
		19,
		"0:0#0:1#0:2#0:3"
	},
	{
		20,
		"0:0#1:-1#2:-1#2:0"
	},
	{
		21,
		"0:0#0:1#1:1#2:0"
	},
	{
		22,
		"0:0#0:1#1:0#2:0"
	},
	{
		23,
		"0:0#1:0#2:0#3:0#4:0"
	},
	{
		24,
		"0:0#1:-1#1:0#2:-1#2:0"
	},
	{
		25,
		"0:0#0:1#1:0#1:1#2:0"
	},
	{
		26,
		"0:0#0:1#1:-1#1:0#2:-1"
	},
	{
		27,
		"0:0#1:-1#1:0#2:-2#2:-1"
	},
	{
		28,
		"0:0#0:1#0:2#0:3#0:4"
	},
	{
		29,
		"0:0#1:-1#2:-2#3:-3#4:-4"
	},
	{
		30,
		"0:0#1:-1#1:0#2:-2#3:-3"
	},
	{
		31,
		"0:0#1:-1#2:-3#2:-2#3:-3"
	},
	{
		32,
		"0:0#0:1#0:2#0:3#1:0"
	},
	{
		33,
		"0:0#1:-3#1:-2#1:-1#1:0"
	},
	{
		34,
		"0:0#1:-2#1:-1#1:0#2:-2"
	}
}
local t_hex_lineup_piece = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21],
	dataList[22],
	dataList[23],
	dataList[24],
	dataList[25],
	dataList[26],
	dataList[27],
	dataList[28],
	dataList[29],
	dataList[30],
	dataList[31],
	dataList[32],
	dataList[33],
	dataList[34]
}

t_hex_lineup_piece.dataList = dataList

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

return t_hex_lineup_piece
