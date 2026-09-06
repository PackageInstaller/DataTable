-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jiu_normal_clg_stage.lua

module("logicconfig.config.t_jiu_normal_clg_stage", package.seeall)

local title = {
	stageId = 3,
	name = 4,
	phaseId = 2,
	prize = 6,
	creepsMasterId = 5,
	activityId = 1
}
local dataList = {
	{
		386001,
		1,
		1,
		"济世 Ⅰ-1",
		2001,
		"4:241:1"
	},
	{
		386001,
		1,
		2,
		"济世 Ⅰ-2",
		2002,
		"4:241:1"
	},
	{
		386001,
		1,
		3,
		"济世 Ⅰ-3",
		2003,
		"4:241:2"
	},
	{
		386001,
		1,
		4,
		"济世 Ⅰ-4",
		2004,
		"4:241:2"
	},
	{
		386001,
		2,
		1,
		"济世 Ⅱ-1",
		2005,
		"4:241:3"
	},
	{
		386001,
		2,
		2,
		"济世 Ⅱ-2",
		2006,
		"4:241:3"
	},
	{
		386001,
		2,
		3,
		"济世 Ⅱ-3",
		2007,
		"4:241:4"
	},
	{
		386001,
		2,
		4,
		"济世 Ⅱ-4",
		2008,
		"4:241:4"
	},
	{
		386001,
		3,
		1,
		"济世 Ⅲ-1",
		2009,
		"8:1:250000"
	},
	{
		386001,
		3,
		2,
		"济世 Ⅲ-2",
		2010,
		"8:1:250000"
	},
	{
		386001,
		3,
		3,
		"济世 Ⅲ-3",
		2011,
		"8:1:500000"
	},
	{
		386001,
		3,
		4,
		"济世 Ⅲ-4",
		2012,
		"4:90004:1"
	},
	{
		386002,
		1,
		1,
		"济世 Ⅰ-1",
		2001,
		"8:1:1"
	},
	{
		386002,
		1,
		2,
		"济世 Ⅰ-2",
		2002,
		"8:1:1"
	},
	{
		386002,
		1,
		3,
		"济世 Ⅰ-3",
		2003,
		"8:1:1"
	},
	{
		386002,
		1,
		4,
		"济世 Ⅰ-4",
		2004,
		"8:1:1"
	},
	{
		386002,
		2,
		1,
		"济世 Ⅱ-1",
		2005,
		"8:1:1"
	},
	{
		386002,
		2,
		2,
		"济世 Ⅱ-2",
		2006,
		"8:1:1"
	},
	{
		386002,
		2,
		3,
		"济世 Ⅱ-3",
		2007,
		"8:1:1"
	},
	{
		386002,
		2,
		4,
		"济世 Ⅱ-4",
		2008,
		"8:1:1"
	},
	{
		386002,
		3,
		1,
		"济世 Ⅲ-1",
		2009,
		"8:1:1"
	},
	{
		386002,
		3,
		2,
		"济世 Ⅲ-2",
		2010,
		"8:1:1"
	},
	{
		386002,
		3,
		3,
		"济世 Ⅲ-3",
		2011,
		"8:1:1"
	},
	{
		386002,
		3,
		4,
		"济世 Ⅲ-4",
		2012,
		"8:1:1"
	}
}
local t_jiu_normal_clg_stage = {
	[386001] = {
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
		},
		{
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		}
	},
	[386002] = {
		{
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16]
		},
		{
			dataList[17],
			dataList[18],
			dataList[19],
			dataList[20]
		},
		{
			dataList[21],
			dataList[22],
			dataList[23],
			dataList[24]
		}
	}
}

t_jiu_normal_clg_stage.dataList = dataList

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

return t_jiu_normal_clg_stage
