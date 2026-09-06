-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_plugin_progress_plan.lua

module("logicconfig.config.t_activity_plugin_progress_plan", package.seeall)

local title = {
	progressId = 3,
	spaceX = 9,
	animTime = 11,
	type = 4,
	spaceY = 10,
	planId = 5,
	towerStarCount = 8,
	activityType = 1,
	materialId = 7,
	redPointId = 6,
	activityId = 2
}
local dataList = {
	{
		17,
		17090,
		1,
		314,
		1,
		518,
		"10:17086:1",
		6,
		30,
		14,
		0.2
	},
	{
		328,
		328001,
		1,
		314,
		2,
		518,
		"10:296018:1",
		5,
		48,
		16,
		0.2
	},
	{
		328,
		328002,
		1,
		314,
		3,
		518,
		"10:328002:1",
		5,
		48,
		16,
		0.2
	},
	{
		17,
		17126,
		1,
		314,
		4,
		518,
		"10:17126:1",
		4,
		50,
		28,
		0.2
	},
	{
		328,
		328003,
		1,
		314,
		5,
		518,
		"10:328003:1",
		5,
		48,
		16,
		0.2
	}
}
local t_activity_plugin_progress_plan = {
	[17] = {
		[17090] = {
			dataList[1]
		},
		[17126] = {
			dataList[4]
		}
	},
	[328] = {
		[328001] = {
			dataList[2]
		},
		[328002] = {
			dataList[3]
		},
		[328003] = {
			dataList[5]
		}
	}
}

t_activity_plugin_progress_plan.dataList = dataList

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

return t_activity_plugin_progress_plan
