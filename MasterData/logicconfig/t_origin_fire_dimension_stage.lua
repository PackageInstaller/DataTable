-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fire_dimension_stage.lua

module("logicconfig.config.t_origin_fire_dimension_stage", package.seeall)

local title = {
	stageId = 2,
	alivePetNum = 4,
	targetDesc = 6,
	needUseBlockBuff = 3,
	creepsMasterId = 5,
	enemyBuffDesc = 7,
	activityId = 1
}
local dataList = {
	{
		560001,
		1,
		{
			1,
			2,
			3
		},
		4,
		1001,
		"破阵，且我方存活精灵≥4",
		"当前所有关卡累计精灵存活数量:%s"
	},
	{
		560001,
		2,
		{
			1,
			2,
			3
		},
		4,
		1002,
		"破阵，且我方存活精灵≥4",
		"当前所有关卡累计精灵存活数量:%s"
	},
	{
		560001,
		3,
		{
			1,
			2,
			3
		},
		4,
		1003,
		"破阵，且我方存活精灵≥4",
		"当前所有关卡累计精灵存活数量:%s"
	},
	{
		560001,
		4,
		{
			1,
			2,
			3
		},
		4,
		1004,
		"破阵，且我方存活精灵≥4",
		"当前所有关卡累计精灵存活数量:%s"
	},
	{
		560001,
		5,
		{
			1,
			2,
			3
		},
		4,
		1005,
		"破阵，且我方存活精灵≥4",
		"当前所有关卡累计精灵存活数量:%s"
	},
	{
		560001,
		6,
		{
			1,
			2,
			3
		},
		4,
		1006,
		"破阵，且我方存活精灵≥4",
		"当前所有关卡累计精灵存活数量:%s"
	}
}
local t_origin_fire_dimension_stage = {
	[560001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_origin_fire_dimension_stage.dataList = dataList

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

return t_origin_fire_dimension_stage
