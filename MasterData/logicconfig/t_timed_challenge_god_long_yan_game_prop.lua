-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_god_long_yan_game_prop.lua

module("logicconfig.config.t_timed_challenge_god_long_yan_game_prop", package.seeall)

local title = {
	clickScaleArray = 6,
	imgScaleArray = 5,
	propName = 2,
	propId = 1,
	clickEffPath = 3,
	second = 8,
	score = 7,
	imgPath = 4
}
local dataList = {
	{
		1,
		"积分碎片",
		"",
		"items/icon_huoqiu",
		nil,
		nil,
		1,
		0
	},
	{
		2,
		"时间炸弹",
		"fx_ui_zdsz/fx_ui_zdsz_baozha",
		"items/icon_zhadan",
		nil,
		nil,
		0,
		-5
	}
}
local t_timed_challenge_god_long_yan_game_prop = {
	dataList[1],
	dataList[2]
}

t_timed_challenge_god_long_yan_game_prop.dataList = dataList

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

return t_timed_challenge_god_long_yan_game_prop
