-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bone_dragon_clg_stage.lua

module("logicconfig.config.t_bone_dragon_clg_stage", package.seeall)

local title = {
	stageId = 2,
	prize = 3,
	supportPetId = 5,
	creepsMasterId = 4,
	activityId = 1,
	formationPlanId = 6
}
local dataList = {
	{
		488001,
		1,
		"4:297:20",
		1001,
		100000001,
		1
	},
	{
		488001,
		2,
		"4:297:20",
		1002,
		100000001,
		1
	},
	{
		488001,
		3,
		"4:297:20",
		1003,
		100000002,
		1
	},
	{
		488001,
		4,
		"4:297:20",
		1004,
		100000003,
		1
	},
	{
		488001,
		5,
		"4:297:20",
		1005,
		100000002,
		1
	},
	{
		488001,
		6,
		"4:297:20",
		1006,
		100000002,
		1
	}
}
local t_bone_dragon_clg_stage = {
	[488001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_bone_dragon_clg_stage.dataList = dataList

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

return t_bone_dragon_clg_stage
