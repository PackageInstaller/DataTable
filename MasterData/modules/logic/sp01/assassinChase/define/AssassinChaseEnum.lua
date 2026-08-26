-- chunkname: @modules/logic/sp01/assassinChase/define/AssassinChaseEnum.lua

module("modules.logic.sp01.assassinChase.define.AssassinChaseEnum", package.seeall)

local AssassinChaseEnum = _M

AssassinChaseEnum.ConstId = {
	TotalGameTime = 7,
	ChangeDirectionTimeLimit = 2,
	DirectionChangeCount = 3,
	EndTime = 4,
	DirectionCount = 1
}
AssassinChaseEnum.ViewState = {
	Select = 1,
	Progress = 2,
	Result = 3
}
AssassinChaseEnum.SpineState = {
	Skill = 3,
	Idle = 1,
	Walk = 2
}
AssassinChaseEnum.MainRoleSpineState = {
	[AssassinChaseEnum.SpineState.Idle] = "idle",
	[AssassinChaseEnum.SpineState.Walk] = "walk",
	[AssassinChaseEnum.SpineState.Skill] = "idle_room"
}
AssassinChaseEnum.OtherRoleSpineState = {
	[AssassinChaseEnum.SpineState.Idle] = "idle",
	[AssassinChaseEnum.SpineState.Walk] = "walk",
	[AssassinChaseEnum.SpineState.Skill] = "idle"
}
AssassinChaseEnum.SpineDefaultHeight = -132.5
AssassinChaseEnum.MainRoleIndex = 1
AssassinChaseEnum.AppleRoleIndex = 2
AssassinChaseEnum.OtherRoleIndex = 3
AssassinChaseEnum.OtherRoleRunOffset = 200
AssassinChaseEnum.MainRoleRunOffset = -100
AssassinChaseEnum.OtherRoleFinishOffset = -25
AssassinChaseEnum.MainRoleFinishOffset = 25
AssassinChaseEnum.SpineResPath = {
	"roles/s01_500501_xingti2hao_ui_xx/500501_xingti2hao_ui_xx_ui.prefab",
	"roles/s01_302801_apple_ui_xx/302801_apple_ui_xx_ui.prefab",
	"roles/s01_312301_ajaadtl_ui_xx/312301_ajaadtl_ui_xx_ui.prefab"
}
AssassinChaseEnum.MaterialResPath = "ui/materials/dynamic/ui_spine_assassin_chase_game.mat"
AssassinChaseEnum.ForceEndLockTime = 5
AssassinChaseEnum.AutoGetRewardDelay = 0.5

return AssassinChaseEnum
