-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_project_ash_buff_plan.lua

module("logicconfig.config.t_project_ash_buff_plan", package.seeall)

local title = {
	buffPlanId = 1,
	name = 4,
	buffId = 2,
	iconPath = 5,
	des = 3
}
local dataList = {
	{
		1,
		1,
		"战斗开始时，己方精灵恢复30点气势",
		"气势+30",
		"icon_expedition_kaichangqishi"
	},
	{
		1,
		2,
		"所有生命恢复效果提升30%",
		"恢复+30%",
		"icon_expedition_liaoxiao"
	},
	{
		1,
		3,
		"暴击率+30%",
		"暴击率+30%",
		"icon_expedition_baojilv1"
	},
	{
		1,
		4,
		"超杀技能的伤害提升20%",
		"超杀伤害+20%",
		"icon_expedition_chaoshatisheng"
	},
	{
		1,
		5,
		"魔法伤害提升25%",
		"魔法伤害+25%",
		"icon_expedition_mogongtisheng"
	},
	{
		1,
		6,
		"物理伤害提升25%",
		"物理伤害+25%",
		"icon_expedition_wugongtisheng"
	}
}
local t_project_ash_buff_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_project_ash_buff_plan.dataList = dataList

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

return t_project_ash_buff_plan
