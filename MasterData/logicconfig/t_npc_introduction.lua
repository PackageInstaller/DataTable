-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_npc_introduction.lua

module("logicconfig.config.t_npc_introduction", package.seeall)

local title = {
	asset = 2,
	name = 3,
	offsetY = 7,
	scale = 8,
	id = 1,
	title = 5,
	offsetX = 6,
	desc = 4
}
local dataList = {
	{
		1,
		"10097_moyan",
		"末炎",
		"红莲绽放，浴火而生。\n不仅是召唤师世家的继承人，也是幽空之城的女王，长久守护着这片静寂的城。",
		"红莲绽放",
		0,
		0,
		1.4
	},
	{
		2,
		"10028_shengguangfeilong",
		"圣光飞龙",
		"英雄殿的守护者，严格执行着内心信条。\n“英雄永远不能退缩。不管对手是谁，都必须全力以赴。”",
		"英雄殿的守护者",
		0,
		0,
		1.6
	},
	{
		3,
		"10155_qianniaowan",
		"千鸟丸",
		"一位没有感情的忍者。\n总是能在对手尚未发觉之前，一击必杀。\n因此，从未有人见过他的真正面目。",
		"一位没有感情的忍者",
		0,
		0,
		1.5
	},
	{
		4,
		"10159_gongfuxiongmao",
		"功夫熊猫",
		"大侠的行事风格，自然是来无影去无终。\n据说要历经多重梅花桩的考验，才能够见到传说中的功夫熊猫真身。",
		"大侠的行事风格",
		0,
		0,
		1.4
	},
	{
		5,
		"10127_xinglanlong",
		"星蓝龙",
		"蓝龙湾的不败传说。\n世间传颂着“蓝龙大义，凛然天下！”的歌谣。\n在漫长的岁月里，他的神威从未减过一分。",
		"蓝龙湾的不败传说",
		0,
		0,
		1.4
	},
	{
		6,
		"80012_dingding_lihui",
		"叮叮",
		"常驻在奥奇广场的可爱少女。\n热情地指引着新来的小奥奇们。\n喜欢摄影，据闻她最常用的相机价值888万金币。",
		"新手训练师引导者",
		0,
		2.5,
		1.5
	},
	{
		7,
		"80001_xiaojing",
		"小静",
		"负责图书馆的学姐管理员。\n温柔善良，会耐心的解答每一个小奥奇的疑问。\n脑袋里装着几乎整个图书馆的知识，有什么难题问她准没错！",
		"图书馆管理员",
		0,
		3,
		0.25
	},
	{
		8,
		"80002_yifu",
		"伊静",
		"性感火热的御姐训练师。\n长腿与肤白并存，是处于奥奇城食物链顶端的女人。\n虽然看上去很不好惹，但绝对无条件庇护自己人，是个让人安心的姐姐。",
		"御姐训练师",
		-0.3,
		2.5,
		0.4
	},
	{
		10,
		"80013_gelante_lihui",
		"格兰特",
		"镇守奥奇学院的强大训练师。\n掌握着高超的战术和阵法，几乎无法被战胜。\n身为院长，禀奉“严格、谨慎”的教育理念，是所有精灵训练师又爱又恨的对象。",
		"奥奇学院院长",
		-0.5,
		0.5,
		1.5
	},
	{
		11,
		"80014_jielun_lihui",
		"杰伦",
		"驻守竞技场的护卫队长。\n负责奥奇城的安全工作，以“热血”作为自己的人生信条。\n时刻都处于激情四射的状态，若是有谁在他眼皮底下作乱，一定会后悔自己的不法行为。",
		"守卫队队长",
		0,
		1,
		1.5
	},
	{
		12,
		"80015_linlinqi_lihui",
		"林林奇",
		"驻留商业街的鬼才科学家。\n古灵精怪，有着各种超乎想象的神奇发明。\n最喜欢踩着轮滑鞋四处游荡，但绝对是解决技术问题的一把好手！",
		"鬼才发明家",
		-0.5,
		3,
		1.5
	}
}
local t_npc_introduction = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	[10] = dataList[9],
	[11] = dataList[10],
	[12] = dataList[11]
}

t_npc_introduction.dataList = dataList

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

return t_npc_introduction
