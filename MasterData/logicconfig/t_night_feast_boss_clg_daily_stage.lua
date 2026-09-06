-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_night_feast_boss_clg_daily_stage.lua

module("logicconfig.config.t_night_feast_boss_clg_daily_stage", package.seeall)

local title = {
	stageId = 2,
	stageDesc = 5,
	creepsMasterId = 3,
	winPoint = 4,
	activityId = 1
}
local dataList = {
	{
		335001,
		1,
		1001,
		1,
		"成功破阵即可"
	},
	{
		335001,
		2,
		1002,
		1,
		"成功破阵即可"
	},
	{
		335001,
		3,
		1003,
		1,
		"成功破阵即可"
	},
	{
		335001,
		4,
		1004,
		1,
		"成功破阵即可"
	},
	{
		335001,
		5,
		1005,
		1,
		"成功破阵即可"
	},
	{
		335001,
		6,
		1006,
		1,
		"成功破阵即可"
	},
	{
		335001,
		7,
		1007,
		1,
		"成功破阵即可"
	},
	{
		335001,
		8,
		1008,
		1,
		"成功破阵即可"
	},
	{
		335001,
		9,
		1009,
		1,
		"成功破阵即可"
	},
	{
		335001,
		10,
		1010,
		1,
		"成功破阵即可"
	},
	{
		335001,
		11,
		1011,
		1,
		"成功破阵即可"
	},
	{
		335001,
		12,
		1012,
		1,
		"成功破阵即可"
	},
	{
		335001,
		13,
		1013,
		1,
		"成功破阵即可"
	},
	{
		335001,
		14,
		1014,
		1,
		"成功破阵即可"
	},
	{
		335001,
		15,
		1015,
		1,
		"成功破阵即可"
	},
	{
		335002,
		1,
		2001,
		1,
		"成功破阵即可"
	},
	{
		335002,
		2,
		2002,
		1,
		"成功破阵即可"
	},
	{
		335002,
		3,
		2003,
		1,
		"成功破阵即可"
	},
	{
		335002,
		4,
		2004,
		1,
		"成功破阵即可"
	},
	{
		335002,
		5,
		2005,
		1,
		"成功破阵即可"
	},
	{
		335002,
		6,
		2006,
		1,
		"成功破阵即可"
	},
	{
		335002,
		7,
		2007,
		1,
		"成功破阵即可"
	},
	{
		335002,
		8,
		2008,
		1,
		"成功破阵即可"
	},
	{
		335002,
		9,
		2009,
		1,
		"成功破阵即可"
	},
	{
		335002,
		10,
		2010,
		1,
		"成功破阵即可"
	},
	{
		335002,
		11,
		2011,
		1,
		"成功破阵即可"
	},
	{
		335002,
		12,
		2012,
		1,
		"成功破阵即可"
	},
	{
		335002,
		13,
		2013,
		1,
		"成功破阵即可"
	},
	{
		335002,
		14,
		2014,
		1,
		"成功破阵即可"
	},
	{
		335002,
		15,
		2015,
		1,
		"成功破阵即可"
	}
}
local t_night_feast_boss_clg_daily_stage = {
	[335001] = {
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
	},
	[335002] = {
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	}
}

t_night_feast_boss_clg_daily_stage.dataList = dataList

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

return t_night_feast_boss_clg_daily_stage
