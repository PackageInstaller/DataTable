-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_carve_up_diamond_lottery_activity.lua

module("logicconfig.config.t_carve_up_diamond_lottery_activity", package.seeall)

local title = {
	normalCost = 4,
	bigPrizePlanId = 3,
	bigCost = 5,
	activityId = 1,
	normalPrizePlanId = 2
}
local dataList = {
	{
		21001,
		1,
		1,
		"10:21001:1",
		"10:21005:1#10:21006:1#10:21007:1#10:21008:1#10:21009:1"
	},
	{
		21002,
		2,
		2,
		"10:21002:1",
		"10:21010:1#10:21011:1#10:21012:1#10:21013:1#10:21014:1"
	}
}
local t_carve_up_diamond_lottery_activity = {
	[21001] = dataList[1],
	[21002] = dataList[2]
}

t_carve_up_diamond_lottery_activity.dataList = dataList

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

return t_carve_up_diamond_lottery_activity
