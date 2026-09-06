-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fight_pick_up_idea_bubble.lua

module("logicconfig.config.t_origin_fight_pick_up_idea_bubble", package.seeall)

local title = {
	id = 1,
	name = 2,
	score = 3
}
local dataList = {
	{
		1,
		"荒野灵感",
		5
	},
	{
		2,
		"长安灵感",
		5
	},
	{
		3,
		"天竺灵感",
		5
	},
	{
		4,
		"普通血液",
		5
	},
	{
		5,
		"高级血液",
		15
	}
}
local t_origin_fight_pick_up_idea_bubble = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_origin_fight_pick_up_idea_bubble.dataList = dataList

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

return t_origin_fight_pick_up_idea_bubble
