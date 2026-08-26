-- chunkname: @modules/logic/versionactivity2_1/aergusi/define/AergusiEnum.lua

module("modules.logic.versionactivity2_1.aergusi.define.AergusiEnum", package.seeall)

local AergusiEnum = _M

AergusiEnum.OperationType = {
	Probe = 2,
	GetClue = 6,
	Tip = 101,
	Merge = 103,
	Submit = 1,
	Refutation = 3,
	NextDialogs = 5,
	EndEpisode = 4,
	NotKeyProbe = 8,
	AutoBubble = 7,
	New = 102
}
AergusiEnum.ProgressState = {
	BeforeStory = 0,
	Evidence = 1,
	Finished = 3,
	AfterStory = 2
}
AergusiEnum.DialogPos = {
	Left = 1,
	Right = 2
}
AergusiEnum.DialogBubbleType = {
	Speaker = 1,
	Thought = 2
}
AergusiEnum.DialogBubblePos = {
	Left = 1,
	Right = 2
}
AergusiEnum.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
AergusiEnum.DialogType = {
	SystemMsg = 0,
	NormalRight = 2,
	NormalLeft = 1
}
AergusiEnum.DialogGroupType = {
	Interact = 2,
	Normal = 1
}
AergusiEnum.DialogItemCls = {
	[AergusiEnum.DialogType.SystemMsg] = AergusiDialogSystemMessageItem,
	[AergusiEnum.DialogType.NormalLeft] = AergusiDialogNormalLeftItem,
	[AergusiEnum.DialogType.NormalRight] = AergusiDialogNormalRightItem
}
AergusiEnum.TaskMOAllFinishId = -100
AergusiEnum.MinHeight = {
	[AergusiEnum.DialogType.NormalLeft] = 150,
	[AergusiEnum.DialogType.NormalRight] = 150,
	[AergusiEnum.DialogType.SystemMsg] = 50
}
AergusiEnum.IntervalY = 40
AergusiEnum.MessageBgOffsetWidth = 30
AergusiEnum.MessageBgOffsetHeight = 20
AergusiEnum.MessageTxtMaxWidth = 711
AergusiEnum.MessageTxtOneLineHeight = 40
AergusiEnum.MessageNameHeight = 50
AergusiEnum.DialogReferenceOffsetHeight = 40
AergusiEnum.DialogDoubtOffsetHeight = 40
AergusiEnum.LevelScrollWidth = 2800
AergusiEnum.FirstGroupId = 101
AergusiEnum.FirstGroupLastStepId = 7
AergusiEnum.FirstDialogGuideId = 21302
AergusiEnum.AdamClueId = 8

return AergusiEnum
