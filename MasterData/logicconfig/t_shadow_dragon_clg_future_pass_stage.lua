-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shadow_dragon_clg_future_pass_stage.lua

module("logicconfig.config.t_shadow_dragon_clg_future_pass_stage", package.seeall)

local title = {
	stageId = 2,
	topDesc = 7,
	type = 3,
	creepsMasterId = 6,
	selectBuffPlan = 5,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		527001,
		1,
		2,
		"未来关卡-1",
		0,
		1006,
		"敌阵精灵攻击目标时附带自身攻击力*120%的毁灭伤"
	},
	{
		527001,
		2,
		2,
		"未来关卡-2",
		0,
		1007,
		"敌阵精灵攻击目标时附带自身攻击力*120%的毁灭伤"
	},
	{
		527001,
		3,
		2,
		"未来关卡-3",
		0,
		1008,
		"敌阵精灵攻击目标时附带自身攻击力*120%的毁灭伤"
	},
	{
		527001,
		4,
		2,
		"未来关卡-4",
		0,
		1009,
		"敌阵精灵攻击目标时附带自身攻击力*120%的毁灭伤"
	},
	{
		527001,
		5,
		1,
		"过去关卡-1",
		1,
		1010,
		"敌阵精灵获得50%闪避率"
	},
	{
		527001,
		6,
		1,
		"过去关卡-2",
		1,
		1011,
		"敌阵精灵获得50%闪避率"
	},
	{
		527001,
		7,
		1,
		"过去关卡-3",
		1,
		1012,
		"敌阵精灵获得50%闪避率"
	},
	{
		527001,
		8,
		1,
		"过去关卡-4",
		1,
		1013,
		"敌阵精灵获得50%闪避率"
	}
}
local t_shadow_dragon_clg_future_pass_stage = {
	[527001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_shadow_dragon_clg_future_pass_stage.dataList = dataList

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

return t_shadow_dragon_clg_future_pass_stage
