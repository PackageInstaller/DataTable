-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_publicity_prize.lua

module("logicconfig.config.t_anniversary_publicity_prize", package.seeall)

local title = {
	wet = 6,
	name = 3,
	prize = 7,
	overDesc = 9,
	content = 10,
	redpoint = 11,
	planId = 1,
	desc = 8,
	endTime = 5,
	id = 2,
	startTime = 4
}
local dataList = {
	{
		1,
		1,
		"应援同人纪",
		"2022-07-01T05:00:00",
		"2022-07-29T05:00:00",
		"http://aqsy.100bt.com/zt-sysl?fromAct=sy-0701-banner",
		"104:2:50",
		"内容正在制作中，敬请期待",
		"活动已经结束",
		"<color=#657cb2><size=30>一周年生贺应援同人纪</size></color>\r\n<color=#657cb2><size=30>奥奇，一起再出发</size></color>\r\n\r\n时光匆匆而过，不知不觉，奥奇们已经陪伴小诺走过一年啦！！周年庆典的序幕即将拉开，奥奇城里的大家也在有条不紊地筹备着。小诺邀请奥奇们一起参与一周年生贺应援同人纪，共同庆祝这个特别的日子！\r\n参与活动将有机会获取丰厚奖励，期待奥奇们的优秀创作(๑•̀ㅂ•́)و✧\r\n\r\n<color=#657cb2><size=25>活动时间</size></color>\r\n投稿开启3.22-4.18\r\n投票期4.19-4.22\r\n评选期4.25-5.1\r\n公布结果5.6\r\n\r\n<color=#657cb2><size=25>活动内容</size></color>\r\n本次《奥奇传说》手游一周年生贺应援同人纪分「奥奇同人绘」和「奥奇映像」两个赛道，并且同时开启，独立评选奖励，奥奇可自由投稿。\r\n「奥奇同人绘」赛道包含所有图画类同人内容如插画、条漫、表情包等。\r\n「奥奇映像」赛道则包含所有哔哩哔哩可投稿的视频内容，如主题曲翻唱、奥奇主题的mad、攻略视频、绘画视频等。\r\n\r\n<color=#657cb2><size=25>活动奖励</size></color>\r\n包含京东卡+周年庆全新周边+海量神钻+小诺银饰+大触专属头像框/称号等\r\n\r\n<color=#657cb2><size=25>参与方式&参赛须知</size></color>\r\n请戳下方按钮，进入活动详情页查看~",
		"-210"
	}
}
local t_anniversary_publicity_prize = {
	{
		dataList[1]
	}
}

t_anniversary_publicity_prize.dataList = dataList

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

return t_anniversary_publicity_prize
