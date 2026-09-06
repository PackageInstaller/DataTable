-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_vr_space_mode_plan.lua

module("logicconfig.config.t_vr_space_mode_plan", package.seeall)

local title = {
	stagePlanId = 4,
	mode = 2,
	activityId = 1,
	spaceType = 3
}
local dataList = {
	{
		531001,
		0,
		0,
		1
	},
	{
		531001,
		0,
		1,
		2
	},
	{
		531001,
		1,
		0,
		3
	},
	{
		531001,
		1,
		1,
		4
	},
	{
		531002,
		0,
		0,
		5
	},
	{
		531002,
		0,
		1,
		6
	},
	{
		531002,
		1,
		0,
		7
	},
	{
		531002,
		1,
		1,
		8
	}
}
local t_vr_space_mode_plan = {
	[531001] = {
		[0] = {
			[0] = dataList[1],
			dataList[2]
		},
		{
			[0] = dataList[3],
			dataList[4]
		}
	},
	[531002] = {
		[0] = {
			[0] = dataList[5],
			dataList[6]
		},
		{
			[0] = dataList[7],
			dataList[8]
		}
	}
}

t_vr_space_mode_plan.dataList = dataList

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

return t_vr_space_mode_plan
