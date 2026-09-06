-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guess_box_game_rule.lua

module("logicconfig.config.t_guess_box_game_rule", package.seeall)

local title = {
	txtRule = 4,
	pageId = 2,
	rulePlanId = 1,
	picturePath = 3
}
local dataList = {
	{
		1,
		1,
		"guessbox/board_yazhililiang_38",
		"蓝紫色花朵为正确鲜花，记下正确鲜花的位置哦"
	},
	{
		1,
		2,
		"guessbox/board_yazhililiang_37",
		"游戏开始后，花篮将随机变换位置，请记住正确鲜花变换到的位置哦"
	},
	{
		1,
		3,
		"guessbox/board_yazhililiang_36",
		"变换结束后，需要选择正确鲜花所在的篮子，游戏结束后将获得对应奖励"
	},
	{
		2,
		1,
		"guessbox/board_zhuomicang_anniu_05",
		"咦？调皮的小诺藏在雪人后面，想要和奥奇来一场捉迷藏！快记下小诺躲藏的位置吧~"
	},
	{
		2,
		2,
		"guessbox/board_zhuomicang_anniu_06",
		"游戏开始后，雪人将随机变换位置，专心观察，请记住小诺他们变换后的位置哦！"
	},
	{
		2,
		3,
		"guessbox/board_zhuomicang_anniu_07",
		"困难模式下，小诺他们将加大难度，还需要记住他们的出场顺序，按顺序找到会有积分翻倍的惊喜噢！"
	},
	{
		2,
		4,
		"guessbox/board_zhuomicang_anniu_08",
		"这一次的雪人会前后左右互换啦，奥奇，你能接住这个考验吗><？"
	},
	{
		2,
		5,
		"guessbox/board_zhuomicang_anniu_09",
		"在雪人们变换结束后，需要选择小诺他们所在的雪人噢！选择次数用完或倒计时结束后，游戏会结束并将获得积分~"
	},
	{
		3,
		1,
		"guessbox/board_wanglongfenshen_05",
		"调皮的小诺藏在王龙的真身后面，想要和奥奇来一场捉迷藏！快记下小诺躲藏的位置并选择出来"
	},
	{
		3,
		2,
		"guessbox/board_wanglongfenshen_06",
		"困难模式下，小诺他们将加大难度，还需要记住他们的出场顺序，按顺序找到会有积分翻倍的惊喜噢"
	},
	{
		3,
		3,
		"guessbox/board_wanglongfenshen_07",
		"在分身们变换结束后，需要选择小诺他们所在的王龙真身噢！选择次数用完或倒计时结束后，游戏会结束并结算积分~"
	},
	{
		4,
		1,
		"guessbox/board_wanglongfenshen_05",
		"解神和小奥奇藏在礼盒后面，快记下珍宝的位置并选择出来"
	},
	{
		4,
		2,
		"guessbox/board_wanglongfenshen_06",
		"需要记住角色的出场顺序，镜子还会前后交换位置"
	},
	{
		4,
		3,
		"guessbox/board_wanglongfenshen_07",
		"在镜子位置变换结束后，需要按角色出现顺序，选择角色所在的镜子噢！选择次数用完或倒计时结束后，游戏结束，全部猜中视为通关！"
	},
	{
		5,
		1,
		"guessbox/board_wuwenfenshen_guize01",
		"珍宝藏在礼盒后面，快记下珍宝的位置并选择出来"
	},
	{
		5,
		2,
		"guessbox/board_wuwenfenshen_guize04",
		"困难模式下，需要记住珍宝的出场顺序，礼盒还会前后交换位置，按顺序找到会有积分翻倍的惊喜噢"
	},
	{
		5,
		3,
		"guessbox/board_wuwenfenshen_guize05",
		"在礼盒位置变换结束后，需要按珍宝出现顺序，选择珍宝所在的礼盒噢！选择次数用完或倒计时结束后，游戏会结束并结算积分~"
	},
	{
		6,
		1,
		"guessbox/board_wuwenfenshen_guize01",
		"鲜花藏在花篮后面，记下鲜花的位置及出现顺序吧！"
	},
	{
		6,
		2,
		"guessbox/board_wuwenfenshen_guize04",
		"花篮会前后、左右交换位置"
	},
	{
		6,
		3,
		"guessbox/board_wuwenfenshen_guize05",
		"在花篮位置变换结束后，需要按鲜花的出现顺序，选择鲜花所在的花篮噢！选择次数用完或倒计时结束后，游戏会结束并结算~"
	}
}
local t_guess_box_game_rule = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11]
	},
	{
		dataList[12],
		dataList[13],
		dataList[14]
	},
	{
		dataList[15],
		dataList[16],
		dataList[17]
	},
	{
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_guess_box_game_rule.dataList = dataList

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

return t_guess_box_game_rule
