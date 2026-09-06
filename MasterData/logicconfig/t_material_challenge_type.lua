-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_material_challenge_type.lua

module("logicconfig.config.t_material_challenge_type", package.seeall)

local title = {
	FirstDes = 12,
	FirstRecommendId = 14,
	resourceChapterDailyLimit = 8,
	chapterId = 1,
	payVipId = 9,
	farBg = 18,
	roundDes = 11,
	dailyDoubleTimes = 19,
	SecondDes = 13,
	middleBg = 17,
	SecondRecommendId = 15,
	chapterName = 2,
	sortId = 3,
	popupPic = 6,
	additionalDes = 10,
	stagePic = 5,
	nearBg = 16,
	chapterPic = 4,
	doubleRewardId = 7
}
local dataList = {
	{
		1,
		"经验幻境",
		1,
		"fubeng_board_richang02",
		"fuben_board01",
		"board_jqfb_sm1",
		4,
		9999,
		11,
		"累计造成伤害：%d",
		"",
		"敌方的<color=#60ee85>魔防</color>额外增加，造成伤害越多，\n评分越高，获得经验果越多",
		"推荐利爪、疾速精灵:",
		10130,
		10309,
		"jingyanhuanjing1",
		"jingyanhuanjing2",
		"jingyanhuanjing3",
		0
	},
	{
		2,
		"金币幻境",
		2,
		"fubeng_board_richang01",
		"fuben_board03",
		"board_jqfb_sm2",
		5,
		9999,
		12,
		"累计造成伤害：%d",
		"",
		"敌方的<color=#60ee85>物防</color>额外增加，造成伤害越多，\n评分越高，获得金币越多",
		"推荐魔法精灵:",
		10204,
		10326,
		"jinbihuanjing1",
		"jinbihuanjing2",
		"",
		0
	},
	{
		3,
		"星神幻境",
		4,
		"fubeng_board_richang04",
		"fuben_board04",
		"board_jqfb_sm4",
		6,
		9999,
		14,
		"累计击倒精灵：%d只",
		"",
		"敌方的<color=#60ee85>物防</color>额外增加，击杀敌方精灵越多，\n评分越高，获得星神越多",
		"推荐魔法精灵:",
		10204,
		10326,
		"xingshenhuanjing1",
		"xingshenhuanjing2",
		"xingshenhuanjing3",
		0
	},
	{
		4,
		"装备幻境",
		3,
		"fubeng_board_richang03",
		"fuben_board02",
		"board_jqfb_sm3",
		7,
		9999,
		13,
		"累计击倒精灵：%d只",
		"",
		"敌方的<color=#60ee85>攻击</color>额外增加，血量防御大幅减少，\n击杀敌方精灵越多，评分越高，获得装备越多",
		"推荐肉盾、平衡精灵:",
		10324,
		10143,
		"zhuangbeihuanjing1",
		"zhuangbeihuanjing2",
		"zhuangbeihuanjing3",
		0
	}
}
local t_material_challenge_type = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_material_challenge_type.dataList = dataList

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

return t_material_challenge_type
