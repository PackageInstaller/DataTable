-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_moyan_preheat.lua

module("logicconfig.config.t_moyan_preheat", package.seeall)

local title = {
	gameBgImg = 15,
	unlockEffPath = 13,
	gameStartTips = 16,
	thrower = 9,
	normalProp = 17,
	isHaveCrazyModel = 20,
	unlockProps = 3,
	unlockImage = 8,
	startGameEffPath = 11,
	activityId = 1,
	collisionEffPath = 14,
	effPath = 12,
	props = 4,
	addSpecialProp = 19,
	rulesKey = 6,
	specialProp = 18,
	gameName = 5,
	bgImg = 7,
	catcher = 10,
	prizePlan = 2
}
local dataList = {
	{
		66001,
		1,
		1,
		"10:66001",
		"小末寻桂",
		"moyanjiehua_rules",
		"bg_myjgh_01",
		"board_myjgh_03",
		"effect/prefabs/ui/fx_ui_moyanmianban/tuzi_xiaoren/tuzi_xiaoren-ui_p",
		"effect/prefabs/ui/fx_ui_moyanmianban/moyan_xiaoren/10092_xiaomo_xiaoren-ui_p",
		"fx_ui_jieguihua/fx_ui_jieguihua_anniu",
		"fx_ui_jieguihua/fx_ui_jieguihua_fenwei",
		"fx_ui_jieguihua/fx_ui_jieguihua_jiesuo",
		"fx_ui_jieguihua/fx_ui_jieguihua_jiehua",
		"bg_myjgh_01",
		"点击屏幕任意空白处开始游戏\n按住小末并左右拖动，获得更多的桂花吧",
		"catch_prop_normalflower",
		"catch_prop_specialflower",
		"catch_prop_specialflower",
		false
	},
	{
		66002,
		2,
		2,
		"10:66002",
		"中秋接月饼",
		"moyanjiehua_rules",
		"bg_myjgh_01",
		"board_myjgh_03",
		"effect/prefabs/ui/fx_ui_moyanmianban/tuzi_xiaoren/tuzi_xiaoren-ui_p",
		"effect/prefabs/ui/fx_ui_moyanmianban/moyan_xiaoren/10092_xiaomo_xiaoren-ui_p",
		"fx_ui_jieguihua/fx_ui_jieguihua_anniu",
		"fx_ui_jieguihua/fx_ui_jieguihua_fenwei",
		"fx_ui_jieguihua/fx_ui_jieguihua_jiesuo",
		"fx_ui_jieguihua/fx_ui_jieguihua_jiehua",
		"bg_myjgh_01",
		"点击屏幕任意空白处开始游戏\n按住小末并左右拖动，获得更多的月饼吧",
		"catch_prop_normalmooncake",
		"catch_prop_specialmooncake",
		"catch_prop_specialmooncake",
		false
	},
	{
		66003,
		3,
		3,
		"10:66003",
		"阿瑞助力",
		"moyanjiehua_rules",
		"bg_arsmqxyx_01",
		"board_myjgh_03",
		"effect/prefabs/ui/fx_ui_moyanmianban/tuzi_xiaoren/tuzi_xiaoren-ui_p",
		"character/10139_arui/10139_arui-ui_p",
		"fx_ui_jieguihua/fx_ui_jieguihua_anniu",
		"fx_ui_jieguihua/fx_ui_jieguihua_fenwei",
		"fx_ui_jieguihua/fx_ui_jieguihua_jiesuo",
		"fx_ui_jieguihua/fx_ui_jieguihua_jiehua",
		"bg_arsmqxyx_01",
		"点击屏幕任意空白处开始游戏\n按住阿瑞并左右拖动，获得更多的元素吧",
		"catch_prop_fire#catch_prop_grass#catch_prop_water",
		"catch_prop_specialmooncake",
		"catch_prop_specialmooncake",
		true
	},
	{
		66004,
		4,
		4,
		"10:66004",
		"中秋接月饼",
		"moyanjiehua_rules",
		"bg_myjgh_01",
		"board_myjgh_03",
		"effect/prefabs/ui/fx_ui_moyanmianban/tuzi_xiaoren/tuzi_xiaoren-ui_p",
		"effect/prefabs/ui/20211028/zhiren_aoqi/zhiren_aoqi-ui_p",
		"fx_ui_jieguihua/fx_ui_jieguihua_anniu",
		"fx_ui_jieguihua/fx_ui_jieguihua_fenwei",
		"fx_ui_jieguihua/fx_ui_jieguihua_jiesuo",
		"fx_ui_jieguihua/fx_ui_jieguihua_jiehua",
		"bg_myjgh_01",
		"点击屏幕任意空白处开始游戏\n按住奥奇并左右拖动，获得更多的月饼吧",
		"catch_prop_normalmooncake",
		"catch_prop_specialmooncake",
		"catch_prop_specialmooncake",
		false
	},
	{
		66005,
		4,
		4,
		"10:66005",
		"接红包",
		"moyanjiehua_rules",
		"bg_myjgh_01",
		"board_myjgh_03",
		"effect/prefabs/ui/fx_ui_moyanmianban/tuzi_xiaoren/tuzi_xiaoren-ui_p",
		"effect/prefabs/ui/20211028/zhiren_aoqi/zhiren_aoqi-ui_p",
		"fx_ui_jieguihua/fx_ui_jieguihua_anniu",
		"fx_ui_jieguihua/fx_ui_jieguihua_fenwei",
		"fx_ui_jieguihua/fx_ui_jieguihua_jiesuo",
		"fx_ui_jieguihua/fx_ui_jieguihua_jiehua",
		"bg_jiehongbao",
		"点击屏幕任意空白处开始游戏\n按住奥奇并左右拖动，获得更多的红包吧",
		"catch_prop_normalhongbao",
		"catch_prop_specialhongbao",
		"catch_prop_add_specialhongbao",
		false
	}
}
local t_moyan_preheat = {
	[66001] = dataList[1],
	[66002] = dataList[2],
	[66003] = dataList[3],
	[66004] = dataList[4],
	[66005] = dataList[5]
}

t_moyan_preheat.dataList = dataList

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

return t_moyan_preheat
