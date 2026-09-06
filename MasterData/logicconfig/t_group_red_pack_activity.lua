-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_group_red_pack_activity.lua

module("logicconfig.config.t_group_red_pack_activity", package.seeall)

local title = {
	consolationPrizeDailyLimit = 5,
	redPackPlanId = 2,
	sloganPlanId = 7,
	consolationPrize = 4,
	coverPlanId = 8,
	showCount = 6,
	activityId = 1,
	gainParam = 3
}
local dataList = {
	{
		249001,
		1,
		"3",
		"",
		10,
		100,
		1,
		1
	},
	{
		249002,
		2,
		"3",
		"",
		10,
		100,
		1,
		2
	}
}
local t_group_red_pack_activity = {
	[249001] = dataList[1],
	[249002] = dataList[2]
}

t_group_red_pack_activity.dataList = dataList

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

return t_group_red_pack_activity
