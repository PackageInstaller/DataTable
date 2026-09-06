-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_domain_adventure_resource.lua

module("logicconfig.config.t_domain_adventure_resource", package.seeall)

local title = {
	path = 2,
	resourceKey = 1
}
local dataList = {
	{
		"Empty",
		""
	},
	{
		"Over",
		""
	},
	{
		"BuffIcon",
		""
	},
	{
		"Skin",
		""
	},
	{
		"OccMask",
		"scene/domainadventure/domadv_occupied_mask.prefab"
	},
	{
		"NotOccMask",
		"scene/domainadventure/domadv_unoccupied_mask.prefab"
	},
	{
		"FireMask",
		"scene/domainadventure/domadv_fire_mask.prefab"
	},
	{
		"SolveFormUnlockMask",
		"scene/domainadventure/domadv_solve_form_unlock_mask.prefab"
	},
	{
		"BossLock",
		"scene/domainadventure/domadv_locktag.prefab"
	},
	{
		"RelLock",
		"scene/domainadventure/domadv_locktag.prefab"
	},
	{
		"EventIconFight",
		"scene/domainadventure/domadv_eventicon_fight.prefab"
	},
	{
		"EventIconSolveForm",
		"scene/domainadventure/domadv_eventicon_solveform.prefab"
	},
	{
		"EventIconDispatch",
		"scene/domainadventure/domadv_eventicon_dispatch.prefab"
	},
	{
		"EventIconGame",
		"scene/domainadventure/domadv_eventicon_game.prefab"
	},
	{
		"EventIconBoss",
		"scene/domainadventure/domadv_eventicon_boss.prefab"
	},
	{
		"EventIconEliteFight",
		"scene/domainadventure/domadv_eventicon_elitefight.prefab"
	}
}
local t_domain_adventure_resource = {
	Empty = dataList[1],
	Over = dataList[2],
	BuffIcon = dataList[3],
	Skin = dataList[4],
	OccMask = dataList[5],
	NotOccMask = dataList[6],
	FireMask = dataList[7],
	SolveFormUnlockMask = dataList[8],
	BossLock = dataList[9],
	RelLock = dataList[10],
	EventIconFight = dataList[11],
	EventIconSolveForm = dataList[12],
	EventIconDispatch = dataList[13],
	EventIconGame = dataList[14],
	EventIconBoss = dataList[15],
	EventIconEliteFight = dataList[16]
}

t_domain_adventure_resource.dataList = dataList

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

return t_domain_adventure_resource
