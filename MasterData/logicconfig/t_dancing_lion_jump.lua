-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dancing_lion_jump.lua

module("logicconfig.config.t_dancing_lion_jump", package.seeall)

local title = {
	dailyTimeLimit = 3,
	stagePlanId = 2,
	redPointId = 4,
	cheatPlanId = 5,
	activityId = 1
}
local dataList = {
	{
		235001,
		1,
		10,
		436,
		1
	},
	{
		235002,
		2,
		10,
		436,
		1
	},
	{
		235003,
		3,
		10,
		436,
		1
	},
	{
		235004,
		4,
		10,
		436,
		1
	},
	{
		235005,
		4,
		10,
		436,
		1
	}
}
local t_dancing_lion_jump = {
	[235001] = dataList[1],
	[235002] = dataList[2],
	[235003] = dataList[3],
	[235004] = dataList[4],
	[235005] = dataList[5]
}

t_dancing_lion_jump.dataList = dataList

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

return t_dancing_lion_jump
