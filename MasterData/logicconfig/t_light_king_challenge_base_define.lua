-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_light_king_challenge_base_define.lua

module("logicconfig.config.t_light_king_challenge_base_define", package.seeall)

local title = {
	challengeType = 1,
	name = 2,
	ruleKey = 7,
	condition = 3,
	desc = 10,
	buyTimesPlanId = 6,
	bubble = 9,
	viewName = 8,
	hasDailyTimesLimit = 4,
	freeDailyTimes = 5
}
local dataList = {
	{
		1,
		"圣光挑战",
		{},
		true,
		10,
		1,
		"shengguangchallenge",
		"lightkingshengguangview",
		"你不是一个人在战斗！\n<size=36>我<color=#EB4642FF>带上小弟</color>帮你！</size>",
		"光明王将携带契约精灵\n作为<color=#FEE04AFF>第6人</color>助战"
	},
	{
		2,
		"耀世挑战",
		{},
		false,
		0,
		0,
		"yaoshichallenge",
		"lightkingyaoshiview",
		"<size=36>光明终将战胜黑暗！</size>",
		"1.敌阵怪怪<color=#FEE04AFF>被攻击</color>时，<color=#FEE04AFF>其自身及相邻（上下左右）怪怪会更换属性</color>（光→暗，暗→光）\n2.将敌阵<color=#FEE04AFF>全部变为光怪怪</color>即可通关"
	},
	{
		3,
		"极限挑战",
		{
			1,
			2
		},
		true,
		10,
		3,
		"jixianchallenge",
		"lightkingjixianview",
		"",
		"通关极限挑战前<color=#FEE04AFF>5999</color>名玩家\n可得<color=#FEE04AFF>专属头像框</color>，精灵背包中<color=#FEE04AFF>展示</color>光明王显示<color=#FEE04AFF>获得名次</color>"
	}
}
local t_light_king_challenge_base_define = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_light_king_challenge_base_define.dataList = dataList

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

return t_light_king_challenge_base_define
