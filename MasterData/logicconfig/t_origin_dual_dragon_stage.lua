-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dual_dragon_stage.lua

module("logicconfig.config.t_origin_dual_dragon_stage", package.seeall)

local title = {
	stageId = 3,
	buffId = 4,
	buffDesc = 7,
	creepsMasterId = 5,
	stageType = 2,
	activityId = 1,
	stageName = 6
}
local dataList = {
	{
		618001,
		1,
		1,
		0,
		1001,
		"善·第一关",
		"受治疗最多的精灵，获得永久禁疗（不可清除）"
	},
	{
		618001,
		1,
		2,
		0,
		1002,
		"善·第二关",
		"生命值最低的精灵，进入战斗时立即死亡"
	},
	{
		618001,
		1,
		3,
		0,
		1003,
		"善·第三关",
		"造成伤害最高的精灵，受到的所有伤害+50%且获得禁疗（1个大回合）"
	},
	{
		618001,
		1,
		4,
		0,
		1004,
		"善·第四关",
		"造成伤害最高的精灵，进入战斗时立即死亡"
	},
	{
		618001,
		1,
		5,
		0,
		1005,
		"善·第五关",
		"造成伤害最高的精灵，进入战斗时立即死亡"
	},
	{
		618001,
		2,
		1,
		1,
		1006,
		"恶·第一关",
		""
	},
	{
		618001,
		2,
		2,
		2,
		1007,
		"恶·第二关",
		""
	},
	{
		618001,
		2,
		3,
		3,
		1008,
		"恶·第三关",
		""
	},
	{
		618001,
		2,
		4,
		4,
		1009,
		"恶·第四关",
		""
	},
	{
		618001,
		2,
		5,
		4,
		1010,
		"恶·第五关",
		""
	}
}
local t_origin_dual_dragon_stage = {
	[618001] = {
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
		}
	}
}

t_origin_dual_dragon_stage.dataList = dataList

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

return t_origin_dual_dragon_stage
