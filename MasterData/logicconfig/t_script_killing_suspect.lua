-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_script_killing_suspect.lua

module("logicconfig.config.t_script_killing_suspect", package.seeall)

local title = {
	suspectId = 3,
	activityId = 1,
	chapterId = 2
}
local dataList = {
	{
		365001,
		1,
		3
	},
	{
		365001,
		1,
		4
	},
	{
		365001,
		1,
		5
	},
	{
		365001,
		1,
		6
	},
	{
		365001,
		1,
		7
	},
	{
		365001,
		2,
		3
	},
	{
		365001,
		2,
		4
	},
	{
		365001,
		2,
		5
	},
	{
		365001,
		2,
		6
	},
	{
		365001,
		2,
		7
	},
	{
		365001,
		3,
		3
	},
	{
		365001,
		3,
		4
	},
	{
		365001,
		3,
		5
	},
	{
		365001,
		3,
		6
	},
	{
		365001,
		3,
		7
	},
	{
		365002,
		1,
		1
	},
	{
		365003,
		1,
		1
	},
	{
		365003,
		1,
		2
	},
	{
		365003,
		1,
		3
	},
	{
		365003,
		1,
		4
	},
	{
		365003,
		1,
		5
	},
	{
		365003,
		1,
		6
	},
	{
		365003,
		1,
		7
	},
	{
		365003,
		2,
		1
	},
	{
		365003,
		2,
		2
	},
	{
		365003,
		2,
		3
	},
	{
		365003,
		2,
		4
	},
	{
		365003,
		2,
		5
	},
	{
		365003,
		2,
		6
	},
	{
		365003,
		2,
		7
	},
	{
		365003,
		3,
		1
	},
	{
		365003,
		3,
		2
	},
	{
		365003,
		3,
		3
	},
	{
		365003,
		3,
		4
	},
	{
		365003,
		3,
		5
	},
	{
		365003,
		3,
		6
	},
	{
		365003,
		3,
		7
	}
}
local t_script_killing_suspect = {
	[365001] = {
		{
			[3] = dataList[1],
			[4] = dataList[2],
			[5] = dataList[3],
			[6] = dataList[4],
			[7] = dataList[5]
		},
		{
			[3] = dataList[6],
			[4] = dataList[7],
			[5] = dataList[8],
			[6] = dataList[9],
			[7] = dataList[10]
		},
		{
			[3] = dataList[11],
			[4] = dataList[12],
			[5] = dataList[13],
			[6] = dataList[14],
			[7] = dataList[15]
		}
	},
	[365002] = {
		{
			dataList[16]
		}
	},
	[365003] = {
		{
			dataList[17],
			dataList[18],
			dataList[19],
			dataList[20],
			dataList[21],
			dataList[22],
			dataList[23]
		},
		{
			dataList[24],
			dataList[25],
			dataList[26],
			dataList[27],
			dataList[28],
			dataList[29],
			dataList[30]
		},
		{
			dataList[31],
			dataList[32],
			dataList[33],
			dataList[34],
			dataList[35],
			dataList[36],
			dataList[37]
		}
	}
}

t_script_killing_suspect.dataList = dataList

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

return t_script_killing_suspect
