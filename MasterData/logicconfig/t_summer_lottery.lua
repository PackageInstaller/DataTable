-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summer_lottery.lua

module("logicconfig.config.t_summer_lottery", package.seeall)

local title = {
	activityId = 1,
	poolPlanId = 2
}
local dataList = {
	{
		167001,
		1
	},
	{
		167002,
		2
	},
	{
		167003,
		3
	},
	{
		167004,
		4
	},
	{
		167005,
		5
	},
	{
		167006,
		6
	}
}
local t_summer_lottery = {
	[167001] = dataList[1],
	[167002] = dataList[2],
	[167003] = dataList[3],
	[167004] = dataList[4],
	[167005] = dataList[5],
	[167006] = dataList[6]
}

t_summer_lottery.dataList = dataList

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

return t_summer_lottery
