-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dishitian_challenge_extreme_step.lua

module("logicconfig.config.t_divine_dishitian_challenge_extreme_step", package.seeall)

local title = {
	stepId = 2,
	openTime = 4,
	activityId = 1,
	openCopy = 3
}
local dataList = {
	{
		363001,
		1,
		true,
		"2024-04-30T05:00:00"
	},
	{
		363001,
		2,
		false,
		"2024-05-01T05:00:00"
	},
	{
		363001,
		3,
		false,
		"2024-05-02T05:00:00"
	}
}
local t_divine_dishitian_challenge_extreme_step = {
	[363001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_divine_dishitian_challenge_extreme_step.dataList = dataList

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

return t_divine_dishitian_challenge_extreme_step
