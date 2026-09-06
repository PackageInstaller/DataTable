-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_painter_phase.lua

module("logicconfig.config.t_dream_painter_phase", package.seeall)

local title = {
	leftNum = 5,
	endDateTime = 4,
	phaseId = 2,
	openDateTime = 3,
	tabName = 6,
	activityId = 1
}
local dataList = {
	{
		285001,
		1,
		"2023-06-30T05:00:00",
		"2023-07-14T04:48:59",
		0,
		"6.30-7.14\r\n投稿阶段"
	},
	{
		285001,
		2,
		"2023-07-14T05:00:00",
		"2023-07-21T04:48:59",
		8,
		"7.14-7.21\r\n突围阶段"
	},
	{
		285001,
		3,
		"2023-07-21T05:00:00",
		"2023-07-28T04:48:59",
		8,
		"7.21-7.28\r\n排名阶段"
	},
	{
		285001,
		4,
		"2023-07-28T05:00:00",
		"2023-08-04T05:00:00",
		0,
		"7.28-8.4\r\n公示阶段"
	},
	{
		285002,
		1,
		"2024-04-03T05:00:00",
		"2024-04-19T04:48:59",
		0,
		"4.3-4.17\r\n投稿阶段"
	},
	{
		285002,
		2,
		"2024-04-19T05:00:00",
		"2024-04-26T04:48:59",
		8,
		"4.19-4.26\r\n突围阶段"
	},
	{
		285002,
		3,
		"2024-04-26T05:00:00",
		"2024-05-05T04:48:59",
		8,
		"4.26-5.5\r\n排名阶段"
	},
	{
		285002,
		4,
		"2024-05-05T05:00:00",
		"2024-05-09T05:00:00",
		0,
		"5.5-5.9\r\n公示阶段"
	},
	{
		285003,
		1,
		"2025-04-03T05:00:00",
		"2025-04-18T04:48:59",
		0,
		"4.3-4.14\r\n投稿阶段"
	},
	{
		285003,
		2,
		"2025-04-18T05:00:00",
		"2025-04-25T04:48:59",
		11,
		"4.18-4.25\r\n突围阶段"
	},
	{
		285003,
		3,
		"2025-04-25T05:00:00",
		"2025-05-05T04:48:59",
		11,
		"4.25-5.5\r\n排名阶段"
	},
	{
		285003,
		4,
		"2025-05-05T05:00:00",
		"2025-05-09T04:48:59",
		0,
		"5.5-5.9\r\n公示阶段"
	},
	{
		285004,
		1,
		"2026-04-03T05:00:00",
		"2026-04-17T05:00:00",
		0,
		"3.25-4.14\r\n投稿阶段"
	},
	{
		285004,
		2,
		"2026-04-17T05:00:00",
		"2026-04-24T05:00:00",
		11,
		"4.17-4.24\r\n突围阶段"
	},
	{
		285004,
		3,
		"2026-04-24T05:00:00",
		"2026-05-05T05:00:00",
		11,
		"4.24-5.5\r\n排名阶段"
	},
	{
		285004,
		4,
		"2026-05-05T05:00:00",
		"2026-05-08T05:00:00",
		0,
		"5.5-5.8\r\n公示阶段"
	}
}
local t_dream_painter_phase = {
	[285001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[285002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[285003] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[285004] = {
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_dream_painter_phase.dataList = dataList

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

return t_dream_painter_phase
