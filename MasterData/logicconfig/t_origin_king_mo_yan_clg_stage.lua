-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_king_mo_yan_clg_stage.lua

module("logicconfig.config.t_origin_king_mo_yan_clg_stage", package.seeall)

local title = {
	stageId = 3,
	ruleDesc = 6,
	phaseId = 2,
	activityId = 1,
	creepsMasterId = 5,
	pointId = 4
}
local dataList = {
	{
		559001,
		1,
		1,
		10,
		1001,
		"我方精灵需存活3个"
	},
	{
		559001,
		1,
		2,
		12,
		1002,
		"我方精灵需存活3个"
	},
	{
		559001,
		1,
		3,
		14,
		1003,
		"我方精灵需存活4个"
	},
	{
		559001,
		1,
		4,
		29,
		1004,
		"我方精灵需存活4个"
	},
	{
		559001,
		2,
		1,
		10,
		1005,
		"我方精灵需存活5个"
	},
	{
		559001,
		2,
		2,
		12,
		1006,
		"我方精灵需存活5个"
	},
	{
		559001,
		2,
		3,
		14,
		1007,
		"我方精灵需存活5个"
	},
	{
		559001,
		2,
		4,
		29,
		1008,
		"我方精灵需存活5个"
	},
	{
		559001,
		3,
		1,
		10,
		1009,
		"我方精灵需存活5个"
	},
	{
		559001,
		3,
		2,
		12,
		1010,
		"我方精灵需存活5个"
	},
	{
		559001,
		3,
		3,
		14,
		1011,
		"我方精灵需存活5个"
	},
	{
		559001,
		3,
		4,
		29,
		1012,
		"我方精灵需存活6个"
	}
}
local t_origin_king_mo_yan_clg_stage = {
	[559001] = {
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
	}
}

t_origin_king_mo_yan_clg_stage.dataList = dataList

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

return t_origin_king_mo_yan_clg_stage
