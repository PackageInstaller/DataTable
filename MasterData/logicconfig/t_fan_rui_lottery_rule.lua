-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fan_rui_lottery_rule.lua

module("logicconfig.config.t_fan_rui_lottery_rule", package.seeall)

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
		"ui/bigbg/views/fanruichoujiang/board_frcj_07.png",
		"每次开始博弈时，需要选择一次出招，倒计时结束后，双方展开对拼。"
	},
	{
		1,
		2,
		"ui/bigbg/views/fanruichoujiang/board_frcj_08.png",
		"若对拼胜利，对方血量减少1格；若失败，自身血量减少；若平局，不扣除双方血量。"
	},
	{
		1,
		3,
		"ui/bigbg/views/fanruichoujiang/board_frcj_09.png",
		"当对方的血量扣除达3格时，博弈游戏结束，可获得翻倍鸡腿币；若己方失败，则返还部分鸡腿币。"
	}
}
local t_fan_rui_lottery_rule = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_fan_rui_lottery_rule.dataList = dataList

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

return t_fan_rui_lottery_rule
