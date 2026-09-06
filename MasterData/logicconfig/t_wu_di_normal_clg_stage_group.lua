-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wu_di_normal_clg_stage_group.lua

module("logicconfig.config.t_wu_di_normal_clg_stage_group", package.seeall)

local title = {
	groupId = 2,
	dataBitId = 3,
	activityId = 1,
	creepsMasterId = 4
}
local dataList = {
	{
		317001,
		1,
		1,
		101
	},
	{
		317001,
		1,
		2,
		110
	},
	{
		317001,
		1,
		3,
		107
	},
	{
		317001,
		2,
		1,
		102
	},
	{
		317001,
		2,
		2,
		105
	},
	{
		317001,
		2,
		3,
		111
	},
	{
		317001,
		3,
		1,
		103
	},
	{
		317001,
		3,
		2,
		106
	},
	{
		317001,
		3,
		3,
		109
	},
	{
		317001,
		4,
		1,
		104
	},
	{
		317001,
		4,
		2,
		108
	},
	{
		317001,
		4,
		3,
		112
	},
	{
		317002,
		1,
		1,
		101
	},
	{
		317002,
		1,
		2,
		110
	},
	{
		317002,
		1,
		3,
		107
	},
	{
		317002,
		2,
		1,
		102
	},
	{
		317002,
		2,
		2,
		105
	},
	{
		317002,
		2,
		3,
		111
	},
	{
		317002,
		3,
		1,
		103
	},
	{
		317002,
		3,
		2,
		106
	},
	{
		317002,
		3,
		3,
		109
	},
	{
		317002,
		4,
		1,
		104
	},
	{
		317002,
		4,
		2,
		108
	},
	{
		317002,
		4,
		3,
		112
	}
}
local t_wu_di_normal_clg_stage_group = {
	[317001] = {
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
		},
		{
			dataList[10],
			dataList[11],
			dataList[12]
		}
	},
	[317002] = {
		{
			dataList[13],
			dataList[14],
			dataList[15]
		},
		{
			dataList[16],
			dataList[17],
			dataList[18]
		},
		{
			dataList[19],
			dataList[20],
			dataList[21]
		},
		{
			dataList[22],
			dataList[23],
			dataList[24]
		}
	}
}

t_wu_di_normal_clg_stage_group.dataList = dataList

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

return t_wu_di_normal_clg_stage_group
