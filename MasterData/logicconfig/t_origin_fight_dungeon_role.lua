-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fight_dungeon_role.lua

module("logicconfig.config.t_origin_fight_dungeon_role", package.seeall)

local title = {
	headIconRes = 5,
	name = 3,
	modelRes = 6,
	roleId = 2,
	specificEventTypes = 4,
	activityId = 1
}
local dataList = {
	{
		525001,
		1,
		"傀儡龙",
		{
			"battle",
			"chest"
		},
		"ui/bigbg/linghailongpaotu/board_lhlpt_long03.png",
		"effect/prefabs/ui/20250628/shenghailong03/shenghailong03-ui_p.prefab"
	},
	{
		525001,
		2,
		"传教士",
		{
			"believer",
			"chest",
			"switchCtrl"
		},
		"ui/bigbg/linghailongpaotu/board_lhlpt_long02.png",
		"effect/prefabs/ui/20250628/shenghailong02/shenghailong02-ui_p.prefab"
	},
	{
		525001,
		3,
		"医生",
		{
			"injured",
			"chest",
			"switchCtrl"
		},
		"ui/bigbg/linghailongpaotu/board_lhlpt_long01.png",
		"effect/prefabs/ui/20250628/shenghailong01/shenghailong01-ui_p.prefab"
	}
}
local t_origin_fight_dungeon_role = {
	[525001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_fight_dungeon_role.dataList = dataList

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

return t_origin_fight_dungeon_role
