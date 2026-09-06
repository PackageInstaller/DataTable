-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_theater_dialog.lua

module("logicconfig.config.t_theater_dialog", package.seeall)

local title = {
	id = 1,
	content = 2
}
local dataList = {
	{
		1,
		"你居然……看到了我的睡相。"
	},
	{
		2,
		"你昨晚睡觉我帮你把眼罩摘下来了！"
	},
	{
		3,
		"我不是、我没有。"
	},
	{
		4,
		"暗天使，你是天生的面瘫吗？"
	},
	{
		5,
		"淡定，我会罩着大家的。"
	},
	{
		6,
		"快点复活队友！"
	},
	{
		7,
		"你的体重我带不动。"
	},
	{
		8,
		"暗天使，你可以带我飞吗？"
	},
	{
		9,
		"我看起来像神棍？！"
	},
	{
		10,
		"大神，帮我改个富二代命格吧~"
	},
	{
		11,
		"秃……秃如起来？？离我远点！"
	},
	{
		12,
		"你的羽毛真漂亮，拔几根给我留念呗。"
	},
	{
		13,
		"那是……赏给你的标本！"
	},
	{
		14,
		"你每次飞翔都掉羽毛，是不是有脱发嫌疑？"
	},
	{
		15,
		"……给你重新组织语言的机会。"
	},
	{
		16,
		"日盲症发作的你就像个柔弱无助的小可爱诶~"
	},
	{
		17,
		"有、有什么事？说人话。"
	},
	{
		18,
		"亲爱的天道·永夜磁暴·魔神使，有事相求……"
	},
	{
		19,
		"谢谢，感觉马上能摆摊算命。"
	},
	{
		20,
		"收到我送给你的墨镜吗？日盲症患者的福音。"
	},
	{
		21,
		"可能因为……看上去比较黑……？"
	},
	{
		22,
		"为什么大家都以为你很坏？"
	},
	{
		23,
		"没说错啊，十分简单，九十分很难。"
	},
	{
		24,
		"次元圣龙的考试那么难！你还说十分简单！"
	},
	{
		25,
		"这一秒就是下一秒的过去，现在趁早行动起来。"
	},
	{
		26,
		"好想回到过去改变一切啊……"
	},
	{
		27,
		"不要看不起“鸟语”，这也是一门外语！"
	},
	{
		28,
		"你可以跟鸟对话？！"
	}
}
local t_theater_dialog = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21],
	dataList[22],
	dataList[23],
	dataList[24],
	dataList[25],
	dataList[26],
	dataList[27],
	dataList[28]
}

t_theater_dialog.dataList = dataList

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

return t_theater_dialog
