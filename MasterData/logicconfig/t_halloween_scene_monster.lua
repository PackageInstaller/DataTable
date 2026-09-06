-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_halloween_scene_monster.lua

module("logicconfig.config.t_halloween_scene_monster", package.seeall)

local title = {
	funcId = 7,
	prizePlanId = 5,
	sceneRefreshPositionNum = 3,
	scenePlanId = 4,
	buffMaterial = 6,
	buffDesc = 8,
	modelId = 9,
	activityId = 1,
	dailyRefreshSceneNum = 2
}
local dataList = {
	{
		82001,
		3,
		3,
		1,
		1,
		"20:1:1",
		400,
		"成功驱赶今日所有捣蛋鬼后可激活\r\nPVE场景中己方暴击+10%，buff生效时间：自获得时起至次日5:00失效",
		15001
	},
	{
		82002,
		3,
		3,
		1,
		2,
		"20:1:1",
		400,
		"成功驱赶今日所有捣蛋鬼后可激活\r\nPVE场景中己方暴击+10%，buff生效时间：自获得时起至次日5:00失效",
		15001
	},
	{
		82003,
		3,
		3,
		1,
		3,
		"",
		400,
		"",
		15001
	},
	{
		82004,
		3,
		3,
		1,
		4,
		"",
		400,
		"",
		15001
	},
	{
		82005,
		3,
		3,
		1,
		5,
		"",
		400,
		"",
		15001
	},
	{
		82006,
		3,
		3,
		1,
		6,
		"",
		400,
		"",
		10374
	}
}
local t_halloween_scene_monster = {
	[82001] = dataList[1],
	[82002] = dataList[2],
	[82003] = dataList[3],
	[82004] = dataList[4],
	[82005] = dataList[5],
	[82006] = dataList[6]
}

t_halloween_scene_monster.dataList = dataList

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

return t_halloween_scene_monster
