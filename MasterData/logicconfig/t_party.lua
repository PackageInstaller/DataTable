-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_party.lua

module("logicconfig.config.t_party", package.seeall)

local title = {
	activityId = 1,
	redPointId = 5,
	endTime = 4,
	prize = 2,
	startTime = 3
}
local dataList = {
	{
		262001,
		"4:90385:1",
		"2023-04-14T05:00:00",
		"2023-04-28T05:00:00",
		344
	},
	{
		262004,
		"4:90462:1",
		"2024-04-12T05:00:00",
		"2024-04-30T05:00:00",
		344
	},
	{
		262006,
		"104:2:1000",
		"2025-04-11T05:00:00",
		"2025-04-30T05:00:00",
		344
	}
}
local t_party = {
	[262001] = dataList[1],
	[262004] = dataList[2],
	[262006] = dataList[3]
}

t_party.dataList = dataList

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

return t_party
