-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_battle_item.lua

module("logicconfig.config.t_battle_item", package.seeall)

local title = {
	initCd = 6,
	display = 14,
	id = 1,
	type = 3,
	name = 2,
	releaseCd = 7,
	canSale = 18,
	desc = 25,
	icon = 20,
	maxQuantity = 15,
	skill = 9,
	model = 21,
	price = 23,
	hpChanged2Target = 4,
	targetDesc = 11,
	effect = 24,
	buffs2Target = 5,
	quality = 19,
	canTrade = 17,
	consumeNumPerAction = 13,
	source = 26,
	target = 10,
	useType = 22,
	targetFilter = 12,
	consumeEnergy = 8,
	isVipItem = 16
}
local dataList = {
	{
		10027,
		82037508,
		"技能类",
		-10000,
		"",
		0,
		1,
		1,
		{
			10027,
			210027
		},
		"敌方-单体",
		"前端选择一只",
		"Active",
		0,
		"特效XXX",
		9999,
		true,
		false,
		true,
		4,
		"icon_10028_shengguangfeilong",
		"",
		0,
		9999,
		"造成10000点伤害",
		82037509,
		"6"
	},
	{
		10083,
		82037510,
		"技能类",
		-10000,
		"",
		0,
		1,
		1,
		{
			10083,
			210083
		},
		"敌方-单体",
		"前端选择一只",
		"Active",
		0,
		"特效XXX",
		9999,
		true,
		false,
		true,
		4,
		"icon_10083_lingshi",
		"",
		0,
		9999,
		"造成10000点伤害",
		82037509,
		"6"
	},
	{
		10098,
		82037511,
		"技能类",
		-5000,
		"289:1",
		0,
		1,
		1,
		{
			10098,
			210098
		},
		"敌方-单体",
		"前端选择一只",
		"Active",
		0,
		"特效XXX",
		9999,
		true,
		false,
		true,
		4,
		"icon_10098_binglingwang",
		"",
		0,
		9999,
		"造成5000点伤害，并击晕目标",
		82037512,
		"6"
	},
	{
		10165,
		82037513,
		"技能类",
		0,
		"449:1",
		0,
		1,
		1,
		{
			10165,
			210165
		},
		"敌方-单体",
		"前端选择一只",
		"Active",
		0,
		"特效XXX",
		9999,
		true,
		false,
		true,
		4,
		"icon_10165_mang",
		"",
		0,
		9999,
		"造成12000点伤害，若击杀目标则对目标相邻的两位精灵造成10000点伤害",
		82037514,
		"6"
	}
}
local t_battle_item = {
	[10027] = dataList[1],
	[10083] = dataList[2],
	[10098] = dataList[3],
	[10165] = dataList[4]
}

t_battle_item.dataList = dataList

local multiLanguageCells = {
	desc = true,
	name = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_battle_item
