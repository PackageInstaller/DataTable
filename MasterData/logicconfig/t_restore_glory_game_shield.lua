-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_restore_glory_game_shield.lua

module("logicconfig.config.t_restore_glory_game_shield", package.seeall)

local title = {
	bgPath = 5,
	shieldPath = 6,
	successBgPath = 8,
	storyId = 4,
	dragEffPath = 10,
	waterPath = 7,
	descSuccess = 11,
	dirtyPlanId = 2,
	ruleId = 3,
	successShieldPath = 9,
	gameId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		4450004,
		"bigbg/recastglory/bg_chongzhurongguang_01.png",
		"bigbg/recastglory/board_chongzhurongguang_13",
		"icon/items/icon_shengdan_hsshenshui",
		"bigbg/recastglory/bg_chongzhurongguang_01",
		"bigbg/recastglory/board_chongzhurongguang_15",
		"20230331/chongzhurongguang/fx_ui_chongzhurongguang_shengshui",
		"恭喜你，洗濯黄金圣盾成功，消耗神曜之盾*100即可将【圣域·黄金圣龙】神曜突破为【神曜寰宇·黄金圣龙】"
	},
	{
		2,
		2,
		1,
		0,
		"bigbg/eternaldragon/bg_zhongshu_02",
		"bigbg/eternaldragon/board_zhongshu_11",
		"icon/items/board_zhongshu_04",
		"bigbg/eternaldragon/bg_zhongshu_02",
		"bigbg/eternaldragon/board_zhongshu_11",
		"20230825/yonghengguodu/fx_ui_yonghengguodu_jiandao",
		"恭喜你，修剪世界树枯叶成功"
	},
	{
		3,
		3,
		1,
		0,
		"bigbg/eternaldragon/bg_zhongshu_02",
		"bigbg/eternaldragon/board_zhongshu_12",
		"icon/items/board_zhongshu_04",
		"bigbg/eternaldragon/bg_zhongshu_02",
		"bigbg/eternaldragon/board_zhongshu_12",
		"20230826/yonghengguodu/fx_ui_yonghengguodu_jiandao",
		"恭喜你，修剪世界树枯叶成功"
	},
	{
		4,
		4,
		1,
		0,
		"bigbg/eternaldragon/bg_zhongshu_02",
		"bigbg/eternaldragon/board_zhongshu_13",
		"icon/items/board_zhongshu_04",
		"bigbg/eternaldragon/bg_zhongshu_02",
		"bigbg/eternaldragon/board_zhongshu_13",
		"20230827/yonghengguodu/fx_ui_yonghengguodu_jiandao",
		"恭喜你，修剪世界树枯叶成功"
	}
}
local t_restore_glory_game_shield = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_restore_glory_game_shield.dataList = dataList

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

return t_restore_glory_game_shield
