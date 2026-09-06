-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_trial_super_trial_stage.lua

module("logicconfig.config.t_goddess_trial_super_trial_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	superTrialPlanId = 1,
	score = 4
}
local dataList = {
	{
		1,
		1,
		4001,
		200
	},
	{
		1,
		2,
		4002,
		200
	},
	{
		1,
		3,
		4003,
		200
	},
	{
		1,
		4,
		4004,
		200
	},
	{
		1,
		5,
		4005,
		200
	},
	{
		1,
		6,
		4006,
		200
	},
	{
		1,
		7,
		4007,
		200
	},
	{
		1,
		8,
		4008,
		200
	},
	{
		2,
		1,
		5001,
		200
	},
	{
		2,
		2,
		5002,
		200
	},
	{
		2,
		3,
		5003,
		200
	},
	{
		2,
		4,
		5004,
		200
	},
	{
		2,
		5,
		5005,
		200
	},
	{
		2,
		6,
		5006,
		200
	},
	{
		2,
		7,
		5007,
		200
	},
	{
		2,
		8,
		5008,
		200
	},
	{
		3,
		1,
		6001,
		200
	},
	{
		3,
		2,
		6002,
		200
	},
	{
		3,
		3,
		6003,
		200
	},
	{
		3,
		4,
		6004,
		200
	},
	{
		3,
		5,
		6005,
		200
	},
	{
		3,
		6,
		6006,
		200
	},
	{
		3,
		7,
		6007,
		200
	},
	{
		3,
		8,
		6008,
		200
	}
}
local t_goddess_trial_super_trial_stage = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	},
	{
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	}
}

t_goddess_trial_super_trial_stage.dataList = dataList

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

return t_goddess_trial_super_trial_stage
