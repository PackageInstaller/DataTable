-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_suppress_game_tab.lua

module("logicconfig.config.t_suppress_game_tab", package.seeall)

local title = {
	suppressEffPath = 7,
	name = 3,
	taskPlanId = 5,
	jumpTo = 8,
	progressPlanId = 4,
	storyId = 9,
	content = 10,
	maxProgress = 6,
	activityId = 1,
	gameId = 2
}
local dataList = {
	{
		161001,
		1,
		"造梦",
		1,
		1,
		1200,
		"20220701/yazhililiang/fx_ui_yzll_zaomeng",
		"ui#copylonghuanggameview",
		4290002,
		"莱莉丝作为梦境领主，可随意进入他人梦境，以无害姿态引诱他人沉迷梦境。"
	},
	{
		161001,
		2,
		"玫瑰",
		2,
		2,
		1200,
		"20220701/yazhililiang/fx_ui_yzll_meigui",
		"ui#copyguessboxsceneview",
		4290003,
		"莱莉丝的花园中栽满了黑玫瑰，被她引诱的做梦者会嗅到玫瑰的香气，在不知不觉中入睡。"
	},
	{
		161001,
		3,
		"永生",
		3,
		3,
		1200,
		"20220701/yazhililiang/fx_ui_yzll_yongsheng",
		"ui#copyburygamemainview",
		4290004,
		"莱莉丝从梦中吸取力量，只要有人沉睡，她就能永远存在于梦中，不死不灭。"
	},
	{
		161001,
		4,
		"控制",
		4,
		4,
		1200,
		"20220701/yazhililiang/fx_ui_yzll_kongzhi",
		"ui#copyflipgamemainview",
		4290005,
		"当做梦者沉浸在美梦中时，莱莉丝会把美梦突然转变为噩梦，欣赏对方痛苦的挣扎。"
	},
	{
		161001,
		5,
		"地狱",
		5,
		5,
		1200,
		"20220701/yazhililiang/fx_ui_yzll_diyu",
		"ui#copyduolagameview",
		4290006,
		"莱莉丝的黑玫瑰香气以沉睡者为支点扩散，最终让整个时空的生灵陷入寂灭，谁都无法逃离。"
	}
}
local t_suppress_game_tab = {
	[161001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_suppress_game_tab.dataList = dataList

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

return t_suppress_game_tab
