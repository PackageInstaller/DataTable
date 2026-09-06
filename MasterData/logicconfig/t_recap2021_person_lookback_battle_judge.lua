-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_recap2021_person_lookback_battle_judge.lua

module("logicconfig.config.t_recap2021_person_lookback_battle_judge", package.seeall)

local title = {
	dataId2 = 6,
	battleTime = 7,
	desc1 = 5,
	tag2 = 8,
	ranks = 3,
	desc2 = 9,
	dataId1 = 2,
	tag1 = 4,
	stage = 1
}
local dataList = {
	{
		1,
		9,
		{
			1,
			10
		},
		"竞技王者",
		"用兵如神，战无不胜\r\n<color=#657cb2><size=30>%s</size></color>，非你莫属！",
		13,
		6500,
		"大神训练师",
		"用兵如神，战无不胜\r\n<color=#657cb2><size=30>%s</size></color>，非你莫属！"
	},
	{
		2,
		9,
		{
			11,
			30
		},
		"传奇决斗家",
		"运筹帷幄，决胜千里\r\n你是令人敬仰的<color=#657cb2><size=30>%s</size></color>",
		13,
		5800,
		"传奇训练师",
		"运筹帷幄，决胜千里\r\n你是令人敬仰的<color=#657cb2><size=30>%s</size></color>"
	},
	{
		3,
		9,
		{
			31,
			70
		},
		"极耀决斗家",
		"出奇制胜，所向披靡\r\n你是令人敬仰的<color=#657cb2><size=30>%s</size></color>！",
		13,
		5100,
		"极耀训练师",
		"出奇制胜，所向披靡\r\n你是令人敬仰的<color=#657cb2><size=30>%s</size></color>！"
	},
	{
		4,
		9,
		{
			71,
			120
		},
		"宗师决斗家",
		"势如破竹，攻无不克\r\n你是令人敬仰的<color=#657cb2><size=30>%s</size></color>！",
		13,
		4400,
		"宗师训练师",
		"势如破竹，攻无不克\r\n你是令人敬仰的<color=#657cb2><size=30>%s</size></color>！"
	},
	{
		5,
		9,
		{
			121,
			200
		},
		"钻石决斗家",
		"料敌先机，百战不殆\r\n不愧是<color=#657cb2><size=30>%s</size></color>！",
		13,
		3700,
		"钻石训练师",
		"料敌先机，百战不殆\r\n不愧是<color=#657cb2><size=30>%s</size></color>！"
	},
	{
		6,
		9,
		{
			201,
			500
		},
		"琥珀决斗家",
		"深谋远虑，砥足前行\r\n不愧是<color=#657cb2><size=30>%s</size></color>！",
		13,
		3000,
		"琥珀训练师",
		"深谋远虑，砥足前行\r\n不愧是<color=#657cb2><size=30>%s</size></color>！"
	},
	{
		7,
		9,
		{
			501,
			900
		},
		"铂金决斗家",
		"有勇有谋，登龙有术\r\n不愧是<color=#657cb2><size=30>%s</size></color>！",
		13,
		2300,
		"铂金训练师",
		"有勇有谋，登龙有术\r\n不愧是<color=#657cb2><size=30>%s</size></color>！"
	},
	{
		8,
		9,
		{
			901,
			1500
		},
		"金牌决斗家",
		"上兵伐谋，勇猛精进\r\n不愧是<color=#657cb2><size=30>%s</size></color>！",
		13,
		1600,
		"金牌训练师",
		"上兵伐谋，勇猛精进\r\n不愧是<color=#657cb2><size=30>%s</size></color>！"
	},
	{
		9,
		9,
		{
			1501,
			5000
		},
		"白银决斗家",
		"厚积薄发，跬步千里，\r\n虽然现在只是<color=#657cb2><size=30>%s</size></color>，\r\n但总有一天可以触摸到王者的殿堂！",
		13,
		900,
		"白银训练师",
		"厚积薄发，跬步千里，\r\n虽然现在只是<color=#657cb2><size=30>%s</size></color>，\r\n但总有一天可以触摸到王者的殿堂！"
	},
	{
		10,
		9,
		{
			5001,
			10000000
		},
		"萌新决斗家",
		"虽然你现在还是<color=#657cb2><size=30>%s</size></color>，\r\n但你就像一轮初升之阳，\r\n总能发出耀眼光芒！",
		13,
		0,
		"萌新训练师",
		"虽然你现在还是<color=#657cb2><size=30>%s</size></color>，\r\n但你就像一轮初升之阳，\r\n总能发出耀眼光芒！"
	}
}
local t_recap2021_person_lookback_battle_judge = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10]
}

t_recap2021_person_lookback_battle_judge.dataList = dataList

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

return t_recap2021_person_lookback_battle_judge
