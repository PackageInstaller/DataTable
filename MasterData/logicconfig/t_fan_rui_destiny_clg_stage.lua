-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fan_rui_destiny_clg_stage.lua

module("logicconfig.config.t_fan_rui_destiny_clg_stage", package.seeall)

local title = {
	stageId = 2,
	planId = 5,
	passStagePrize = 4,
	creepsMasterId = 3,
	title = 6,
	activityId = 1
}
local dataList = {
	{
		293001,
		1,
		201,
		"4:378:10",
		1,
		"洞悉命运•第1关"
	},
	{
		293001,
		2,
		202,
		"4:378:10",
		2,
		"洞悉命运•第2关"
	},
	{
		293001,
		3,
		203,
		"4:378:10",
		3,
		"洞悉命运•第3关"
	},
	{
		293002,
		1,
		501,
		"4:397:10",
		2930021,
		"先知断命·第1关"
	},
	{
		293002,
		2,
		502,
		"4:397:10",
		2930022,
		"先知断命·第2关"
	},
	{
		293002,
		3,
		503,
		"4:397:10",
		2930023,
		"先知断命·第3关"
	},
	{
		293003,
		1,
		2001,
		"4:510781:10",
		2930031,
		"繁花似锦·第1关"
	},
	{
		293003,
		2,
		2002,
		"4:510781:10",
		2930032,
		"繁花似锦·第2关"
	},
	{
		293003,
		3,
		2003,
		"4:510781:10",
		2930033,
		"繁花似锦·第3关"
	}
}
local t_fan_rui_destiny_clg_stage = {
	[293001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[293002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[293003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_fan_rui_destiny_clg_stage.dataList = dataList

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

return t_fan_rui_destiny_clg_stage
