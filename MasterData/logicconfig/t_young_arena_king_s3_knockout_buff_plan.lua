-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_arena_king_s3_knockout_buff_plan.lua

module("logicconfig.config.t_young_arena_king_s3_knockout_buff_plan", package.seeall)

local title = {
	buffPlanId = 1,
	name = 5,
	buffId = 2,
	icon = 4,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		"技能命中目标后，额外造成攻击20%的伤害",
		"icon/expevents/icon_expedition_xieli01",
		"双刃剑"
	},
	{
		1,
		2,
		"无视目标35%防御",
		"icon/expevents/icon_expedition_yisun01",
		"无视防御"
	},
	{
		1,
		3,
		"超杀伤害+20%",
		"icon/expevents/icon_expedition_yadao01",
		"超杀伤害"
	},
	{
		1,
		4,
		"每回合结束时，恢复12%的生命",
		"icon/expevents/icon_expedition_shengmingqishi",
		"恢复生命"
	},
	{
		1,
		5,
		"己方每死亡一个精灵，所有精灵+15点气势",
		"icon/expevents/icon_expedition_yadao01",
		"死亡加气"
	},
	{
		1,
		6,
		"攻击50%以下生命的目标时，伤害+25%",
		"icon/expevents/icon_expedition_shenqi_huo",
		"残血收割"
	}
}
local t_young_arena_king_s3_knockout_buff_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_young_arena_king_s3_knockout_buff_plan.dataList = dataList

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

return t_young_arena_king_s3_knockout_buff_plan
