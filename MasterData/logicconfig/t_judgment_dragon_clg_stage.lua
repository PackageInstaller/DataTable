-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_judgment_dragon_clg_stage.lua

module("logicconfig.config.t_judgment_dragon_clg_stage", package.seeall)

local title = {
	stageId = 2,
	stagePlanId = 1,
	creepsMasterId = 3,
	positionPlanId = 4
}
local dataList = {
	{
		1,
		1,
		1001,
		1
	},
	{
		1,
		2,
		1002,
		2
	},
	{
		1,
		3,
		1003,
		3
	},
	{
		1,
		4,
		1004,
		4
	},
	{
		1,
		5,
		1005,
		5
	},
	{
		2,
		1,
		1006,
		6
	},
	{
		2,
		2,
		1007,
		7
	},
	{
		2,
		3,
		1008,
		8
	},
	{
		2,
		4,
		1009,
		9
	},
	{
		2,
		5,
		1010,
		10
	},
	{
		3,
		1,
		1011,
		11
	},
	{
		3,
		2,
		1012,
		12
	},
	{
		3,
		3,
		1013,
		13
	},
	{
		3,
		4,
		1014,
		14
	},
	{
		3,
		5,
		1015,
		15
	}
}
local t_judgment_dragon_clg_stage = {
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
	}
}

t_judgment_dragon_clg_stage.dataList = dataList

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

return t_judgment_dragon_clg_stage
