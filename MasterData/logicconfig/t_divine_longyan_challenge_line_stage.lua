-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_longyan_challenge_line_stage.lua

module("logicconfig.config.t_divine_longyan_challenge_line_stage", package.seeall)

local title = {
	stageId = 2,
	name = 7,
	zdlShow = 6,
	raceId = 5,
	creepsMasterId = 4,
	prize = 3,
	activityId = 1,
	openTime = 8
}
local dataList = {
	{
		355001,
		1,
		"8:1:10000",
		101,
		16020,
		400000,
		"灼世之炎1",
		"2024-04-03T05:00:00"
	},
	{
		355001,
		2,
		"8:1:10000",
		102,
		11013,
		800000,
		"灼世之炎2",
		"2024-04-03T05:00:00"
	},
	{
		355001,
		3,
		"8:1:10000",
		103,
		16014,
		1200000,
		"灼世之炎3",
		"2024-04-03T05:00:00"
	},
	{
		355001,
		4,
		"8:1:10000",
		104,
		12014,
		1400000,
		"灼世之炎4",
		"2024-04-03T05:00:00"
	},
	{
		355001,
		5,
		"8:1:10000",
		105,
		15016,
		1600000,
		"灼世之炎5",
		"2024-04-03T05:00:00"
	},
	{
		355001,
		6,
		"8:1:10000",
		106,
		13013,
		1800000,
		"灼世之炎6",
		"2024-04-03T05:00:00"
	},
	{
		355001,
		7,
		"8:1:10000",
		107,
		14017,
		1850000,
		"灼世之炎7",
		"2024-04-03T05:00:00"
	},
	{
		355001,
		8,
		"8:1:10000",
		108,
		14020,
		1900000,
		"灼世之炎8",
		"2024-04-03T05:00:00"
	},
	{
		355001,
		9,
		"8:1:10000",
		109,
		15021,
		2000000,
		"灼世之炎9",
		"2024-04-03T05:00:00"
	},
	{
		355001,
		10,
		"8:1:10000",
		110,
		17015,
		2100000,
		"灼世之炎10",
		"2024-04-03T05:00:00"
	},
	{
		355001,
		11,
		"8:1:10000",
		111,
		11014,
		2200000,
		"灼世之炎11",
		"2024-04-03T05:00:00"
	},
	{
		355001,
		12,
		"4:510279:100",
		112,
		16019,
		2300000,
		"灼世之炎12",
		"2024-04-03T05:00:00"
	}
}
local t_divine_longyan_challenge_line_stage = {
	[355001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_divine_longyan_challenge_line_stage.dataList = dataList

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

return t_divine_longyan_challenge_line_stage
