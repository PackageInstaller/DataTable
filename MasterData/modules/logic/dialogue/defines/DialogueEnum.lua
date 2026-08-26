-- chunkname: @modules/logic/dialogue/defines/DialogueEnum.lua

module("modules.logic.dialogue.defines.DialogueEnum", package.seeall)

local DialogueEnum = _M

DialogueEnum.Type = {
	RightMessage = 2,
	LeftMessage = 1,
	Option = 4,
	JumpToGroup = 5,
	SystemMessage = 3
}
DialogueEnum.MinHeight = {
	[DialogueEnum.Type.LeftMessage] = 150,
	[DialogueEnum.Type.RightMessage] = 150,
	[DialogueEnum.Type.SystemMessage] = 50,
	[DialogueEnum.Type.Option] = 50
}
DialogueEnum.IntervalY = 26
DialogueEnum.MessageBgOffsetWidth = 30
DialogueEnum.MessageBgOffsetHeight = 20
DialogueEnum.MessageTxtMaxWidth = 711
DialogueEnum.MessageTxtOneLineHeight = 40
DialogueEnum.MessageNameHeight = 50
DialogueEnum.DialogueItemCls = {
	[DialogueEnum.Type.LeftMessage] = DialogueNormalItem,
	[DialogueEnum.Type.RightMessage] = DialogueNormalItem,
	[DialogueEnum.Type.SystemMessage] = DialogueSystemMessageItem,
	[DialogueEnum.Type.Option] = DialogueOptionItem
}
DialogueEnum.OnDialogueDoneWaitTime = 1.5

return DialogueEnum
