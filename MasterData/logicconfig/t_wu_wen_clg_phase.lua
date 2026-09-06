-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wu_wen_clg_phase.lua

module("logicconfig.config.t_wu_wen_clg_phase", package.seeall)

local title = {
	petAliveLimit = 4,
	openTime = 3,
	phaseId = 2,
	buffPlanId = 5,
	prize = 6,
	name = 7,
	activityId = 1
}
local dataList = {
	{
		374001,
		1,
		"2024-06-14T05:00:00",
		12,
		1,
		"4:237:20",
		"第一层"
	},
	{
		374001,
		2,
		"2024-06-15T05:00:00",
		18,
		2,
		"4:237:40",
		"第二层"
	},
	{
		374001,
		3,
		"2024-06-16T05:00:00",
		24,
		3,
		"4:237:60",
		"第三层"
	},
	{
		374002,
		1,
		"2024-03-14T05:00:00",
		12,
		4,
		"4:269:10",
		"第一层"
	},
	{
		374002,
		2,
		"2024-03-15T05:00:00",
		18,
		5,
		"4:269:10",
		"第二层"
	},
	{
		374002,
		3,
		"2024-03-16T05:00:00",
		24,
		6,
		"4:269:100",
		"第三层"
	},
	{
		374003,
		1,
		"2025-11-28T05:00:00",
		12,
		7,
		"4:510637:20",
		"第一层"
	},
	{
		374003,
		2,
		"2025-11-29T05:00:00",
		18,
		8,
		"4:510637:40",
		"第二层"
	},
	{
		374003,
		3,
		"2025-11-30T05:00:00",
		24,
		9,
		"4:510637:40",
		"第三层"
	}
}
local t_wu_wen_clg_phase = {
	[374001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[374002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[374003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_wu_wen_clg_phase.dataList = dataList

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

return t_wu_wen_clg_phase
