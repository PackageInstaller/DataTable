-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tour_arena_game_activity.lua

module("logicconfig.config.t_tour_arena_game_activity", package.seeall)

local title = {
	mainViewRankZoneId = 5,
	comPlanId = 4,
	redPointId = 3,
	zoneTermId = 2,
	activityId = 1
}
local dataList = {
	{
		309001,
		1,
		0,
		1,
		0
	},
	{
		309002,
		1,
		0,
		1,
		0
	},
	{
		309003,
		2,
		0,
		1,
		1
	},
	{
		309004,
		2,
		0,
		1,
		1
	},
	{
		309005,
		3,
		0,
		1,
		0
	},
	{
		309006,
		3,
		0,
		1,
		0
	}
}
local t_tour_arena_game_activity = {
	[309001] = dataList[1],
	[309002] = dataList[2],
	[309003] = dataList[3],
	[309004] = dataList[4],
	[309005] = dataList[5],
	[309006] = dataList[6]
}

t_tour_arena_game_activity.dataList = dataList

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

return t_tour_arena_game_activity
