-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_clg_stage.lua

module("logicconfig.config.t_boccaccio_clg_stage", package.seeall)

local title = {
	stageId = 2,
	pos = 5,
	skinId = 6,
	creepsMasterId = 3,
	topDesc = 4,
	activityId = 1
}
local dataList = {
	{
		578001,
		1,
		1001,
		"敌阵标记精灵会吸收对应的属性，破阵后换算成积分进行排名",
		{
			-80,
			160
		},
		16041
	},
	{
		578001,
		2,
		1002,
		"敌阵标记精灵会吸收对应的属性，破阵后换算成积分进行排名",
		{
			183,
			236
		},
		12040
	},
	{
		578001,
		3,
		1003,
		"敌阵标记精灵会吸收对应的属性，破阵后换算成积分进行排名",
		{
			467,
			198
		},
		13025
	},
	{
		578001,
		4,
		1004,
		"敌阵标记精灵会吸收对应的属性，破阵后换算成积分进行排名",
		{
			-87,
			-91
		},
		12038
	},
	{
		578001,
		5,
		1005,
		"敌阵标记精灵会吸收对应的属性，破阵后换算成积分进行排名",
		{
			191,
			-138
		},
		11036
	},
	{
		578001,
		6,
		1006,
		"敌阵标记精灵会吸收对应的属性，破阵后换算成积分进行排名",
		{
			451,
			-56
		},
		17025
	}
}
local t_boccaccio_clg_stage = {
	[578001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_boccaccio_clg_stage.dataList = dataList

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

return t_boccaccio_clg_stage
