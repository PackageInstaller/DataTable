-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_kaya_activity.lua

module("logicconfig.config.t_king_kaya_activity", package.seeall)

local title = {
	extremePassPrize = 2,
	comPlanId = 4,
	activityId = 1,
	redPointId = 3
}
local dataList = {
	{
		371001,
		"100:13015:1:1",
		579,
		1
	},
	{
		371002,
		"8:1:1",
		0,
		2
	}
}
local t_king_kaya_activity = {
	[371001] = dataList[1],
	[371002] = dataList[2]
}

t_king_kaya_activity.dataList = dataList

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

return t_king_kaya_activity
