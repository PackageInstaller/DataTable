-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_firstshow.lua

module("logicconfig.config.t_pet_firstshow", package.seeall)

local title = {
	showType = 6,
	scale = 5,
	flip = 7,
	id = 1,
	offsetY = 4,
	offsetX = 3,
	desc = 2
}
local dataList = {
	{
		10097,
		"红莲绽放，浴火而生。\n不仅是召唤师世家的继承人，也是幽空之城的女王，长久守护着这片静寂的城。",
		100,
		-48,
		1.4,
		1,
		0
	},
	{
		10028,
		"英雄殿的守护者，严格执行着内心信条。\n“英雄永远不能退缩。不管对手是谁，都必须全力以赴。”",
		211,
		0,
		1.6,
		1,
		0
	},
	{
		10155,
		"一位没有感情的忍者。\n总是能在对手尚未发觉之前，一击必杀。\n因此，从未有人见过他的真正面目。",
		-87,
		-144,
		1.5,
		2,
		1
	},
	{
		10159,
		"大侠的行事风格，自然是来无影去无终。\n据说要历经多重梅花桩的考验，才能够见到传说中的功夫熊猫真身。",
		-80,
		-81,
		1.4,
		2,
		1
	},
	{
		10127,
		"蓝龙湾的不败传说。\n世间传颂着“蓝龙大义，凛然天下！”的歌谣。\n在漫长的岁月里，他的神威从未减过一分。",
		-35,
		-219,
		1.4,
		2,
		1
	}
}
local t_pet_firstshow = {
	[10097] = dataList[1],
	[10028] = dataList[2],
	[10155] = dataList[3],
	[10159] = dataList[4],
	[10127] = dataList[5]
}

t_pet_firstshow.dataList = dataList

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

return t_pet_firstshow
