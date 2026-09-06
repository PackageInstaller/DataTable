-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_hall_activity.lua

module("logicconfig.config.t_star_hall_activity", package.seeall)

local title = {
	activityId = 1,
	redPointId = 2,
	skinId = 5,
	numbers = 3,
	prize = 4,
	ruleKey = 6
}
local dataList = {
	{
		494001,
		712,
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		"10:17160:1",
		16035,
		"starhallview_rule"
	},
	{
		494002,
		712,
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		"10:17160:1",
		16035,
		"starhallview_rule"
	}
}
local t_star_hall_activity = {
	[494001] = dataList[1],
	[494002] = dataList[2]
}

t_star_hall_activity.dataList = dataList

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

return t_star_hall_activity
