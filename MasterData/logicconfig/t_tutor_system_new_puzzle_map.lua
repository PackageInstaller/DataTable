-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tutor_system_new_puzzle_map.lua

module("logicconfig.config.t_tutor_system_new_puzzle_map", package.seeall)

local title = {
	pointId = 1,
	imgPath = 2
}
local dataList = {
	{
		0,
		"picturepuzzle/tutorsystem/board_pt_01"
	},
	{
		1,
		"picturepuzzle/tutorsystem/board_pt_02"
	},
	{
		2,
		"picturepuzzle/tutorsystem/board_pt_03"
	},
	{
		3,
		"picturepuzzle/tutorsystem/board_pt_04"
	},
	{
		4,
		"picturepuzzle/tutorsystem/board_pt_05"
	},
	{
		5,
		"picturepuzzle/tutorsystem/board_pt_06"
	},
	{
		6,
		"picturepuzzle/tutorsystem/board_pt_07"
	},
	{
		7,
		"picturepuzzle/tutorsystem/board_pt_08"
	},
	{
		8,
		"picturepuzzle/tutorsystem/board_pt_09"
	},
	{
		9,
		"picturepuzzle/tutorsystem/board_pt_10"
	},
	{
		10,
		"picturepuzzle/tutorsystem/board_pt_11"
	},
	{
		11,
		"picturepuzzle/tutorsystem/board_pt_12"
	},
	{
		12,
		"picturepuzzle/tutorsystem/board_pt_13"
	},
	{
		13,
		"picturepuzzle/tutorsystem/board_pt_14"
	},
	{
		14,
		"picturepuzzle/tutorsystem/board_pt_15"
	}
}
local t_tutor_system_new_puzzle_map = {
	[0] = dataList[1],
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
	dataList[15]
}

t_tutor_system_new_puzzle_map.dataList = dataList

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

return t_tutor_system_new_puzzle_map
