-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_world_cup_stage.lua

module("logicconfig.config.t_world_cup_stage", package.seeall)

local title = {
	stageId = 2,
	name = 3,
	activityId = 1,
	betTime = 4
}
local dataList = {
	{
		602001,
		1,
		"小组赛",
		"2026-06-08T05:00:00"
	},
	{
		602001,
		2,
		"32强赛",
		"2026-06-08T05:00:00"
	},
	{
		602001,
		3,
		"16强赛",
		"2026-06-08T05:00:00"
	},
	{
		602001,
		4,
		"四分之一决赛",
		"2026-06-08T05:00:00"
	},
	{
		602001,
		5,
		"半决赛",
		"2026-06-08T05:00:00"
	},
	{
		602001,
		6,
		"三四名决赛",
		"2026-06-08T05:00:00"
	},
	{
		602001,
		7,
		"决赛",
		"2026-06-08T05:00:00"
	}
}
local t_world_cup_stage = {
	[602001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_world_cup_stage.dataList = dataList

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

return t_world_cup_stage
