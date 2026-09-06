-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fire_dimension_challenge_stage.lua

module("logicconfig.config.t_fire_dimension_challenge_stage", package.seeall)

local title = {
	stageId = 2,
	openTime = 3,
	buffId = 5,
	prize = 7,
	banNum = 6,
	desc = 8,
	activityId = 1,
	stageName = 4
}
local dataList = {
	{
		274001,
		1,
		"2023-06-16T05:00:00",
		"星火",
		1,
		3,
		"4:510169:20",
		"最多获得：\n20<quad name=4:510169|icon size=26 width=1 offsetY=-8/>"
	},
	{
		274001,
		2,
		"2023-06-17T05:00:00",
		"炽焰",
		2,
		2,
		"4:510169:30",
		"最多获得：\n30<quad name=4:510169|icon size=26 width=1 offsetY=-8/>"
	},
	{
		274001,
		3,
		"2023-06-18T05:00:00",
		"燎原",
		3,
		1,
		"4:510169:50",
		"最多获得：\n50<quad name=4:510169|icon size=26 width=1 offsetY=-8/>"
	},
	{
		274002,
		1,
		"2025-01-24T05:00:00",
		"流言",
		1,
		3,
		"4:263:20",
		"最多获得：20<quad name=4:263|icon size=26 width=1 offsetY=-8/>"
	},
	{
		274002,
		2,
		"2025-01-24T05:00:00",
		"勘破",
		2,
		2,
		"4:263:30",
		"最多获得：30<quad name=4:263|icon size=26 width=1 offsetY=-8/>"
	},
	{
		274002,
		3,
		"2025-01-24T05:00:00",
		"真相",
		3,
		1,
		"4:263:50",
		"最多获得：50<quad name=4:263|icon size=26 width=1 offsetY=-8/>"
	},
	{
		274003,
		1,
		"2023-06-16T05:00:00",
		"星火",
		1,
		3,
		"8:1:1",
		"最多获得：\n20<quad name=4:510169|icon size=26 width=1 offsetY=-8/>"
	},
	{
		274003,
		2,
		"2023-06-17T05:00:00",
		"炽焰",
		2,
		2,
		"8:1:1",
		"最多获得：\n30<quad name=4:510169|icon size=26 width=1 offsetY=-8/>"
	},
	{
		274003,
		3,
		"2023-06-18T05:00:00",
		"燎原",
		3,
		1,
		"8:1:1",
		"最多获得：\n50<quad name=4:510169|icon size=26 width=1 offsetY=-8/>"
	}
}
local t_fire_dimension_challenge_stage = {
	[274001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[274002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[274003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_fire_dimension_challenge_stage.dataList = dataList

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

return t_fire_dimension_challenge_stage
