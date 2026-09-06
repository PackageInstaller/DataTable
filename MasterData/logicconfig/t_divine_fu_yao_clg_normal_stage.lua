-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_fu_yao_clg_normal_stage.lua

module("logicconfig.config.t_divine_fu_yao_clg_normal_stage", package.seeall)

local title = {
	stageId = 2,
	prize = 3,
	activityId = 1,
	creepsMasterId = 4
}
local dataList = {
	{
		502001,
		1,
		"4:388:1",
		2001
	},
	{
		502001,
		2,
		"4:388:1",
		2002
	},
	{
		502001,
		3,
		"4:388:1",
		2003
	},
	{
		502001,
		4,
		"4:388:1",
		2004
	},
	{
		502001,
		5,
		"4:388:1",
		2005
	},
	{
		502001,
		6,
		"4:90004:1",
		2006
	},
	{
		502001,
		7,
		"4:388:1",
		2007
	},
	{
		502001,
		8,
		"4:388:2",
		2008
	},
	{
		502001,
		9,
		"4:388:2",
		2009
	},
	{
		502001,
		10,
		"4:388:2",
		2010
	},
	{
		502001,
		11,
		"4:388:2",
		2011
	},
	{
		502001,
		12,
		"4:388:2",
		2012
	},
	{
		502001,
		13,
		"4:388:2",
		2013
	},
	{
		502001,
		14,
		"4:388:2",
		2014
	},
	{
		502001,
		15,
		"8:1:1000000",
		2015
	}
}
local t_divine_fu_yao_clg_normal_stage = {
	[502001] = {
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
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_divine_fu_yao_clg_normal_stage.dataList = dataList

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

return t_divine_fu_yao_clg_normal_stage
