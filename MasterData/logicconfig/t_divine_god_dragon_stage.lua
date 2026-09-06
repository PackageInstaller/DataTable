-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_god_dragon_stage.lua

module("logicconfig.config.t_divine_god_dragon_stage", package.seeall)

local title = {
	stageId = 2,
	name = 5,
	supportCreepsId = 4,
	bgRes = 6,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		346001,
		1,
		1001,
		100001,
		"神曜苍穹·圣光飞龙试炼",
		"btn_lssl_shengguangfeilong"
	},
	{
		346001,
		2,
		1002,
		100001,
		"神曜寰宇·黄金圣龙试炼",
		"btn_lssl_huangjingshenglong"
	},
	{
		346001,
		3,
		1003,
		100001,
		"神曜法则·秩序圣龙试炼",
		"btn_lssl_zhixushenglong"
	},
	{
		346001,
		4,
		1004,
		100001,
		"神曜万象·次元龙尊试炼",
		"btn_lssl_ciyuanlongzun"
	},
	{
		346001,
		5,
		1005,
		100001,
		"神曜赤甲·火次元试炼",
		"btn_lssl_huociyuan"
	},
	{
		346002,
		1,
		2001,
		100002,
		"神曜苍穹·圣光飞龙",
		"btn_lssl_shengguangfeilong"
	},
	{
		346002,
		2,
		2002,
		100002,
		"神曜寰宇·黄金圣龙",
		"btn_lssl_huangjingshenglong"
	},
	{
		346002,
		3,
		2003,
		100002,
		"神曜法则·秩序圣龙",
		"btn_lssl_zhixushenglong"
	},
	{
		346002,
		4,
		2004,
		100002,
		"神曜万象·次元龙尊",
		"btn_lssl_ciyuanlongzun"
	},
	{
		346002,
		5,
		2005,
		100002,
		"神曜赤甲·火次元",
		"btn_lssl_huociyuan"
	}
}
local t_divine_god_dragon_stage = {
	[346001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[346002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_divine_god_dragon_stage.dataList = dataList

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

return t_divine_god_dragon_stage
