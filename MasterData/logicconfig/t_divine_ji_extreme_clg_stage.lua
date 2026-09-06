-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ji_extreme_clg_stage.lua

module("logicconfig.config.t_divine_ji_extreme_clg_stage", package.seeall)

local title = {
	stageId = 2,
	attrType = 3,
	buffPlanId = 6,
	factorPlanId = 5,
	creepsMasterId = 4,
	activityId = 1,
	buffDetails = 7
}
local dataList = {
	{
		421001,
		1,
		"水",
		2001,
		1,
		1,
		"我方每上阵一只水属性精灵，敌阵攻击后有20%几率立即出手一次（每只精灵每个大回合最多1次）"
	},
	{
		421001,
		2,
		"火",
		2002,
		1,
		2,
		"我方每上阵一只火属性精灵，敌阵每个大回合开始时获得30点气势"
	},
	{
		421001,
		3,
		"草",
		2003,
		1,
		3,
		"我方每上阵一只草属性精灵，敌阵每次受击前获得10%最大生命值护盾"
	},
	{
		421001,
		4,
		"光",
		2004,
		1,
		4,
		"我方每上阵一只光属性精灵，敌阵死亡时恢复20%生命值及20气势（每只精灵限1次）"
	},
	{
		421001,
		5,
		"暗",
		2005,
		1,
		5,
		"我方每上阵一只暗属性精灵，敌阵闪避率提高15%"
	},
	{
		421001,
		6,
		"空",
		2006,
		1,
		6,
		"我方每上阵一只空属性精灵，敌阵全属性及生命上限增加10%"
	},
	{
		421002,
		1,
		"水",
		2001,
		1,
		1,
		"我方每上阵一只水属性精灵，敌阵攻击后有20%几率立即出手一次（每只精灵每个大回合最多1次）"
	},
	{
		421002,
		2,
		"火",
		2002,
		1,
		2,
		"我方每上阵一只火属性精灵，敌阵每个大回合开始时获得30点气势"
	},
	{
		421002,
		3,
		"草",
		2003,
		1,
		3,
		"我方每上阵一只草属性精灵，敌阵每次受击前获得10%最大生命值护盾"
	},
	{
		421002,
		4,
		"光",
		2004,
		1,
		4,
		"我方每上阵一只光属性精灵，敌阵死亡时恢复20%生命值及20气势（每只精灵限1次）"
	},
	{
		421002,
		5,
		"暗",
		2005,
		1,
		5,
		"我方每上阵一只暗属性精灵，敌阵闪避率提高15%"
	},
	{
		421002,
		6,
		"空",
		2006,
		1,
		6,
		"我方每上阵一只空属性精灵，敌阵全属性及生命上限增加10%"
	}
}
local t_divine_ji_extreme_clg_stage = {
	[421001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[421002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_divine_ji_extreme_clg_stage.dataList = dataList

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

return t_divine_ji_extreme_clg_stage
