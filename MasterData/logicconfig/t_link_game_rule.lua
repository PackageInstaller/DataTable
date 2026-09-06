-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_link_game_rule.lua

module("logicconfig.config.t_link_game_rule", package.seeall)

local title = {
	resPath = 3,
	pageId = 2,
	ruleId = 1,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		"ui/bigbg/copychapter/board_tianyanlianliankan_04.png",
		"点击相同的两个头像，锁链会将其相连\r\n当锁链拐弯次数不超过2次时，头像可以被消除"
	},
	{
		1,
		2,
		"ui/bigbg/copychapter/board_tianyanlianliankan_05.png",
		"只有将特殊格子链接，才可成功通过关卡"
	}
}
local t_link_game_rule = {
	{
		dataList[1],
		dataList[2]
	}
}

t_link_game_rule.dataList = dataList

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

return t_link_game_rule
