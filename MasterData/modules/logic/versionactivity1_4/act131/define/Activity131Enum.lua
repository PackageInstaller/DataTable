-- chunkname: @modules/logic/versionactivity1_4/act131/define/Activity131Enum.lua

module("modules.logic.versionactivity1_4.act131.define.Activity131Enum", package.seeall)

local Activity131Enum = _M

Activity131Enum.TaskMOAllFinishId = -100
Activity131Enum.MinSlideX = 0
Activity131Enum.MaxSlideX = 1538
Activity131Enum.SceneMaxX = 21.55
Activity131Enum.SlideSpeed = 1
Activity131Enum.MaxShowEpisodeCount = 6
Activity131Enum.ActivityId = {
	Act131 = 11403
}
Activity131Enum.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
Activity131Enum.ElementType = {
	TaskTip = 5,
	General = 2,
	LogEnd = 11,
	LogStart = 10,
	Dialog = 4,
	ChangeScene = 9,
	SetValue = 6,
	UnlockDecrypt = 7,
	Battle = 1,
	Respawn = 3,
	CheckDecrypt = 8
}
Activity131Enum.EpisodeState = {
	Unfinished = 0,
	Finished = 1
}
Activity131Enum.GeneralType = {
	Audio = 1,
	Bgm = 0
}
Activity131Enum.ProgressType = {
	Interact = 1,
	BeforeStory = 0,
	Finished = 3,
	AfterStory = 2
}
Activity131Enum.dialogType = {
	slector = "slector",
	option = "option",
	talk = "talk",
	dialog = "dialog",
	tip = "tip"
}

return Activity131Enum
