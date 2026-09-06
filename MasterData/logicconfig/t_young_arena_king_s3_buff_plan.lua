-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_arena_king_s3_buff_plan.lua

module("logicconfig.config.t_young_arena_king_s3_buff_plan", package.seeall)

local title = {
	raceId = 3,
	buffPlanId = 1,
	buffId = 2,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		15050,
		"进入战斗时，全体梦之队精灵获得40点气势"
	},
	{
		1,
		2,
		11036,
		"进入战斗时，全体水系精灵获得30%生命和生命上限"
	},
	{
		1,
		3,
		12040,
		"进入战斗时，全体火系精灵获得20%伤害（持续两个大回合）"
	},
	{
		1,
		4,
		13025,
		"进入战斗时，全体草系精灵获得20%免伤（持续两个大回合）"
	},
	{
		2,
		1,
		15050,
		"进入战斗时，全体梦之队精灵获得40点气势"
	},
	{
		2,
		2,
		11036,
		"进入战斗时，全体水系精灵获得30%生命和生命上限"
	},
	{
		2,
		3,
		12040,
		"进入战斗时，全体火系精灵获得20%伤害（持续两个大回合）"
	},
	{
		2,
		4,
		13025,
		"进入战斗时，全体草系精灵获得20%免伤（持续两个大回合）"
	},
	{
		2,
		5,
		16041,
		"进入战斗时，全体空系精灵获得30%最大生命值护盾"
	},
	{
		2,
		6,
		14039,
		"进入战斗时，全体光,暗,空系精灵获得40点气势"
	},
	{
		2,
		7,
		16046,
		"进入战斗时，全体女性获得1次无视超杀伤害效果"
	},
	{
		2,
		8,
		15044,
		"进入战斗时，全体暗系精灵获得80%闪避率（1回合）"
	},
	{
		2,
		9,
		17025,
		"进入战斗时，全体创系精灵获得30%克制伤害（持续两个大回合）"
	}
}
local t_young_arena_king_s3_buff_plan = {
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
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13]
	}
}

t_young_arena_king_s3_buff_plan.dataList = dataList

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

return t_young_arena_king_s3_buff_plan
