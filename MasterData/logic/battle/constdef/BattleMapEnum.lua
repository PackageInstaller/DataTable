-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/constdef/BattleMapEnum.lua

module("logic.battle.constdef.BattleMapEnum", package.seeall)

local BattleMapEnum = {}

BattleMapEnum.WeakPointBreakEffect = {
	[BattleConst.SPECIAL_MODELID_AILISI] = {
		brokenTime = 0.5,
		effectCode = 10061
	},
	[0] = {
		brokenTime = 0.5,
		effectCode = BattleConst.WEAK_POINT_BROKEN
	}
}
BattleMapEnum.WarningAction = {
	RemoteMelee = 2,
	StandBy = 3,
	SanityDead = 1
}
BattleMapEnum.WarningActionContent = {
	[BattleMapEnum.WarningAction.SanityDead] = "tips_battle_warning_action_sanity_dead",
	[BattleMapEnum.WarningAction.RemoteMelee] = "tips_battle_warning_action_remote_melee",
	[BattleMapEnum.WarningAction.StandBy] = "tips_battle_warning_action_standby"
}

return BattleMapEnum
