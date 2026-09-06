-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_nuo_ya_sister_extreme_clg_stage.lua

module("logicconfig.config.t_divine_nuo_ya_sister_extreme_clg_stage", package.seeall)

local title = {
	stageId = 3,
	typeId = 2,
	activityId = 1,
	creepsMasterId = 4
}
local dataList = {
	{
		407001,
		1,
		1,
		1001
	},
	{
		407001,
		1,
		2,
		1002
	},
	{
		407001,
		1,
		3,
		1003
	},
	{
		407001,
		1,
		4,
		1004
	},
	{
		407001,
		1,
		5,
		1005
	},
	{
		407001,
		1,
		6,
		1006
	},
	{
		407001,
		1,
		7,
		1007
	},
	{
		407001,
		2,
		1,
		1007
	},
	{
		407001,
		2,
		2,
		1006
	},
	{
		407001,
		2,
		3,
		1005
	},
	{
		407001,
		2,
		4,
		1004
	},
	{
		407001,
		2,
		5,
		1003
	},
	{
		407001,
		2,
		6,
		1002
	},
	{
		407001,
		2,
		7,
		1001
	},
	{
		407002,
		1,
		1,
		1001
	},
	{
		407002,
		1,
		2,
		1002
	},
	{
		407002,
		1,
		3,
		1003
	},
	{
		407002,
		1,
		4,
		1004
	},
	{
		407002,
		1,
		5,
		1005
	},
	{
		407002,
		1,
		6,
		1006
	},
	{
		407002,
		1,
		7,
		1007
	},
	{
		407002,
		2,
		1,
		1007
	},
	{
		407002,
		2,
		2,
		1006
	},
	{
		407002,
		2,
		3,
		1005
	},
	{
		407002,
		2,
		4,
		1004
	},
	{
		407002,
		2,
		5,
		1003
	},
	{
		407002,
		2,
		6,
		1002
	},
	{
		407002,
		2,
		7,
		1001
	}
}
local t_divine_nuo_ya_sister_extreme_clg_stage = {
	[407001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7]
		},
		{
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14]
		}
	},
	[407002] = {
		{
			dataList[15],
			dataList[16],
			dataList[17],
			dataList[18],
			dataList[19],
			dataList[20],
			dataList[21]
		},
		{
			dataList[22],
			dataList[23],
			dataList[24],
			dataList[25],
			dataList[26],
			dataList[27],
			dataList[28]
		}
	}
}

t_divine_nuo_ya_sister_extreme_clg_stage.dataList = dataList

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

return t_divine_nuo_ya_sister_extreme_clg_stage
