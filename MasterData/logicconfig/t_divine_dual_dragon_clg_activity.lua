-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dual_dragon_clg_activity.lua

module("logicconfig.config.t_divine_dual_dragon_clg_activity", package.seeall)

local title = {
	raceId = 5,
	phasePlanId = 4,
	jumpTo = 6,
	disablePhasePrize = 3,
	limitStartTime = 2,
	activityId = 1
}
local dataList = {
	{
		469001,
		"2025-05-16T05:00:00",
		false,
		1,
		16034,
		{
			"func#618#16034",
			"mibao#jinglingyangcheng",
			"ui#lottery"
		}
	},
	{
		469002,
		"2025-05-16T05:00:00",
		true,
		1,
		16034,
		{
			"func#618#16034",
			"mibao#jinglingyangcheng",
			"ui#lottery"
		}
	},
	{
		469003,
		"2025-05-16T05:00:00",
		true,
		2,
		16034,
		{
			"func#618#16034",
			"mibao#jinglingyangcheng",
			"ui#lottery"
		}
	},
	{
		469004,
		"2025-05-16T05:00:00",
		false,
		1,
		16034,
		{
			"func#618#16034",
			"mibao#jinglingyangcheng",
			"ui#lottery"
		}
	}
}
local t_divine_dual_dragon_clg_activity = {
	[469001] = dataList[1],
	[469002] = dataList[2],
	[469003] = dataList[3],
	[469004] = dataList[4]
}

t_divine_dual_dragon_clg_activity.dataList = dataList

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

return t_divine_dual_dragon_clg_activity
