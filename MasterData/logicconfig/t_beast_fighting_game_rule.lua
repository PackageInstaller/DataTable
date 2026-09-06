-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_fighting_game_rule.lua

module("logicconfig.config.t_beast_fighting_game_rule", package.seeall)

local title = {
	index = 1,
	picturePath = 2,
	desc = 3
}
local dataList = {
	{
		1,
		"doushouqi/board_doushouqi_gz_01",
		"斗兽棋中双方轮流消耗步数，吃棋需按照克制条进行，克制条上的棋子可以吃掉其右边的所有棋子；但奥奇是唯一可吃掉凡尔维斯的棋子。\r\n斐希司>王者次元龙>时空龙尊>修诺>小天>小炎>呆呆鸭>奥奇"
	},
	{
		2,
		"doushouqi/board_doushouqi_gz_02",
		"斗兽棋中，己方棋子下方显示为黄色，点击棋子后，选择格子即可移动；\r\n每回合仅可进行翻棋/移动其中一步，使用技能不消耗步数"
	},
	{
		3,
		"doushouqi/board_doushouqi_gz_03",
		"围虎棋中双方轮流进行操作，默认红方先行，己方棋子下方显示为黄色\r\n红棋仅有1只，蓝棋有16只，当超过30回合时，游戏平局"
	},
	{
		4,
		"doushouqi/board_doushouqi_gz_04",
		"蓝棋获胜条件：需要将红棋所有出路用蓝棋堵住，即可围棋成功\r\n蓝棋无法吃棋"
	},
	{
		7,
		"doushouqi/board_doushouqi_gz_07",
		"红棋获胜条件：成功吃掉蓝棋8个，红棋即可突围成功"
	},
	{
		5,
		"doushouqi/board_doushouqi_gz_05",
		"红棋吃棋需满足：①与被吃蓝棋位于同一直线上；②位于2个蓝棋中间；③这条直线上，被吃的蓝棋旁边没有链接其他蓝棋"
	},
	{
		6,
		"doushouqi/board_doushouqi_gz_06",
		"如图中情况所示，蓝棋旁边还链接别的蓝棋，该种情况下则无法吃棋噢"
	}
}
local t_beast_fighting_game_rule = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	[7] = dataList[5],
	dataList[6],
	dataList[7]
}

t_beast_fighting_game_rule.dataList = dataList

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

return t_beast_fighting_game_rule
