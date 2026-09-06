-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_king_ci_yuan_dragon_clg_stage.lua

module("logicconfig.config.t_origin_king_ci_yuan_dragon_clg_stage", package.seeall)

local title = {
	stageId = 2,
	blockId = 3,
	name = 5,
	blockStageId = 4,
	creepsMasterId = 6,
	buffDesc = 7,
	activityId = 1
}
local dataList = {
	{
		534001,
		1,
		1,
		1,
		"A.虚空海",
		1001,
		"敌阵精灵每次攻击后，永久提高自身15%暴击率和暴击伤害"
	},
	{
		534001,
		2,
		1,
		2,
		"A.虚空海",
		1002,
		"敌阵精灵首次暴击时，令自身获得一次立即出手"
	},
	{
		534001,
		3,
		1,
		3,
		"A.虚空海",
		1003,
		"敌阵精灵每次暴击时，令自身获得50气势（群攻多个暴击只算1次暴击）"
	},
	{
		534001,
		4,
		2,
		1,
		"B.熔火界",
		1004,
		"敌阵精灵每次攻击若未造成暴击，则令自身下一次攻击必定暴击"
	},
	{
		534001,
		5,
		2,
		2,
		"B.熔火界",
		1005,
		"每大回合开始，敌阵在上个大回合暴击次数≤2，则立即出手一次（第1个大回合不触发，群攻暴击只算1次暴击）"
	},
	{
		534001,
		6,
		2,
		3,
		"B.熔火界",
		1006,
		"敌阵精灵每次出手后获得20气势"
	},
	{
		534001,
		7,
		3,
		1,
		"C.机械境",
		1007,
		"敌阵精灵每次暴击时，获得10点通灵进度（群攻多个暴击只算1次暴击）"
	},
	{
		534001,
		8,
		3,
		2,
		"C.机械境",
		1008,
		"敌阵精灵受到的非暴击伤害降低50%"
	},
	{
		534001,
		9,
		3,
		3,
		"C.机械境",
		1009,
		"敌阵受到的非直接伤害降低50%"
	}
}
local t_origin_king_ci_yuan_dragon_clg_stage = {
	[534001] = {
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

t_origin_king_ci_yuan_dragon_clg_stage.dataList = dataList

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

return t_origin_king_ci_yuan_dragon_clg_stage
