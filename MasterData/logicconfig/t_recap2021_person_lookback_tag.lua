-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_recap2021_person_lookback_tag.lua

module("logicconfig.config.t_recap2021_person_lookback_tag", package.seeall)

local title = {
	tagDesc = 3,
	isBattleTag = 6,
	rank = 2,
	tagPlanId = 1,
	judgePlanId = 5,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		"博物馆馆长",
		"我的我的，全是我的！\r\n<color=#657cb2><size=30>%s</size></color>\r\n宝座非你莫属！",
		1,
		false
	},
	{
		1,
		2,
		"博物馆专家",
		"小孩子才做选择，\r\n现在我全都要！\r\n你就是<color=#657cb2><size=30>%s</size></color>！",
		2,
		false
	},
	{
		1,
		3,
		"大神收藏家",
		"恭喜你成为\r\n<color=#657cb2><size=30>%s</size></color>！\r\n你的宝库琳琅满目，熠熠生辉！",
		3,
		false
	},
	{
		1,
		4,
		"宗师收藏家",
		"你已成功成为大师级人物\r\n<color=#657cb2><size=30>%s</size></color>！\r\n藏品数量非常人可比！",
		4,
		false
	},
	{
		1,
		5,
		"王牌收藏家",
		"你是众人眼中的\r\n<color=#657cb2><size=30>%s</size></color>\r\n任何领域你都有所涉猎！",
		5,
		false
	},
	{
		1,
		6,
		"金牌收藏家",
		"<color=#657cb2><size=30>%s</size></color>\r\n是专属你的荣誉\r\n你已一只脚跨入了收藏家的殿堂！",
		6,
		false
	},
	{
		1,
		7,
		"精英收藏家",
		"恭喜你触摸到了收藏家的大门\r\n成为<color=#657cb2><size=30>%s</size></color>\r\n再接再厉！",
		7,
		false
	},
	{
		2,
		1,
		"",
		"%s",
		0,
		true
	},
	{
		3,
		1,
		"肝中龙凤",
		"<color=#657cb2><size=30>%s</size></color>就是你！\r\n你就是肝帝中的卧龙凤雏！",
		8,
		false
	},
	{
		3,
		2,
		"肝帝",
		"<color=#657cb2><size=30>%s</size></color>降临！\r\n你的信条就是\r\n“快扶我起来我还能肝！”",
		9,
		false
	},
	{
		3,
		3,
		"爆肝王",
		"距离肝帝仅一步之遥，\r\n你就是一人之下，万人之上的\r\n<color=#657cb2><size=30>%s</size></color>",
		10,
		false
	},
	{
		3,
		4,
		"端水大师",
		"恭喜你成为<color=#657cb2><size=30>%s</size></color>\r\n工作学习与娱乐，三者兼得\r\n平衡力绝佳！",
		11,
		false
	},
	{
		3,
		5,
		"肝脏守护者",
		"<color=#657cb2><size=30>%s</size></color>\r\n是你当之无愧的美誉\r\n轻松游戏，愉快生活",
		12,
		false
	},
	{
		3,
		6,
		"养肝大师",
		"佛系游戏，朋克养生\r\n<color=#657cb2><size=30>%s</size></color>名不虚传！",
		13,
		false
	}
}
local t_recap2021_person_lookback_tag = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	{
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_recap2021_person_lookback_tag.dataList = dataList

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

return t_recap2021_person_lookback_tag
