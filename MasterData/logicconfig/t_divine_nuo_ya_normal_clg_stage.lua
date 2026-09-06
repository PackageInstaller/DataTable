-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_nuo_ya_normal_clg_stage.lua

module("logicconfig.config.t_divine_nuo_ya_normal_clg_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1,
	supportPetCount = 4
}
local dataList = {
	{
		316001,
		1,
		101,
		2
	},
	{
		316001,
		2,
		102,
		2
	},
	{
		316001,
		3,
		103,
		2
	},
	{
		316001,
		4,
		104,
		2
	},
	{
		316001,
		5,
		105,
		2
	},
	{
		316001,
		6,
		106,
		2
	},
	{
		316001,
		7,
		107,
		2
	},
	{
		316001,
		8,
		108,
		2
	},
	{
		316001,
		9,
		109,
		2
	},
	{
		316001,
		10,
		110,
		2
	},
	{
		316001,
		11,
		111,
		2
	},
	{
		316001,
		12,
		112,
		2
	},
	{
		316001,
		13,
		113,
		2
	},
	{
		316001,
		14,
		114,
		2
	},
	{
		316001,
		15,
		115,
		2
	},
	{
		316001,
		16,
		116,
		2
	},
	{
		316001,
		17,
		117,
		2
	},
	{
		316001,
		18,
		118,
		2
	},
	{
		316001,
		19,
		119,
		2
	},
	{
		316001,
		20,
		120,
		2
	},
	{
		316001,
		21,
		121,
		2
	}
}
local t_divine_nuo_ya_normal_clg_stage = {
	[316001] = {
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
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21]
	}
}

t_divine_nuo_ya_normal_clg_stage.dataList = dataList

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

return t_divine_nuo_ya_normal_clg_stage
