-- chunkname: @modules/logic/dialogue/defines/DialogueEvent.lua

module("modules.logic.dialogue.defines.DialogueEvent", package.seeall)

local DialogueEvent = _M

DialogueEvent.OnClickOption = 1
DialogueEvent.BeforePlayStep = 2
DialogueEvent.OnDone = 3
DialogueEvent.OnDialogueInfoChange = 100
DialogueEvent.OnCloseViewWithDialogueDone = 4

return DialogueEvent
