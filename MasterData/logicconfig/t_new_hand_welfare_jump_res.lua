-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_hand_welfare_jump_res.lua

module("logicconfig.config.t_new_hand_welfare_jump_res", package.seeall)

local title = {
	index = 2,
	periodId = 1,
	name = 3
}
local dataList = {
	{
		1,
		1,
		"board_thfl_17"
	},
	{
		1,
		2,
		"board_thfl_18"
	},
	{
		1,
		3,
		"board_thfl_19"
	},
	{
		2,
		1,
		"board_thfl_17"
	},
	{
		2,
		2,
		"board_thfl_18"
	},
	{
		2,
		3,
		"icon_lb_mdsqzx"
	},
	{
		3,
		1,
		"board_thfl_17"
	},
	{
		3,
		2,
		"board_thfl_18"
	},
	{
		3,
		3,
		"icon_lb_mdsqzx"
	},
	{
		4,
		1,
		"board_thfl_17"
	},
	{
		4,
		2,
		"board_thfl_18"
	},
	{
		4,
		3,
		"icon_lb_mdsqzx"
	},
	{
		5,
		1,
		"board_thfl_17"
	},
	{
		5,
		2,
		"board_thfl_18"
	},
	{
		5,
		3,
		"icon_lb_mdsqzx"
	},
	{
		6,
		1,
		"board_thfl_17"
	},
	{
		6,
		2,
		"board_thfl_18"
	},
	{
		6,
		3,
		"icon_lb_mdsqzx"
	}
}
local t_new_hand_welfare_jump_res = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15]
	},
	{
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_new_hand_welfare_jump_res.dataList = dataList

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

return t_new_hand_welfare_jump_res
