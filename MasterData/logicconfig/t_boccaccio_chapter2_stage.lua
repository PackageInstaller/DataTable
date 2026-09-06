-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_chapter2_stage.lua

module("logicconfig.config.t_boccaccio_chapter2_stage", package.seeall)

local title = {
	positionWord = 4,
	stageId = 2,
	storyId = 3,
	creepsMasterId = 5,
	activityId = 1
}
local dataList = {
	{
		580001,
		1,
		1,
		{
			1,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		2001
	},
	{
		580001,
		2,
		1,
		{
			2,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		2002
	},
	{
		580001,
		3,
		1,
		{
			0,
			9,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		2003
	},
	{
		580001,
		4,
		1,
		{
			10,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		2004
	},
	{
		580001,
		5,
		1,
		{
			3,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		2005
	},
	{
		580001,
		6,
		1,
		{
			4,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		2006
	},
	{
		580001,
		7,
		2,
		{
			5,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		2007
	},
	{
		580001,
		8,
		2,
		{
			11,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		2008
	},
	{
		580001,
		9,
		2,
		{
			0,
			6,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		2009
	},
	{
		580001,
		10,
		2,
		{
			0,
			0,
			0,
			12,
			0,
			0,
			0,
			0,
			0
		},
		2010
	},
	{
		580001,
		11,
		2,
		{
			0,
			7,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		2011
	},
	{
		580001,
		12,
		2,
		{
			0,
			0,
			0,
			8,
			0,
			0,
			0,
			0,
			0
		},
		2012
	}
}
local t_boccaccio_chapter2_stage = {
	[580001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_boccaccio_chapter2_stage.dataList = dataList

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

return t_boccaccio_chapter2_stage
