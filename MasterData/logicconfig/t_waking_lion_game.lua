-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_waking_lion_game.lua

module("logicconfig.config.t_waking_lion_game", package.seeall)

local title = {
	startTime = 8,
	name = 4,
	levelDesc = 5,
	type = 3,
	petPlanId = 11,
	shapePlanId = 12,
	prize = 9,
	desc = 6,
	intentionPlanId = 13,
	gameActivityId = 14,
	introduceId = 15,
	creepsMasterId = 10,
	ui = 7,
	activityId = 1,
	gameId = 2
}
local dataList = {
	{
		237001,
		1,
		1,
		"形",
		"南派醒狮又称为醒狮、瑞狮、雄狮等。狮头以戏剧脸谱三国时期的刘备、关羽、张飞等英雄人物作为搭配参考，每个脸谱颜色不同，代表的人物和意义都不同。舞动时注重形神、马步，首尾呼应，人狮合一，配上大锣、大鼓和广钹，气派十足。",
		"按照醒狮实物照片，为醒狮线稿上色吧~",
		"lioncultureshapeview",
		"2023-01-20T05:00:00",
		"4:31:5",
		0,
		0,
		1,
		0,
		0,
		0
	},
	{
		237001,
		2,
		2,
		"意",
		"舞狮者通过在地面或桩阵上腾、挪、闪、扑、回旋、飞跃等高难度动作演绎狮子喜、怒、哀、乐、惊、疑、动、静八态，表现狮子的威猛与刚劲。",
		"辨认左侧舞狮照片表达出的情绪，选择正确的醒狮表情吧~",
		"lionculturemeanview",
		"2023-01-22T05:00:00",
		"4:31:5",
		0,
		0,
		0,
		1,
		0,
		0
	},
	{
		237001,
		3,
		3,
		"声",
		"醒狮醒国魂，击鼓振精神。醒狮鼓乐由鼓、锣、镲组成，二醒狮大鼓是醒狮配乐的灵魂，狮子无论摇摆、叩拜、跳跃、采青等动作，都配有相应的鼓乐声。",
		"点击鼓面上的黄色圆圈处，即可为醒狮击鼓助威！",
		"lionculturevoiceview",
		"2023-01-24T05:00:00",
		"4:31:5",
		0,
		0,
		0,
		0,
		0,
		0
	},
	{
		237001,
		4,
		4,
		"阵",
		"醒狮阵型有五行青阵、灵蛇衔珠青阵、九宫八卦青阵等，寄托了期盼天时地利、人和兴旺、驱邪化煞、转运开运的美好期盼。",
		"操控小奥奇根据右上角的规则，探阵破阵，挑战渊魔吧！",
		"lioncultureformationview",
		"2023-01-26T05:00:00",
		"4:31:5",
		1001,
		1,
		0,
		0,
		0,
		1
	},
	{
		237001,
		5,
		5,
		"演",
		"醒狮表演必有采青，“青”指的是生菜，寓意生财。醒狮采青后便会吐青，把生菜撕碎，然后抛向四方，寓意遍地生菜（生财）。",
		"根据采青故事的上下文，将正确的醒狮表情拖拽至空白处，补完醒狮故事吧~",
		"lioncultureactview",
		"2023-01-28T05:00:00",
		"2:79:1",
		0,
		0,
		0,
		0,
		214002,
		0
	}
}
local t_waking_lion_game = {
	[237001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_waking_lion_game.dataList = dataList

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

return t_waking_lion_game
