-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_uphold_justice_player_type.lua

module("logicconfig.config.t_uphold_justice_player_type", package.seeall)

local title = {
	onceLimit = 5,
	strengthLimit = 4,
	zdlLimit = 3,
	type = 2,
	dailyLimit = 6,
	activityLimit = 7,
	activityId = 1,
	activityValueLimit = 8
}
local dataList = {
	{
		581001,
		1,
		1500000,
		50000,
		50000,
		20000,
		100000,
		0
	},
	{
		581001,
		2,
		1500000,
		5000,
		5000,
		5000,
		35000,
		120
	}
}
local t_uphold_justice_player_type = {
	[581001] = {
		dataList[1],
		dataList[2]
	}
}

t_uphold_justice_player_type.dataList = dataList

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

return t_uphold_justice_player_type
