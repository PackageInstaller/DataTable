-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_team_play_game.lua

module("logicconfig.config.t_team_play_game", package.seeall)

local title = {
	bossId = 9,
	name = 3,
	popRes = 5,
	expireSec = 8,
	typeId = 2,
	Res = 6,
	id = 1,
	gameTime = 7,
	des = 4
}
local dataList = {
	{
		1,
		1,
		"烤鸡腿",
		"快速点击翻转按钮，时间到点自动出炉并且给予对应的奖励",
		"",
		"",
		30,
		1814400,
		2
	},
	{
		2,
		1,
		"烤鸡腿",
		"快速点击翻转按钮，时间到点自动出炉并且给予对应的奖励。",
		"",
		"",
		50,
		1814400,
		13
	},
	{
		3,
		2,
		"小天飞",
		"点击屏幕可使小天上升一段距离，飞行距离越远，奖励越丰厚。",
		"",
		"",
		0,
		1814400,
		9
	},
	{
		4,
		3,
		"抓水母",
		"看准时机点击屏幕，使小诺飞向水母，要小心海胆和暗涌哦！",
		"",
		"",
		0,
		1814400,
		6
	}
}
local t_team_play_game = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_team_play_game.dataList = dataList

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

return t_team_play_game
