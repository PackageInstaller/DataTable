-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wu_di_clg_activity.lua

module("logicconfig.config.t_wu_di_clg_activity", package.seeall)

local title = {
	extremeClgPrize = 2,
	comPlanId = 5,
	redPointId = 4,
	normalClgMaxSupportPetCount = 3,
	activityId = 1
}
local dataList = {
	{
		317001,
		"100:14017:1:1",
		1,
		528,
		1
	},
	{
		317002,
		"8:1:1",
		1,
		648,
		2
	}
}
local t_wu_di_clg_activity = {
	[317001] = dataList[1],
	[317002] = dataList[2]
}

t_wu_di_clg_activity.dataList = dataList

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

return t_wu_di_clg_activity
