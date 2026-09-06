-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_fuben_clue.lua

module("logicconfig.config.t_annual_fuben_clue", package.seeall)

local title = {
	progressId = 4,
	name = 6,
	storyId = 5,
	clueId = 2,
	iconRes = 8,
	initClue = 3,
	activityId = 1,
	desc = 7
}
local dataList = {
	{
		546001,
		1,
		true,
		0,
		4820039,
		"永恒的血肉",
		"创世圣龙化作了精灵大陆最初的<color=#c54949>生命</color>。",
		"ui/icon/character/icon_13008_yonghengshenglong.png"
	},
	{
		546001,
		2,
		true,
		0,
		4820040,
		"无垢神性",
		"黑创对于规则十分执拗，但并不是没有变通的可能。",
		"ui/icon/character/icon_14022_yuanchushenglong.png"
	},
	{
		546001,
		3,
		true,
		0,
		4820041,
		"老相识",
		"创世圣龙的人性启蒙始于龙族<color=#c54949>诞生</color>之刻。",
		"ui/icon/character/icon_18021_feixisi.png"
	},
	{
		546001,
		4,
		true,
		0,
		4820042,
		"宿命的突破口",
		"规则与现实并非不能共存，<color=#BCA006FF>阿撒托斯</color>或许能成为让黑创暂时转变目标的突破口。",
		"ui/icon/character/icon_11028_mingyuan.png"
	},
	{
		546001,
		5,
		true,
		0,
		4820043,
		"并不孤独的神明",
		"其他次元时间线中的创世圣龙形单影只，并没有其他龙族的身影。",
		"ui/icon/character/icon_15027_shenyaoanshikonglong.png"
	},
	{
		546001,
		6,
		true,
		0,
		4820044,
		"铁则的代价",
		"黑创如若成功修复天理，万界万物将<color=#4DE581FF>重新</color>来过，即便是<color=#4DE581FF>灵魂</color>也无法幸存。",
		"ui/icon/character/icon_16039_linghailong.png"
	},
	{
		546001,
		7,
		true,
		0,
		4820045,
		"平易近人的神",
		"创世圣龙仁善圣洁，毫无神明做派，是一众神眷的良师益友，<color=#4DE581FF>心灵</color>导师。",
		"ui/icon/character/icon_12037_shizushenglong.png"
	},
	{
		546001,
		8,
		true,
		0,
		4820046,
		"渎神",
		"黑创如果复归火种，重启天理，便会将<color=#BCA006FF>阿撒托斯</color>的污染带入下一世循环。",
		"ui/icon/character/icon_15041_daoyinglong.png"
	},
	{
		546001,
		9,
		true,
		0,
		4820047,
		"天理的开端与终结",
		"天理需要创世圣龙复归火种，原初与终末衔尾<color=#4DE581FF>重开</color>世宇。",
		"ui/icon/character/icon_18001_fanerweisi.png"
	},
	{
		546001,
		10,
		false,
		0,
		0,
		"精灵大陆·起源",
		"创世圣龙因守护火种而生，历经无数循环，直到这一世龙族降生，其不忍同族伴随天理消陨，于是在人性的萌发与驱使之下封印神性，传火救世，而其本尊最后则化作精灵大陆最初的生命，世世代代与魔界中的阿撒托斯抗争……",
		"ui/icon/items/icon_juqing_yshz.png"
	},
	{
		546001,
		11,
		false,
		0,
		0,
		"何为天理",
		"元素火种创造万物，当世界宙宇膨胀熵增到极点之刻，火种便会回收所创造之物——物质与精神，肉体与灵魂，无一幸存，直到原初与终灭再次衔接，开始下一世循环，此即为天理。然而，天理虽然无情，但并不代表着天理的守护者同样无心。",
		"ui/icon/items/icon_xcxx_shuaxin.png"
	},
	{
		546001,
		12,
		false,
		0,
		0,
		"渎神之举",
		"更高维度的古老神明一直注视着诸界宙宇，祂试图染指每一个创世神所创造的事务，如今祂的子嗣为了达到‘污染神’的目的逐渐步入疯狂。要向打败真正的邪恶，只有揪出隐匿在背后的宿主方可一击致胜，而这份污染同样可能成为此世决不能重启的原因之一……",
		"ui/bigbg/story/story_icons/icon_juqing_hsdp.png"
	},
	{
		546001,
		13,
		false,
		2,
		0,
		"技能揭秘-被动技能",
		"免降气免非伤免无法行动，加气出手，攻击叠加攻击和双爆",
		"ui/icon/skill/skill_bd.png"
	},
	{
		546001,
		14,
		false,
		3,
		0,
		"技能揭秘-普攻技能",
		"普攻高额物攻，攻击后追加固定比例攻击力伤害",
		"ui/icon/skill/skill_pg_1.png"
	},
	{
		546001,
		15,
		false,
		4,
		0,
		"技能揭秘-超杀技能",
		"高额物攻，给队友加气势，目标存活与否触发不同毁灭伤害",
		"ui/icon/skill/skill_cs_1.png"
	},
	{
		546001,
		16,
		false,
		5,
		0,
		"技能揭秘-创世技",
		"构建叠加属性残缺规则，补全增益全队，首次死亡依进度获对应效果",
		"ui/icon/skill/skill_818031.png"
	}
}
local t_annual_fuben_clue = {
	[546001] = {
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
		dataList[16]
	}
}

t_annual_fuben_clue.dataList = dataList

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

return t_annual_fuben_clue
