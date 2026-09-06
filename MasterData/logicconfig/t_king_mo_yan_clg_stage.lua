-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_mo_yan_clg_stage.lua

module("logicconfig.config.t_king_mo_yan_clg_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		429001,
		1,
		1001,
		"4:421:2"
	},
	{
		429001,
		2,
		1002,
		"4:421:2"
	},
	{
		429001,
		3,
		1003,
		"4:421:4"
	},
	{
		429001,
		4,
		1004,
		"4:421:4"
	},
	{
		429001,
		5,
		1005,
		"4:421:6"
	},
	{
		429001,
		6,
		1006,
		"4:421:6"
	},
	{
		429001,
		7,
		1007,
		"4:421:8"
	},
	{
		429001,
		8,
		1008,
		"4:421:8"
	},
	{
		429001,
		9,
		1009,
		"4:421:10"
	},
	{
		429001,
		10,
		1010,
		"4:421:10"
	},
	{
		429001,
		11,
		1011,
		"4:421:12"
	},
	{
		429001,
		12,
		1012,
		"4:421:12"
	},
	{
		429001,
		13,
		1013,
		"4:421:12"
	},
	{
		429001,
		14,
		1014,
		"4:421:12"
	},
	{
		429001,
		15,
		1015,
		"4:421:12"
	},
	{
		429002,
		1,
		1001,
		"8:1:1"
	},
	{
		429002,
		2,
		1002,
		"8:1:1"
	},
	{
		429002,
		3,
		1003,
		"8:1:1"
	},
	{
		429002,
		4,
		1004,
		"8:1:1"
	},
	{
		429002,
		5,
		1005,
		"8:1:1"
	},
	{
		429002,
		6,
		1006,
		"8:1:1"
	},
	{
		429002,
		7,
		1007,
		"8:1:1"
	},
	{
		429002,
		8,
		1008,
		"8:1:1"
	},
	{
		429002,
		9,
		1009,
		"8:1:1"
	},
	{
		429002,
		10,
		1010,
		"8:1:1"
	},
	{
		429002,
		11,
		1011,
		"8:1:1"
	},
	{
		429002,
		12,
		1012,
		"8:1:1"
	},
	{
		429002,
		13,
		1013,
		"8:1:1"
	},
	{
		429002,
		14,
		1014,
		"8:1:1"
	},
	{
		429002,
		15,
		1015,
		"8:1:1"
	}
}
local t_king_mo_yan_clg_stage = {
	[429001] = {
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
	[429002] = {
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

t_king_mo_yan_clg_stage.dataList = dataList

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

return t_king_mo_yan_clg_stage
