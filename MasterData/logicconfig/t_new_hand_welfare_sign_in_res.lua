-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_hand_welfare_sign_in_res.lua

module("logicconfig.config.t_new_hand_welfare_sign_in_res", package.seeall)

local title = {
	value = 3,
	periodId = 1,
	key = 2
}
local dataList = {
	{
		1,
		"leftIcon",
		"xinshoufuli/bg_xinshouhaoli"
	},
	{
		1,
		"7DayIcon",
		"xinshoufuli/board_thfl_04"
	},
	{
		2,
		"leftIcon",
		"xinshoufuli/bg_shenyaohuangjinlong"
	},
	{
		2,
		"7DayIcon",
		"xinshoufuli/board_shenyaohuangjinlong"
	},
	{
		3,
		"leftIcon",
		"xinshoufuli/board_xinshouyouhua_02"
	},
	{
		3,
		"7DayIcon",
		"xinshoufuli/board_shenyaohuangjinlong"
	},
	{
		4,
		"leftIcon",
		"xinshoufuli/board_xinshouyouhua_02"
	},
	{
		4,
		"7DayIcon",
		"xinshoufuli/board_shenyaohuangjinlong"
	},
	{
		5,
		"leftIcon",
		"xinshoufuli/board_xinshouyouhua_02"
	},
	{
		5,
		"7DayIcon",
		"xinshoufuli/board_shenyaohuangjinlong"
	},
	{
		6,
		"leftIcon",
		"xinshoufuli/board_xinshouyouhua_02"
	},
	{
		6,
		"7DayIcon",
		"xinshoufuli/board_shenyaohuangjinlong"
	}
}
local t_new_hand_welfare_sign_in_res = {
	{
		leftIcon = dataList[1],
		["7DayIcon"] = dataList[2]
	},
	{
		leftIcon = dataList[3],
		["7DayIcon"] = dataList[4]
	},
	{
		leftIcon = dataList[5],
		["7DayIcon"] = dataList[6]
	},
	{
		leftIcon = dataList[7],
		["7DayIcon"] = dataList[8]
	},
	{
		leftIcon = dataList[9],
		["7DayIcon"] = dataList[10]
	},
	{
		leftIcon = dataList[11],
		["7DayIcon"] = dataList[12]
	}
}

t_new_hand_welfare_sign_in_res.dataList = dataList

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

return t_new_hand_welfare_sign_in_res
