-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mi_rui_ke_clg_stage.lua

module("logicconfig.config.t_divine_mi_rui_ke_clg_stage", package.seeall)

local title = {
	stageId = 3,
	creepsId = 5,
	phaseId = 2,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		381001,
		1,
		1,
		1001,
		0
	},
	{
		381001,
		1,
		2,
		1002,
		0
	},
	{
		381001,
		1,
		3,
		1003,
		0
	},
	{
		381001,
		2,
		1,
		1004,
		0
	},
	{
		381001,
		2,
		2,
		1005,
		0
	},
	{
		381001,
		2,
		3,
		1006,
		0
	},
	{
		381001,
		3,
		1,
		1007,
		100000001
	},
	{
		381001,
		3,
		2,
		1008,
		100000002
	},
	{
		381001,
		3,
		3,
		1009,
		100000003
	}
}
local t_divine_mi_rui_ke_clg_stage = {
	[381001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9]
		}
	}
}

t_divine_mi_rui_ke_clg_stage.dataList = dataList

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

return t_divine_mi_rui_ke_clg_stage
