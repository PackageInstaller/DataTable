-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_red_lotus_gala_common.lua

module("logicconfig.config.t_red_lotus_gala_common", package.seeall)

local title = {
	desc = 2,
	commonKey = 1
}
local dataList = {
	{
		"PRIZE1",
		"8:1:120000"
	},
	{
		"PRIZE2",
		"60:1:48"
	},
	{
		"PRIZE3",
		"10:17073:60"
	},
	{
		"SX_GAME_RULE",
		"3个相同的食材连在一起，即可消除。\r\n4个相同食材连在一起，可合成闪电道具；5个相同食材合在一起，可合成炸弹道具；道具不消耗步数。"
	}
}
local t_red_lotus_gala_common = {
	PRIZE1 = dataList[1],
	PRIZE2 = dataList[2],
	PRIZE3 = dataList[3],
	SX_GAME_RULE = dataList[4]
}

t_red_lotus_gala_common.dataList = dataList

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

return t_red_lotus_gala_common
