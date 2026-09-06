-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_era_nuo_ya_common_stage.lua

module("logicconfig.config.t_new_era_nuo_ya_common_stage", package.seeall)

local title = {
	stageId = 2,
	prize = 5,
	floorId = 3,
	prizeName = 6,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		535001,
		1,
		1,
		1009,
		"8:1:1000000",
		"白昼"
	},
	{
		535001,
		2,
		1,
		1010,
		"4:428:5",
		"黄昏"
	},
	{
		535001,
		3,
		1,
		1011,
		"4:428:5",
		"黑夜"
	},
	{
		535001,
		4,
		1,
		1012,
		"4:428:10",
		"黎明"
	},
	{
		535001,
		5,
		2,
		1013,
		"4:90004:1",
		"黎明"
	},
	{
		535001,
		6,
		2,
		1014,
		"4:30006:10",
		"黑夜"
	},
	{
		535001,
		7,
		2,
		1015,
		"4:30006:10",
		"黄昏"
	},
	{
		535001,
		8,
		2,
		1016,
		"4:30006:20",
		"白昼"
	}
}
local t_new_era_nuo_ya_common_stage = {
	[535001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_new_era_nuo_ya_common_stage.dataList = dataList

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

return t_new_era_nuo_ya_common_stage
