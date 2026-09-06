-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fight_planetarium_game.lua

module("logicconfig.config.t_origin_fight_planetarium_game", package.seeall)

local title = {
	stageId = 1,
	linkage = 5,
	bgName = 6,
	startAngle = 3,
	rotateAngle = 4,
	ringId = 2
}
local dataList = {
	{
		1,
		1,
		-90,
		90,
		2,
		"board_gxzb_zhuanpan09"
	},
	{
		1,
		2,
		90,
		-90,
		3,
		"board_gxzb_zhuanpan08"
	},
	{
		1,
		3,
		0,
		180,
		1,
		"board_gxzb_zhuanpan07"
	}
}
local t_origin_fight_planetarium_game = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_fight_planetarium_game.dataList = dataList

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

return t_origin_fight_planetarium_game
