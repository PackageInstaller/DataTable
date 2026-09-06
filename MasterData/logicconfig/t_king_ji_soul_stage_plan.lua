-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ji_soul_stage_plan.lua

module("logicconfig.config.t_king_ji_soul_stage_plan", package.seeall)

local title = {
	stagePlanId = 1,
	stageId = 2,
	raceId = 5,
	buffDesc = 6,
	creepsMasterId = 3,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		201,
		"至少上阵3只水系精灵",
		16000,
		""
	},
	{
		1,
		2,
		202,
		"至少上阵3只水系精灵",
		14008,
		""
	},
	{
		1,
		3,
		203,
		"至少上阵3只水系精灵",
		10206,
		""
	},
	{
		1,
		4,
		204,
		"至少上阵3只水系精灵",
		10144,
		""
	},
	{
		1,
		5,
		205,
		"至少上阵3只水系精灵",
		13004,
		""
	},
	{
		2,
		1,
		206,
		"至少上阵3只火系精灵",
		10370,
		""
	},
	{
		2,
		2,
		207,
		"至少上阵3只火系精灵",
		10345,
		""
	},
	{
		2,
		3,
		208,
		"至少上阵3只火系精灵",
		10327,
		""
	},
	{
		2,
		4,
		209,
		"至少上阵3只火系精灵",
		10143,
		""
	},
	{
		2,
		5,
		210,
		"至少上阵3只火系精灵",
		10146,
		""
	},
	{
		3,
		1,
		211,
		"至少上阵3只草系精灵",
		15006,
		""
	},
	{
		3,
		2,
		212,
		"至少上阵3只草系精灵",
		16003,
		""
	},
	{
		3,
		3,
		213,
		"至少上阵3只草系精灵",
		10334,
		""
	},
	{
		3,
		4,
		214,
		"至少上阵3只草系精灵",
		14004,
		""
	},
	{
		3,
		5,
		215,
		"至少上阵3只草系精灵",
		15006,
		""
	},
	{
		4,
		1,
		216,
		"至少上阵3只光系精灵",
		12007,
		""
	},
	{
		4,
		2,
		217,
		"至少上阵3只光系精灵",
		13004,
		""
	},
	{
		4,
		3,
		218,
		"至少上阵3只光系精灵",
		10327,
		""
	},
	{
		4,
		4,
		219,
		"至少上阵3只光系精灵",
		10181,
		""
	},
	{
		4,
		5,
		220,
		"至少上阵3只光系精灵",
		12007,
		""
	},
	{
		5,
		1,
		221,
		"至少上阵3只暗系精灵",
		14004,
		""
	},
	{
		5,
		2,
		222,
		"至少上阵3只暗系精灵",
		16003,
		""
	},
	{
		5,
		3,
		223,
		"至少上阵3只暗系精灵",
		10334,
		""
	},
	{
		5,
		4,
		224,
		"至少上阵3只暗系精灵",
		15006,
		""
	},
	{
		5,
		5,
		225,
		"至少上阵3只暗系精灵",
		17006,
		""
	}
}
local t_king_ji_soul_stage_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	},
	{
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	},
	{
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25]
	}
}

t_king_ji_soul_stage_plan.dataList = dataList

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

return t_king_ji_soul_stage_plan
