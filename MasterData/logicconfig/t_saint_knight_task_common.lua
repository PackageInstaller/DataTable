-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_task_common.lua

module("logicconfig.config.t_saint_knight_task_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"WORLD_TASK_FIRST_RED",
		"-248"
	},
	{
		"PERSON_TASK_FIRST_RED",
		"-249"
	},
	{
		"WATER_DARK_DAY_RED",
		"-39"
	},
	{
		"WORLD_TASK_PRIZE_RED",
		"-253"
	},
	{
		"COLLECTION_PRIZE_RED",
		"300"
	},
	{
		"VERIFY_PRIZE_RED",
		"499"
	},
	{
		"BLESSINGWORD_KEY",
		"SaintKnightTask_Blessing"
	}
}
local t_saint_knight_task_common = {
	WORLD_TASK_FIRST_RED = dataList[1],
	PERSON_TASK_FIRST_RED = dataList[2],
	WATER_DARK_DAY_RED = dataList[3],
	WORLD_TASK_PRIZE_RED = dataList[4],
	COLLECTION_PRIZE_RED = dataList[5],
	VERIFY_PRIZE_RED = dataList[6],
	BLESSINGWORD_KEY = dataList[7]
}

t_saint_knight_task_common.dataList = dataList

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

return t_saint_knight_task_common
