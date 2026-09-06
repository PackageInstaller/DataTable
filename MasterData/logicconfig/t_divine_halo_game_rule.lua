-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_halo_game_rule.lua

module("logicconfig.config.t_divine_halo_game_rule", package.seeall)

local title = {
	resPath = 3,
	pageId = 2,
	ruleId = 1,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		"ui/bigbg/copychapter/board_skmg_guize_01.png",
		"进入时空迷宫后，需要倒计时结束前脱出\r\n操纵遥感，移动光轮到达每个迷宫内的出口即可逃出"
	},
	{
		1,
		2,
		"ui/bigbg/copychapter/board_skmg_guize_03.png",
		"光轮触碰到时空迷宫内的跃迁装置，即可变换颜色\r\n变换颜色才可进入传送门、穿梭墙体"
	},
	{
		1,
		3,
		"ui/bigbg/copychapter/board_skmg_guize_02.png",
		"在迷宫内存在特殊的墙体，拾起钥匙后即可打开\r\n需变成与钥匙相同的颜色才可以拾起"
	}
}
local t_divine_halo_game_rule = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_divine_halo_game_rule.dataList = dataList

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

return t_divine_halo_game_rule
