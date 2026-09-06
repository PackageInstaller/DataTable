-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_era_nuo_ya_ext_stage.lua

module("logicconfig.config.t_new_era_nuo_ya_ext_stage", package.seeall)

local title = {
	stageId = 3,
	buffId = 5,
	floorId = 2,
	prize = 6,
	creepsMasterId = 4,
	prizeName = 7,
	activityId = 1
}
local dataList = {
	{
		535001,
		1,
		1,
		1004,
		1,
		"4:430:12",
		"白昼"
	},
	{
		535001,
		1,
		2,
		1002,
		2,
		"4:430:12",
		"黄昏"
	},
	{
		535001,
		1,
		3,
		1001,
		3,
		"4:430:12",
		"黑夜"
	},
	{
		535001,
		1,
		4,
		1003,
		4,
		"4:430:12",
		"黎明"
	},
	{
		535001,
		2,
		1,
		1008,
		4,
		"4:430:12",
		"黎明"
	},
	{
		535001,
		2,
		2,
		1006,
		3,
		"4:430:12",
		"黑夜"
	},
	{
		535001,
		2,
		3,
		1007,
		2,
		"4:430:14",
		"黄昏"
	},
	{
		535001,
		2,
		4,
		1005,
		1,
		"4:430:14",
		"白昼"
	}
}
local t_new_era_nuo_ya_ext_stage = {
	[535001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		}
	}
}

t_new_era_nuo_ya_ext_stage.dataList = dataList

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

return t_new_era_nuo_ya_ext_stage
