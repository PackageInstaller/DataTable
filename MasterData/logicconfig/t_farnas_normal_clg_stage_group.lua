-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_farnas_normal_clg_stage_group.lua

module("logicconfig.config.t_farnas_normal_clg_stage_group", package.seeall)

local title = {
	groupId = 2,
	dataBitId = 3,
	activityId = 1,
	creepsMasterId = 4
}
local dataList = {
	{
		333001,
		1,
		1,
		101
	},
	{
		333001,
		1,
		2,
		102
	},
	{
		333001,
		1,
		3,
		103
	},
	{
		333001,
		2,
		1,
		104
	},
	{
		333001,
		2,
		2,
		105
	},
	{
		333001,
		2,
		3,
		106
	},
	{
		333001,
		3,
		1,
		107
	},
	{
		333001,
		3,
		2,
		108
	},
	{
		333001,
		3,
		3,
		109
	},
	{
		333002,
		1,
		1,
		101
	},
	{
		333002,
		1,
		2,
		102
	},
	{
		333002,
		1,
		3,
		103
	},
	{
		333002,
		2,
		1,
		104
	},
	{
		333002,
		2,
		2,
		105
	},
	{
		333002,
		2,
		3,
		106
	},
	{
		333002,
		3,
		1,
		107
	},
	{
		333002,
		3,
		2,
		108
	},
	{
		333002,
		3,
		3,
		109
	}
}
local t_farnas_normal_clg_stage_group = {
	[333001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9]
		}
	},
	[333002] = {
		{
			dataList[10],
			dataList[11],
			dataList[12]
		},
		{
			dataList[13],
			dataList[14],
			dataList[15]
		},
		{
			dataList[16],
			dataList[17],
			dataList[18]
		}
	}
}

t_farnas_normal_clg_stage_group.dataList = dataList

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

return t_farnas_normal_clg_stage_group
