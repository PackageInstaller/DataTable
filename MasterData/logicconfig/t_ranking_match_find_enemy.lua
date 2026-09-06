-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ranking_match_find_enemy.lua

module("logicconfig.config.t_ranking_match_find_enemy", package.seeall)

local title = {
	id = 1,
	desc = 2
}
local dataList = {
	{
		1,
		"旗鼓相当的对手"
	},
	{
		2,
		"实力超群的对手"
	},
	{
		3,
		"变幻莫测的对手"
	},
	{
		4,
		"随叫随到的对手"
	},
	{
		5,
		"神秘莫测的对手"
	},
	{
		6,
		"你不是我的对手"
	}
}
local t_ranking_match_find_enemy = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_ranking_match_find_enemy.dataList = dataList

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

return t_ranking_match_find_enemy
