-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_draw_and_guess_emoji.lua

module("logicconfig.config.t_draw_and_guess_emoji", package.seeall)

local title = {
	id = 2,
	iconUrl = 3,
	activityId = 1
}
local dataList = {
	{
		536001,
		1,
		"ui/emoji/mengzhidui/emoji_mengzhidui_03"
	},
	{
		536001,
		2,
		"ui/emoji/vip/emoji_wenhao"
	},
	{
		536001,
		3,
		"ui/emoji/vip/emoji_paolu"
	},
	{
		536001,
		4,
		"ui/emoji/nianfei/emoji_qiaonaodai"
	},
	{
		536001,
		5,
		"ui/emoji/2zhounian/emoji_2zn_02"
	},
	{
		536001,
		6,
		"ui/emoji/2zhounian/emoji_2zn_10"
	},
	{
		536001,
		7,
		"ui/emoji/2zhounian/emoji_2zn_14"
	},
	{
		536001,
		8,
		"ui/emoji/3zhounian/icon_biaoqing_3zhounian12"
	}
}
local t_draw_and_guess_emoji = {
	[536001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_draw_and_guess_emoji.dataList = dataList

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

return t_draw_and_guess_emoji
