-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_chen_clg_extreme_stage.lua

module("logicconfig.config.t_origin_chen_clg_extreme_stage", package.seeall)

local title = {
	stageId = 2,
	petValidator = 4,
	activityId = 1,
	creepsMasterId = 3
}
local dataList = {
	{
		620001,
		1,
		1008,
		"Gender$1"
	},
	{
		620001,
		2,
		1002,
		"Gender$1"
	},
	{
		620001,
		3,
		1003,
		"Gender$1"
	},
	{
		620001,
		4,
		1004,
		"Gender$1"
	},
	{
		620001,
		5,
		1005,
		"Gender$1"
	},
	{
		620001,
		6,
		1006,
		"Gender$1"
	},
	{
		620001,
		7,
		1007,
		"Gender$1"
	},
	{
		620001,
		8,
		1001,
		"Gender$1"
	},
	{
		620001,
		9,
		1009,
		"Gender$1"
	}
}
local t_origin_chen_clg_extreme_stage = {
	[620001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_origin_chen_clg_extreme_stage.dataList = dataList

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

return t_origin_chen_clg_extreme_stage
