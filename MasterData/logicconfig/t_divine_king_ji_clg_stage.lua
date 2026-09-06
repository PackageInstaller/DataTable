-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_ji_clg_stage.lua

module("logicconfig.config.t_divine_king_ji_clg_stage", package.seeall)

local title = {
	baseLockCount = 4,
	stageId = 2,
	buffPlanId = 6,
	maxLockCount = 5,
	creepsMasterId = 3,
	prize = 7,
	activityId = 1
}
local dataList = {
	{
		463001,
		1,
		1001,
		1,
		6,
		1,
		"4:272:5"
	},
	{
		463001,
		2,
		1002,
		2,
		6,
		1,
		"4:272:5"
	},
	{
		463001,
		3,
		1003,
		3,
		6,
		1,
		"4:272:10"
	},
	{
		463001,
		4,
		1004,
		4,
		6,
		1,
		"4:272:10"
	},
	{
		463001,
		5,
		1005,
		4,
		6,
		1,
		"4:272:10"
	},
	{
		463001,
		6,
		1006,
		5,
		6,
		1,
		"4:272:10"
	},
	{
		463001,
		7,
		1007,
		5,
		6,
		1,
		"4:272:15"
	},
	{
		463001,
		8,
		1008,
		6,
		6,
		1,
		"4:272:15"
	},
	{
		463001,
		9,
		1009,
		6,
		6,
		1,
		"4:272:20"
	}
}
local t_divine_king_ji_clg_stage = {
	[463001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_divine_king_ji_clg_stage.dataList = dataList

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

return t_divine_king_ji_clg_stage
