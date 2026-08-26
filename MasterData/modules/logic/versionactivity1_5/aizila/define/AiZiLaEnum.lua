-- chunkname: @modules/logic/versionactivity1_5/aizila/define/AiZiLaEnum.lua

module("modules.logic.versionactivity1_5.aizila.define.AiZiLaEnum", package.seeall)

local AiZiLaEnum = _M

AiZiLaEnum.AnimatorTime = {
	HandbookViewClose = 0.3,
	EpsiodeDetailViewClose = 0.3,
	EquipViewClose = 0.3,
	ViewClose = 0.01,
	TaskRewardMoveUp = 0.15,
	GameEventViewClose = 0.3,
	EffectViewOpen = 3.3,
	MapViewOpen = 1,
	ViewOpen = 1,
	TaskReward = 0.5,
	MapViewRise = 2.3,
	MapViewClose = 0.3
}
AiZiLaEnum.ComponentType = {
	Animator = typeof(UnityEngine.Animator)
}
AiZiLaEnum.RareIcon = {
	"v1a5_aizila_quality4",
	"v1a5_aizila_quality4",
	"v1a5_aizila_quality3",
	"v1a5_aizila_quality2",
	"v1a5_aizila_quality1"
}
AiZiLaEnum.TaskMOAllFinishId = -100
AiZiLaEnum.AllStoryEpisodeId = -100
AiZiLaEnum.OpenStoryEpisodeId = -1
AiZiLaEnum.EventType = {
	BranchLine = 1
}
AiZiLaEnum.UITaskItemHeight = {
	ItemTab = 67,
	ItemCell = 161
}
AiZiLaEnum.Guide = {
	FirstEnter = 15401
}

return AiZiLaEnum
