-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_halloween_scene_monster_scene.lua

module("logicconfig.config.t_halloween_scene_monster_scene", package.seeall)

local title = {
	sceneId = 3,
	scenePositionPlanId = 5,
	sceneName = 4,
	id = 2,
	scenePlanId = 1
}
local dataList = {
	{
		1,
		1,
		1001,
		"奥奇城",
		1
	},
	{
		1,
		2,
		106,
		"梦之岛",
		2
	},
	{
		1,
		3,
		107,
		"召唤师大陆",
		3
	},
	{
		1,
		4,
		111,
		"砂之迷城",
		4
	},
	{
		1,
		5,
		114,
		"蓝龙湾",
		5
	},
	{
		1,
		6,
		117,
		"曙光森林",
		6
	},
	{
		1,
		7,
		118,
		"砂之国",
		7
	},
	{
		1,
		8,
		119,
		"星神界",
		8
	},
	{
		1,
		9,
		120,
		"赎罪者峡谷",
		9
	},
	{
		1,
		10,
		124,
		"溯回虚空",
		10
	},
	{
		1,
		11,
		126,
		"夜阑城",
		11
	}
}
local t_halloween_scene_monster_scene = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	}
}

t_halloween_scene_monster_scene.dataList = dataList

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

return t_halloween_scene_monster_scene
