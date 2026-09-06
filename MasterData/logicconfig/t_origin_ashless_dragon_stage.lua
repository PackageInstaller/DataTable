-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ashless_dragon_stage.lua

module("logicconfig.config.t_origin_ashless_dragon_stage", package.seeall)

local title = {
	stageId = 3,
	name = 4,
	phaseId = 2,
	balancePlanId = 6,
	creepsMasterId = 5,
	activityId = 1
}
local dataList = {
	{
		564001,
		1,
		1,
		"熔心遗迹",
		1001,
		1
	},
	{
		564001,
		1,
		2,
		"脊骨长廊",
		1002,
		2
	},
	{
		564001,
		1,
		3,
		"爪痕裂谷",
		1003,
		1
	},
	{
		564001,
		1,
		4,
		"鳞岩广场",
		1004,
		2
	},
	{
		564001,
		2,
		1,
		"焚寂意志",
		1005,
		1
	},
	{
		564001,
		2,
		2,
		"复苏仪式",
		1006,
		2
	},
	{
		564001,
		2,
		3,
		"烬灭王座",
		1007,
		1
	},
	{
		564001,
		2,
		4,
		"无烬之源 ",
		1008,
		2
	}
}
local t_origin_ashless_dragon_stage = {
	[564001] = {
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
		}
	}
}

t_origin_ashless_dragon_stage.dataList = dataList

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

return t_origin_ashless_dragon_stage
