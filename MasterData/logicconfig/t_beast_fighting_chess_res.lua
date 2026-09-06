-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_fighting_chess_res.lua

module("logicconfig.config.t_beast_fighting_chess_res", package.seeall)

local title = {
	resName = 2,
	tagDesc = 3,
	level = 1
}
local dataList = {
	{
		1,
		"board_doushouqi_qizi_11",
		"仅可吃斐"
	},
	{
		2,
		"board_doushouqi_qizi_10",
		""
	},
	{
		3,
		"board_doushouqi_qizi_09",
		""
	},
	{
		4,
		"board_doushouqi_qizi_08",
		""
	},
	{
		5,
		"board_doushouqi_qizi_07",
		""
	},
	{
		6,
		"board_doushouqi_qizi_06",
		""
	},
	{
		7,
		"board_doushouqi_qizi_05",
		""
	},
	{
		8,
		"board_doushouqi_qizi_12",
		"仅被奇吃"
	}
}
local t_beast_fighting_chess_res = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_beast_fighting_chess_res.dataList = dataList

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

return t_beast_fighting_chess_res
