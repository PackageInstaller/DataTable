-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_scratch_cycle.lua

module("logicconfig.config.t_star_scratch_cycle", package.seeall)

local title = {
	openDateTime = 3,
	endDateTime = 4,
	bigPrizeGuaranteed = 6,
	cycleId = 2,
	timesLimit = 5,
	name = 7,
	activityId = 1
}
local dataList = {
	{
		364001,
		1,
		"2024-04-30T05:00:00",
		"2024-05-10T05:00:00",
		15,
		15,
		"星神刮刮乐"
	},
	{
		364001,
		2,
		"2024-05-10T05:00:00",
		"2024-05-17T05:00:00",
		15,
		15,
		"神唤券刮刮乐"
	},
	{
		364001,
		3,
		"2024-05-17T05:00:00",
		"2024-05-24T05:00:00",
		15,
		15,
		"萌宠刮刮乐"
	},
	{
		364001,
		4,
		"2024-05-24T05:00:00",
		"2024-05-31T05:00:00",
		15,
		15,
		"金币刮刮乐"
	}
}
local t_star_scratch_cycle = {
	[364001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_star_scratch_cycle.dataList = dataList

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

return t_star_scratch_cycle
