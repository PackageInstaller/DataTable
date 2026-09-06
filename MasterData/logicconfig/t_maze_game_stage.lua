-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_maze_game_stage.lua

module("logicconfig.config.t_maze_game_stage", package.seeall)

local title = {
	stageId = 2,
	name = 5,
	elementalTitanList = 4,
	prize = 3,
	startTime = 7,
	activityId = 1,
	sceneImgName = 6
}
local dataList = {
	{
		523001,
		1,
		"4:36:20#8:1:30000000",
		{
			1,
			2,
			3
		},
		"流离之屿裂隙",
		"icon/task/icon_map_liulizhidao",
		"2025-11-07T05:00:00"
	},
	{
		523001,
		2,
		"4:12102:5#4:11002:15000",
		{
			4,
			5
		},
		"奥奇城裂隙",
		"icon/task/icon_map_aoqicheng",
		"2025-11-07T05:00:00"
	},
	{
		523001,
		3,
		"4:90312:2",
		{
			6,
			7
		},
		"镜像世界裂隙",
		"icon/task/icon_map_jingxiangshijie",
		"2025-11-07T05:00:00"
	}
}
local t_maze_game_stage = {
	[523001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_maze_game_stage.dataList = dataList

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

return t_maze_game_stage
