-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_make_snowman.lua

module("logicconfig.config.t_make_snowman", package.seeall)

local title = {
	activityId = 1,
	redPointId = 4,
	prizePlanId = 3,
	progressItemId = 2,
	ruleKey = 5
}
local dataList = {
	{
		231001,
		231001,
		1,
		419,
		"makesnowmanmainview_rule"
	},
	{
		231002,
		231002,
		2,
		419,
		"makesnowmanmainview_rule"
	}
}
local t_make_snowman = {
	[231001] = dataList[1],
	[231002] = dataList[2]
}

t_make_snowman.dataList = dataList

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

return t_make_snowman
