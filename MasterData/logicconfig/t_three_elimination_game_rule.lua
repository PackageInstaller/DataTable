-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_elimination_game_rule.lua

module("logicconfig.config.t_three_elimination_game_rule", package.seeall)

local title = {
	id = 2,
	res = 3,
	ruleId = 1,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		"ui/bigbg/naiwanwanfa/board_naiwanwanfa_26.png",
		"<color=#C54949>拖动精灵和其他任意精灵交换位置</color>，达成一条直线或者斜线满足三只相同的精灵以上可升级"
	},
	{
		1,
		2,
		"ui/bigbg/naiwanwanfa/board_naiwanwanfa_27.png",
		"消除会生成作战单位到待机区,一次性消除越多生成作战单位越多"
	},
	{
		1,
		3,
		"ui/bigbg/naiwanwanfa/board_naiwanwanfa_28.png",
		"<color=#C54949>直接拖动精灵</color>到左侧也可以上阵"
	}
}
local t_three_elimination_game_rule = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_three_elimination_game_rule.dataList = dataList

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

return t_three_elimination_game_rule
