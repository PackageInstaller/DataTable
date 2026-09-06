-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_longyan_challenge_power_stage.lua

module("logicconfig.config.t_divine_longyan_challenge_power_stage", package.seeall)

local title = {
	stageId = 3,
	prize = 4,
	creepsMasterId = 5,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		355001,
		1,
		1,
		"4:231:80",
		1001
	},
	{
		355001,
		1,
		2,
		"4:231:80",
		1002
	},
	{
		355001,
		1,
		3,
		"4:231:80",
		1003
	},
	{
		355001,
		2,
		1,
		"4:231:80",
		1004
	},
	{
		355001,
		2,
		2,
		"4:231:80",
		1005
	},
	{
		355001,
		2,
		3,
		"4:231:80",
		1006
	},
	{
		355001,
		3,
		1,
		"4:231:80",
		1007
	},
	{
		355001,
		3,
		2,
		"4:231:80",
		1008
	},
	{
		355001,
		3,
		3,
		"4:231:80",
		1009
	}
}
local t_divine_longyan_challenge_power_stage = {
	[355001] = {
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
		}
	}
}

t_divine_longyan_challenge_power_stage.dataList = dataList

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

return t_divine_longyan_challenge_power_stage
