-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_spring_red_pack_activity.lua

module("logicconfig.config.t_spring_red_pack_activity", package.seeall)

local title = {
	dailyRounds = 7,
	pickNum = 6,
	oneRoundPackNum = 5,
	headIconId = 10,
	showName = 11,
	durationSec = 4,
	dailyRedPackId = 8,
	noticeTime = 3,
	dailyTime = 2,
	raceId = 9,
	activityId = 1
}
local dataList = {
	{
		113001,
		"2022-01-28 05:00:00#2022-02-05 05:00:00,2022-02-11 05:00:00#2022-02-16 05:00:00",
		120,
		900,
		8,
		4,
		3,
		7,
		1600301,
		78,
		"秩序圣龙"
	},
	{
		113002,
		"2022-06-02 05:00:00#2022-06-06 05:00:00",
		120,
		900,
		8,
		4,
		3,
		7,
		1600301,
		78,
		"秩序圣龙"
	},
	{
		113003,
		"2022-12-05 05:00:00#2022-12-06 05:00:00",
		120,
		1800,
		8,
		4,
		2,
		7,
		10143,
		1,
		"巅峰赛三强"
	},
	{
		113004,
		"2023-01-02 05:00:00#2023-01-03 05:00:00",
		120,
		1800,
		8,
		4,
		2,
		7,
		10143,
		1,
		"巅峰赛三强"
	},
	{
		113005,
		"2023-01-20 05:00:00#2023-01-24 05:00:00,2023-01-27 05:00:00#2023-01-31 05:00:00,2023-02-03 05:00:00#2023-02-07 05:00:00",
		120,
		900,
		8,
		4,
		3,
		7,
		1400601,
		122,
		"雄狮采青·诺亚"
	},
	{
		113006,
		"2024-02-09 05:00:00#2024-02-17 05:00:00,2024-02-23 05:00:00#2024-02-25 05:00:00",
		120,
		900,
		8,
		4,
		3,
		7,
		1402301,
		235,
		"长安鼓舞·希望神女"
	},
	{
		113007,
		"2024-03-02 05:00:00#2024-03-03 05:00:00",
		120,
		900,
		8,
		4,
		3,
		7,
		1402301,
		235,
		"长安鼓舞·希望神女"
	},
	{
		113008,
		"2025-01-28 05:00:00#2025-02-05 05:00:00,2025-02-12 05:00:00#2025-02-15 05:00:00",
		120,
		900,
		8,
		4,
		3,
		7,
		1202701,
		373,
		"劲射风华·无烬神女"
	},
	{
		113009,
		"2026-02-16 05:00:00#2026-02-24 05:00:00,2026-03-01 05:00:00#2026-03-04 05:00:00",
		120,
		900,
		8,
		4,
		3,
		7,
		1204105,
		522,
		"待见春·无烬神女"
	}
}
local t_spring_red_pack_activity = {
	[113001] = dataList[1],
	[113002] = dataList[2],
	[113003] = dataList[3],
	[113004] = dataList[4],
	[113005] = dataList[5],
	[113006] = dataList[6],
	[113007] = dataList[7],
	[113008] = dataList[8],
	[113009] = dataList[9]
}

t_spring_red_pack_activity.dataList = dataList

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

return t_spring_red_pack_activity
