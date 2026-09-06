-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_collector.lua

module("logicconfig.config.t_goddess_collector", package.seeall)

local title = {
	verificationNum = 6,
	verificationPrizePlanId = 9,
	petPlanId = 2,
	awakenLevelRatio = 8,
	skinPlanId = 4,
	skinPrizePlanId = 5,
	petPrizePlanId = 3,
	levelRatio = 7,
	redPointId = 10,
	activityId = 1
}
local dataList = {
	{
		124001,
		1,
		1,
		1,
		2,
		6,
		10,
		200,
		3,
		213
	},
	{
		124002,
		2,
		4,
		2,
		5,
		6,
		10,
		200,
		3,
		213
	},
	{
		124003,
		3,
		6,
		3,
		7,
		6,
		10,
		200,
		3,
		213
	},
	{
		124004,
		0,
		0,
		4,
		8,
		6,
		10,
		200,
		3,
		213
	},
	{
		124005,
		0,
		0,
		5,
		9,
		6,
		10,
		200,
		3,
		213
	},
	{
		124006,
		0,
		0,
		6,
		10,
		6,
		10,
		200,
		3,
		213
	},
	{
		124007,
		0,
		0,
		7,
		11,
		6,
		10,
		200,
		3,
		213
	},
	{
		124008,
		0,
		0,
		8,
		12,
		6,
		10,
		200,
		3,
		213
	},
	{
		124009,
		0,
		0,
		9,
		13,
		6,
		10,
		200,
		3,
		213
	},
	{
		124010,
		0,
		0,
		10,
		14,
		6,
		10,
		200,
		3,
		213
	}
}
local t_goddess_collector = {
	[124001] = dataList[1],
	[124002] = dataList[2],
	[124003] = dataList[3],
	[124004] = dataList[4],
	[124005] = dataList[5],
	[124006] = dataList[6],
	[124007] = dataList[7],
	[124008] = dataList[8],
	[124009] = dataList[9],
	[124010] = dataList[10]
}

t_goddess_collector.dataList = dataList

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

return t_goddess_collector
