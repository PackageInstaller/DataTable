-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_unique_world_rule.lua

module("logicconfig.config.t_unique_world_rule", package.seeall)

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
		"ui/bigbg/uniqueworld/board_bydt_tc_01.png",
		"进入地图搜刮矿物、宝箱，获得物资后前往商店招募精灵，组建探险队伍"
	},
	{
		1,
		2,
		"ui/bigbg/uniqueworld/board_bydt_tc_02.png",
		"击败守卫、精英守卫，清空每层事件即可找到通往下一层的入口"
	},
	{
		1,
		3,
		"ui/bigbg/uniqueworld/board_bydt_tc_03.png",
		"跟人物对话可获得不同效果加成，使用道具（回血、复活、增益等）可以辅助战斗胜利"
	}
}
local t_unique_world_rule = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_unique_world_rule.dataList = dataList

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

return t_unique_world_rule
