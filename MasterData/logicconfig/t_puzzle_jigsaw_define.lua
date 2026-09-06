-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_puzzle_jigsaw_define.lua

module("logicconfig.config.t_puzzle_jigsaw_define", package.seeall)

local title = {
	openDay = 3,
	grayIcon = 4,
	baseIcon = 6,
	prize = 8,
	planId = 1,
	jigsawId = 2,
	icon = 5,
	shareId = 9,
	shareIcon = 7
}
local dataList = {
	{
		1,
		2,
		1,
		"board_kcyr_bg03",
		"board_kcyr_bg04",
		"board_kcyr_pintu01",
		"board_kcyr_fx01",
		"4:36:1#4:502:10",
		4
	},
	{
		1,
		3,
		2,
		"board_kcyr_bg07",
		"board_kcyr_bg08",
		"board_kcyr_pintu02",
		"board_kcyr_tmw01",
		"4:36:1#4:30001:10",
		5
	},
	{
		1,
		4,
		3,
		"board_kcyr_bg09",
		"board_kcyr_bg10",
		"board_kcyr_pintu03",
		"board_kcyr_tmw02",
		"4:36:1#4:3:10",
		6
	}
}
local t_puzzle_jigsaw_define = {
	{
		[2] = dataList[1],
		[3] = dataList[2],
		[4] = dataList[3]
	}
}

t_puzzle_jigsaw_define.dataList = dataList

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

return t_puzzle_jigsaw_define
