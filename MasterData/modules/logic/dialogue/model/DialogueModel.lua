-- chunkname: @modules/logic/dialogue/model/DialogueModel.lua

module("modules.logic.dialogue.model.DialogueModel", package.seeall)

local DialogueModel = class("DialogueModel", ListScrollModel)

function DialogueModel:onInit()
	return
end

function DialogueModel:reInit()
	self.dialogueDict = nil
end

function DialogueModel:initDialogue(dialogueList)
	self.dialogueDict = {}

	for _, dialogueId in ipairs(dialogueList) do
		self.dialogueDict[dialogueId] = true
	end
end

function DialogueModel:updateDialogueInfo(dialogueId)
	self.dialogueDict[dialogueId] = true

	DialogueController.instance:dispatchEvent(DialogueEvent.OnDialogueInfoChange, dialogueId)
end

function DialogueModel:isFinishDialogue(dialogueId)
	return self.dialogueDict and self.dialogueDict[dialogueId]
end

DialogueModel.instance = DialogueModel.New()

return DialogueModel
