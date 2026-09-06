-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_era_nuo_ya_stage.lua

module("logicconfig.config.t_new_era_nuo_ya_stage", package.seeall)

local title = {
	stageId = 3,
	buffId = 5,
	floorId = 2,
	prize = 6,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		535001,
		1,
		1,
		1001,
		1,
		"8:1:2000000"
	},
	{
		535001,
		1,
		2,
		1002,
		2,
		"10:453001:200"
	},
	{
		535001,
		1,
		3,
		1003,
		3,
		"10:453001:200"
	},
	{
		535001,
		1,
		4,
		1004,
		4,
		"8:1:2000000"
	},
	{
		535001,
		2,
		1,
		1001,
		4,
		"10:453001:300"
	},
	{
		535001,
		2,
		2,
		1002,
		3,
		"10:453001:300"
	},
	{
		535001,
		2,
		3,
		1003,
		2,
		"8:1:3000000"
	},
	{
		535001,
		2,
		4,
		1004,
		1,
		"10:453001:500"
	}
}
local t_new_era_nuo_ya_stage = {
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

t_new_era_nuo_ya_stage.dataList = dataList

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

return t_new_era_nuo_ya_stage
