-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_restore_glory_tag.lua

module("logicconfig.config.t_restore_glory_tag", package.seeall)

local title = {
	labelPlanId = 1,
	olddes = 4,
	labelId = 2,
	newTitle = 5,
	newdes = 6,
	oldTitle = 3
}
local dataList = {
	{
		1,
		1,
		"消弭",
		"以龙族的普遍性年历计算，黄金圣龙尚且年幼，可对沉睡已久的圣龙来说，元素力量的消弭是其不得不面对的现实。",
		"救赎",
		"与圣龙一同发展壮大的奥奇城也为这位守护者带来了救赎之道，居民们决定为黄金圣龙祈愿。"
	},
	{
		1,
		2,
		"神陨",
		"身为守护者却无力再承担守护奥奇城的责任，那么神陨或许是最为妥当的结局——牺牲自身并将元素力量如数奉还……",
		"凝聚",
		"居民们发自内心的祈愿经由原初之核传递给圣龙，坚定的意志与凝聚的信念帮助了祂找回本我，神曜寰宇。"
	},
	{
		1,
		3,
		"无法制敌",
		"旧黄金圣龙的技能完美履行了“守护”的职责，化身圣盾后虽然能给队友回血，却无法左右战局。",
		"限制敌阵",
		"神格突破为神曜职业后，黄金圣龙拥有了限制敌阵的能力，辅助队友的能力也得到了极大提升。"
	},
	{
		2,
		1,
		"残破",
		"一身勇武、满腔热血……有些时候并不见得是一件好事，再为锋利尖锐的剑也有顿挫残破的那一天。",
		"锋芒",
		"历经重重挫折，热血仍旧沸腾，光芒万丈，重铸我身，圣剑的锋芒将再次闪耀在奥奇城的天空。"
	},
	{
		2,
		2,
		"迟疑不决",
		"虽然坚定的精神防线轻易被神判者摧毁，但当祂回首看向身后所守护之物时，还是颤抖着提剑应战，目光如炬，慷慨赴死。",
		"不破不立",
		"赞歌在绝境中萦绕，向死而生，顷刻间与原初之核共鸣，勇气的决心帮助祂找回本我，神曜苍穹。"
	},
	{
		2,
		3,
		"输出刮痧",
		"圣光飞龙已存活了千百年，面对强者的高压，更多的是做出防御的姿态，为队友们提供加持，无法对敌人造成伤害。",
		"输出增强",
		"圣光飞龙突破后，拥有了灵活切换形态的能力，圣剑更加锋利了，对敌人可以造成不可忽视的伤害。"
	}
}
local t_restore_glory_tag = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_restore_glory_tag.dataList = dataList

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

return t_restore_glory_tag
