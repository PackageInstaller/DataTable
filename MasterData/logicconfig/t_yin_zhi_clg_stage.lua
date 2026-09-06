-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_yin_zhi_clg_stage.lua

module("logicconfig.config.t_yin_zhi_clg_stage", package.seeall)

local title = {
	stageId = 3,
	activityId = 1,
	phaseId = 2,
	creepsMasterId = 4
}
local dataList = {
	{
		486001,
		1,
		1,
		1001
	},
	{
		486001,
		1,
		2,
		1002
	},
	{
		486001,
		1,
		3,
		1003
	},
	{
		486001,
		2,
		1,
		1004
	},
	{
		486001,
		2,
		2,
		1005
	},
	{
		486001,
		2,
		3,
		1006
	},
	{
		486001,
		2,
		4,
		1007
	},
	{
		486001,
		3,
		1,
		1008
	},
	{
		486001,
		3,
		2,
		1009
	},
	{
		486001,
		3,
		3,
		1010
	},
	{
		486001,
		3,
		4,
		1011
	},
	{
		486001,
		3,
		5,
		1012
	},
	{
		486002,
		1,
		1,
		2001
	},
	{
		486002,
		1,
		2,
		2002
	},
	{
		486002,
		1,
		3,
		2003
	},
	{
		486002,
		2,
		1,
		2004
	},
	{
		486002,
		2,
		2,
		2005
	},
	{
		486002,
		2,
		3,
		2006
	},
	{
		486002,
		2,
		4,
		2007
	},
	{
		486002,
		3,
		1,
		2008
	},
	{
		486002,
		3,
		2,
		2009
	},
	{
		486002,
		3,
		3,
		2010
	},
	{
		486002,
		3,
		4,
		2011
	},
	{
		486002,
		3,
		5,
		2012
	}
}
local t_yin_zhi_clg_stage = {
	[486001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
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
			dataList[12]
		}
	},
	[486002] = {
		{
			dataList[13],
			dataList[14],
			dataList[15]
		},
		{
			dataList[16],
			dataList[17],
			dataList[18],
			dataList[19]
		},
		{
			dataList[20],
			dataList[21],
			dataList[22],
			dataList[23],
			dataList[24]
		}
	}
}

t_yin_zhi_clg_stage.dataList = dataList

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

return t_yin_zhi_clg_stage
