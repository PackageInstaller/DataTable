-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_game_rule.lua

module("logicconfig.config.t_beast_rich_man_game_rule", package.seeall)

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
		"ui/bigbg/copychapter/board_ruishoudafuwengguize_01.png",
		"路径格子说明"
	},
	{
		1,
		2,
		"ui/bigbg/copychapter/board_ruishoudafuwengguize_02.png",
		"固定建筑说明"
	},
	{
		1,
		3,
		"ui/bigbg/copychapter/board_ruishoudafuwengguize_03.png",
		"挑战瑞兽说明"
	}
}
local t_beast_rich_man_game_rule = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_beast_rich_man_game_rule.dataList = dataList

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

return t_beast_rich_man_game_rule
