-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_meng_meng_challenge_guard_stage.lua

module("logicconfig.config.t_king_meng_meng_challenge_guard_stage", package.seeall)

local title = {
	stageId = 2,
	name = 3,
	raceId = 5,
	buffName = 6,
	creepsMasterId = 4,
	buffDesc = 7,
	activityId = 1,
	buffIcon = 8
}
local dataList = {
	{
		278001,
		1,
		"王之守卫一",
		301,
		12012,
		"王之力量一",
		"王者挑战中，王者梦梦BOSS单次受到最大伤害为100W",
		"icon_expedition_dikang_quan"
	},
	{
		278001,
		2,
		"王之守卫二",
		302,
		14011,
		"王之力量二",
		"王者挑战中，王者梦梦BOSS每个大回合结束时恢复5%最大生命值",
		"icon_expedition_kaichanghuixue"
	},
	{
		278001,
		3,
		"王之守卫三",
		303,
		16010,
		"王之力量三",
		"王者挑战中，王者梦梦BOSS受到的非直接伤害减少80%",
		"icon_expedition_changsheng"
	},
	{
		278001,
		4,
		"王之守卫四",
		304,
		14014,
		"王之力量四",
		"王者挑战中，王者梦梦BOSS攻击后可额外出手一次",
		"icon_expedition_zhuiji"
	},
	{
		278002,
		1,
		"王之守卫一",
		301,
		12012,
		"王之力量一",
		"王者挑战中，王者梦梦BOSS单次受到最大伤害为100W",
		"icon_expedition_dikang_quan"
	},
	{
		278002,
		2,
		"王之守卫二",
		302,
		14011,
		"王之力量二",
		"王者挑战中，王者梦梦BOSS每个大回合结束时恢复5%最大生命值",
		"icon_expedition_kaichanghuixue"
	},
	{
		278002,
		3,
		"王之守卫三",
		303,
		16010,
		"王之力量三",
		"王者挑战中，王者梦梦BOSS受到的非直接伤害减少80%",
		"icon_expedition_changsheng"
	},
	{
		278002,
		4,
		"王之守卫四",
		304,
		14014,
		"王之力量四",
		"王者挑战中，王者梦梦BOSS攻击后可额外出手一次",
		"icon_expedition_zhuiji"
	}
}
local t_king_meng_meng_challenge_guard_stage = {
	[278001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[278002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_king_meng_meng_challenge_guard_stage.dataList = dataList

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

return t_king_meng_meng_challenge_guard_stage
