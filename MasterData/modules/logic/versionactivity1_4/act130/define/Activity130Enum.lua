-- chunkname: @modules/logic/versionactivity1_4/act130/define/Activity130Enum.lua

module("modules.logic.versionactivity1_4.act130.define.Activity130Enum", package.seeall)

local Activity130Enum = _M

Activity130Enum.TaskMOAllFinishId = -100
Activity130Enum.MinSlideX = 0
Activity130Enum.MaxSlideX = 1220
Activity130Enum.SceneMaxX = 16.4
Activity130Enum.SlideSpeed = 1
Activity130Enum.MaxShowEpisodeCount = 5
Activity130Enum.ActivityId = {
	Act130 = 11402
}
Activity130Enum.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
Activity130Enum.ElementType = {
	TaskTip = 5,
	General = 2,
	Dialog = 4,
	ChangeScene = 9,
	SetValue = 6,
	UnlockDecrypt = 7,
	Battle = 1,
	Respawn = 3,
	CheckDecrypt = 8
}
Activity130Enum.EpisodeState = {
	Unfinished = 0,
	Finished = 1
}
Activity130Enum.GeneralType = {
	Audio = 1,
	Bgm = 0
}
Activity130Enum.ProgressType = {
	Interact = 1,
	BeforeStory = 0,
	Finished = 3,
	AfterStory = 2
}
Activity130Enum.dialogType = {
	slector = "slector",
	option = "option",
	talk = "talk",
	dialog = "dialog",
	tip = "tip"
}
Activity130Enum.lvSceneType = {
	Light = 1,
	Moon = 2
}

return Activity130Enum
