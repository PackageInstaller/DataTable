-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fire_works_display_scene.lua

module("logicconfig.config.t_fire_works_display_scene", package.seeall)

local title = {
	sceneId = 2,
	scenePlanId = 1,
	sceneName = 3,
	scenePositionPlanId = 4
}
local dataList = {
	{
		1,
		1001,
		"奥奇城",
		1
	},
	{
		1,
		106,
		"梦之岛",
		2
	},
	{
		1,
		107,
		"召唤师大陆",
		3
	},
	{
		1,
		114,
		"蓝龙湾",
		4
	},
	{
		1,
		117,
		"曙光森林",
		5
	},
	{
		1,
		118,
		"砂之国",
		6
	},
	{
		1,
		119,
		"星神界",
		7
	},
	{
		1,
		120,
		"赎罪者峡谷",
		8
	},
	{
		1,
		126,
		"夜阑城",
		9
	}
}
local t_fire_works_display_scene = {
	{
		[1001] = dataList[1],
		[106] = dataList[2],
		[107] = dataList[3],
		[114] = dataList[4],
		[117] = dataList[5],
		[118] = dataList[6],
		[119] = dataList[7],
		[120] = dataList[8],
		[126] = dataList[9]
	}
}

t_fire_works_display_scene.dataList = dataList

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

return t_fire_works_display_scene
