-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_eternal_dragon_clg_stage.lua

module("logicconfig.config.t_origin_eternal_dragon_clg_stage", package.seeall)

local title = {
	stageId = 3,
	type = 2,
	creepsMasterId = 5,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		551001,
		1,
		1,
		"春-1",
		1001
	},
	{
		551001,
		1,
		2,
		"春-2",
		1002
	},
	{
		551001,
		1,
		3,
		"春-3",
		1003
	},
	{
		551001,
		2,
		1,
		"夏-1",
		1004
	},
	{
		551001,
		2,
		2,
		"夏-2",
		1001
	},
	{
		551001,
		2,
		3,
		"夏-3",
		1002
	},
	{
		551001,
		3,
		1,
		"秋-1",
		1003
	},
	{
		551001,
		3,
		2,
		"秋-2",
		1004
	},
	{
		551001,
		3,
		3,
		"秋-3",
		1004
	},
	{
		551001,
		4,
		1,
		"冬-1",
		1003
	},
	{
		551001,
		4,
		2,
		"冬-2",
		1004
	},
	{
		551001,
		4,
		3,
		"冬-3",
		1004
	}
}
local t_origin_eternal_dragon_clg_stage = {
	[551001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9]
		},
		{
			dataList[10],
			dataList[11],
			dataList[12]
		}
	}
}

t_origin_eternal_dragon_clg_stage.dataList = dataList

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

return t_origin_eternal_dragon_clg_stage
