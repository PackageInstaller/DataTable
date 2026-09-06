-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_hot_blooded_mm_stage.lua

module("logicconfig.config.t_origin_hot_blooded_mm_stage", package.seeall)

local title = {
	stageId = 2,
	enemyRaceId = 5,
	prize = 6,
	markPosId = 4,
	creepsMasterId = 3,
	activityId = 1,
	desc = 7
}
local dataList = {
	{
		599001,
		1,
		1001,
		5,
		11030,
		"4:510799:100",
		"敌阵只能被标记站位的精灵击杀,被非标记的精灵击杀时,立即复活。"
	},
	{
		599001,
		2,
		1002,
		5,
		12033,
		"4:510799:100",
		"敌阵只能被标记站位的精灵击杀,被非标记的精灵击杀时,立即复活。"
	},
	{
		599001,
		3,
		1003,
		5,
		14039,
		"4:510799:100",
		"敌阵只能被标记站位的精灵击杀,被非标记的精灵击杀时,立即复活。"
	},
	{
		599001,
		4,
		1004,
		5,
		15037,
		"4:510799:100",
		"敌阵只能被标记站位的精灵击杀,被非标记的精灵击杀时,立即复活。"
	},
	{
		599001,
		5,
		1005,
		5,
		12040,
		"4:510799:100",
		"敌阵只能被标记站位的精灵击杀,被非标记的精灵击杀时,立即复活。"
	},
	{
		599001,
		6,
		1006,
		5,
		12038,
		"4:510799:100",
		"敌阵只能被标记站位的精灵击杀,被非标记的精灵击杀时,立即复活。"
	},
	{
		599001,
		7,
		1007,
		5,
		11036,
		"4:510799:100",
		"敌阵只能被标记站位的精灵击杀,被非标记的精灵击杀时,立即复活。"
	},
	{
		599001,
		8,
		1008,
		5,
		13025,
		"4:510799:100",
		"敌阵只能被标记站位的精灵击杀,被非标记的精灵击杀时,立即复活。"
	},
	{
		599001,
		9,
		1009,
		5,
		16025,
		"4:510799:100",
		"敌阵只能被标记站位的精灵击杀,被非标记的精灵击杀时,立即复活。"
	}
}
local t_origin_hot_blooded_mm_stage = {
	[599001] = {
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

t_origin_hot_blooded_mm_stage.dataList = dataList

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

return t_origin_hot_blooded_mm_stage
