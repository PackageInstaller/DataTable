-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guard_destroy_stage.lua

module("logicconfig.config.t_guard_destroy_stage", package.seeall)

local title = {
	type1CreepsMasterId = 4,
	stageId = 2,
	type2CreepsMasterId = 5,
	supportPetPlanId = 6,
	openDays = 3,
	activityId = 1
}
local dataList = {
	{
		474001,
		1,
		1,
		101,
		201,
		1
	},
	{
		474001,
		2,
		1,
		102,
		202,
		2
	},
	{
		474001,
		3,
		1,
		103,
		203,
		3
	},
	{
		474001,
		4,
		1,
		104,
		204,
		4
	},
	{
		474001,
		5,
		1,
		105,
		205,
		5
	},
	{
		474001,
		6,
		1,
		105,
		206,
		6
	},
	{
		474001,
		7,
		1,
		105,
		207,
		7
	},
	{
		474001,
		8,
		1,
		105,
		208,
		8
	},
	{
		474001,
		9,
		1,
		105,
		209,
		9
	},
	{
		474001,
		10,
		1,
		105,
		210,
		10
	},
	{
		474002,
		1,
		1,
		1001,
		2001,
		11
	},
	{
		474002,
		2,
		1,
		1002,
		2002,
		12
	},
	{
		474002,
		3,
		1,
		1003,
		2003,
		13
	},
	{
		474002,
		4,
		1,
		1004,
		2004,
		14
	},
	{
		474002,
		5,
		1,
		1005,
		2005,
		15
	},
	{
		474002,
		6,
		1,
		1006,
		2006,
		15
	},
	{
		474002,
		7,
		1,
		1007,
		2007,
		15
	},
	{
		474002,
		8,
		1,
		1008,
		2008,
		15
	},
	{
		474002,
		9,
		1,
		1009,
		2009,
		15
	},
	{
		474002,
		10,
		1,
		1010,
		2010,
		15
	}
}
local t_guard_destroy_stage = {
	[474001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[474002] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_guard_destroy_stage.dataList = dataList

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

return t_guard_destroy_stage
