-- chunkname: @modules/logic/dialogue/controller/DialogueController.lua

module("modules.logic.dialogue.controller.DialogueController", package.seeall)

local DialogueController = class("DialogueController", BaseController)

function DialogueController:onInit()
	return
end

function DialogueController:reInit()
	return
end

function DialogueController:enterDialogue(dialogueId, callback, callbackTarget, callbackParams)
	ViewMgr.instance:openView(ViewName.DialogueView, {
		dialogueId = dialogueId,
		callback = callback,
		callbackTarget = callbackTarget,
		callbackParams = callbackParams
	})
end

DialogueController.instance = DialogueController.New()

return DialogueController
